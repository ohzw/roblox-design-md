-- button-buy from DESIGN.roblox.md (Indigo Quartermaster): full pill,
-- currency icon left, bold amount right. {colors.secondary} for soft
-- currency; premium-currency prices swap the fill to {colors.primary} (this
-- taste's green also means "price you can afford", not just confirm). Lives
-- centered near card bottoms and inline in rows. Full rounding is reserved
-- for prices/counters -- never spend it on an ordinary button.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local PILL_HEIGHT = 36 -- visible token height
local TOUCH_HEIGHT = 44 -- invisible touch root (tap-target vs token conflict)

local VARIANTS = {
	soft = { fill = Theme.colors.secondary, pressed = Theme.derived.secondaryPressed },
	premium = { fill = Theme.colors.primary, pressed = Theme.derived.primaryPressed },
}

local function ButtonBuy(props)
	local pillRef = React.useRef(nil)
	local variant = VARIANTS[props.currency or "soft"]

	local function lift(color, info)
		local rbx = pillRef.current
		if rbx then
			TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
		end
	end

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
			lift(variant.pressed, LIFT_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			lift(variant.fill, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			lift(variant.fill, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Pill = e("Frame", {
			ref = pillRef,
			BackgroundColor3 = variant.fill,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.fromOffset(0, PILL_HEIGHT),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
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
			-- Currency icon: real sourced asset (Theme.assets), monochrome
			-- white line-art tinted via ImageColor3 (asset-sourcing.md tinting
			-- rule) so one asset serves both currency variants' fill colors.
			Icon = e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = if props.currency == "premium"
					then Theme.assets.iconCurrencyPremium
					else Theme.assets.iconCurrencySoft,
				ImageColor3 = Theme.colors.onSurface,
				Size = UDim2.fromOffset(16, 16),
				LayoutOrder = 1,
				ZIndex = 3,
			}),
			Amount = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.new(0, 0, 1, 0),
				Text = tostring(props.amount or 0),
				FontFace = Theme.typography.label.font,
				TextSize = Theme.typography.label.textSize,
				TextColor3 = Theme.colors.onSurface,
				LayoutOrder = 2,
				ZIndex = 3,
			}),
		}),
	})
end

return ButtonBuy
