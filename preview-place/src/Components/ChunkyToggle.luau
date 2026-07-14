-- Settings-row toggle per DESIGN.roblox.md Screen Patterns ("Settings"):
-- an outlined pill track with the knob carrying the bevel.
-- Anatomy: root pill (track fill, outline stroke) > Knob circle
-- (bevel color, outline) > Face (cream fill, sits KNOB_BEVEL px short of the
-- bottom). On = primary green track, off = neutral surface-deep track.
-- Knob slides between the pill ends with settle easing (durations.fast);
-- pressing squashes to 0.92 and collapses the knob bevel, like every button.
--
-- The knob/track are animated by TweenService via refs: their animated
-- properties are rendered ONCE from the initial value and never re-rendered,
-- so React does not fight the tweens.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement
local KNOB_BEVEL = 4

local ON_POSITION = UDim2.fromScale(1, 0.5)
local ON_ANCHOR = Vector2.new(1, 0.5)
local OFF_POSITION = UDim2.fromScale(0, 0.5)
local OFF_ANCHOR = Vector2.new(0, 0.5)

-- Knob slide + track recolor: a value change -> settle easing (DESIGN.md Motion).
local SLIDE = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
-- Press squash (DESIGN.md Motion): 0.92 at durations.instant, restore with settle.
local SQUASH_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local SQUASH_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function trackColor(value)
	return if value then Theme.colors.primary else Theme.colors.surfaceDeep
end

local function ChunkyToggle(props)
	local pressed, setPressed = React.useState(false)
	local scaleRef = React.useRef(nil)
	local trackRef = React.useRef(nil)
	local knobRef = React.useRef(nil)
	-- Frozen first-render value: the animated props below always render from
	-- this, so re-renders never snap the knob out from under a tween.
	local initialValue = React.useRef(props.value)
	local isFirstEffect = React.useRef(true)

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	React.useEffect(function()
		if isFirstEffect.current then
			-- First render already placed the knob; nothing to animate.
			isFirstEffect.current = false
			return
		end
		local knob = knobRef.current
		local track = trackRef.current
		if knob then
			TweenService:Create(knob, SLIDE, {
				Position = if props.value then ON_POSITION else OFF_POSITION,
				AnchorPoint = if props.value then ON_ANCHOR else OFF_ANCHOR,
			}):Play()
		end
		if track then
			TweenService:Create(track, SLIDE, {
				BackgroundColor3 = trackColor(props.value),
			}):Play()
		end
	end, { props.value })

	return e("TextButton", {
		ref = trackRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = trackColor(initialValue.current),
		Size = props.size or UDim2.fromOffset(100, 56),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			setPressed(true)
			squash(0.92, SQUASH_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			setPressed(false)
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			setPressed(false)
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onToggle then
				props.onToggle(not props.value)
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Knob = e("Frame", {
			ref = knobRef,
			BackgroundColor3 = Theme.bevels.knob,
			Size = UDim2.fromScale(1, 1),
			Position = if initialValue.current then ON_POSITION else OFF_POSITION,
			AnchorPoint = if initialValue.current then ON_ANCHOR else OFF_ANCHOR,
			ZIndex = 2,
		}, {
			Ratio = e("UIAspectRatioConstraint", { AspectRatio = 1 }),
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			Face = e("Frame", {
				BackgroundColor3 = Theme.colors.surface,
				-- Pressed collapses the knob bevel, same affordance as buttons.
				Size = if pressed then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 1, -KNOB_BEVEL),
				ZIndex = 3,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
			}),
		}),
	})
end

return ChunkyToggle
