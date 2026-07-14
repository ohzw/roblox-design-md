-- progress-bar from DESIGN.roblox.md: navy pill track, green vertical-gradient
-- fill, centered outlined label. Fill animation is a Phase 3 concern.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function ProgressBar(props)
	local progress = math.clamp(props.progress or 0, 0, 1)

	return e("Frame", {
		BackgroundColor3 = Color3.fromHex("#3A2A5E"),
		Size = props.size or UDim2.fromOffset(300, 26),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Fill = if progress > 0
			then e("Frame", {
				BackgroundColor3 = Theme.colors.white,
				Size = UDim2.fromScale(progress, 1),
				ZIndex = 2,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
				Gradient = e("UIGradient", {
					Rotation = 90,
					Color = ColorSequence.new(Color3.fromHex("#7CE85A"), Color3.fromHex("#4CB82E")),
				}),
			})
			else nil,
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = props.label or string.format("%d%%", math.floor(progress * 100 + 0.5)),
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize,
			TextColor3 = Theme.colors.white,
			ZIndex = 3,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}),
	})
end

return ProgressBar
