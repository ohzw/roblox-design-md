-- All button components with live controls. Press them: the bevel must collapse.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ChunkyButton = require(script.Parent.Parent.Components.ChunkyButton)
local CloseButton = require(script.Parent.Parent.Components.CloseButton)
local SideButton = require(script.Parent.Parent.Components.SideButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Text = "CLAIM",
		Disabled = false,
		Badge = 3,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Color3.fromHex("#87CEEB"),
			Size = UDim2.fromScale(1, 1),
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, Theme.spacing.lg),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Primary = e(ChunkyButton, {
				text = props.controls.Text,
				variant = "primary",
				disabled = props.controls.Disabled,
				layoutOrder = 1,
			}),
			Secondary = e(ChunkyButton, {
				text = "SHOP",
				variant = "secondary",
				layoutOrder = 2,
			}),
			Close = e(CloseButton, { layoutOrder = 3 }),
			Side = e(SideButton, {
				text = "PETS",
				badge = props.controls.Badge,
				layoutOrder = 4,
			}),
		})
	end,
}
