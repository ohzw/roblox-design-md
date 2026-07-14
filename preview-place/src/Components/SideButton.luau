-- side-button from DESIGN.roblox.md: yellow square launcher with an icon,
-- caption, and an optional red notification badge pinned to the top-right
-- corner. Icon is a real image asset from Theme.assets (asset-sourcing.md)
-- when the `icon` prop is supplied; falls back to the original colored-circle
-- placeholder otherwise (keeps older call sites working unmodified).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement
local BEVEL = 4

local function badgeText(count)
	if count > 99 then
		return "99+"
	end
	return tostring(count)
end

local function SideButton(props)
	local pressed, setPressed = React.useState(false)

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.bevels.side,
		Size = props.size or UDim2.fromOffset(72, 72),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
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
		Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Face = e("Frame", {
			BackgroundColor3 = Theme.colors.currencySoft,
			Size = if pressed then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 1, -BEVEL),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
			Icon = if props.icon
				then e("ImageLabel", {
					BackgroundTransparency = 1,
					Image = props.icon,
					ImageColor3 = props.iconColor or Theme.colors.onSurface,
					Size = UDim2.fromOffset(34, 34),
					Position = UDim2.new(0.5, 0, 0, 8),
					AnchorPoint = Vector2.new(0.5, 0),
					ZIndex = 3,
				})
				else e("Frame", {
					BackgroundColor3 = props.iconColor or Theme.colors.secondary,
					Size = UDim2.fromOffset(30, 30),
					Position = UDim2.new(0.5, 0, 0, 8),
					AnchorPoint = Vector2.new(0.5, 0),
					ZIndex = 3,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
					Stroke = e("UIStroke", {
						Thickness = 2,
						Color = Theme.strokes.outline.color,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					}),
				}),
			Caption = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -8, 0, 18),
				Position = UDim2.new(0.5, 0, 1, -4),
				AnchorPoint = Vector2.new(0.5, 1),
				Text = string.upper(props.text or "SHOP"),
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}, {
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
			}),
		}),
		Badge = if props.badge and props.badge > 0
			then e("Frame", {
				BackgroundColor3 = Theme.colors.danger,
				Size = UDim2.fromOffset(28, 28),
				Position = UDim2.new(1, -2, 0, 2),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 4,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
				Stroke = e("UIStroke", {
					Thickness = 2,
					Color = Theme.strokes.outline.color,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				}),
				Count = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Text = badgeText(props.badge),
					FontFace = Theme.typography.caption.font,
					TextScaled = true,
					TextColor3 = Theme.colors.white,
					ZIndex = 5,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = 14 }),
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, 4),
						PaddingRight = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 4),
						PaddingBottom = UDim.new(0, 4),
					}),
				}),
			})
			else nil,
	})
end

return SideButton
