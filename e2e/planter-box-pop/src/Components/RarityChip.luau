-- rarity-chip from DESIGN.roblox.md: small raised plate, rarity-colored fill,
-- white Title Case outlined text, white rim, 2px bevel in a darker rarity
-- tone. Transcendent adds star sparkles at the plate's left and right edges.
-- Rarity color appears ONLY on chips (Colors prose) -- never on the row fill
-- or the item name; this component is the sole place accent-* tokens render.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local RARITIES = {
	common = { fill = Theme.colors.accentCommon, bevel = Theme.derived.rarityBevels.common },
	uncommon = { fill = Theme.colors.accentUncommon, bevel = Theme.derived.rarityBevels.uncommon },
	rare = { fill = Theme.colors.accentRare, bevel = Theme.derived.rarityBevels.rare },
	legendary = { fill = Theme.colors.accentLegendary, bevel = Theme.derived.rarityBevels.legendary },
	divine = { fill = Theme.colors.accentDivine, bevel = Theme.derived.rarityBevels.divine },
	transcendent = { fill = Theme.colors.accentTranscendent, bevel = Theme.derived.rarityBevels.transcendent, stars = true },
}

local BEVEL_HEIGHT = 2

-- Title Case per the Typography prose ("chips are Title Case"); rarity keys
-- are lowercase identifiers, this maps them to display text.
local LABELS = {
	common = "Common",
	uncommon = "Uncommon",
	rare = "Rare",
	legendary = "Legendary",
	divine = "Divine",
	transcendent = "Transcendent",
}

local function RarityChip(props)
	-- Defensive fallback: an unrecognized rarity key (e.g. a showcase tier
	-- this taste's own six-step scale doesn't name) degrades to "common"
	-- instead of crashing the tree (self-review fix: was a hard `nil.bevel`
	-- index error until Shop.story's caller was corrected to a valid key --
	-- kept here too so future callers fail soft, not hard).
	local rarity = RARITIES[props.rarity or "common"] or RARITIES.common
	local label = props.text or LABELS[props.rarity or "common"] or LABELS.common

	return e("Frame", {
		BackgroundColor3 = rarity.bevel,
		Size = props.size or UDim2.fromOffset(96, 28),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 1,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outlineWhite.thickness,
			Color = Theme.strokes.outlineWhite.color,
			ApplyStrokeMode = Theme.strokes.outlineWhite.mode,
		}),
		Face = e("Frame", {
			BackgroundColor3 = rarity.fill,
			Size = UDim2.new(1, 0, 1, -BEVEL_HEIGHT),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			LeftStar = rarity.stars and e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(14, 14),
				Position = UDim2.new(0, 2, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				-- U+2726 tofu'd in verified testing (verification.md); use ASCII asterisk instead.
				Text = "*",
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}, {
				-- Typography prose: "every piece of text in this taste is
				-- outlined ... no exceptions" (self-review fix: was missing).
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
			}) or nil,
			RightStar = rarity.stars and e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(14, 14),
				Position = UDim2.new(1, -2, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				Text = "*",
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
			}) or nil,
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = label,
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, rarity.stars and 16 or Theme.spacing.xs),
					PaddingRight = UDim.new(0, rarity.stars and 16 or Theme.spacing.xs),
				}),
			}),
		}),
	})
end

return RarityChip
