-- button-roll from DESIGN.roblox.md: "the hero: a larger dark lg-rounded tile
-- with a white dice glyph and a 'Roll' label beneath ... the lever you came to
-- pull." The die is drawn procedurally (a tilted white rounded square with
-- three dark pips) — no arbitrated dice asset exists, and a procedural die
-- reads truer to the source than a wrong-subject stock image. Press feedback:
-- fill lift toward the confirm stroke color (Motion prose), no deform.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local LIFT_IN = TweenInfo.new(Theme.motion.durations.instant, Theme.motion.easings.settle.style, Theme.motion.easings.settle.direction)
local LIFT_OUT = TweenInfo.new(Theme.motion.durations.fast, Theme.motion.easings.settle.style, Theme.motion.easings.settle.direction)

-- three pips on a diagonal (die showing 3), scale positions inside the face.
local PIPS = {
	{ 0.24, 0.24 },
	{ 0.5, 0.5 },
	{ 0.76, 0.76 },
}

local function RollButton(props)
	local fillRef = React.useRef(nil)
	local side = props.side or 130

	local function tint(color, info)
		local frame = fillRef.current
		if frame then
			TweenService:Create(frame, info, { BackgroundColor3 = color }):Play()
		end
	end

	local pipChildren = {
		Corner = e("UICorner", { CornerRadius = UDim.new(0.28, 0) }),
	}
	for i, p in PIPS do
		pipChildren["Pip" .. i] = e("Frame", {
			BackgroundColor3 = Theme.colors.surfaceDeep,
			Size = UDim2.fromScale(0.16, 0.16),
			Position = UDim2.fromScale(p[1], p[2]),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 3,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		})
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.fromOffset(side, 0),
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
		Tile = e("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Theme.colors.surfaceDeep,
			Size = UDim2.fromOffset(side, side),
			LayoutOrder = 1,
			ref = fillRef,
			[React.Event.MouseButton1Down] = function()
				tint(Theme.derived.pressed.confirm, LIFT_IN)
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
			Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.panel.thickness,
				Color = Theme.strokes.panel.color,
				ApplyStrokeMode = Theme.strokes.panel.mode,
			}),
			Die = e("Frame", {
				BackgroundColor3 = Theme.colors.onSurface,
				Size = UDim2.fromScale(0.56, 0.56),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Rotation = 12,
				ZIndex = 2,
			}, pipChildren),
		}),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.XY,
			Text = props.label or "Roll",
			FontFace = Theme.typography.label.font,
			TextColor3 = Theme.colors.onSurface,
			TextSize = Theme.typography.label.textSize,
			LayoutOrder = 2,
		}),
	})
end

return RollButton
