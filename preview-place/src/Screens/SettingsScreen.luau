-- Settings screen per DESIGN.roblox.md Screen Patterns: a Window with
-- single-column list rows on surface; each row = label left, chunky toggle
-- right. Rows are laid out by UIListLayout (spacing.md gaps) — never manual
-- positions for repeating content.
--
-- Props:
--   settings   array of { id, label, value }
--   onToggle   function(id, newValue)
--   onClose    function()
--   title      optional header text (default "SETTINGS")
--   size       optional Window size passthrough

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local ChunkyToggle = require(script.Parent.Parent.Components.ChunkyToggle)

local e = React.createElement

local TOGGLE_WIDTH = 100
local TOGGLE_HEIGHT = 56 -- chunky taste: 56px+ targets
local ROW_HEIGHT = 64

-- One settings row: body-tier label left (on-surface brown, no text stroke —
-- body text on surface may skip the outline), toggle anchored right.
local function SettingsRow(props)
	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, ROW_HEIGHT),
		LayoutOrder = props.layoutOrder,
	}, {
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -(TOGGLE_WIDTH + Theme.spacing.md), 1, 0),
			Text = props.label or "",
			FontFace = Theme.typography.body.font,
			TextSize = Theme.typography.body.textSize,
			TextColor3 = Theme.colors.onSurface,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}),
		Toggle = e(ChunkyToggle, {
			value = props.value,
			size = UDim2.fromOffset(TOGGLE_WIDTH, TOGGLE_HEIGHT),
			position = UDim2.new(1, 0, 0.5, 0),
			anchorPoint = Vector2.new(1, 0.5),
			onToggle = props.onToggle,
		}),
	})
end

local function SettingsScreen(props)
	local rows = {}
	rows.Layout = e("UIListLayout", {
		Padding = UDim.new(0, Theme.spacing.md),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
	})
	for i, setting in ipairs(props.settings or {}) do
		rows[setting.id] = e(SettingsRow, {
			label = setting.label,
			value = setting.value,
			layoutOrder = i,
			onToggle = function(newValue)
				if props.onToggle then
					props.onToggle(setting.id, newValue)
				end
			end,
		})
	end

	return e(Window, {
		title = props.title or "SETTINGS",
		size = props.size or UDim2.fromOffset(460, 400),
		onClose = props.onClose,
	}, {
		Rows = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
		}, rows),
	})
end

return SettingsScreen
