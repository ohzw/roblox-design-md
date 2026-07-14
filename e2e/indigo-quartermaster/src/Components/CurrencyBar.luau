-- currency-bar from DESIGN.roblox.md (Indigo Quartermaster): dark
-- surface-dark pill, icon left, white amount, full rounding. Anchored in the
-- hub header band right of the tabs / left of the close glyph.

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
	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDark,
		Size = props.size or UDim2.fromOffset(120, 44),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.xs),
		}),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.md),
			PaddingRight = UDim.new(0, Theme.spacing.md),
		}),
		-- Currency icon: real sourced asset (Theme.assets.iconCurrencySoft),
		-- monochrome white line-art tinted via ImageColor3 (asset-sourcing.md
		-- tinting rule) with the accent-soft periwinkle this slot used before.
		Icon = e("ImageLabel", {
			BackgroundTransparency = 1,
			Image = Theme.assets.iconCurrencySoft,
			ImageColor3 = Theme.colors.accentSoft,
			Size = UDim2.fromOffset(20, 20),
			LayoutOrder = 1,
			ZIndex = (props.zIndex or 1) + 1,
		}),
		Amount = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = abbreviate(props.amount or 0),
			FontFace = Theme.typography.label.font,
			TextSize = Theme.typography.label.textSize,
			TextColor3 = Theme.colors.onSurface,
			LayoutOrder = 2,
			ZIndex = (props.zIndex or 1) + 1,
		}),
	})
end

return CurrencyBar
