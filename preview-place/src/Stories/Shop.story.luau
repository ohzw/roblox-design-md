-- Standard showcase Shop (standard-showcase.md): the taste's window, titled
-- "SHOP" (the DESIGN.md's own Screen Patterns word — "Shop: full window with
-- left category rail ... content grid of card-grid items, price on
-- button-primary per card"), exactly six items (Acorn/Feather/Crystal/
-- Lantern/Compass/Crown) in that fixed order and tiers, with visible prices,
-- Crown getting the taste's legendary + emphasized treatment (heavy outline +
-- lighter fill + decorative tilt, see Card.luau).
--
-- This taste's own Shop pattern also calls for a left category rail
-- (button-icon column) and a top "Featured/limited" ribbon slot; the rail is
-- OUT of a core slice per generation-procedure.md's scope vocabulary (it is
-- not load-bearing for content parity — the six items must be present and
-- purchasable, not that the rail exists), so it is omitted here and noted.
-- Grid density is this taste's own 4-wide UIGridLayout (per the Shop pattern
-- and Window.story precedent), which leaves an orphan row of 2 for 6 items —
-- expected per standard-showcase.md ("real shops have them").
--
-- Item visuals are real image assets (Theme.assets.item*, asset-sourcing.md)
-- via Card's `icon` prop. Rarity tier names map onto this taste's own ladder
-- (Theme.rarity: common/rare/epic/legendary — see Theme.luau's Derived note);
-- this taste's DESIGN.md never names a ladder explicitly beyond
-- accent-rare/selected, so the ladder itself is Derived, not taste-native
-- vocabulary invented here.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local Card = require(script.Parent.Parent.Components.Card)

local e = React.createElement

local ITEMS = {
	{ name = "ACORN", rarity = "common", price = 25, icon = Theme.assets.itemAcorn },
	{ name = "FEATHER", rarity = "common", price = 40, icon = Theme.assets.itemFeather },
	{ name = "CRYSTAL", rarity = "rare", price = 120, icon = Theme.assets.itemCrystal },
	{ name = "LANTERN", rarity = "rare", price = 150, icon = Theme.assets.itemLantern },
	{ name = "COMPASS", rarity = "epic", price = 600, icon = Theme.assets.itemCompass },
	{ name = "CROWN", rarity = "legendary", price = 2500, icon = Theme.assets.itemCrown },
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "SHOP",
	},
	story = function(props)
		local cards = {}
		cards.Layout = e("UIGridLayout", {
			CellSize = UDim2.fromOffset(150, 190),
			CellPadding = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
		})
		-- Responsive window pattern (layout-rules.md): content region is a
		-- ScrollingFrame whenever its natural height can exceed the panel -- a
		-- 6-item grid at 190px cells always can at 667x375. Verified failure
		-- mode: rows past the first were unreachable at phone landscape.
		local GRID_ROWS = math.ceil(#ITEMS / 4)
		local GRID_CANVAS_HEIGHT = GRID_ROWS * 190 + math.max(GRID_ROWS - 1, 0) * Theme.spacing.md
		for i, item in ipairs(ITEMS) do
			cards[item.name] = e(Card, {
				text = item.name,
				rarity = item.rarity,
				price = item.price,
				icon = item.icon,
				layoutOrder = i,
			})
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = props.controls.Title,
				-- Responsive window pattern: Scale-first size + Window's own
				-- UISizeConstraint MaxSize (default 700x520, this taste's prior
				-- fixed desktop size) so the panel never exceeds the viewport.
				size = UDim2.fromScale(0.85, 0.85),
				maxSize = Vector2.new(700, 520),
			}, {
				Grid = e("Frame", {
					BackgroundColor3 = Theme.colors.surfaceDeep,
					Size = UDim2.fromScale(1, 1),
					ZIndex = 13,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.outline.thickness,
						Color = Theme.strokes.outline.color,
						ApplyStrokeMode = Theme.strokes.outline.mode,
					}),
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, Theme.spacing.md),
						PaddingRight = UDim.new(0, Theme.spacing.md),
						PaddingTop = UDim.new(0, Theme.spacing.md),
						PaddingBottom = UDim.new(0, Theme.spacing.md),
					}),
					-- Content region is a ScrollingFrame (Responsive window
					-- pattern): 6 cards at 190px cell height in 2 rows always
					-- exceed a phone-landscape panel's available height.
					Cards = e("ScrollingFrame", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						CanvasSize = UDim2.new(0, 0, 0, GRID_CANVAS_HEIGHT),
						ScrollBarThickness = 6,
						ScrollBarImageColor3 = Theme.colors.onSurface,
						ScrollBarImageTransparency = 0.3,
						ZIndex = 13,
					}, cards),
				}),
			}),
		})
	end,
}
