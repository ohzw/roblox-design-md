-- window / window-header / window-info / window-header-info from
-- DESIGN.roblox.md (Honey Ledger). Anatomy (drawable from prose, "Window
-- anatomy" section):
--
--   A hard-edged, strokeless rectangle, usually portrait. The header is a
--   full-width band in a brighter step of the panel's own family
--   (surfaceHeader honey on mustard; secondary blue on royal blue) sitting
--   flush inside the top edge -- never overlapping, never floating, no gap
--   above it. The title sits in the band: centered dark text (honey family)
--   or left-aligned white stroked text (blue family). The close control
--   lives INSIDE the band: honey family floats a rounded beveled red block
--   at the band's RIGHT end; blue family docks a flat red square flush to
--   the band's LEFT end, sharing the band's full height. Below the band,
--   content is an uninterrupted column of full-width color-step rows with
--   xs-sm cracks between them; corners stay sharp everywhere; no footer
--   convention. Layer stack: world -> window -> nothing else (no dim, no
--   shadow -- declared gap, this taste's windows sit raw on the world).
--
-- variant = "honey" | "info":
--   honey -- surface mustard body, surfaceHeader band, centered dark title,
--           beveled close docked RIGHT inside the band.
--   info  -- surfaceInfo royal-blue body + thin `frame` navy stroke, secondary
--           blue band, left-aligned white stroked title, flat close docked
--           LEFT inside the band, sharing the band's full height.
--
-- Motion: entrance may be a hard cut OR scale 0.95 -> 1.0 with `settle` at
-- `fast` (Motion prose) -- NEVER Back-Out overshoot on windows (reads too
-- modern for this taste). Exit: instant, or `exit` easing at `instant`
-- duration, never slower than entrance. Implemented via a UIScale ref
-- (motion-implementation.md) using settle/exit, never the reserved pop
-- (Back-Out) easing.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local CloseButton = require(script.Parent.CloseButton)

local e = React.createElement

local HEADER_HEIGHT = 56

local ENTRANCE = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local EXIT = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.exit.style,
	Theme.motion.easings.exit.direction
)

local function Window(props)
	local scaleRef = React.useRef(nil)
	local variant = props.variant or "honey" -- "honey" | "info"
	local isInfo = variant == "info"
	local listLayoutRef = React.useRef(nil)
	local scrollingFrameRef = React.useRef(nil)

	-- Entrance: scale 0.95 -> 1.0 settle at `fast` (never Back-Out overshoot).
	-- Skippable per-instance (props.instant) for a period-correct hard cut.
	React.useEffect(function()
		local scale = scaleRef.current
		if scale and not props.instant then
			scale.Scale = 0.95
			TweenService:Create(scale, ENTRANCE, { Scale = 1 }):Play()
		end
	end, {})

	-- Responsive window pattern (layout-rules.md): when props.scrollable is
	-- set, Content becomes a ScrollingFrame whose CanvasSize tracks the
	-- inner UIListLayout's own AbsoluteContentSize -- a 6-row list (64px
	-- rows) always exceeds a phone-landscape panel's available height.
	React.useEffect(function()
		if not props.scrollable then
			return
		end
		local layout = listLayoutRef.current
		local scrollingFrame = scrollingFrameRef.current
		if not layout or not scrollingFrame then
			return
		end
		local function sync()
			scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
		end
		sync()
		local conn = layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(sync)
		return function()
			conn:Disconnect()
		end
	end, { props.scrollable })

	local function requestClose()
		local scale = scaleRef.current
		if scale and not props.instant then
			local tween = TweenService:Create(scale, EXIT, { Scale = 0.95 })
			tween.Completed:Once(function()
				if props.onClose then
					props.onClose()
				end
			end)
			tween:Play()
		elseif props.onClose then
			props.onClose()
		end
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = props.size or UDim2.fromOffset(420, 560),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		ZIndex = props.zIndex,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		-- Responsive window pattern (layout-rules.md): MaxSize clamps the
		-- panel at the taste's intended desktop dimensions so it can never
		-- exceed the viewport at phone landscape (667x375).
		MaxSize = if props.maxSize then e("UISizeConstraint", { MaxSize = props.maxSize }) else nil,
		Panel = e("Frame", {
			BackgroundColor3 = if isInfo then Theme.colors.surfaceInfo else Theme.colors.surface,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 1,
		}, {
			-- rounded.none everywhere: sharp corners, no UICorner instance.
			-- frameColor override: Colors prose assigns accentSelect as the
			-- "dialog outer frame" specifically (brighter than the navy
			-- `frame` stroke floating info cards use) -- callers pass it in
			-- rather than this component guessing dialog-vs-card from title.
			Stroke = if isInfo
				then e("UIStroke", {
					Thickness = Theme.strokes.frame.thickness,
					Color = props.frameColor or Theme.strokes.frame.color,
					ApplyStrokeMode = Theme.strokes.frame.mode,
				})
				else nil,
			Header = e("Frame", {
				BackgroundColor3 = if isInfo then Theme.colors.secondary else Theme.colors.surfaceHeader,
				Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
				ZIndex = 2,
			}, {
				Title = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = if isInfo
						then UDim2.new(1, -(HEADER_HEIGHT + Theme.spacing.lg + Theme.spacing.md), 1, 0)
						else UDim2.fromScale(1, 1),
					Position = if isInfo then UDim2.fromOffset(HEADER_HEIGHT + Theme.spacing.md, 0) else nil,
					Text = props.title or "Window",
					FontFace = Theme.typography.heading.font,
					TextSize = Theme.typography.heading.textSize,
					TextColor3 = if isInfo then Theme.colors.white else Theme.colors.onSurface,
					TextXAlignment = if isInfo then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center,
					ZIndex = 3,
				}, {
					Stroke = if isInfo
						then e("UIStroke", {
							Thickness = Theme.strokes.textOutline.thickness,
							Color = Theme.strokes.textOutline.color,
							ApplyStrokeMode = Theme.strokes.textOutline.mode,
						})
						else nil,
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.heading.textSize }),
				}),
				-- info family: flat close square docked LEFT, sharing the band's full height.
				CloseLeft = if isInfo
					then e(CloseButton, {
						variant = "flat",
						size = UDim2.fromOffset(HEADER_HEIGHT, HEADER_HEIGHT),
						position = UDim2.fromOffset(0, 0),
						zIndex = 4,
						onActivated = requestClose,
					})
					else nil,
				-- honey family: beveled close block floating inside the RIGHT end.
				CloseRight = if not isInfo
					then e(CloseButton, {
						variant = "beveled",
						position = UDim2.new(1, -Theme.spacing.sm, 0.5, 0),
						anchorPoint = Vector2.new(1, 0.5),
						zIndex = 4,
						onActivated = requestClose,
					})
					else nil,
			}),
			Content = e(if props.scrollable then "ScrollingFrame" else "Frame", {
				ref = if props.scrollable then scrollingFrameRef else nil,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, -HEADER_HEIGHT),
				Position = UDim2.fromOffset(0, HEADER_HEIGHT),
				ZIndex = 1,
				ScrollBarThickness = if props.scrollable then 6 else nil,
				ScrollBarImageColor3 = if props.scrollable then Theme.colors.onSurface else nil,
				ScrollBarImageTransparency = if props.scrollable then 0.2 else nil,
			}, {
				-- Window inner padding is spacing.sm at most (Layout prose);
				-- content runs nearly edge-to-edge.
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.sm),
					PaddingRight = UDim.new(0, Theme.spacing.sm),
					PaddingTop = UDim.new(0, Theme.spacing.sm),
					PaddingBottom = UDim.new(0, Theme.spacing.sm),
				}),
				Layout = e("UIListLayout", {
					ref = if props.scrollable then listLayoutRef else nil,
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.xs), -- xs-sm cracks between rows
				}),
				Children = e(React.Fragment, nil, props.children),
			}),
		}),
	})
end

return Window
