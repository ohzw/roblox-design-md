-- currency-bar from DESIGN.roblox.md: dark navy pill, coin icon, amount, green + button.
-- Icon is a real image asset from Theme.assets (asset-sourcing.md) when the
-- `icon` prop is supplied — coin stack for soft, diamond outline for hard,
-- both white/transparent so ImageColor3 can tint per the tinting rule.
-- Falls back to the original colored-circle placeholder when no icon prop is
-- passed (keeps older call sites, e.g. Buttons.story, working unmodified).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function abbreviate(n)
	if n >= 1_000_000 then
		return string.format("%.1fM", n / 1_000_000)
	elseif n >= 10_000 then
		return string.format("%.1fK", n / 1_000)
	end
	return tostring(n)
end

local function CurrencyBar(props)
	local iconColor = if props.kind == "hard" then Theme.colors.currencyHard else Theme.colors.currencySoft
	local iconAsset = props.icon

	return e("Frame", {
		BackgroundColor3 = Color3.fromHex("#3A2A5E"),
		Size = props.size or UDim2.fromOffset(190, 44),
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
		Icon = if iconAsset
			then e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = iconAsset,
				ImageColor3 = iconColor,
				Size = UDim2.fromOffset(36, 36),
				Position = UDim2.new(0, 4, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				ZIndex = 2,
			})
			else e("Frame", {
				BackgroundColor3 = iconColor,
				Size = UDim2.fromOffset(36, 36),
				Position = UDim2.new(0, 4, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				ZIndex = 2,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
				Stroke = e("UIStroke", {
					Thickness = 2,
					Color = Theme.strokes.outline.color,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				}),
			}),
		Amount = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -88, 1, 0),
			Position = UDim2.fromOffset(46, 0),
			Text = abbreviate(props.amount or 0),
			FontFace = Theme.typography.body.font,
			TextSize = Theme.typography.body.textSize,
			TextColor3 = Theme.colors.white,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}),
		Plus = e("TextButton", {
			AutoButtonColor = false,
			BackgroundColor3 = Theme.colors.primary,
			Size = UDim2.fromOffset(34, 34),
			Position = UDim2.new(1, -5, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Text = "+",
			FontFace = Theme.typography.label.font,
			TextSize = 26,
			TextColor3 = Theme.colors.white,
			ZIndex = 2,
			[React.Event.Activated] = function()
				if props.onBuy then
					props.onBuy()
				end
			end,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
			Stroke = e("UIStroke", {
				Thickness = 2,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			}),
			TextStroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			}),
		}),
	})
end

return CurrencyBar
