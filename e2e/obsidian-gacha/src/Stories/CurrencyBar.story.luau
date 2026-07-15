-- currency-bar showcase: gems (soft, cyan) + Robux (hard, green) glossy pills.

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
		Gems = 260000,
		Robux = 499,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, Theme.spacing.md),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Gems = e(CurrencyBar, {
				kind = "soft",
				amount = props.controls.Gems,
				layoutOrder = 1,
			}),
			Robux = e(CurrencyBar, {
				kind = "hard",
				amount = props.controls.Robux,
				layoutOrder = 2,
			}),
		})
	end,
}
