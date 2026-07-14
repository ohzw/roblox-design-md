-- Standard showcase Dialog (standard-showcase.md): a small confirm popup over
-- this taste's dim-overlay treatment (purple-navy tint, ~33% opaque —
-- Colors prose: "the popup backdrop ... tinting the world rather than
-- blacking it out"), title CONFIRM, one body line ("Buy Crown for 2,500?"),
-- a primary confirm and this taste's dismiss affordance (the close button,
-- top-right corner — Components: button-close — or tapping the dim, per
-- Components: "dim-overlay ... clicking/tapping it closes dismissible
-- windows").
--
-- This taste has no bespoke "dialog" anatomy in its DESIGN.md: reusing the
-- window/window-header component at a smaller size is the expected answer
-- per standard-showcase.md, not a workaround — Window already owns the
-- dim + entrance-pop motion this popup needs.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local ChunkyButton = require(script.Parent.Parent.Components.ChunkyButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Body = "Buy Crown for 2,500?",
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = "CONFIRM",
				size = UDim2.fromOffset(420, 260),
				onClose = function()
					print("dismiss confirm dialog")
				end,
			}, {
				Column = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ZIndex = 13,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, Theme.spacing.lg),
					}),
					Body = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 48),
						Text = props.controls.Body,
						FontFace = Theme.typography.body.font,
						TextSize = Theme.typography.body.textSize,
						TextColor3 = Theme.colors.onSurface,
						TextWrapped = true,
						LayoutOrder = 1,
					}),
					Confirm = e(ChunkyButton, {
						text = "CONFIRM",
						variant = "primary",
						size = UDim2.fromOffset(220, 68),
						layoutOrder = 2,
					}),
				}),
			}),
		})
	end,
}
