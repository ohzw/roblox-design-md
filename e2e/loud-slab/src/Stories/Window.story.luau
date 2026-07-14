local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "Rebirth",
		ShowDim = true,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			WindowRoot = e(Window, {
				title = props.controls.Title,
				showDim = props.controls.ShowDim,
				size = UDim2.fromScale(0.5, 0.55),
			}, {
				Body = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Text = "Window content goes here.",
					FontFace = Theme.typography.body.font,
					TextSize = Theme.typography.body.textSize,
					TextColor3 = Theme.colors.onSurface,
					ZIndex = 2,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
				}),
			}),
		})
	end,
}
