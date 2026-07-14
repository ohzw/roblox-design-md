-- window / window-header / dim-overlay from DESIGN.roblox.md (Loud Slab).
-- Anatomy (the load-bearing "Window anatomy" prose): a single square-cornered
-- charcoal slab (window) over the blurred world. Header is a full-width solid
-- band (window-header) FLUSH with the slab's top edge -- not a floating tab,
-- not an overlapping ribbon -- in the window's theme color (default
-- {colors.chrome}; events retheme this ONE slot). Title left-aligned, heavy
-- white outlined type. Close button docked INSIDE the right end of the
-- header band, matching its height, never overlapping a corner. Corners
-- resolve dead sharp: 0 radius, no stroke around the slab, no bevel, no drop
-- image -- the band/body color seam IS the frame. Layer stack:
-- dim+blur -> slab -> band -> content.
--
-- Depth is exactly two tricks, neither a shadow: (1) blur+dim behind the
-- window (dim-overlay ~35% opaque black pairs with a DoF/blur world
-- treatment we can't reproduce in a story, so the backdrop stands in with a
-- flat color -- declared gap, see Theme.derived.worldBackdrop); (2) contrast
-- steps between surface tones + thin white slot-outline strokes on wells.
-- There is no PanelGroup/shadow sibling here (unlike bevel-shadow tastes) --
-- this taste's Do's-and-Don'ts explicitly bans drop images/bevels/gradients
-- for depth.
--
-- Motion (taste-family preset, low confidence -- no video input): entrance
-- overshoot pop 0.8->1.0 at durations.normal; exit at durations.fast (faster
-- than entrance, per Motion prose). UIScale + ref, per motion-implementation.md.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local ButtonClose = require(script.Parent.ButtonClose)

local e = React.createElement

local HEADER_HEIGHT = 72 -- token: components.window-header.height

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

local function Window(props)
	local scaleRef = React.useRef(nil)
	local panelRef = React.useRef(nil)
	local closingRef = React.useRef(false)

	-- Entrance: overshoot pop, scale 0.8 -> 1.0 (frozen-initial-render: the
	-- effect drives the tween, the element always renders Scale = 1 so React
	-- never fights TweenService after the first frame).
	React.useEffect(function()
		local uiScale = scaleRef.current
		if uiScale then
			uiScale.Scale = 0.8
			TweenService:Create(uiScale, ENTRANCE, { Scale = 1 }):Play()
		end
	end, {})

	local function requestClose()
		if closingRef.current then
			return
		end
		closingRef.current = true
		local uiScale = scaleRef.current
		local panel = panelRef.current
		if not uiScale or not panel then
			if props.onClose then
				props.onClose()
			end
			return
		end
		local tween = TweenService:Create(uiScale, EXIT, { Scale = 0.9 })
		TweenService:Create(panel, EXIT, { BackgroundTransparency = 1 }):Play()
		tween.Completed:Once(function()
			closingRef.current = false
			if props.onClose then
				props.onClose()
			end
		end)
		tween:Play()
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = props.zIndex,
	}, {
		-- dim-overlay: pairs with the (unreproduced-here) world blur, ~35% black.
		Dim = props.showDim ~= false and e("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Theme.colors.dim,
			BackgroundTransparency = Theme.dimTransparency,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 10,
			[React.Event.Activated] = function()
				if props.dismissible ~= false then
					requestClose()
				end
			end,
		}) or nil,
		PanelGroup = e("Frame", {
			BackgroundTransparency = 1,
			-- scale 0.45-0.70 wide, centered; tall windows run near full height (token).
			Size = props.size or UDim2.fromScale(0.6, 0.75),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 11,
		}, {
			Scale = e("UIScale", { ref = scaleRef }),
			-- Responsive window pattern (layout-rules.md): MaxSize clamps the
			-- panel at the taste's intended desktop dimensions so it can never
			-- exceed the viewport at phone landscape (667x375).
			MaxSize = if props.maxSize then e("UISizeConstraint", { MaxSize = props.maxSize }) else nil,
			-- window: square charcoal slab, translucent, hard corners, no stroke.
			Panel = e("Frame", {
				ref = panelRef,
				BackgroundColor3 = Theme.colors.surface,
				BackgroundTransparency = Theme.surfaceTransparency,
				Size = UDim2.fromScale(1, 1),
				ClipsDescendants = true,
				ZIndex = 1,
			}, {
				-- window-header: full-width band flush with the slab's top edge.
				Header = e("Frame", {
					BackgroundColor3 = props.chromeColor or Theme.colors.chrome,
					Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
					ZIndex = 2,
				}, {
					Title = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, -(Theme.spacing.xl + HEADER_HEIGHT), 1, 0),
						Position = UDim2.new(0, Theme.spacing.xl, 0, 0),
						Text = string.upper(props.title or "WINDOW"),
						FontFace = Theme.typography.heading.font,
						TextSize = Theme.typography.heading.textSize,
						TextColor3 = Theme.colors.onSurface,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextTruncate = Enum.TextTruncate.AtEnd,
						ZIndex = 3,
					}, {
						Stroke = e("UIStroke", {
							Thickness = Theme.strokes.textOutline.thickness,
							Color = Theme.strokes.textOutline.color,
							ApplyStrokeMode = Theme.strokes.textOutline.mode,
						}),
					}),
					-- Close square docked INSIDE the right end, matching header height.
					Close = e(ButtonClose, {
						size = UDim2.fromOffset(HEADER_HEIGHT, HEADER_HEIGHT),
						position = UDim2.new(1, 0, 0, 0),
						anchorPoint = Vector2.new(1, 0),
						zIndex = 4,
						onActivated = requestClose,
					}),
				}),
				Content = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, -HEADER_HEIGHT),
					Position = UDim2.new(0, 0, 0, HEADER_HEIGHT),
					ClipsDescendants = true,
					ZIndex = 1,
				}, {
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, Theme.spacing.lg),
						PaddingRight = UDim.new(0, Theme.spacing.lg),
						PaddingTop = UDim.new(0, Theme.spacing.lg),
						PaddingBottom = UDim.new(0, Theme.spacing.lg),
					}),
					Children = e(React.Fragment, nil, props.children),
				}),
			}),
		}),
	})
end

return Window
