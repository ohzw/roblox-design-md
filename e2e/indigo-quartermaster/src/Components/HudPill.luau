-- hud-pill from DESIGN.roblox.md (Indigo Quartermaster): {colors.hud-ink}
-- rounded-rect pill for timer / kill count / team roster. hud-ink is colder
-- and darker than the lobby indigo so it recedes against bright game worlds
-- -- this is the ONE place this taste breaks its own indigo ladder
-- (in-match chrome uses a different base value entirely, per the Colors
-- section). rounded.md (8px), 48px tall token height.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local HEIGHT = 48

local function HudPill(props)
	return e("Frame", {
		BackgroundColor3 = Theme.colors.hudInk,
		Size = props.size or UDim2.fromOffset(140, HEIGHT),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.md),
			PaddingRight = UDim.new(0, Theme.spacing.md),
		}),
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.xs),
		}),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = props.text or "",
			FontFace = if props.mono then Theme.typography.timer.font else Theme.typography.label.font,
			TextSize = if props.mono then Theme.typography.timer.textSize else Theme.typography.label.textSize,
			TextColor3 = Theme.colors.onSurface,
			LayoutOrder = 1,
			ZIndex = (props.zIndex or 1) + 1,
		}),
		-- Team-roster variant: small colored squares, each with a white count digit.
		Roster = if props.roster
			then e("Frame", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.new(0, 0, 1, 0),
				LayoutOrder = 2,
				ZIndex = (props.zIndex or 1) + 1,
			}, (function()
				local children = {}
				children.Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.xs),
				})
				for i, player in ipairs(props.roster) do
					children["Player_" .. i] = e("Frame", {
						BackgroundColor3 = player.color,
						Size = UDim2.fromOffset(24, 24),
						LayoutOrder = i,
					}, {
						Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
						Count = e("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1),
							Text = tostring(player.count or 1),
							FontFace = Theme.typography.caption.font,
							TextSize = Theme.typography.caption.textSize,
							TextColor3 = Theme.colors.onSurface,
						}),
					})
				end
				return children
			end)())
			else nil,
	})
end

return HudPill
