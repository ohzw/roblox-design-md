-- Dialog: a small confirm popup reusing the Window at its "dialog" variant
-- (a smaller window, not a new anatomy — standard-showcase.md), over the dim +
-- blurred backdrop. Title "Confirm", one body line, a primary confirm and a
-- neutral cancel; the bare white X and dim-tap also dismiss (Window anatomy).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local ActionButton = require(script.Parent.Parent.Components.ActionButton)

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
			Win = e(Window, {
				title = "Confirm",
				variant = "dialog",
				icon = Theme.assets.iconGem,
				iconColor = Theme.colors.primary,
			}, {
				Body = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
				}, {
					Message = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 40),
						Position = UDim2.fromScale(0.5, 0.34),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Text = "Buy Crown for 2,500?",
						FontFace = Theme.typography.body.font,
						TextColor3 = Theme.colors.onSurface,
						TextSize = Theme.typography.body.textSize,
						TextWrapped = true,
					}),
					Buttons = e("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 48),
						Position = UDim2.new(0.5, 0, 1, 0),
						AnchorPoint = Vector2.new(0.5, 1),
					}, {
						Layout = e("UIListLayout", {
							FillDirection = Enum.FillDirection.Horizontal,
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							Padding = UDim.new(0, Theme.spacing.md),
							SortOrder = Enum.SortOrder.LayoutOrder,
						}),
						Cancel = e(ActionButton, { variant = "neutral", text = "Cancel", size = UDim2.fromOffset(130, 48), layoutOrder = 1 }),
						Confirm = e(ActionButton, { variant = "confirm", text = "Confirm", size = UDim2.fromOffset(130, 48), layoutOrder = 2 }),
					}),
				}),
			}),
		})
	end,
}
