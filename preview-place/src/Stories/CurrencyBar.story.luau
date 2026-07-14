-- Currency pills (soft + hard), stacked top-right style. Amounts abbreviate at 5 digits.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyBar = require(script.Parent.Parent.Components.CurrencyBar)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Coins = 12400,
		Gems = 999,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Color3.fromHex("#87CEEB"),
			Size = UDim2.fromScale(1, 1),
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, Theme.spacing.sm),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Coins = e(CurrencyBar, {
				kind = "soft",
				amount = props.controls.Coins,
				layoutOrder = 1,
			}),
			Gems = e(CurrencyBar, {
				kind = "hard",
				amount = props.controls.Gems,
				layoutOrder = 2,
			}),
		})
	end,
}
