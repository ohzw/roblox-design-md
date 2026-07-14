-- currency-counter from DESIGN.roblox.md: the HUD money readout -- no plate
-- at all, just huge white display numerals with the 4px warm-brown stroke
-- and a slight italic skew, bottom-left. Abbreviates aggressively (K/M/B/QA)
-- with the cent glyph (Components prose). The italic slant is implemented as
-- a Rotation skew garnish, not a fontStyle token, per the extraction notes
-- (the mapped family, FredokaOne, ships one style).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function abbreviate(n)
	if n >= 1_000_000_000_000 then
		return string.format("%.1fQA", n / 1_000_000_000_000)
	elseif n >= 1_000_000_000 then
		return string.format("%.1fB", n / 1_000_000_000)
	elseif n >= 1_000_000 then
		return string.format("%.1fM", n / 1_000_000)
	elseif n >= 10_000 then
		return string.format("%.1fK", n / 1_000)
	end
	return string.format("%d", n)
end

local function CurrencyCounter(props)
	return e("TextLabel", {
		BackgroundTransparency = 1,
		Size = props.size or UDim2.fromOffset(280, 64),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		Text = "$" .. abbreviate(props.amount or 0) .. "\u{00A2}", -- cent glyph per Components prose
		FontFace = Theme.typography.display.font,
		TextScaled = true,
		TextColor3 = Theme.colors.onSurface,
		TextXAlignment = Enum.TextXAlignment.Left,
		Rotation = -4, -- Typography prose: italic slant implemented as a skew/rotation garnish
	}, {
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.textOutlineDisplay.thickness,
			Color = Theme.strokes.textOutlineDisplay.color,
			ApplyStrokeMode = Theme.strokes.textOutlineDisplay.mode,
		}),
		MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.display.textSize }),
	})
end

return CurrencyCounter
