-- IconTile — fulfils side-button AND button-icon from DESIGN.roblox.md (one
-- component, prop-branched anatomy, per generation-procedure.md). A dark
-- rounded-square tile holding one glowing semantic-colored glyph; the glyph's
-- role tints the tile's stroke. Optional notification badge (top-right), an
-- optional top tag ("Free" / "Join Group") and bottom label ("Auto" / "Skip"),
-- which sit OUTSIDE the square in a vertical stack — the square is the touch
-- target. Press feedback: fill lift toward the stroke color (no deform).
--
-- variant selects the stroke color like ActionButton; default "neutral" tile
-- (panel stroke). iconColor tints the glyph independently (rail glyphs glow in
-- their role color: green backpack, red shop, gold medal...).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local STROKES = {
	neutral = Theme.strokes.panel,
	confirm = Theme.strokes.confirm,
	favorite = Theme.strokes.favorite,
	danger = Theme.strokes.destroy,
	buy = Theme.strokes.affirm,
}
local PRESSED = {
	neutral = Theme.derived.pressed.neutral,
	confirm = Theme.derived.pressed.confirm,
	favorite = Theme.derived.pressed.favorite,
	danger = Theme.derived.pressed.destroy,
	buy = Theme.derived.pressed.affirm,
}

local LIFT_IN = TweenInfo.new(Theme.motion.durations.instant, Theme.motion.easings.settle.style, Theme.motion.easings.settle.direction)
local LIFT_OUT = TweenInfo.new(Theme.motion.durations.fast, Theme.motion.easings.settle.style, Theme.motion.easings.settle.direction)

local function IconTile(props)
	local fillRef = React.useRef(nil)
	local side = props.side or 66
	local variant = props.variant or "neutral"
	local stroke = STROKES[variant]
	local pressed = PRESSED[variant]
	local rounded = props.rounded or Theme.rounded.md

	local function tint(color, info)
		local frame = fillRef.current
		if frame then
			TweenService:Create(frame, info, { BackgroundColor3 = color }):Play()
		end
	end

	local tile = e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.surfaceDeep,
		Size = UDim2.fromOffset(side, side),
		LayoutOrder = 2,
		ref = fillRef,
		[React.Event.MouseButton1Down] = function()
			tint(pressed, LIFT_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			tint(Theme.colors.surfaceDeep, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			tint(Theme.colors.surfaceDeep, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = rounded }),
		Stroke = e("UIStroke", {
			Thickness = stroke.thickness,
			Color = stroke.color,
			ApplyStrokeMode = stroke.mode,
		}),
		Icon = if props.icon
			then e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.icon,
				ImageColor3 = props.iconColor or Theme.colors.onSurface,
				Size = UDim2.fromScale(0.58, 0.58),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 2,
			})
			else nil,
		Badge = if props.badge
			then e("Frame", {
				BackgroundColor3 = Theme.colors.danger,
				Size = UDim2.fromOffset(24, 24),
				Position = UDim2.new(1, 4, 0, -4),
				AnchorPoint = Vector2.new(1, 0),
				ZIndex = 4,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
				Count = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Text = tostring(props.badge),
					FontFace = Theme.typography.caption.font,
					TextScaled = true,
					TextColor3 = Theme.colors.onSurface,
					ZIndex = 4,
				}, {
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, 4),
						PaddingRight = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 3),
						PaddingBottom = UDim.new(0, 3),
					}),
				}),
			})
			else nil,
	})

	-- Icon-only rail button: no external labels, return the bare tile so it
	-- sizes to `side` inside its column.
	if not props.label and not props.topTag then
		return e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(side, side),
			Position = props.position,
			AnchorPoint = props.anchorPoint,
			LayoutOrder = props.layoutOrder,
		}, { Tile = tile })
	end

	-- Roll-cluster tile: [topTag] / [square] / [label] stacked vertically.
	return e("Frame", {
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.fromOffset(side + 40, 0),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
	}, {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0, Theme.spacing.xs),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		TopTag = if props.topTag
			then e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.XY,
				Text = props.topTag,
				FontFace = Theme.typography.caption.font,
				TextColor3 = props.topTagColor or Theme.colors.secondary,
				TextSize = Theme.typography.caption.textSize,
				LayoutOrder = 1,
			})
			else nil,
		Tile = tile,
		Label = if props.label
			then e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.XY,
				Text = props.label,
				FontFace = Theme.typography.label.font,
				TextColor3 = Theme.colors.onSurface,
				TextSize = Theme.typography.label.textSize,
				LayoutOrder = 3,
			})
			else nil,
	})
end

return IconTile
