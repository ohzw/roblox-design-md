-- currency-display (standard-showcase.md slot) from DESIGN.roblox.md
-- (Candlelit Parlor): no dedicated HUD currency-bar token exists in this
-- taste's front matter (extraction notes: "currency-bar ... not observed
-- and intentionally undefined") — filled per generation-procedure.md's
-- derived-token rule with the taste's OWN grammar rather than an invented
-- hue: the same gold pill anatomy as button-buy (bright currency-soft fill,
-- dark currency-ink digits, rectangle 8px corners, never a capsule), read
-- here as a passive HUD readout rather than a tap target. Non-interactive:
-- no press/lift state, no Activated handler — this is a display, not a
-- button. Platform-currency glyph left, same as BuyPill, for visual parity
-- with the taste's one price-pill silhouette.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local HEIGHT = 36 -- same token height as button-buy; readout, not a tap target

local function formatAmount(n)
	-- Comma-grouped per the standard showcase's "12,400" presentational form.
	local s = tostring(math.floor(n or 0))
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return out:gsub("^,", "")
end

local function CurrencyDisplay(props)
	return e("Frame", {
		BackgroundColor3 = Theme.currencyDisplay.fill,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = props.size or UDim2.fromOffset(0, HEIGHT),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.md),
			PaddingRight = UDim.new(0, Theme.spacing.md),
		}),
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.xs),
		}),
		-- Platform-currency glyph, same dark-ink family as BuyPill's.
		Glyph = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = props.glyph or "\u{E002}",
			FontFace = Theme.typography.label.font,
			TextSize = Theme.typography.label.textSize,
			TextColor3 = Theme.currencyDisplay.ink,
			LayoutOrder = 1,
		}),
		Amount = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = formatAmount(props.amount),
			FontFace = Theme.typography.label.font,
			TextSize = Theme.typography.label.textSize,
			TextColor3 = Theme.currencyDisplay.ink,
			LayoutOrder = 2,
		}),
	})
end

return CurrencyDisplay
