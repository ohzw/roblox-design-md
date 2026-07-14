-- card-grid from DESIGN.roblox.md (Loud Slab): "near-black wells with thin
-- white strokes; name caption at the top of the cell, rarity caption
-- color-coded at the bottom." rounded.none, {strokes.slot-outline} (2px
-- white). "Don't invent panel-level rarity theming -- rarity lives in text
-- color, not in card fills": the rarity ladder recolors the bottom caption
-- TEXT only (common positive-green, rare accent-rare gold, epic cyan
-- #26C3FE per prose, legendary gets the emphasized/limited treatment: a
-- brighter selected-outline ring + the rarity text, never a recolored fill).
-- Buy control is the button-buy variant of ButtonPrimary, "wide pill-shaped
-- rectangle spanning most of its card, white currency glyph leading the
-- price."

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local ButtonPrimary = require(script.Parent.ButtonPrimary)

local e = React.createElement

-- Rarity ladder recolors TEXT only (Do's-and-Don'ts). Cyan #26C3FE is named
-- in prose for "a higher tier" but has no front-matter token; kept as a
-- component-level literal per Theme.colors.accentEpic (Theme-derived, not a
-- literal in this file).
local RARITY_COLORS = {
	common = Theme.colors.positive,
	rare = Theme.colors.accentRare,
	epic = Theme.colors.accentEpic,
	legendary = Theme.colors.accentRare, -- gold text; the emphasis comes from the outline + badge below, not a new hue
}

local function ItemCard(props)
	local rarity = props.rarity or "common"
	local emphasized = rarity == "legendary" or props.emphasized

	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDeep,
		Size = props.size or UDim2.fromOffset(200, 240),
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Stroke = e("UIStroke", {
			Thickness = if emphasized then Theme.strokes.selectedOutline.thickness else Theme.strokes.slotOutline.thickness,
			Color = if emphasized then Theme.strokes.selectedOutline.color else Theme.strokes.slotOutline.color,
			ApplyStrokeMode = Theme.strokes.slotOutline.mode,
		}),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.sm),
			PaddingRight = UDim.new(0, Theme.spacing.sm),
			PaddingTop = UDim.new(0, Theme.spacing.sm),
			PaddingBottom = UDim.new(0, Theme.spacing.sm),
		}),
		-- Name caption at the top of the cell.
		Name = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 24),
			Text = props.name or "Item",
			FontFace = Theme.typography.label.font,
			TextSize = Theme.typography.label.textSize,
			TextColor3 = Theme.colors.onSurface,
			TextScaled = true,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
		}),
		Art = e("ImageLabel", {
			BackgroundTransparency = 1,
			Image = props.icon or "",
			Size = UDim2.new(0.7, 0, 0, 118), -- square-ish band between the name and rarity/buy captions
			Position = UDim2.new(0.5, 0, 0, 30),
			AnchorPoint = Vector2.new(0.5, 0),
			ScaleType = Enum.ScaleType.Fit,
			ImageColor3 = props.iconColor, -- nil = asset's native color; monochrome icon slots pass Theme.colors.onSurface
			ZIndex = 2,
		}, {
			Ratio = e("UIAspectRatioConstraint", { AspectRatio = 1 }),
		}),
		-- Rarity caption, color-coded, at the bottom of the cell.
		Rarity = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 20),
			Position = UDim2.new(0, 0, 1, -68),
			Text = string.upper(rarity),
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize,
			TextColor3 = RARITY_COLORS[rarity] or Theme.colors.positive,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = 2,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			}),
		}),
		-- buy-control: button-buy pill spanning most of the card width.
		Buy = e(ButtonPrimary, {
			variant = "buy",
			text = tostring(props.price or 0),
			size = UDim2.new(1, 0, 0, 44),
			position = UDim2.new(0, 0, 1, 0),
			anchorPoint = Vector2.new(0, 1),
			zIndex = 2,
			onActivated = props.onBuy,
		}),
	})
end

return ItemCard
