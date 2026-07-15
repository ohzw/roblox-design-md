-- Standard-showcase Shop through the Obsidian Gacha grammar.
-- The taste has TWO shop surfaces: the aura GRID (rarity cards, in Aura
-- Storage) and the banner-offer stack (Exclusive Shop). The six fixed items
-- have rarity tiers, so they use the taste's rarity-CARD grammar (fill +
-- brackets + name recolor to tier); one signature banner-offer sits above the
-- grid as a featured promo (real shops have them; the six items remain present
-- and purchasable below). Tiers map onto this taste's ladder: common / rare /
-- epic / legendary (Crown = the top rung, filled-glow treatment). Each card
-- owns its buy pill (price + gem glyph). Prices 25/40/120/150/600/2500.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local AuraCard = require(script.Parent.Parent.Components.AuraCard)
local BannerOffer = require(script.Parent.Parent.Components.BannerOffer)
local SegmentedTabs = require(script.Parent.Parent.Components.SegmentedTabs)

local e = React.createElement

local ITEMS = {
	{ name = "Acorn", rarity = "common", price = "25", icon = Theme.assets.itemAcorn },
	{ name = "Feather", rarity = "common", price = "40", icon = Theme.assets.itemFeather },
	{ name = "Crystal", rarity = "rare", price = "120", icon = Theme.assets.itemCrystal },
	{ name = "Lantern", rarity = "rare", price = "150", icon = Theme.assets.itemLantern },
	{ name = "Compass", rarity = "epic", price = "600", icon = Theme.assets.itemCompass },
	{ name = "Crown", rarity = "legendary", price = "2500", icon = Theme.assets.itemCrown },
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {},
	story = function()
		local gridChildren = {
			Layout = e("UIGridLayout", {
				-- cells sized so all six fit one row inside the panel content width
				-- with margin (verified in-engine: 150px clipped Crown at the edge).
				CellSize = UDim2.fromOffset(140, 168),
				CellPadding = UDim2.fromOffset(Theme.spacing.sm, Theme.spacing.sm),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		}
		for i, it in ITEMS do
			gridChildren["Item" .. i] = e(AuraCard, {
				name = it.name,
				rarity = it.rarity,
				icon = it.icon,
				tintIcon = false,
				price = it.price,
				priceIcon = Theme.assets.iconGem,
				layoutOrder = i,
			})
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Win = e(Window, {
				title = "Shop",
				icon = Theme.assets.iconShop,
				iconColor = Theme.colors.danger,
				search = true,
			}, {
				Body = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						Padding = UDim.new(0, Theme.spacing.md),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Featured = e(BannerOffer, {
						title = "2X Gems",
						subtitle = "Get 2x gems everywhere!",
						icon = Theme.assets.iconGem,
						hue = Theme.colors.surfaceDark,
						price = "499",
						layoutOrder = 1,
					}),
					Grid = e("ScrollingFrame", {
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 1, -160),
						CanvasSize = UDim2.new(0, 0, 0, 372),
						ScrollBarThickness = 4,
						ScrollBarImageColor3 = Theme.colors.onSurfaceDim,
						LayoutOrder = 2,
					}, gridChildren),
					Footer = e("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 44),
						LayoutOrder = 3,
					}, {
						Tabs = e(SegmentedTabs, {
							options = { "Items", "Amulets", "Materials" },
							selectedIndex = 1,
							size = UDim2.fromOffset(320, 40),
							position = UDim2.fromScale(1, 0.5),
							anchorPoint = Vector2.new(1, 0.5),
						}),
					}),
				}),
			}),
		})
	end,
}
