-- Standard showcase: Shop.story (standard-showcase.md).
-- Screen Patterns ("Shop window", observed): header band (title + RESTOCK +
-- close) -> scrolling list of row-cards; "no footer CTA -- purchases happen
-- in-row." This taste's own Overview rule #3 is explicit: "Commerce is a
-- list, not a grid" -- so unlike grid-grammar tastes in this catalog, the
-- fixed six-item set renders as full-width RowCards in a single scrolling
-- column, per this taste's own density (Layout prose: "a window shows 2-3
-- rows per screenful, scrolled").
-- Title: DESIGN.md uses "Seed Shop" / "shop window" -- SHOP is used directly
-- per standard-showcase.md ("titled with the taste's own shop word").
-- Fixed catalog set: Acorn/Feather (common), Crystal/Lantern (rare), Compass
-- (standard-showcase.md's "epic" tier -- this taste's own Colors prose
-- defines an explicit six-step scale, common/uncommon/rare/legendary/divine/
-- transcendent, with NO "epic" rung; mapped to this taste's "divine", the
-- rung directly below legendary, so Compass reads one step under Crown
-- without colliding with Crystal/Lantern's shared "rare"), Crown (legendary +
-- this taste's emphasis: the red "Limited!" ribbon + info badge are its two
-- per-row emphasis devices -- Crown gets BOTH, reading as the header's
-- featured restock). Prices 25/40/120/150/600/2500 in currency-soft green
-- (Do's and Don'ts: price color is exclusive to currency-soft). Item art:
-- real image assets (Theme.assets.item*) per asset-sourcing.md, rendered
-- inside each row's surface-well.
-- Buy-control: no distinct voice exists in this taste's soft-currency path
-- (see RowCard's own header comment) -- the row itself (RowCard's root
-- TextButton) IS the buy control, read via the visible currency-soft price.
-- The confirm-popup step this tap would open is the dedicated Dialog.story
-- deliverable, not re-wired here.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local RowCard = require(script.Parent.Parent.Components.RowCard)

local e = React.createElement

local ROW_HEIGHT = 128 -- ~3.5:1 width:height at reference row width (RowCard's own token)

-- Fixed standard-showcase catalog: identical content across every taste.
local ITEMS = {
	{ name = "Acorn", rarity = "common", price = 25, icon = "itemAcorn", stockText = "x12 Stock" },
	{ name = "Feather", rarity = "common", price = 40, icon = "itemFeather", stockText = "x8 Stock" },
	{ name = "Crystal", rarity = "rare", price = 120, icon = "itemCrystal", stockText = "x5 Stock" },
	{ name = "Lantern", rarity = "rare", price = 150, icon = "itemLantern", stockText = "x3 Stock" },
	{ name = "Compass", rarity = "divine", price = 600, icon = "itemCompass", stockText = "x1 Stock" }, -- showcase "epic" tier mapped to this taste's own "divine" rung (see header comment)
	{
		name = "Crown",
		rarity = "legendary",
		price = 2500,
		icon = "itemCrown",
		stockText = "x1 Stock",
		limited = true, -- this taste's emphasis/limited treatment (red ribbon)
		infoBadge = true,
	},
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "Shop",
		ActionText = "RESTOCK",
	},
	story = function(props)
		local rows = {}
		rows.Layout = e("UIListLayout", {
			Padding = UDim.new(0, Theme.spacing.md),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		for i, item in ipairs(ITEMS) do
			rows["Row" .. i] = e(RowCard, {
				name = item.name,
				stockText = item.stockText,
				price = "$" .. tostring(item.price) .. "\u{00A2}",
				rarity = item.rarity,
				icon = Theme.assets[item.icon],
				limited = item.limited,
				infoBadge = item.infoBadge,
				layoutOrder = i,
				size = UDim2.new(1, -Theme.spacing.md, 0, ROW_HEIGHT), -- clears the slim scrollbar gutter
			})
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = props.controls.Title,
				actionText = props.controls.ActionText,
				-- Responsive window pattern: Scale-first size + Window's own
				-- UISizeConstraint MaxSize (560x560, this taste's prior fixed
				-- desktop size) -- the panel's fixed offset previously exceeded
				-- 375px viewport height at phone landscape, pushing the
				-- integrated header band off the top of the screen even though
				-- the List below was already a ScrollingFrame.
				size = UDim2.fromScale(0.85, 0.85),
				maxSize = Vector2.new(560, 560),
			}, {
				List = e("ScrollingFrame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					CanvasSize = UDim2.new(0, 0, 0, (ROW_HEIGHT + Theme.spacing.md) * #ITEMS),
					ScrollBarThickness = 8,
					ScrollBarImageColor3 = Theme.colors.onSurface, -- Layout prose: slim light scrollbar, never hidden
					ScrollBarImageTransparency = 0.2,
					ZIndex = 3,
				}, rows),
			}),
		})
	end,
}
