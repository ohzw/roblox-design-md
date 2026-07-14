-- list-row from DESIGN.roblox.md (Indigo Quartermaster): "the row is the
-- atom" -- full-width {colors.surface-raised} bar, bold title top, muted
-- meta line below, reward/status chips right-aligned, and an optional thin
-- progress-bar strip pinned along the bottom edge. ~150px tall at reference
-- (px carries a constant-factor caveat, ratio is load-bearing). rounded.sm
-- (buttons/chips corner, NOT rounded.none -- the row itself is a card-ish
-- bar, only full-bleed HUB rows/tabs are square per Shapes). The WHOLE row
-- is the tap surface when onActivated is provided.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local ProgressBar = require(script.Parent.ProgressBar)

local e = React.createElement

local ROW_HEIGHT = 150

local function ListRow(props)
	local hasProgress = props.progress ~= nil

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.surfaceRaised,
		Size = props.size or UDim2.new(1, 0, 0, ROW_HEIGHT),
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		-- Content lives in its own padded frame so the bottom progress strip
		-- (below) can stay flush with the row's OUTER edge, unaffected by
		-- inner padding -- mirrors how a card's bottom strip inherits the
		-- card's own corner rather than its content inset.
		Content = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, if hasProgress then -8 else 0),
			ZIndex = 2,
		}, {
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.lg),
				PaddingRight = UDim.new(0, Theme.spacing.lg),
				PaddingTop = UDim.new(0, Theme.spacing.md),
				PaddingBottom = UDim.new(0, Theme.spacing.md),
			}),
			Title = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.6, 0, 0, 26),
				Text = props.title or "Row title",
				FontFace = Theme.typography.label.font,
				TextSize = Theme.typography.label.textSize,
				TextColor3 = Theme.colors.onSurface,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 3,
			}),
			Meta = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.6, 0, 0, 22),
				Position = UDim2.new(0, 0, 0, 30),
				Text = props.meta or "",
				FontFace = Theme.typography.body.font,
				TextSize = Theme.typography.body.textSize,
				TextColor3 = Theme.colors.onSurfaceMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 3,
			}),
			-- Reward/status chips, right-aligned.
			Chips = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.35, 0, 1, 0),
				Position = UDim2.fromScale(1, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				ZIndex = 3,
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.sm),
				}),
				Children = e(React.Fragment, nil, props.children),
			}),
		}),
		-- Meta-state strip pinned flush to the row's bottom edge (rule of
		-- thumb #3) -- a sibling of Content, never inside its UIPadding.
		Progress = if hasProgress
			then e(ProgressBar, {
				progress = props.progress,
				size = UDim2.new(1, 0, 0, 8),
				position = UDim2.fromScale(0, 1),
				anchorPoint = Vector2.new(0, 1),
				zIndex = 2,
			})
			else nil,
	})
end

return ListRow
