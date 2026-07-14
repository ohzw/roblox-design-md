-- Component story: the remaining building-block components not already
-- exercised head-on by their own story (CurrencyBar/SideButton/ItemCard/
-- BadgeSlot/CloseButton) -- HUD/Shop/Dialog compose these, but a reviewer
-- should be able to poke each in isolation too (generation-procedure.md
-- self-review checklist: "every component/screen has a story").

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyBar = require(script.Parent.Parent.Components.CurrencyBar)
local SideButton = require(script.Parent.Parent.Components.SideButton)
local ItemCard = require(script.Parent.Parent.Components.ItemCard)
local BadgeSlot = require(script.Parent.Parent.Components.BadgeSlot)
local CloseButton = require(script.Parent.Parent.Components.CloseButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Amount = 12400,
		Badge = 3,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.xl),
			}),
			Currency = e(CurrencyBar, { kind = "soft", amount = props.controls.Amount, layoutOrder = 1 }),
			Side = e(SideButton, { text = "Shop", icon = "\u{25A0}", badge = props.controls.Badge, layoutOrder = 2 }),
			CardCommon = e(ItemCard, {
				name = "Acorn",
				rarity = "common",
				price = 25,
				icon = Theme.assets.itemAcorn,
				layoutOrder = 3,
			}),
			CardLegendary = e(ItemCard, {
				name = "Crown",
				rarity = "legendary",
				price = 2500,
				icon = Theme.assets.itemCrown,
				layoutOrder = 4,
			}),
			Badge = e(BadgeSlot, { text = "RARE", layoutOrder = 5 }),
			Close = e(CloseButton, { size = UDim2.fromOffset(80, 72), layoutOrder = 6 }),
		})
	end,
}
