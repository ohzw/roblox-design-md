-- progress-bar showcase: dark track + primary-gradient fill at a few values.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ProgressBar = require(script.Parent.Parent.Components.ProgressBar)

local e = React.createElement

local function labelled(text, value, order)
	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 40),
		LayoutOrder = order,
	}, {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, Theme.spacing.xs),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		Caption = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 16),
			Text = text,
			FontFace = Theme.typography.caption.font,
			TextColor3 = Theme.colors.onSurfaceDim,
			TextSize = Theme.typography.caption.textSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = 1,
		}),
		Bar = e(ProgressBar, { value = value, layoutOrder = 2 }),
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Progress = 0.35,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Panel = e("Frame", {
				BackgroundColor3 = Theme.colors.surface,
				Size = UDim2.fromOffset(440, 220),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.panel.thickness,
					Color = Theme.strokes.panel.color,
					ApplyStrokeMode = Theme.strokes.panel.mode,
				}),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.lg),
					PaddingRight = UDim.new(0, Theme.spacing.lg),
					PaddingTop = UDim.new(0, Theme.spacing.lg),
					PaddingBottom = UDim.new(0, Theme.spacing.lg),
				}),
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, Theme.spacing.md),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				A = labelled("Ascend  0 / 1", 0.0, 1),
				B = labelled("Aura Farming  93 / 584", props.controls.Progress, 2),
				C = labelled("AFK Grinder  Ready to Claim!", 1.0, 3),
			}),
		})
	end,
}
