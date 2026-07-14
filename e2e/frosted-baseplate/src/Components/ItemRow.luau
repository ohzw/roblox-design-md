-- item-card-or-row (standard-showcase.md slot) from DESIGN.roblox.md (Frosted
-- Baseplate) Screen Patterns / "Shop / offers": "full-width product rows:
-- item art left, odds/variant card strip center, price pill(s) right." This
-- taste's shop grammar is ROWS, not a card grid -- the window's whole anatomy
-- is "a single padded column of inset rows" (Components: window), so the
-- item slot reuses that same inset-row shape rather than inventing a card.
--
-- Inset row: surface-deep fill, rounded.sm, NO stroke (Elevation prose:
-- "inset rows... no strokes on rows... depth inside slabs comes from darker
-- fills"). Item art sits on card-grid (ice-blue gradient + outline-ice
-- stroke) per Components prose ("odds/variant card strip") -- the art chip
-- is the one place inside a row allowed a stroke, since it is its OWN
-- card-grid token, not the row.
--
-- Emphasized/limited (Crown, legendary): standard-showcase.md requires the
-- taste's own emphasized treatment. This taste's `accent-rare` gold is
-- reserved for "featured reward columns, event headline text" (Colors
-- prose) -- the closest documented emphasis lever -- so the legendary row's
-- name label and art-chip stroke both switch to accentRare gold. No
-- separate "rare glow" chrome exists in this taste's Components section, so
-- nothing new is invented beyond that documented gold accent.
--
-- Buy control: dual BuyPill (soft + hard) side by side per Components prose
-- ("They appear side by side; never show one without a clear icon"); items
-- without a hard-currency price show only the soft pill (never fabricate a
-- premium price the standard set doesn't define).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local BuyPill = require(script.Parent.BuyPill)

local e = React.createElement

local RARITY_LABEL = {
	common = "Common",
	rare = "Rare",
	epic = "Epic",
	legendary = "Legendary",
}

local ART_SIZE = 72
local BUY_PILL_TOUCH_WIDTH = 96 -- BuyPill's default touch-root width (see BuyPill.luau)
local PRICES_MAX_WIDTH = BUY_PILL_TOUCH_WIDTH * 2 + Theme.spacing.sm -- widest Prices frame: two pills + their gap

local function ItemRow(props)
	local emphasized = props.rarity == "legendary"
	local nameColor = if emphasized then Theme.colors.accentRare else Theme.colors.onSurface
	local artStrokeColor = if emphasized then Theme.colors.accentRare else Theme.strokes.outlineIce.color

	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDeep, -- inset row: NO outer glow, no extra stroke
		Size = UDim2.new(1, 0, 0, 96),
		LayoutOrder = props.layoutOrder,
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
			Padding = UDim.new(0, Theme.spacing.md),
		}),
		-- Item art: card-grid token (ice-blue gradient + outline-ice stroke),
		-- the row's one permitted stroke since it is a distinct chip, not the
		-- row's own chrome.
		Art = e("Frame", {
			BackgroundColor3 = Theme.gradients.cardGrid[1],
			Size = UDim2.fromOffset(ART_SIZE, ART_SIZE),
			LayoutOrder = 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
			Gradient = e("UIGradient", {
				Rotation = 90,
				Color = ColorSequence.new(Theme.gradients.cardGrid[1], Theme.gradients.cardGrid[2]),
			}),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outlineIce.thickness,
				Color = artStrokeColor,
				ApplyStrokeMode = Theme.strokes.outlineIce.mode,
			}),
			Icon = e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.icon,
				Size = UDim2.fromScale(0.7, 0.7),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 2,
			}),
		}),
		-- Name + rarity strip (the "odds/variant card strip center" of the
		-- Screen Patterns prose, collapsed to a name + rarity caption since
		-- this catalog slice has no odds data to show).
		Info = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -(ART_SIZE + PRICES_MAX_WIDTH + Theme.spacing.md * 2), 1, 0),
			LayoutOrder = 2,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.xs),
			}),
			Name = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 30),
				Text = props.name or "Item", -- Title Case per Typography prose
				FontFace = Theme.typography.body.font,
				TextSize = Theme.typography.body.textSize,
				TextColor3 = nameColor,
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = 1,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
			}),
			Rarity = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 20),
				Text = RARITY_LABEL[props.rarity] or "Common", -- Title Case, never ALL CAPS
				FontFace = Theme.typography.caption.font,
				TextSize = Theme.typography.caption.textSize,
				TextColor3 = Theme.colors.onSurface,
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = 2,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
			}),
		}),
		-- Dual price pills, side by side (Components prose), right-aligned.
		Prices = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(if props.hardPrice then PRICES_MAX_WIDTH else BUY_PILL_TOUCH_WIDTH + Theme.spacing.sm, 44),
			LayoutOrder = 3,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.sm),
			}),
			Soft = e(BuyPill, {
				variant = "soft",
				amount = props.price,
				layoutOrder = 1,
			}),
			Hard = props.hardPrice and e(BuyPill, {
				variant = "hard",
				amount = props.hardPrice,
				layoutOrder = 2,
			}) or nil,
		}),
	})
end

return ItemRow
