-- button-close from DESIGN.roblox.md: red circle, white X, oversized target.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement
local BEVEL = 4

local function CloseButton(props)
	local pressed, setPressed = React.useState(false)

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.bevels.danger,
		Size = props.size or UDim2.fromOffset(56, 56),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 5,
		[React.Event.MouseButton1Down] = function()
			setPressed(true)
		end,
		[React.Event.MouseButton1Up] = function()
			setPressed(false)
		end,
		[React.Event.MouseLeave] = function()
			setPressed(false)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Face = e("Frame", {
			BackgroundColor3 = Theme.colors.danger,
			Size = if pressed then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 1, -BEVEL),
			ZIndex = props.zIndex or 5,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = "X",
				FontFace = Theme.typography.label.font,
				TextScaled = true,
				TextColor3 = Theme.colors.white,
				ZIndex = (props.zIndex or 5) + 1,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, 14),
					PaddingRight = UDim.new(0, 14),
					PaddingTop = UDim.new(0, 12),
					PaddingBottom = UDim.new(0, 12),
				}),
			}),
		}),
	})
end

return CloseButton
