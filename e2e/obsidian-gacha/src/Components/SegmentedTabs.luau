-- segmented-tab from DESIGN.roblox.md: "a pill group (Normal/Hardcore,
-- Items/Amulets/Materials); the selected segment lifts to a mid-gray fill with
-- on-surface text, others stay transparent with on-surface-dim text."
--
-- Props: options (array of strings), selectedIndex (1-based), onSelect(index).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function SegmentedTabs(props)
	local options = props.options or {}
	local selected = props.selectedIndex or 1

	local segments = {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, Theme.spacing.xs),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.xs),
			PaddingRight = UDim.new(0, Theme.spacing.xs),
			PaddingTop = UDim.new(0, Theme.spacing.xs),
			PaddingBottom = UDim.new(0, Theme.spacing.xs),
		}),
	}

	for i, label in options do
		local isSel = i == selected
		segments["Seg" .. i] = e("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Theme.derived.tabSelectedFill,
			BackgroundTransparency = if isSel then 0 else 1,
			Size = UDim2.new(1 / #options, -Theme.spacing.xs, 1, 0),
			LayoutOrder = i,
			[React.Event.Activated] = function()
				if props.onSelect then
					props.onSelect(i)
				end
			end,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = label,
				FontFace = Theme.typography.body.font,
				TextColor3 = if isSel then Theme.colors.onSurface else Theme.colors.onSurfaceDim,
				TextSize = Theme.typography.body.textSize,
			}),
		})
	end

	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDeep,
		Size = props.size or UDim2.fromOffset(260, 40),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.panel.thickness,
			Color = Theme.strokes.panel.color,
			ApplyStrokeMode = Theme.strokes.panel.mode,
		}),
		Segments = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = (props.zIndex or 1) + 1,
		}, segments),
	})
end

return SegmentedTabs
