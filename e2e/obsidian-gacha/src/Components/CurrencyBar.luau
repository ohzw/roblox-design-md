-- currency-bar from DESIGN.roblox.md: "top-left pill, surface-dark navy with a
-- blue/cyan glossy vertical gradient and a bright rim; cyan gem glyph + white
-- amount. Feel: a lit display readout." kind "soft" = gems (cyan), "hard" =
-- Robux (green). Icon is a real image asset from Theme.assets, tinted per kind.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local Glow = require(script.Parent.Glow)

local e = React.createElement

local function abbreviate(n)
	if n >= 1_000_000_000 then
		return string.format("%.2fB", n / 1_000_000_000)
	elseif n >= 1_000_000 then
		return string.format("%.1fM", n / 1_000_000)
	elseif n >= 10_000 then
		return string.format("%.0fK", n / 1_000)
	end
	return tostring(n)
end

local function CurrencyBar(props)
	local isHard = props.kind == "hard"
	local iconColor = if isHard then Theme.colors.currencyHard else Theme.colors.currencySoft
	local iconAsset = if isHard then Theme.assets.iconRobux else Theme.assets.iconGem

	return e("Frame", {
		-- white base: the glossy navy comes from the UIGradient below, which
		-- multiplies with BackgroundColor3 (see Theme.white).
		BackgroundColor3 = Theme.white,
		Size = props.size or UDim2.fromOffset(200, 56),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		Gradient = e("UIGradient", {
			Color = ColorSequence.new(Theme.gradients.currency.top, Theme.gradients.currency.bottom),
			Rotation = 90,
		}),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.confirm.thickness,
			Color = Theme.strokes.confirm.color,
			ApplyStrokeMode = Theme.strokes.confirm.mode,
			Transparency = 0.15,
		}),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.sm),
			PaddingRight = UDim.new(0, Theme.spacing.lg),
		}),
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, Theme.spacing.sm),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		-- gem slot: the gem blooms in its currency color (glow behind, gem on top).
		-- The slot is the layout item; the halo overflows it and the pill edge
		-- (CurrencyBar does not ClipsDescendants), giving the "lit readout" bloom.
		GemSlot = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(34, 34),
			LayoutOrder = 1,
			ZIndex = (props.zIndex or 1) + 1,
		}, {
			Bloom = e(Glow, {
				colorOverride = iconColor,
				token = Theme.glow.gem,
				elementSize = UDim2.fromOffset(34, 34),
				zIndex = (props.zIndex or 1) + 1,
			}),
			Icon = e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = iconAsset,
				ImageColor3 = iconColor,
				Size = UDim2.fromScale(1, 1),
				ZIndex = (props.zIndex or 1) + 2,
			}),
		}),
		Amount = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.fromScale(0, 1),
			Text = abbreviate(props.amount or 0),
			FontFace = Theme.typography.label.font,
			TextColor3 = Theme.colors.onSurface,
			TextSize = Theme.typography.label.textSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = 2,
			ZIndex = (props.zIndex or 1) + 1,
		}),
	})
end

return CurrencyBar
