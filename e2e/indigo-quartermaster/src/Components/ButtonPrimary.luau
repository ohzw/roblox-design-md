-- button-primary / button-primary-disabled / button-danger from
-- DESIGN.roblox.md (Indigo Quartermaster): flat rectangle, white bold label,
-- 4px corners, NO stroke, NO shadow, NO squash. "Feels like a form submit."
-- Disabled keeps the shape and mutes fill + label (observed gray chip,
-- "0.0% COMPLETE"). Press feedback: darken the fill one value step
-- (Motion prose) -- never a bevel collapse, this taste has none.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local HEIGHT = 44 -- token height == the tap-target minimum already; no extra touch frame needed

local VARIANTS = {
	primary = { fill = Theme.colors.primary, pressed = Theme.derived.primaryPressed },
	danger = { fill = Theme.colors.danger, pressed = Theme.derived.dangerPressed },
}

-- button-primary-disabled: DESIGN.md-inlined literal hex, not a Theme.colors
-- token (kept as the skill's literal-hex exception, same as the front matter).
local DISABLED_FILL = Color3.fromHex("#4D5076")

local LIFT_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local LIFT_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ButtonPrimary(props)
	local fillRef = React.useRef(nil)
	local disabled = props.disabled
	local variant = VARIANTS[props.variant or "primary"]

	local function lift(color, info)
		local rbx = fillRef.current
		if rbx then
			TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
		end
	end

	return e("TextButton", {
		ref = fillRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = if disabled then DISABLED_FILL else variant.fill,
		Size = props.size or UDim2.new(0, 160, 0, HEIGHT),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			if not disabled then
				lift(variant.pressed, LIFT_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			if not disabled then
				lift(variant.fill, LIFT_OUT)
			end
		end,
		[React.Event.MouseLeave] = function()
			if not disabled then
				lift(variant.fill, LIFT_OUT)
			end
		end,
		[React.Event.Activated] = function()
			if not disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = props.text or "Button",
			FontFace = Theme.typography.label.font,
			TextSize = Theme.typography.label.textSize,
			TextColor3 = if disabled then Theme.colors.onSurfaceMuted else Theme.colors.onSurface,
			ZIndex = (props.zIndex or 1) + 1,
		}),
	})
end

return ButtonPrimary
