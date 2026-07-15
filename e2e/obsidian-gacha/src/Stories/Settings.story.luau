-- Settings screen story: grouped rows of label + toggle (Hardcore tinted red),
-- an Edit button row, over the taste's dim + blurred backdrop.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local SettingsScreen = require(script.Parent.Parent.Screens.SettingsScreen)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {},
	story = function()
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Screen = e(SettingsScreen, {}),
		})
	end,
}
