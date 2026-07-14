-- button-cta from DESIGN.roblox.md (Indigo Quartermaster): "the lobby PLAY
-- slab: oversized, bright green horizontal gradient, white caps heading-size
-- label. Exactly one per screen, center stage. The only gradient in the
-- entire system." Token: gradient horizontal(#31E856, #22DA34), rounded.sm,
-- no stroke/shadow, size "scale ~0.25 wide, aspect ~4:1". Press feedback:
-- this taste darkens fills one value step and never squashes -- applied here
-- as a same-ratio darken of BOTH gradient stops (Theme.derived.ctaGradient*
-- Pressed), not a squash.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

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

local function ButtonCta(props)
	local gradientRef = React.useRef(nil)

	local function lift(colorTop, colorBottom, info)
		local gradient = gradientRef.current
		if gradient then
			TweenService:Create(gradient, info, {
				Color = ColorSequence.new(colorTop, colorBottom),
			}):Play()
		end
	end

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.primary, -- fallback fill under the gradient
		-- "scale ~0.25 wide, aspect ~4:1" token; offset height keeps the touch
		-- target finger-sized regardless of container width.
		Size = props.size or UDim2.new(0.25, 0, 0, 72),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			lift(Theme.derived.ctaGradientTopPressed, Theme.derived.ctaGradientBottomPressed, LIFT_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			lift(Theme.derived.ctaGradientTop, Theme.derived.ctaGradientBottom, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			lift(Theme.derived.ctaGradientTop, Theme.derived.ctaGradientBottom, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Gradient = e("UIGradient", {
			ref = gradientRef,
			Color = ColorSequence.new(Theme.derived.ctaGradientTop, Theme.derived.ctaGradientBottom),
			Rotation = 0, -- horizontal, per the token
		}),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = string.upper(props.text or "PLAY"),
			FontFace = Theme.typography.heading.font,
			TextSize = Theme.typography.heading.textSize,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = (props.zIndex or 1) + 1,
		}),
	})
end

return ButtonCta
