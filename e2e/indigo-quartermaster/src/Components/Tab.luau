-- tab / tab-selected from DESIGN.roblox.md (Indigo Quartermaster): text-only
-- segment in the hub header. Inactive = muted label on the band color;
-- selected = darker fill #363E70 + white label + a 4px accent-soft underline
-- strip flush with the band's bottom edge. Square corners always (rounded.none
-- -- never round a tab). No stroke, no shadow, no squash: this taste swaps
-- fills instantly.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

-- Selected-tab fill is inlined by the DESIGN.md itself ("#363E70"), not a
-- Theme.colors token -- kept here per the skill's literal-hex exception.
local SELECTED_FILL = Color3.fromHex("#363E70")

local function Tab(props)
	local selected = props.selected

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = if selected then SELECTED_FILL else Theme.colors.none,
		BackgroundTransparency = if selected then 0 else 1,
		Size = props.size or UDim2.fromOffset(120, 44),
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.none }),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = props.text or "Tab",
			FontFace = Theme.typography.label.font,
			TextSize = Theme.typography.label.textSize,
			TextColor3 = if selected then Theme.colors.onSurface else Theme.colors.onSurfaceMuted,
			ZIndex = props.zIndex,
		}),
		-- Active-tab underline: flush with the header band's bottom edge.
		Underline = if selected
			then e("Frame", {
				BackgroundColor3 = Theme.colors.accentSoft,
				Size = UDim2.new(1, 0, 0, 4),
				Position = UDim2.fromScale(0, 1),
				AnchorPoint = Vector2.new(0, 1),
				ZIndex = (props.zIndex or 1) + 1,
			})
			else nil,
	})
end

return Tab
