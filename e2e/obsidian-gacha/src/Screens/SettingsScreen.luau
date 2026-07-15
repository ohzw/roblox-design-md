-- SettingsScreen — Screen Patterns (Settings): "grouped rows (Profile Settings,
-- Gameplay Settings) of label + toggle-switch (or an Edit button); the Hardcore
-- row is tinted red." Composes Window + SettingRow + ToggleSwitch/ActionButton
-- only. Toggle state is held locally so the row switches animate when poked in
-- the story; initial values come from props (story defaults).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local SettingRow = require(script.Parent.Parent.Components.SettingRow)
local ToggleSwitch = require(script.Parent.Parent.Components.ToggleSwitch)
local ActionButton = require(script.Parent.Parent.Components.ActionButton)

local e = React.createElement

local function SectionHeader(text, layoutOrder)
	return e("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 30),
		Text = text,
		FontFace = Theme.typography.label.font,
		TextColor3 = Theme.colors.primary,
		TextSize = Theme.typography.label.textSize,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = layoutOrder,
	})
end

local function SettingsScreen(props)
	local hardcore, setHardcore = React.useState(false)
	local autoRejoin, setAutoRejoin = React.useState(true)
	local luckBoosts, setLuckBoosts = React.useState(true)
	local hidePlayers, setHidePlayers = React.useState(false)
	local pvp, setPvp = React.useState(false)

	local function toggle(value, onChanged)
		return e(ToggleSwitch, {
			value = value,
			onChanged = onChanged,
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
		})
	end

	local canvasSize, setCanvasSize = React.useBinding(UDim2.new())

	return e(Window, {
		title = "Settings",
		icon = Theme.assets.iconSettings,
		iconColor = Theme.colors.primary,
		onClose = props.onClose,
	}, {
		Scroll = e("ScrollingFrame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			CanvasSize = canvasSize,
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = Theme.colors.onSurfaceDim,
			ZIndex = 5,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, Theme.spacing.sm),
				SortOrder = Enum.SortOrder.LayoutOrder,
				[React.Change.AbsoluteContentSize] = function(rbx)
					setCanvasSize(UDim2.new(0, 0, 0, rbx.AbsoluteContentSize.Y))
				end,
			}),
			ProfileHeader = SectionHeader("Profile Settings", 1),
			NameTag = e(SettingRow, {
				label = "Name Tag Effect",
				layoutOrder = 2,
				right = e(ActionButton, {
					variant = "confirm",
					text = "Edit",
					size = UDim2.fromOffset(70, 36),
					position = UDim2.fromScale(1, 0.5),
					anchorPoint = Vector2.new(1, 0.5),
				}),
			}),
			GameplayHeader = SectionHeader("Gameplay Settings", 3),
			Hardcore = e(SettingRow, {
				label = "Hardcore Mode",
				subtitle = "10x decreased luck and auras 10x more valuable",
				danger = true,
				layoutOrder = 4,
				right = toggle(hardcore, setHardcore),
			}),
			AutoRejoin = e(SettingRow, {
				label = "Auto Rejoin",
				layoutOrder = 5,
				right = toggle(autoRejoin, setAutoRejoin),
			}),
			LuckBoosts = e(SettingRow, {
				label = "Toggle Luck Boosts",
				layoutOrder = 6,
				right = toggle(luckBoosts, setLuckBoosts),
			}),
			HidePlayers = e(SettingRow, {
				label = "Hide Other Players",
				layoutOrder = 7,
				right = toggle(hidePlayers, setHidePlayers),
			}),
			Pvp = e(SettingRow, {
				label = "Enable PvP [In Beta]",
				layoutOrder = 8,
				right = toggle(pvp, setPvp),
			}),
		}),
	})
end

return SettingsScreen
