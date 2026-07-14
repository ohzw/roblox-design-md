-- Component story: Window on its own, showing header/well/watermark/close
-- anatomy with placeholder content and a working close (unmounts on click).

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
		Title = "Collection",
		Counter = "12/40",
	},
	story = function(props)
		local open, setOpen = React.useState(true)

		if not open then
			return e("TextButton", {
				Size = UDim2.fromOffset(200, 60),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "Reopen",
				BackgroundColor3 = Theme.colors.primary,
				[React.Event.Activated] = function()
					setOpen(true)
				end,
			})
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = props.controls.Title,
				icon = "\u{25A0}",
				counterText = props.controls.Counter,
				size = UDim2.fromScale(0.7, 0.6),
				onClose = function()
					setOpen(false)
				end,
			}, {
				Placeholder = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Text = "Content goes here",
					FontFace = Theme.typography.body.font,
					TextSize = Theme.typography.body.textSize,
					TextColor3 = Theme.colors.onSurface,
					ZIndex = 5,
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
