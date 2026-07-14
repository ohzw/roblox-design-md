-- Standard showcase Shop (standard-showcase.md): the taste's window, titled
-- with its own shop word, exactly six items (Acorn/Feather/Crystal/Lantern/
-- Compass/Crown) in that fixed order and tiers, with visible prices, Crown
-- getting the legendary + emphasized treatment. Item visuals are real image
-- assets (Theme.assets.item*) per asset-sourcing.md.
--
-- Screen Patterns ("Purchase window"): "header band with counter chip ->
-- two-column grid of item rows... Watermark title echo behind the rows."
-- This taste's own vocabulary calls its spender screen a "Purchase window,"
-- not "Shop" -- DESIGN.md prose never uses the word "Shop"/"Store"/"Market."
-- standard-showcase.md asks for "the taste's own shop word (SHOP / STORE /
-- MARKET...)"; since none of those literal words appear anywhere in this
-- DESIGN.md, "TOYBOX" (the taste's own name, Title Case per Typography
-- prose) is used as the closest taste-native equivalent -- noted here as a
-- substitution per the skill's conflict-surfacing rule.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local ItemCard = require(script.Parent.Parent.Components.ItemCard)

local e = React.createElement

local ITEMS = {
	{ name = "Acorn", rarity = "common", price = 25, icon = Theme.assets.itemAcorn },
	{ name = "Feather", rarity = "common", price = 40, icon = Theme.assets.itemFeather },
	{ name = "Crystal", rarity = "rare", price = 120, icon = Theme.assets.itemCrystal },
	{ name = "Lantern", rarity = "rare", price = 150, icon = Theme.assets.itemLantern },
	{ name = "Compass", rarity = "epic", price = 600, icon = Theme.assets.itemCompass },
	{ name = "Crown", rarity = "legendary", price = 2500, icon = Theme.assets.itemCrown },
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Counter = "6/6",
	},
	story = function(props)
		-- Responsive window pattern: content region is a ScrollingFrame
		-- whenever its natural height can exceed the panel. The column
		-- count these 240px-wide cells actually fit is viewport-dependent
		-- (multiple columns at the ~1088px desktop MaxSize width, but far
		-- fewer -- possibly just 1 -- at the ~340px panel width at 667x375
		-- phone landscape), so CanvasSize is bound to the UIGridLayout's own
		-- AbsoluteContentSize rather than a hardcoded row count (a static
		-- assumption went stale the moment the grid wrapped to a different
		-- column count under a narrower panel -- verified failure mode in
		-- this same pattern on loud-slab's Shop.story).
		local gridLayoutRef = React.useRef(nil)
		local scrollingFrameRef = React.useRef(nil)

		React.useEffect(function()
			local layout = gridLayoutRef.current
			local scrollingFrame = scrollingFrameRef.current
			if not layout or not scrollingFrame then
				return
			end
			local function sync()
				scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
			end
			sync()
			local conn = layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(sync)
			return function()
				conn:Disconnect()
			end
		end, {})

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = "Toybox", -- Title Case; substitution for "Shop/Store/Market" (see header note)
				icon = "\u{25A0}",
				counterText = props.controls.Counter,
				-- Responsive window pattern: Window's own UISizeConstraint
				-- MaxSize (this taste's prior fixed desktop fraction,
				-- expressed as pixels at the 1280x720 budget other stories in
				-- this taste target) so the panel never exceeds the viewport
				-- at phone landscape; size stays this taste's own Scale
				-- fraction (already Scale-first, unlike the fixed-offset
				-- shop windows this pattern was written for).
				size = UDim2.fromScale(0.85, 0.8),
				maxSize = Vector2.new(1088, 576),
			}, {
				Grid = e("ScrollingFrame", {
					ref = scrollingFrameRef,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ScrollBarThickness = 6,
					ScrollBarImageColor3 = Theme.colors.onSurface,
					ScrollBarImageTransparency = 0.3,
					ZIndex = 5,
				}, {
					Layout = e("UIGridLayout", {
						ref = gridLayoutRef,
						CellSize = UDim2.fromOffset(240, 300),
						CellPadding = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
					}),
					Acorn = e(ItemCard, { name = ITEMS[1].name, rarity = ITEMS[1].rarity, price = ITEMS[1].price, icon = ITEMS[1].icon, layoutOrder = 1 }),
					Feather = e(ItemCard, { name = ITEMS[2].name, rarity = ITEMS[2].rarity, price = ITEMS[2].price, icon = ITEMS[2].icon, layoutOrder = 2 }),
					Crystal = e(ItemCard, { name = ITEMS[3].name, rarity = ITEMS[3].rarity, price = ITEMS[3].price, icon = ITEMS[3].icon, layoutOrder = 3 }),
					Lantern = e(ItemCard, { name = ITEMS[4].name, rarity = ITEMS[4].rarity, price = ITEMS[4].price, icon = ITEMS[4].icon, layoutOrder = 4 }),
					Compass = e(ItemCard, { name = ITEMS[5].name, rarity = ITEMS[5].rarity, price = ITEMS[5].price, icon = ITEMS[5].icon, layoutOrder = 5 }),
					Crown = e(ItemCard, { name = ITEMS[6].name, rarity = ITEMS[6].rarity, price = ITEMS[6].price, icon = ITEMS[6].icon, layoutOrder = 6 }),
				}),
			}),
		})
	end,
}
