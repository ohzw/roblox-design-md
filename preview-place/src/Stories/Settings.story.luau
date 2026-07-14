-- Settings screen: single-column rows of label + chunky toggle inside a
-- Window. The story holds live toggle state so clicking a toggle really
-- flips it (and animates the knob slide).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local SettingsScreen = require(script.Parent.Parent.Screens.SettingsScreen)

local e = React.createElement

local ROWS = {
	{ id = "music", label = "Music" },
	{ id = "sfx", label = "Sound Effects" },
	{ id = "graphics", label = "Fancy Graphics" },
	{ id = "notifications", label = "Notifications" },
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "SETTINGS",
		MusicOn = true,
	},
	story = function(props)
		-- MusicOn seeds the initial state only; after mount the toggles own it.
		local values, setValues = React.useState({
			music = props.controls.MusicOn,
			sfx = true,
			graphics = false,
			notifications = true,
		})

		local settings = {}
		for i, row in ipairs(ROWS) do
			settings[i] = { id = row.id, label = row.label, value = values[row.id] }
		end

		return e("Frame", {
			BackgroundColor3 = Color3.fromHex("#87CEEB"), -- world-like sky backdrop
			Size = UDim2.fromScale(1, 1),
		}, {
			Settings = e(SettingsScreen, {
				title = props.controls.Title,
				settings = settings,
				onToggle = function(id, newValue)
					setValues(function(prev)
						local updated = table.clone(prev)
						updated[id] = newValue
						return updated
					end)
				end,
				onClose = function()
					print("close settings")
				end,
			}),
		})
	end,
}
