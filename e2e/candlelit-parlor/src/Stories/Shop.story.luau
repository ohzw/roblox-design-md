-- Standard showcase: Shop.story (standard-showcase.md).
-- The taste's window (ParlorWindow), titled "Shop" (Screen Patterns: "Shop
-- window ... Header row: serif title left"). Content is a single scrolling
-- column of ItemRow strips — this e2e slice's shop grammar (glass rows, thin
-- cream strokes; see ItemRow.luau's header comment for the noted conflict
-- against the DESIGN.md's own card-grid token) rather than the 3-card grid
-- the DESIGN.md's Shop-window Screen Pattern describes, because the six-item
-- standard set is asked to render as rows here. Density stays this taste's
-- own: "one column of full-width strips" (Layout section), so six rows in a
-- single scrolling column is native, not borrowed.
-- Fixed catalog set (standard-showcase.md): Acorn/Feather (common),
-- Crystal/Lantern (rare), Compass (epic), Crown (legendary + emphasis) at
-- 25/40/120/150/600/2500. This taste defines NO rarity ladder at all (its
-- only two-way split is commerce-gold vs. life-rose) — tier captions are
-- plain cream ink; Crown alone gets the taste's top/exclusive treatment (see
-- ItemRow.luau). All six items sit in the gold/commerce accent system (none
-- are life/revive-class), so every BuyPill here uses variant="gold" — rose
-- stays reserved for a life context this showcase doesn't exercise (Do's and
-- Don'ts: "keep gold strictly for commerce and rose strictly for
-- life/exit").
-- Item visuals: real image assets (Theme.assets.item*), asset-sourcing.md.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ParlorWindow = require(script.Parent.Parent.Components.ParlorWindow)
local ItemRow = require(script.Parent.Parent.Components.ItemRow)

local e = React.createElement

-- Fixed standard-showcase catalog: identical content across every taste.
local ITEMS = {
	{ key = "Acorn", title = "Acorn", tier = "Common", price = 25, icon = "itemAcorn", tintable = false },
	{ key = "Feather", title = "Feather", tier = "Common", price = 40, icon = "itemFeather", tintable = true },
	{ key = "Crystal", title = "Crystal", tier = "Rare", price = 120, icon = "itemCrystal", tintable = true },
	{ key = "Lantern", title = "Lantern", tier = "Rare", price = 150, icon = "itemLantern", tintable = false },
	{ key = "Compass", title = "Compass", tier = "Epic", price = 600, icon = "itemCompass", tintable = true },
	{
		key = "Crown",
		title = "Crown",
		tier = "Legendary",
		price = 2500,
		icon = "itemCrown",
		tintable = false,
		emphasized = true, -- this taste's top/exclusive treatment (cream-to-gold gradient + full-bright stroke)
	},
}

local ROW_HEIGHT = 84
local ROW_GAP = 12

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "Shop",
	},
	story = function(props)
		local rows = {}
		rows.Layout = e("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, ROW_GAP),
		})
		for i, item in ITEMS do
			rows[item.key] = e(ItemRow, {
				title = item.title,
				tier = item.tier,
				price = item.price,
				icon = Theme.assets[item.icon],
				tintable = item.tintable,
				emphasized = item.emphasized,
				buyVariant = "gold", -- every showcase item sits in the commerce/gold system
				layoutOrder = i,
			})
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(ParlorWindow, {
				title = props.controls.Title,
				-- Responsive window pattern: Scale-first size + ParlorWindow's
				-- own UISizeConstraint MaxSize (560x560, this taste's prior
				-- fixed desktop size) -- the panel's fixed offset previously
				-- exceeded 375px viewport height at phone landscape, pushing
				-- the header/close off the top of the screen even though the
				-- List below was already a ScrollingFrame.
				size = UDim2.fromScale(0.85, 0.85),
				maxSize = Vector2.new(560, 560),
			}, {
				List = e("ScrollingFrame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					CanvasSize = UDim2.new(0, 0, 0, (ROW_HEIGHT + ROW_GAP) * #ITEMS),
					ScrollBarThickness = 4,
					ScrollBarImageColor3 = Theme.colors.primary, -- one-ink rule: cream scrollbar, dim via transparency
					ScrollBarImageTransparency = 0.5,
					ZIndex = 3,
				}, rows),
			}),
		})
	end,
}
