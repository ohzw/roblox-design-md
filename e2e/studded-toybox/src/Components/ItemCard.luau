-- card-grid from DESIGN.roblox.md: squared dark translucent cells with 2px
-- ink borders; "the collection index shows silhouetted contents until
-- unlocked. Rarity/status reads through content color, not through cell
-- chrome" (Components prose). backgroundColor #00000066 -> 0.60 transparency.
--
-- This is the standard-showcase.md "item-card-or-row" slot: a square grid
-- card (this taste's shop grammar is the two-column ROW grid per Screen
-- Patterns' "Purchase window", but card-grid's own anatomy is a square cell,
-- and six items read better as a grid than six tall rows at catalog scale --
-- kept square per the card-grid token's own aspectRatio: 1). The emphasized
-- (legendary/limited) variant reads through content, exactly as the prose
-- prescribes: a gold badge-slot tag and the item's own render, NOT a
-- different cell chrome -- no cell-level "rare glow" exists in this taste.
--
-- Buy control anatomy is button-buy (GradientButton variant "buy"), always
-- inside the card per Components prose: "Always inside a row or card, never
-- free-floating."

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local BadgeSlot = require(script.Parent.BadgeSlot)
local GradientButton = require(script.Parent.GradientButton)

local e = React.createElement

local RARITY_LABEL = {
	common = "COMMON",
	rare = "RARE",
	epic = "EPIC",
	legendary = "LEGENDARY",
}

local function ItemCard(props)
	local emphasized = props.rarity == "legendary"

	return e("Frame", {
		BackgroundColor3 = Theme.inks.cardGridFill,
		BackgroundTransparency = Theme.transparencies.cardGridFill,
		Size = props.size or UDim2.fromOffset(240, 240 / Theme.metrics.cardGridAspect),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			-- Emphasized/limited treatment reads through content color per
			-- Components prose -- a heavier gold-tinted ink border instead of a
			-- new cell chrome (still the SAME strokes.outline anatomy, just the
			-- taste's currency-soft gold standing in for ink on this one cell).
			Thickness = if emphasized then Theme.strokes.outlineHeavy.thickness else Theme.strokes.outline.thickness,
			Color = if emphasized then Theme.colors.currencySoft else Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.xs),
		}),
		Padding = e("UIPadding", {
			PaddingTop = UDim.new(0, Theme.spacing.sm),
			PaddingBottom = UDim.new(0, Theme.spacing.sm),
			PaddingLeft = UDim.new(0, Theme.spacing.sm),
			PaddingRight = UDim.new(0, Theme.spacing.sm),
		}),
		Render = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 96),
			LayoutOrder = 1,
		}, {
			Icon = e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.icon,
				ImageColor3 = if emphasized then Theme.colors.currencySoft else Theme.colors.onSurface,
				Size = UDim2.fromOffset(88, 88),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
			}),
			RarityTag = e(BadgeSlot, {
				text = RARITY_LABEL[props.rarity] or "COMMON",
				fill = if emphasized then Theme.colors.currencySoft else nil,
				position = UDim2.new(0.5, 0, 1, 0),
				anchorPoint = Vector2.new(0.5, 1),
				size = UDim2.fromOffset(112, 28),
				zIndex = 2,
			}),
		}),
		Name = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 32),
			Text = props.name or "Item",
			FontFace = Theme.typography.label.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			LayoutOrder = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
		}),
		Buy = e(GradientButton, {
			variant = "buy",
			text = tostring(props.price or 0),
			size = UDim2.new(1, 0, 0, 44),
			layoutOrder = 3,
			onActivated = props.onBuy,
		}),
	})
end

return ItemCard
