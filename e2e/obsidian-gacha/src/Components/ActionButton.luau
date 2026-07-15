-- button-primary / button-secondary / button-danger / button-buy from
-- DESIGN.roblox.md. The taste's whole button set is ONE object wearing a
-- different stroke: a surface-deep near-black fill, a semantic-colored stroke,
-- and text in that same color. The stroke IS the button (Components prose).
--
-- Press feedback (Motion prose): the fill LIFTS toward the stroke color; the
-- chrome does not deform (no squash, no bevel — this is a flat/dark taste).
-- Color-only lift is safe to tween directly on the ref (motion-implementation.md).
--
-- variant: "confirm" (Equip/commit, blue) | "favorite" (Lock, gold) |
-- "danger" (Salvage/delete, red) | "buy" (price pill, green) | "neutral"
-- (Enter/Use, gray). `price` + `icon` render the buy price-pill content.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local VARIANTS = {
	confirm = { stroke = Theme.strokes.confirm, text = Theme.colors.primary, pressed = Theme.derived.pressed.confirm },
	favorite = { stroke = Theme.strokes.favorite, text = Theme.colors.accentGold, pressed = Theme.derived.pressed.favorite },
	danger = { stroke = Theme.strokes.destroy, text = Theme.colors.danger, pressed = Theme.derived.pressed.destroy },
	buy = { stroke = Theme.strokes.affirm, text = Theme.colors.secondary, pressed = Theme.derived.pressed.affirm },
	neutral = { stroke = Theme.strokes.neutral, text = Theme.colors.onSurfaceDim, pressed = Theme.derived.pressed.neutral },
}

local LIFT_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local LIFT_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ActionButton(props)
	local fillRef = React.useRef(nil)
	local variant = VARIANTS[props.variant or "confirm"]
	local disabled = props.disabled == true

	local function tint(color, info)
		local frame = fillRef.current
		if frame then
			TweenService:Create(frame, info, { BackgroundColor3 = color }):Play()
		end
	end

	local textColor = if disabled then Theme.colors.onSurfaceDim else variant.text
	local stroke = if disabled then Theme.strokes.neutral else variant.stroke

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.surfaceDeep,
		BackgroundTransparency = props.transparency or 0,
		Size = props.size or UDim2.fromOffset(200, 48),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			if not disabled then
				tint(variant.pressed, LIFT_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			tint(Theme.colors.surfaceDeep, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			tint(Theme.colors.surfaceDeep, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if not disabled and props.onActivated then
				props.onActivated()
			end
		end,
		ref = fillRef,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = stroke.thickness,
			Color = stroke.color,
			ApplyStrokeMode = stroke.mode,
		}),
		Row = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = (props.zIndex or 1) + 1,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, Theme.spacing.sm),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			-- buy price-pill: optional leading currency glyph.
			Icon = if props.icon
				then e("ImageLabel", {
					BackgroundTransparency = 1,
					Image = props.icon,
					ImageColor3 = textColor,
					Size = UDim2.fromOffset(22, 22),
					LayoutOrder = 1,
					ZIndex = (props.zIndex or 1) + 1,
				})
				else nil,
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.fromScale(0, 1),
				Text = props.price or props.text or "Button",
				FontFace = Theme.typography.label.font,
				TextColor3 = textColor,
				TextSize = Theme.typography.label.textSize,
				LayoutOrder = 2,
				ZIndex = (props.zIndex or 1) + 1,
			}),
		}),
	})
end

return ActionButton
