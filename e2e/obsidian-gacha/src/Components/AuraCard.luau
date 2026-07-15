-- card-grid (+ -selected) from DESIGN.roblox.md: a dark aura tile whose corner
-- brackets AND gradient name text recolor to the aura's rarity; a quantity
-- badge bottom-right; top rarities become a filled glowing tile; the selected
-- tile brightens its fill and its brackets go full-bright. Rarity is a
-- per-aura hue driven from Theme.rarity (fails soft to `common`).
--
-- Shop use: pass `price` (+ icon) and `onBuy` to dock the taste's buy pill
-- (ActionButton variant "buy") INSIDE the card — stories compose, the card
-- owns its anatomy (standard-showcase.md).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local CornerBrackets = require(script.Parent.CornerBrackets)
local ActionButton = require(script.Parent.ActionButton)

local e = React.createElement

local function AuraCard(props)
	local rarityColor = Theme.rarity[props.rarity] or Theme.rarity.common
	local filled = Theme.rarityFilled[props.rarity] == true
	local selected = props.selected == true
	local bracketColor = if selected then Theme.colors.onSurface else rarityColor
	local baseFill = if selected then Theme.derived.selectedCardFill else Theme.derived.cardFill

	local children = {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		-- filled/glowing wash for high rarity (rarity hue at high transparency
		-- over the dark fill — no new palette introduced).
		Wash = if filled
			then e("Frame", {
				BackgroundColor3 = rarityColor,
				BackgroundTransparency = 0.82,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 1,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			})
			else nil,
		Brackets = e(CornerBrackets, {
			color = bracketColor,
			arm = 16,
			inset = 5,
			thickness = 3,
			zIndex = 3,
		}),
		Icon = if props.icon
			then e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.icon,
				ImageColor3 = if props.tintIcon == false then Color3.new(1, 1, 1) else rarityColor,
				Size = UDim2.fromScale(0.42, 0.42),
				Position = UDim2.fromScale(0.5, 0.36),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 2,
			})
			else nil,
		-- holographic name: a rarity-hue -> cool-white gradient sheen on the
		-- rarity-colored text, with a faint same-hue glow (thin contextual
		-- stroke) standing in for the soft outer glow (Typography prose).
		Name = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -Theme.spacing.sm, 0, 22),
			Position = UDim2.new(0.5, 0, if props.icon then 0.62 else 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = props.name or "Aura",
			FontFace = Theme.typography.caption.font,
			-- white base: the rarity->white holographic sheen comes from the
			-- UIGradient below, which multiplies with TextColor3 (see Theme.white).
			TextColor3 = Theme.white,
			TextScaled = true,
			ZIndex = 3,
		}, {
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.body.textSize }),
			Gradient = e("UIGradient", {
				Color = ColorSequence.new(rarityColor, Theme.colors.onSurface),
				Rotation = 90,
			}),
			Glow = e("UIStroke", {
				Thickness = 1,
				Color = rarityColor,
				Transparency = 0.45,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			}),
		}),
		Qty = if props.qty
			then e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.new(0, 0, 0, 16),
				Position = UDim2.new(1, -Theme.spacing.xs, 1, -Theme.spacing.xs),
				AnchorPoint = Vector2.new(1, 1),
				Text = tostring(props.qty),
				FontFace = Theme.typography.caption.font,
				TextColor3 = Theme.colors.onSurface,
				TextSize = Theme.typography.caption.textSize,
				ZIndex = 3,
			})
			else nil,
		-- shop buy pill, docked bottom, INSIDE the card.
		Buy = if props.price
			then e(ActionButton, {
				variant = "buy",
				price = props.price,
				icon = props.priceIcon,
				size = UDim2.new(1, -Theme.spacing.sm, 0, 34),
				position = UDim2.new(0.5, 0, 1, -Theme.spacing.xs),
				anchorPoint = Vector2.new(0.5, 1),
				zIndex = 4,
				onActivated = props.onBuy,
			})
			else nil,
	}

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = baseFill,
		Size = props.size or UDim2.fromOffset(150, 150),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, children)
end

return AuraCard
