local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ButtonPrimary = require(script.Parent.Parent.Components.ButtonPrimary)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Text = "Regenerate",
		Disabled = false,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.colors.surface,
			Size = UDim2.fromScale(1, 1),
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.md),
			}),
			Primary = e(ButtonPrimary, {
				variant = "primary",
				text = "Confirm",
				disabled = props.controls.Disabled,
				layoutOrder = 1,
			}),
			Secondary = e(ButtonPrimary, {
				variant = "secondary",
				text = props.controls.Text,
				disabled = props.controls.Disabled,
				layoutOrder = 2,
			}),
			Buy = e(ButtonPrimary, {
				variant = "buy",
				text = "150",
				disabled = props.controls.Disabled,
				layoutOrder = 3,
			}),
			Cta = e(ButtonPrimary, {
				variant = "cta",
				text = "Rebirth Now",
				disabled = props.controls.Disabled,
				layoutOrder = 4,
			}),
		})
	end,
}
