local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyDisplay = require(script.Parent.Parent.Components.CurrencyDisplay)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Amount = 12400,
		Caption = "2x Cash Boost Active",
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Currency = e(CurrencyDisplay, {
				amount = props.controls.Amount,
				caption = props.controls.Caption,
				position = UDim2.fromScale(0.5, 0.5),
				anchorPoint = Vector2.new(0.5, 0.5),
			}),
		})
	end,
}
