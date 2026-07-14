-- currency-bar from DESIGN.roblox.md (Frosted Baseplate): top-left pill --
-- oversized ice-cube icon overflowing the left edge, white outlined amount.
-- Light cyan vertical gradient (currencyBar gradient token), rounded.md,
-- fixed 52px height. One currency, one pill (Components prose). The icon
-- badge overlaps the pill's left edge the same way window chrome floats over
-- edges elsewhere in this taste -- "chrome floats; it is never welded on."
-- Not interactive (no press/motion states defined for it in the DESIGN.md).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local ICON_SIZE = 64 -- oversized relative to the 52px bar; deliberately overflows

local function CurrencyBar(props)
	local amountText = props.amount
	if type(amountText) == "number" then
		amountText = tostring(amountText)
	end
	amountText = amountText or "0"

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = props.size or UDim2.fromOffset(180, Theme.metrics.currencyBarHeight),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Pill = e("Frame", {
			BackgroundColor3 = Theme.gradients.currencyBar[1],
			Size = UDim2.fromScale(1, 1),
			ZIndex = 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
			Gradient = e("UIGradient", {
				Rotation = 90,
				Color = ColorSequence.new(Theme.gradients.currencyBar[1], Theme.gradients.currencyBar[2]),
			}),
			Amount = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -(ICON_SIZE * 0.6 + Theme.spacing.md), 1, 0),
				Position = UDim2.new(0, ICON_SIZE * 0.6, 0, 0),
				Text = amountText,
				FontFace = Theme.typography.body.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				TextXAlignment = Enum.TextXAlignment.Right,
				ZIndex = 2,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.body.textSize }),
				Padding = e("UIPadding", {
					PaddingRight = UDim.new(0, Theme.spacing.md),
				}),
			}),
		}),
		-- Oversized ice-cube icon, overflowing the pill's left edge (floating
		-- chrome rule). Diamond silhouette (rotated square) stands in for the
		-- ice cube without an image asset.
		Icon = e("Frame", {
			BackgroundColor3 = Theme.colors.surfaceIce,
			Size = UDim2.fromOffset(ICON_SIZE, ICON_SIZE),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0.25, 0.5),
			Rotation = 45,
			ZIndex = 3,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outlineIce.thickness,
				Color = Theme.strokes.outlineIce.color,
				ApplyStrokeMode = Theme.strokes.outlineIce.mode,
			}),
		}),
	})
end

return CurrencyBar
