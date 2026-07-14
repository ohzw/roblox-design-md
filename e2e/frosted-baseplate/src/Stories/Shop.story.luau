-- Standard showcase Shop (standard-showcase.md): the taste's window, titled
-- with its own shop word -- DESIGN.md's Screen Patterns literally head a
-- section "Shop / offers", so "Shop" (Title Case per Typography prose) is
-- used verbatim, no substitution needed. Exactly six items (Acorn/Feather/
-- Crystal/Lantern/Compass/Crown), fixed order and tiers, visible prices,
-- Crown getting the legendary + emphasized treatment. Item visuals are real
-- image assets (Theme.assets.item*) per asset-sourcing.md.
--
-- Screen Patterns ("Shop / offers"): "slab window with a header row (currency
-- pill left, title center-right, cross close right), then full-width product
-- rows: item art left, odds/variant card strip center, price pill(s) right."
-- This taste's own window anatomy (Components: window) has NO header band
-- and NO footer -- "chrome floats; it is never welded on" -- so the
-- documented "header row" is reconciled with the window's own floating
-- title-tab + free-floating cross (both already part of Window), NOT a new
-- integrated bar; the currency pill mentioned in that header row is the
-- HUD's own persistent element, not re-drawn inside the shop window (a
-- window-internal currency repeat is not in this taste's Components
-- section and would duplicate chrome the window's own anatomy doesn't
-- support). The six items are full-width inset ROWS (this taste's item-
-- card-or-row grammar), not a card grid -- see ItemRow.luau.
--
-- Grid density: the taste states no explicit shop density beyond "full-width
-- product rows" in a single column, so all six rows stack vertically
-- (flexing the count per standard-showcase.md's "flex only when the taste
-- states none" -- this taste states rows, not a fixed row count).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local ItemRow = require(script.Parent.Parent.Components.ItemRow)

local e = React.createElement

local ITEMS = {
	{ name = "Acorn", rarity = "common", price = 25, icon = Theme.assets.itemAcorn },
	{ name = "Feather", rarity = "common", price = 40, icon = Theme.assets.itemFeather },
	{ name = "Crystal", rarity = "rare", price = 120, icon = Theme.assets.itemCrystal },
	{ name = "Lantern", rarity = "rare", price = 150, icon = Theme.assets.itemLantern },
	{ name = "Compass", rarity = "epic", price = 600, icon = Theme.assets.itemCompass },
	{ name = "Crown", rarity = "legendary", price = 2500, hardPrice = 99, icon = Theme.assets.itemCrown },
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "Shop",
	},
	story = function(props)
		-- standard-showcase.md's topbar-clearance rule: the mount harness's
		-- ScreenGui is full-bleed (IgnoreGuiInset=true), so y=0 sits UNDER the
		-- Roblox topbar. This window's floating sticker-tab title and
		-- free-floating close cross both overhang ABOVE the panel's own top
		-- edge (Components prose: "half outside the panel... floating free of
		-- the edge") -- at the original centered fromScale(0.5, 0.86) size, the
		-- panel top (and therefore the tab/cross) collided with the topbar in
		-- 720p captures. Anchored top-center with a computed offset (topInset +
		-- margin) instead of a vertically-centered scale so the floating chrome
		-- clears the inset regardless of viewport height; height switches to a
		-- fixed offset sized to the same 1280x720 budget the taste already fits.
		local topInset = game:GetService("GuiService"):GetGuiInset().Y
		local ROW_HEIGHT = 96
		local CANVAS_HEIGHT = ROW_HEIGHT * #ITEMS + Theme.spacing.md * (#ITEMS - 1)
		local rows = {}
		rows.Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.md),
		})
		rows.Acorn = e(ItemRow, { name = ITEMS[1].name, rarity = ITEMS[1].rarity, price = ITEMS[1].price, icon = ITEMS[1].icon, layoutOrder = 1 })
		rows.Feather = e(ItemRow, { name = ITEMS[2].name, rarity = ITEMS[2].rarity, price = ITEMS[2].price, icon = ITEMS[2].icon, layoutOrder = 2 })
		rows.Crystal = e(ItemRow, { name = ITEMS[3].name, rarity = ITEMS[3].rarity, price = ITEMS[3].price, icon = ITEMS[3].icon, layoutOrder = 3 })
		rows.Lantern = e(ItemRow, { name = ITEMS[4].name, rarity = ITEMS[4].rarity, price = ITEMS[4].price, icon = ITEMS[4].icon, layoutOrder = 4 })
		rows.Compass = e(ItemRow, { name = ITEMS[5].name, rarity = ITEMS[5].rarity, price = ITEMS[5].price, icon = ITEMS[5].icon, layoutOrder = 5 })
		-- Crown: legendary + emphasized treatment (gold name/stroke via
		-- ItemRow's own rarity branch) AND the taste's dual price-pill
		-- pairing (Components prose: "They appear side by side; never show
		-- one without a clear icon") -- the only row with a hard-currency
		-- companion price, matching the standard's 99 hard-currency note.
		rows.Crown = e(ItemRow, { name = ITEMS[6].name, rarity = ITEMS[6].rarity, price = ITEMS[6].price, hardPrice = ITEMS[6].hardPrice, icon = ITEMS[6].icon, layoutOrder = 6 })

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = props.controls.Title,
				icon = "\u{25A0}", -- badge icon glyph, matches this window's utility (slab) material
				-- Responsive window pattern: Scale-first size + Window's own
				-- UISizeConstraint MaxSize (600x600, this taste's prior fixed
				-- desktop height budget) so the panel (and the floating tab/
				-- cross that scale with it) can never exceed the viewport at
				-- phone landscape. Height is `1,0,-(topOffset+bottomMargin)`
				-- rather than a pure Scale fraction: the panel is top-anchored
				-- at a fixed offset (topInset + 40, clearing the floating
				-- tab/cross above it), so its height must subtract that same
				-- offset (plus a bottom margin) from the full-bleed root or a
				-- short viewport (667x375) pushes the panel bottom off-screen.
				size = UDim2.new(0.5, 0, 1, -(topInset + 40 + 24)),
				maxSize = Vector2.new(600, 600),
				position = UDim2.new(0.5, 0, 0, topInset + 40),
				anchorPoint = Vector2.new(0.5, 0),
			}, {
				-- Content region is a ScrollingFrame (Responsive window
				-- pattern): 6 rows at 96px + gaps always exceed a phone-
				-- landscape panel's available height.
				List = e("ScrollingFrame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					CanvasSize = UDim2.new(0, 0, 0, CANVAS_HEIGHT),
					ScrollBarThickness = 6,
					ScrollBarImageColor3 = Theme.colors.onSurface,
					ScrollBarImageTransparency = 0.3,
					ZIndex = 2,
				}, rows),
			}),
		})
	end,
}
