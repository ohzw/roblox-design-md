-- SettingRow — a settings list row (Screen Patterns: "grouped rows of label +
-- toggle-switch (or an Edit button); the Hardcore row is tinted red"). Repeats
-- with its own styling, so it is a component, not inline screen drawing. The
-- trailing control (a ToggleSwitch or an ActionButton) is passed in as `right`
-- so the row owns only label/subtitle/tint/divider.
--
-- Props: label, subtitle (optional), danger (faint red row tint), right
-- (react element), layoutOrder.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function SettingRow(props)
	return e("Frame", {
		BackgroundColor3 = Theme.colors.danger,
		BackgroundTransparency = if props.danger then 0.9 else 1,
		Size = props.size or UDim2.new(1, 0, 0, 56),
		LayoutOrder = props.layoutOrder,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.md),
			PaddingRight = UDim.new(0, Theme.spacing.md),
		}),
		Divider = e("Frame", {
			BackgroundColor3 = Theme.colors.outline,
			BackgroundTransparency = 0.85,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 1, 0),
			AnchorPoint = Vector2.new(0, 1),
		}),
		TextGroup = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -80, 1, 0),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 0, 0),
				Text = props.label or "Setting",
				FontFace = Theme.typography.body.font,
				TextColor3 = Theme.colors.onSurface,
				TextSize = Theme.typography.body.textSize,
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = 1,
			}),
			Subtitle = if props.subtitle
				then e("TextLabel", {
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.new(1, 0, 0, 0),
					Text = props.subtitle,
					FontFace = Theme.typography.caption.font,
					TextColor3 = Theme.colors.onSurfaceDim,
					TextSize = Theme.typography.caption.textSize,
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 2,
				})
				else nil,
		}),
		Control = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(70, 44),
			Position = UDim2.new(1, 0, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
		}, {
			Inner = e(React.Fragment, nil, { Right = props.right }),
		}),
	})
end

return SettingRow
