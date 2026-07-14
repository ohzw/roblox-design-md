-- Component story: GradientButton across its variants (primary/secondary/
-- tierRare/buy/primaryHero) plus disabled -- lets a reviewer poke every
-- gradient-slab voice this taste defines in one frame.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local GradientButton = require(script.Parent.Parent.Components.GradientButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Text = "Spin",
		Disabled = false,
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
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.lg),
			}),
			Primary = e(GradientButton, {
				variant = "primary",
				text = props.controls.Text,
				disabled = props.controls.Disabled,
				size = UDim2.fromOffset(260, 60),
				layoutOrder = 1,
			}),
			Secondary = e(GradientButton, {
				variant = "secondary",
				text = "Buy 1",
				disabled = props.controls.Disabled,
				size = UDim2.fromOffset(260, 60),
				layoutOrder = 2,
			}),
			TierRare = e(GradientButton, {
				variant = "tierRare",
				text = "Buy 5",
				disabled = props.controls.Disabled,
				size = UDim2.fromOffset(260, 60),
				layoutOrder = 3,
			}),
			Buy = e(GradientButton, {
				variant = "buy",
				text = "120",
				disabled = props.controls.Disabled,
				size = UDim2.fromOffset(200, 58),
				layoutOrder = 4,
			}),
			Hero = e(GradientButton, {
				variant = "primaryHero",
				text = "Equip",
				disabled = props.controls.Disabled,
				size = UDim2.fromOffset(320, 90),
				layoutOrder = 5,
			}),
		})
	end,
}
