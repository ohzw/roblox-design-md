-- button-buy / button-buy-rose from DESIGN.roblox.md (Candlelit Parlor):
-- the price pill — bright accent fill (gold for goods, salmon for
-- revive-class items), platform-currency glyph left, dark same-family
-- digits ("a price tag tied with string"). Dark-ink-on-bright-pill is the
-- signature — never white text here. 8px corners (rectangles, not
-- capsules), 36px tall, strokeless, shadowless.
-- The visible pill is 36px (token height); the transparent root supplies
-- the 44px+ touch frame the Layout rules require.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local PILL_HEIGHT = 36 -- button-buy height token
local TOUCH_HEIGHT = 44 -- minimum tap target (layout rules)

local VARIANTS = {
	gold = {
		fill = Theme.colors.currencySoft,
		ink = Theme.colors.currencyInk,
		pressed = Theme.derived.currencySoftPressed,
	},
	rose = {
		fill = Theme.colors.danger,
		ink = Theme.colors.dangerInk,
		pressed = Theme.derived.dangerPressed,
	},
}

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

local function BuyPill(props)
	local pillRef = React.useRef(nil)

	local variant = VARIANTS[props.variant or "gold"]
	local disabled = props.disabled

	local function lift(color, info)
		local rbx = pillRef.current
		if rbx then
			TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
		end
	end

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = props.size or UDim2.fromOffset(0, TOUCH_HEIGHT),
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
			lift(variant.fill, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			lift(variant.fill, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if not disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Pill = e("Frame", {
			ref = pillRef,
			BackgroundColor3 = variant.fill,
			BackgroundTransparency = if disabled then Theme.derived.disabledTransparency else 0,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.fromOffset(0, PILL_HEIGHT),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.md),
				PaddingRight = UDim.new(0, Theme.spacing.md),
			}),
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.xs),
			}),
			-- Platform-currency glyph (Robux), same dark family ink as the digits
			Glyph = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.new(0, 0, 1, 0),
				Text = "\u{E002}",
				FontFace = Theme.typography.label.font,
				TextSize = Theme.typography.label.textSize,
				TextColor3 = variant.ink,
				TextTransparency = if disabled then Theme.derived.disabledTransparency else 0,
				LayoutOrder = 1,
				ZIndex = 3,
			}),
			Amount = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.new(0, 0, 1, 0),
				Text = tostring(props.amount or 0),
				FontFace = Theme.typography.label.font,
				TextSize = Theme.typography.label.textSize, -- label uses fixed textSize
				TextColor3 = variant.ink,
				TextTransparency = if disabled then Theme.derived.disabledTransparency else 0,
				LayoutOrder = 2,
				ZIndex = 3,
			}),
		}),
	})
end

return BuyPill
