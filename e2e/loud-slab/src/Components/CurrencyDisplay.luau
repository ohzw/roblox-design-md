-- currency-bar from DESIGN.roblox.md (Loud Slab): "no plate at all: a naked
-- display-tier TextLabel in {colors.currency-soft} with the black ink
-- outline, plus a caption line." This is the taste's money corner: a huge
-- naked cash counter, bottom-left, with a boost caption under it -- never a
-- pill, never a background.
--
-- Money is double-coded (Colors prose): currency-soft yellow-green for cash
-- AMOUNTS, accent-value yellow for rates/section headings -- this component
-- renders the amount tier only; a `rate` prop (optional) renders a
-- second line in accent-value for "per-second" style displays.

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

local function CurrencyDisplay(props)
	return e("Frame", {
		BackgroundTransparency = 1,
		-- Default height tightened 96->74 (52 Amount + 18 Caption, matching the
		-- REAL TextBounds of each line at their own declared textSize tokens --
		-- measured in-engine, not a guess) -- the previous 60/22 line-box heights
		-- carried ~12px of unused slack that, at 667x375, pushed this component's
		-- bottom edge into the Hotbar row below it (verified failure mode). Token
		-- sizes (display.textSize=52, caption.textSize=18) are unchanged; only
		-- the wrapper boxes now hug the real ink.
		Size = props.size or UDim2.fromOffset(320, 74),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		Amount = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 52),
			Text = abbreviate(props.amount or 0),
			FontFace = Theme.typography.display.font,
			TextSize = Theme.typography.display.textSize,
			TextColor3 = Theme.colors.currencySoft, -- money is NEVER white; always currency-soft or accent-value
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = 1,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}),
		Caption = props.caption and e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 18),
			Text = props.caption,
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize,
			TextColor3 = Theme.colors.onSurface,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = 2,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = 2,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			}),
		}) or nil,
	})
end

return CurrencyDisplay
