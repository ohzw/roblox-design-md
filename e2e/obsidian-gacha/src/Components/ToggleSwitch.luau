-- toggle-switch from DESIGN.roblox.md: "pill track; ON = primary fill with the
-- white knob slid right, OFF = surface-deep with a gray knob." Knob position
-- and track color are ALSO prop-driven, so they use the frozen-initial-render
-- pattern (motion-implementation.md): render once from the first value, drive
-- every change through a useEffect that tweens via refs, so TweenService stays
-- the sole owner and React never snaps it.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local KNOB_ON = 0.72
local KNOB_OFF = 0.28
local SWITCH = TweenInfo.new(Theme.motion.durations.fast, Theme.motion.easings.settle.style, Theme.motion.easings.settle.direction)

local function ToggleSwitch(props)
	local knobRef = React.useRef(nil)
	local trackRef = React.useRef(nil)
	local initial = React.useRef(props.value == true)

	React.useEffect(function()
		local on = props.value == true
		local knob = knobRef.current
		local track = trackRef.current
		if knob then
			TweenService:Create(knob, SWITCH, {
				Position = UDim2.new(if on then KNOB_ON else KNOB_OFF, 0, 0.5, 0),
			}):Play()
		end
		if track then
			TweenService:Create(track, SWITCH, {
				BackgroundColor3 = if on then Theme.colors.primary else Theme.colors.surfaceDeep,
			}):Play()
		end
	end, { props.value })

	local startOn = initial.current

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = if startOn then Theme.colors.primary else Theme.colors.surfaceDeep,
		Size = props.size or UDim2.fromOffset(54, 28),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		ref = trackRef,
		[React.Event.Activated] = function()
			if props.onChanged then
				props.onChanged(not (props.value == true))
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.panel.thickness,
			Color = Theme.strokes.panel.color,
			ApplyStrokeMode = Theme.strokes.panel.mode,
		}),
		Knob = e("Frame", {
			BackgroundColor3 = Theme.colors.onSurface,
			Size = UDim2.fromOffset(22, 22),
			Position = UDim2.new(if startOn then KNOB_ON else KNOB_OFF, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = (props.zIndex or 1) + 1,
			ref = knobRef,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		}),
	})
end

return ToggleSwitch
