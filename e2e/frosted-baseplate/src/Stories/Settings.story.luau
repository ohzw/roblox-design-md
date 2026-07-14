-- Settings window slice (Screen Patterns: "Settings: slab window, two to
-- three full-width rows -- label left, toggle-pill right. No tabs, no
-- footer."). Rows are inset (surface-deep) per Elevation prose ("content
-- wells use surface-deep against surface... no strokes on rows") and are
-- plain screen-level composition (label + TogglePill), not a promoted
-- component, since the row shape does not carry any styling beyond that
-- inset fill (generation-procedure.md #3: promote only if a row STYLES
-- itself further). Backdrop stands in for the blurred game world; the dim
-- tint + Window's entrance motion demonstrate the "open" state per the
-- Motion section.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local TogglePill = require(script.Parent.Parent.Components.TogglePill)

local e = React.createElement

local function SettingsRow(props)
	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDeep, -- inset row: NO stroke (Elevation prose)
		Size = UDim2.new(1, 0, 0, 64),
		LayoutOrder = props.layoutOrder,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.lg),
			PaddingRight = UDim.new(0, Theme.spacing.lg),
		}),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -140, 1, 0),
			Text = props.label, -- Title Case per Typography prose
			FontFace = Theme.typography.body.font,
			TextSize = Theme.typography.body.textSize,
			TextColor3 = Theme.colors.onSurface,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}),
		Toggle = e(TogglePill, {
			value = props.value,
			onToggle = props.onToggle,
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
			zIndex = 2,
		}),
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "Settings",
		Music = true,
		Sfx = true,
		ShowDim = true,
	},
	story = function(props)
		local music, setMusic = React.useState(props.controls.Music)
		local sfx, setSfx = React.useState(props.controls.Sfx)

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = props.controls.Title,
				icon = "\u{2699}", -- gear badge, matches the settings destination
				size = UDim2.fromOffset(560, 320),
				showDim = props.controls.ShowDim,
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.lg),
				}),
				MusicRow = e(SettingsRow, {
					label = "Background Music",
					value = music,
					onToggle = setMusic,
					layoutOrder = 1,
				}),
				SfxRow = e(SettingsRow, {
					label = "Sound Effects",
					value = sfx,
					onToggle = setSfx,
					layoutOrder = 2,
				}),
			}),
		})
	end,
}
