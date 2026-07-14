-- badge-slot from DESIGN.roblox.md: small dark squared tag with a white
-- outlined number/label, pinned to a corner (Components prose: "pinned to
-- hotbar slot corners"). Reused here as the rarity/tier tag on item cards
-- (standard-showcase.md's "ONE emphasized variant" needs a rarity readout,
-- and this taste has no dedicated rarity-chip component -- badge-slot is the
-- closest existing anatomy, per generation-procedure's "derive consistently
-- with the taste" rule).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function BadgeSlot(props)
	return e("Frame", {
		BackgroundColor3 = props.fill or Theme.inks.badgeSlotFill,
		BackgroundTransparency = if props.fill then 0 else Theme.transparencies.badgeSlotFill,
		Size = props.size or UDim2.fromOffset(88, 28),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Text = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = props.text or "",
			FontFace = Theme.typography.caption.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.xs),
				PaddingRight = UDim.new(0, Theme.spacing.xs),
			}),
		}),
	})
end

return BadgeSlot
