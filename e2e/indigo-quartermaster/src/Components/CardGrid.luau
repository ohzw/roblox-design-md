-- card-grid from DESIGN.roblox.md (Indigo Quartermaster): flat near-square
-- card, art/item swatch centered, ALL-CAPS name in {colors.accent-info}
-- below, a button-buy pill under that, and a full-width verdict-color strip
-- flush with the card's bottom edge (6px). aspectRatio 0.9 (token). Corners
-- inherit at rounded.md (8px, "floating popup windows, cards, HUD pills");
-- the bottom strip terminates flush with the card's own bottom radius (never
-- squared off against the card's rounding -- "corner strips and bands
-- terminate flush with their parent's corners").
--
-- -emphasized state (standard-showcase.md's "ONE emphasized/limited variant"
-- slot, e.g. Crown/legendary): the taste's own {strokes.selection} (2px
-- white -- "marks the selected cell in a grid... inferred for lobby grids")
-- applied DIRECTLY on this root, not as an external sibling overlay -- a
-- separate Frame keyed to the same LayoutOrder does NOT share this card's
-- UIGridLayout cell (grid layout gives every child, tied LayoutOrder or not,
-- its own sequential cell), so the stroke must live on the card itself.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local ButtonBuy = require(script.Parent.ButtonBuy)

local e = React.createElement

-- Verdict-color strip along the card's bottom edge: green = owned/free,
-- {colors.danger-soft} = cost/locked, {colors.accent-info} = informational.
local VERDICT_COLORS = {
	owned = Theme.colors.primary,
	cost = Theme.colors.dangerSoft,
	info = Theme.colors.accentInfo,
}

local function CardGrid(props)
	local verdictColor = VERDICT_COLORS[props.verdict or "cost"]

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.surfaceRaised,
		Size = props.size or UDim2.fromOffset(220, 244),
		LayoutOrder = props.layoutOrder,
		ClipsDescendants = true, -- keeps the bottom strip flush inside the rounded corner
		ZIndex = props.zIndex,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
		Ratio = e("UIAspectRatioConstraint", { AspectRatio = 0.9 }),
		Selection = if props.emphasized
			then e("UIStroke", {
				Thickness = Theme.strokes.selection.thickness,
				Color = Theme.strokes.selection.color,
				ApplyStrokeMode = Theme.strokes.selection.mode,
			})
			else nil,
		-- Art well: surfaceDeep backing frame (unchanged taste anatomy) with the
		-- item's real sourced icon (Theme.assets, see asset-sourcing.md)
		-- centered inside. Monochrome siblings tint via ImageColor3;
		-- Acorn/Crown are kept full-color per the tie-break rule and render
		-- untinted (ImageColor3 left at the ImageLabel default white == no-op).
		Art = e("Frame", {
			BackgroundColor3 = props.artColor or Theme.colors.surfaceDeep,
			Size = UDim2.new(1, -(Theme.spacing.md * 2), 0.5, 0),
			Position = UDim2.new(0.5, 0, 0, Theme.spacing.md),
			AnchorPoint = Vector2.new(0.5, 0),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Icon = if props.icon
				then e("ImageLabel", {
					BackgroundTransparency = 1,
					Image = props.icon,
					ImageColor3 = props.iconTint or Theme.colors.onSurface,
					Size = UDim2.fromScale(0.6, 0.6),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					ZIndex = 3,
				})
				else nil,
		}),
		Name = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -(Theme.spacing.md * 2), 0, 20),
			Position = UDim2.new(0.5, 0, 0.5, 4),
			AnchorPoint = Vector2.new(0.5, 0),
			Text = string.upper(props.name or "ITEM"),
			FontFace = Theme.typography.label.font,
			TextSize = Theme.typography.label.textSize,
			TextColor3 = Theme.colors.accentInfo,
			ZIndex = 2,
		}),
		Buy = e(ButtonBuy, {
			amount = props.price or 0,
			currency = props.currency or "soft",
			position = UDim2.new(0.5, 0, 0.5, 34),
			anchorPoint = Vector2.new(0.5, 0),
			zIndex = 2,
		}),
		-- Full-width verdict band flush with the bottom edge.
		VerdictBand = e("Frame", {
			BackgroundColor3 = verdictColor,
			Size = UDim2.new(1, 0, 0, 6),
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),
			ZIndex = 2,
		}),
	})
end

return CardGrid
