-- window / window-header / button-close from DESIGN.roblox.md (Candlelit
-- Parlor): near-black warm-plum translucent panel (~8% see-through, never
-- opaque, never pure black), 2px cream stroke, 12px corners, NO shadow —
-- depth is translucency plus a lit edge. Header is not a band: a transparent
-- row with the serif title left and a bare cream X glyph right (no circle,
-- no red, no container; invisible 44px+ touch frame).
-- Motion (taste-family preset): entrance = fade in with at most a small
-- slide (pop, normal); exit = fade out, quicker (exit, fast). No scale
-- overshoot, nothing snaps or bounces.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local HEADER_HEIGHT = 52
local CLOSE_TOUCH = 44 -- bare glyph gets an invisible 44px+ touch frame

local ENTRANCE = TweenInfo.new(
	Theme.motion.durations.normal,
	Theme.motion.easings.pop.style,
	Theme.motion.easings.pop.direction
)
local EXIT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.exit.style,
	Theme.motion.easings.exit.direction
)
local GLYPH_LIFT = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ParlorWindow(props)
	local panelRef = React.useRef(nil)
	local dimRef = React.useRef(nil)
	local glyphRef = React.useRef(nil)
	local closingRef = React.useRef(false)

	local showDim = props.showDim ~= false
	local finalPosition = props.position or UDim2.fromScale(0.5, 0.5)

	-- Entrance: fade + small downward-settling slide. The rendered
	-- GroupTransparency/Position props never change between renders, so
	-- TweenService stays the sole owner (frozen-value pattern).
	React.useEffect(function()
		local panel = panelRef.current
		if panel then
			panel.Position = finalPosition + UDim2.fromScale(0, 0.02)
			panel.GroupTransparency = 1
			TweenService:Create(panel, ENTRANCE, {
				Position = finalPosition,
				GroupTransparency = 0,
			}):Play()
		end
	end, {})

	local function requestClose()
		if not props.onClose or closingRef.current then
			return
		end
		closingRef.current = true
		local panel = panelRef.current
		if not panel then
			props.onClose()
			return
		end
		local tween = TweenService:Create(panel, EXIT, { GroupTransparency = 1 })
		local dim = dimRef.current
		if dim then
			TweenService:Create(dim, EXIT, { BackgroundTransparency = 1 }):Play()
		end
		tween.Completed:Once(function()
			props.onClose()
		end)
		tween:Play()
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = props.zIndex,
	}, {
		-- Popup layering (Elevation prose): dim -> window -> floating text
		Dim = showDim and e("TextButton", {
			ref = dimRef,
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Theme.derived.dim.color,
			BackgroundTransparency = Theme.derived.dim.transparency,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 10,
			[React.Event.Activated] = requestClose,
		}) or nil,
		Panel = e("CanvasGroup", {
			ref = panelRef,
			GroupTransparency = 1, -- entrance effect fades this to 0
			BackgroundColor3 = Theme.colors.surface,
			BackgroundTransparency = Theme.windowTransparency,
			Size = props.size or UDim2.fromScale(0.4, 0.68),
			Position = finalPosition + UDim2.fromScale(0, 0.02),
			AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
			ZIndex = 11,
		}, {
			-- Responsive window pattern (layout-rules.md): MaxSize clamps the
			-- panel at the taste's intended desktop dimensions so it can never
			-- exceed the viewport at phone landscape (667x375) -- verified
			-- failure mode: the Shop window's fixed 560x560 offset pushed the
			-- header/close off the top of the screen at that size.
			MaxSize = e("UISizeConstraint", { MaxSize = props.maxSize or Vector2.new(560, 560) }),
			Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				Transparency = Theme.strokes.outline.transparency,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.lg),
				PaddingRight = UDim.new(0, Theme.spacing.lg),
				PaddingTop = UDim.new(0, Theme.spacing.lg),
				PaddingBottom = UDim.new(0, Theme.spacing.lg),
			}),
			Header = e("Frame", {
				BackgroundTransparency = 1, -- window-header: transparency 1, not a band
				Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
				ZIndex = 2,
			}, {
				Title = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -(CLOSE_TOUCH + Theme.spacing.sm), 1, 0),
					Text = props.title or "Window", -- serif parlor voice, mixed case
					FontFace = Theme.typography.heading.font,
					TextScaled = true, -- heading scales within its container
					TextColor3 = Theme.colors.primary,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 3,
				}, {
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.heading.textSize }),
				}),
				Close = e("TextButton", {
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1, -- button-close: bare glyph, no container
					Size = UDim2.fromOffset(CLOSE_TOUCH, CLOSE_TOUCH),
					Position = UDim2.fromScale(1, 0.5),
					AnchorPoint = Vector2.new(1, 0.5),
					ZIndex = 3,
					[React.Event.MouseButton1Down] = function()
						local glyph = glyphRef.current
						if glyph then
							TweenService:Create(glyph, GLYPH_LIFT, {
								TextColor3 = Theme.derived.primaryPressed,
							}):Play()
						end
					end,
					[React.Event.MouseButton1Up] = function()
						local glyph = glyphRef.current
						if glyph then
							TweenService:Create(glyph, GLYPH_LIFT, {
								TextColor3 = Theme.colors.primary,
							}):Play()
						end
					end,
					[React.Event.Activated] = requestClose,
				}, {
					Glyph = e("TextLabel", {
						ref = glyphRef,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Text = "\u{00D7}", -- bare cream X, never a red circle (U+00D7: renders in Montserrat; U+2715 is tofu)
						FontFace = Theme.typography.label.font,
						TextSize = Theme.typography.label.textSize,
						TextColor3 = Theme.colors.primary,
						ZIndex = 4,
					}),
				}),
			}),
			Content = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, -(HEADER_HEIGHT + Theme.spacing.md)),
				Position = UDim2.new(0, 0, 0, HEADER_HEIGHT + Theme.spacing.md),
				ZIndex = 2,
			}, {
				Children = e(React.Fragment, nil, props.children),
			}),
		}),
	})
end

return ParlorWindow
