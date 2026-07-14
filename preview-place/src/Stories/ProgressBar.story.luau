-- Progress pill with gradient fill. Drag the Progress control between 0 and 1.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ProgressBar = require(script.Parent.Parent.Components.ProgressBar)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Progress = 0.65,
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
				Padding = UDim.new(0, Theme.spacing.md),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Dynamic = e(ProgressBar, {
				progress = props.controls.Progress,
				layoutOrder = 1,
			}),
			Empty = e(ProgressBar, { progress = 0, label = "0 / 100", layoutOrder = 2 }),
			Full = e(ProgressBar, { progress = 1, label = "MAX", layoutOrder = 3 }),
		})
	end,
}
