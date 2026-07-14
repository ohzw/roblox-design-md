-- list-row from DESIGN.roblox.md (Honey Ledger): cream full-width strip --
-- bold title line leading, Regular description line below, icon flush-left
-- with its count overlapped (badge-slot). Stat variants recolor the fill
-- (Components prose: "pale green rows for buffed stats, blue tag rows...");
-- this component's `emphasized` prop applies the taste's ONE emphasis
-- device observed for premium/legendary tiers (Premium offers pattern:
-- "Item tiers titled in the header yellow ink") -- the row fill steps to
-- surfaceHeader honey and the title takes onSurface-on-bright treatment,
-- keeping the flat/no-glow rule (Do's and Don'ts: never bevel, never
-- gradient between fills) intact.
-- Rows are Scale-width, fixed-offset height, edge-to-edge with
-- {spacing.xs}-{spacing.sm} cracks between siblings (the taste's UIListLayout
-- delegates that gap -- see the Shop story for the column instance).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local ROW_HEIGHT = 64 -- >= 44px tap-target rubric; full-width rows pass per Layout prose

local function ListRow(props)
	local emphasized = props.emphasized or false
	local fill = if emphasized then Theme.colors.surfaceHeader else Theme.colors.surfaceRow
	local titleColor = Theme.colors.onSurface -- dark text on light rows carries no stroke (both fills are light honey steps)

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = fill,
		Size = props.size or UDim2.new(1, 0, 0, ROW_HEIGHT),
		Position = props.position,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		-- rounded.none: sharp corners, no UICorner instance.
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.sm),
			PaddingRight = UDim.new(0, Theme.spacing.sm),
		}),
		Icon = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(48, 48),
			Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			ZIndex = 2,
		}, {
			Image = e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.icon or "",
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}),
			-- badge-slot: stroked white "xN" count tag overlapping the icon's corner.
			Count = if props.count and props.count > 1
				then e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromOffset(28, 18),
					Position = UDim2.new(1, 2, 1, 2),
					AnchorPoint = Vector2.new(1, 1),
					Text = "x" .. tostring(props.count),
					FontFace = Theme.typography.caption.font,
					TextColor3 = Theme.colors.white,
					TextScaled = true,
					ZIndex = 3,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = 14 }),
				})
				else nil,
		}),
		Text = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -(48 + Theme.spacing.md), 1, 0),
			Position = UDim2.fromOffset(48 + Theme.spacing.md, 0),
			ZIndex = 2,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Title = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 24),
				Text = props.title or "Item",
				FontFace = Theme.typography.body.font,
				TextSize = Theme.typography.body.textSize,
				TextColor3 = titleColor,
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = 1,
			}),
			Description = if props.description
				then e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 18),
					Text = props.description,
					FontFace = Theme.typography.caption.font,
					TextSize = Theme.typography.caption.textSize,
					TextColor3 = titleColor,
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 2,
				})
				else nil,
		}),
		-- Selected reads via the taste's square outline convention (Shapes:
		-- "anything selectable gets a square outline, not a shape change").
		SelectedStroke = if props.selected
			then e("UIStroke", {
				Thickness = Theme.strokes.select.thickness,
				Color = Theme.strokes.select.color,
				ApplyStrokeMode = Theme.strokes.select.mode,
			})
			else nil,
	})
end

return ListRow
