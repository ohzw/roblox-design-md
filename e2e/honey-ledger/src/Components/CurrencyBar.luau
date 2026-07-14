-- currency-bar from DESIGN.roblox.md (Honey Ledger): the HUD signature -- a
-- light-gray label chip (parallelogram-cut right edge, the taste's one
-- decorative cut) butted against a translucent charcoal track; amount in
-- currencySoft gold (primary resource) or white (secondary). height 34px at
-- reference. No hard-currency accent was observed in this taste; "kind"
-- picks the gold/white ink split only.
-- The parallelogram cut is implemented as a small rotated Frame overlapping
-- the chip/track seam (a "rotated ImageLabel or slanted 9-slice" per Shapes
-- -- no image asset needed for a solid-fill skew, so a rotated frame is the
-- lighter-weight procedural equivalent).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local HEIGHT = 34
local CHIP_WIDTH = 46

local function abbreviate(n)
	if n >= 1_000_000 then
		return string.format("%.1fM", n / 1_000_000)
	elseif n >= 10_000 then
		return string.format("%.1fK", n / 1_000)
	end
	return string.format("%d", n)
end

local function CurrencyBar(props)
	local ink = if props.kind == "secondary" then Theme.colors.white else Theme.colors.currencySoft

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = props.size or UDim2.fromOffset(190, HEIGHT),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		-- label chip: light-gray, sits left, skewed right edge via the
		-- overlapping rotated frame below.
		Chip = e("Frame", {
			BackgroundColor3 = Theme.derived.currencyChip,
			Size = UDim2.fromOffset(CHIP_WIDTH, HEIGHT),
			ZIndex = 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Glyph = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = props.glyph or "$",
				FontFace = Theme.typography.utility.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}, {
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.utility.textSize }),
			}),
			-- Skew cut: a thin rotated sliver in the track color overlapping
			-- the chip's right edge, standing in for the slanted 9-slice cut.
			Skew = e("Frame", {
				BackgroundColor3 = Theme.colors.surfaceDark,
				BackgroundTransparency = Theme.surfaceDarkTransparency,
				Size = UDim2.new(0, 10, 1, 16),
				Position = UDim2.new(1, -3, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Rotation = 12,
				ZIndex = 2,
			}),
		}),
		-- translucent charcoal track holding the numeral.
		Track = e("Frame", {
			BackgroundColor3 = Theme.colors.surfaceDark,
			BackgroundTransparency = Theme.surfaceDarkTransparency,
			Size = UDim2.new(1, -CHIP_WIDTH + 6, 1, 0),
			Position = UDim2.fromOffset(CHIP_WIDTH - 6, 0),
			ZIndex = 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Amount = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -Theme.spacing.md * 2, 1, 0),
				Position = UDim2.new(0, Theme.spacing.md, 0, 0),
				Text = abbreviate(props.amount or 0),
				FontFace = Theme.typography.utility.font,
				TextSize = Theme.typography.utility.textSize,
				TextColor3 = ink,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2,
			}, {
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.utility.textSize }),
			}),
		}),
	})
end

return CurrencyBar
