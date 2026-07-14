local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ItemCard = require(script.Parent.Parent.Components.ItemCard)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Name = "Crown",
		Rarity = "legendary",
		Price = 2500,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.colors.surface,
			Size = UDim2.fromScale(1, 1),
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.md),
			}),
			Common = e(ItemCard, {
				name = "Acorn",
				rarity = "common",
				price = 25,
				icon = Theme.assets.itemAcorn,
				layoutOrder = 1,
			}),
			Controlled = e(ItemCard, {
				name = props.controls.Name,
				rarity = props.controls.Rarity,
				price = props.controls.Price,
				icon = Theme.assets.itemCrown,
				emphasized = props.controls.Rarity == "legendary",
				layoutOrder = 2,
			}),
		})
	end,
}
