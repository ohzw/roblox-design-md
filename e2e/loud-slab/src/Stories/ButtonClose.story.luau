local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ButtonClose = require(script.Parent.Parent.Components.ButtonClose)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {},
	story = function()
		return e("Frame", {
			BackgroundColor3 = Theme.colors.chrome,
			Size = UDim2.fromScale(1, 1),
		}, {
			Close = e(ButtonClose, {
				position = UDim2.fromScale(0.5, 0.5),
				anchorPoint = Vector2.new(0.5, 0.5),
			}),
		})
	end,
}
