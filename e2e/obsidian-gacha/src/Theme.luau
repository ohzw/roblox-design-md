-- Theme tokens, generated (by hand, this pass) from
-- design-md/obsidian-gacha/DESIGN.roblox.md front matter per
-- designmd-to-react-lua/references/generation-procedure.md.
-- Every visual constant a component consumes lives here; a literal hex in a
-- component file is a review defect (except DESIGN.md-inlined values).

local Theme = {}

-- kebab-case DESIGN.md tokens -> camelCase Theme fields.
Theme.colors = {
	primary = Color3.fromHex("#3961E1"),      -- confirm/brand blue
	secondary = Color3.fromHex("#66D82E"),    -- affordable/success green (== currencyHard hex)
	danger = Color3.fromHex("#D64359"),       -- destructive
	surface = Color3.fromHex("#12171B"),      -- window/panel fill (near-black navy)
	surfaceDeep = Color3.fromHex("#0D0D10"),  -- inset wells + button fills (near-pure black)
	surfaceDark = Color3.fromHex("#14253C"),  -- currency pill / dark glossy chrome
	onSurface = Color3.fromHex("#F2F6FA"),    -- primary text (cool near-white, never pure #FFF)
	onSurfaceDim = Color3.fromHex("#9AA6B2"), -- secondary text / placeholders / disabled
	currencySoft = Color3.fromHex("#60FFF7"), -- gems (cyan) — earned currency
	currencyHard = Color3.fromHex("#66D82E"), -- Robux accent — premium (same green as secondary)
	accentGold = Color3.fromHex("#E3B36E"),   -- lock / favorite / VIP / premium tier
	accentRare = Color3.fromHex("#B14DE0"),   -- representative of the holographic rarity spectrum
	outline = Color3.fromHex("#AEBCCB"),      -- neutral panel/well hairline + corner-bracket reticles
	dim = Color3.fromHex("#05070A"),          -- popup backdrop wash (paired w/ blur; see Theme.dimTransparency)
}

-- dim token "#05070Acc": alpha 0xcc = 80% opaque. Softened to 0.4 for the
-- STILL preview because the DESIGN.md's paired depth-of-field blur (which does
-- most of the backdrop work) isn't legible in a static capture; the heavy
-- alpha alone would flatten the near-black panel against the wash. Documented
-- deviation (generation-procedure.md derived-token rule).
Theme.dimTransparency = 0.4

-- Gradient identity base. UIGradient.Color MULTIPLIES with the object's
-- BackgroundColor3/TextColor3, so any element whose real colors come from a
-- UIGradient must sit on pure white (white * gradient == gradient). Using a
-- colored base multiplies the gradient down toward black — on this near-black
-- taste that erases the gradient entirely.
Theme.white = Color3.new(1, 1, 1)

-- Panels carry a whisper of translucency so the blurred world faintly tints
-- them (window token: transparency 0.04).
Theme.panelTransparency = 0.04

local fredoka = Font.fromName("FredokaOne", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

-- One rounded family across the whole UI (Typography prose). Title Case /
-- sentence case, never shouty caps -> uppercase = false everywhere.
Theme.typography = {
	display = { font = fredoka, textSize = 40, uppercase = false }, -- reward/aura reveal, hero numbers
	heading = { font = fredoka, textSize = 26, uppercase = false }, -- window titles
	label = { font = fredoka, textSize = 22, uppercase = false },   -- buttons
	body = { font = fredoka, textSize = 18, uppercase = false },    -- rows, values
	caption = { font = fredoka, textSize = 14, uppercase = false }, -- counters, badges, microcopy
}

Theme.spacing = { xs = 4, sm = 8, md = 12, lg = 20, xl = 32 }

Theme.rounded = {
	sm = UDim.new(0, 8),
	md = UDim.new(0, 14),
	lg = UDim.new(0, 20),
	full = UDim.new(1, 0),
}

-- Semantic-stroke system (Elevation prose): every action button is one dark
-- fill wearing a different stroke color. panel/bracket are the neutral chrome.
Theme.strokes = {
	panel = { thickness = 2, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border },
	bracket = { thickness = 3, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border },
	confirm = { thickness = 3, color = Theme.colors.primary, mode = Enum.ApplyStrokeMode.Border },
	destroy = { thickness = 3, color = Theme.colors.danger, mode = Enum.ApplyStrokeMode.Border },
	favorite = { thickness = 3, color = Theme.colors.accentGold, mode = Enum.ApplyStrokeMode.Border },
	affirm = { thickness = 3, color = Theme.colors.secondary, mode = Enum.ApplyStrokeMode.Border },
	neutral = { thickness = 2, color = Theme.colors.onSurfaceDim, mode = Enum.ApplyStrokeMode.Border },
}

Theme.motion = {
	durations = { instant = 0.08, fast = 0.15, normal = 0.25, slow = 0.4 },
	easings = {
		pop = { style = Enum.EasingStyle.Back, direction = Enum.EasingDirection.Out },     -- reward/rarity reveal ONLY
		settle = { style = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.Out },
		exit = { style = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.In },
		blur = { style = Enum.EasingStyle.Sine, direction = Enum.EasingDirection.InOut },  -- depth-of-field backdrop
	},
}

-- Two-color UIGradient specs (component builds the ColorSequence). Top->bottom
-- for vertical, left->right for horizontal, matching the DESIGN.md component
-- gradient() values.
Theme.gradients = {
	window = { top = Color3.fromHex("#141B21"), bottom = Color3.fromHex("#0C0F13") },   -- vertical
	currency = { top = Color3.fromHex("#1B3B5C"), bottom = Color3.fromHex("#0E1B2E") }, -- vertical glossy
	progress = { from = Color3.fromHex("#3961E1"), to = Color3.fromHex("#5591E5") },    -- horizontal
	banner = { from = Color3.fromHex("#12324F"), to = Color3.fromHex("#0E1B2E") },      -- horizontal
}

-- Derived (computed from tokens -> must live in Theme, never in components).
local deep = Theme.colors.surfaceDeep
local function lift(c)
	-- Press feedback (Motion prose): fill lifts toward the stroke color; the
	-- chrome does not deform. Same ratio for every variant.
	return deep:Lerp(c, 0.16)
end

Theme.derived = {
	-- Story backdrop: no world-backdrop token exists (story backdrops are a
	-- generation requirement, not a UI token). A muted dusk blue matches the
	-- Overview's "near-black glass over a blurred world" AND gives the
	-- near-black panels something to read against in a still capture.
	worldBackdrop = Color3.fromHex("#35506E"),
	-- Aura/well tile fill. The DESIGN.md calls tiles "surface-deep", but a tile
	-- at surface-deep (#0D0D10) on the near-black panel gradient (#141B21->#0C0F13)
	-- reads as one flat black mass in a capture (verified in-engine). Lifted a
	-- notch to a dark slate so tiles read as RAISED against the panel while
	-- staying firmly in the midnight-vault register. Derived (panel-separation).
	cardFill = Color3.fromHex("#1A222B"),
	-- Selected aura tile fill (card-grid-selected token, DESIGN.md-inlined).
	selectedCardFill = Color3.fromHex("#223349"),
	-- Segmented-tab selected fill (segmented-tab-selected token, inlined).
	tabSelectedFill = Color3.fromHex("#2E3338"),
	pressed = {
		confirm = lift(Theme.colors.primary),
		favorite = lift(Theme.colors.accentGold),
		destroy = lift(Theme.colors.danger),
		affirm = lift(Theme.colors.secondary),
		neutral = lift(Theme.colors.onSurfaceDim),
	},
}

-- Rarity ladder for aura cards. The DESIGN.md states rarity is a per-aura
-- holographic SPECTRUM (fill + brackets + name all take the aura's hue), with
-- accent-rare stored only as a representative. The named rungs below map the
-- standard-showcase tiers onto that spectrum using existing taste tokens (no
-- new palette invented): common=neutral gray, rare=primary blue, epic=
-- accent-rare magenta, legendary=accent-gold (the top/exclusive glow). Cards
-- fail soft to `common` on unknown keys.
Theme.rarity = {
	common = Theme.colors.onSurfaceDim,
	rare = Theme.colors.primary,
	epic = Theme.colors.accentRare,
	legendary = Theme.colors.accentGold,
}

-- Which rungs get a FILLED glowing tile vs staying dark (Colors prose: "Top-tier
-- auras upgrade to a fully filled, glowing tile").
Theme.rarityFilled = {
	common = false,
	rare = false,
	epic = true,
	legendary = true,
}

-- Theme.assets: single audit point for real image assets (asset-sourcing.md).
-- IDs are the catalog's arbitrated canonical IMAGE ids (in-engine verified
-- 2026-07-13). The Studio MCP was disconnected this pass, so no NEW searches
-- or in-session IsLoaded re-checks were possible; icons below are reused from
-- the arbitrated set and must be re-verified in the capture. Icons are
-- white/transparent monochrome, tinted per-slot via ImageColor3 (tinting rule).
-- Stand-in notes: this taste's own glyphs (sparkle/dice/medal) have no
-- arbitrated asset, so the sparkle header slot reuses the diamond outline and
-- the gem/Robux currency icons reuse diamond/coin, all recolored. The Roll
-- die is drawn procedurally (RollButton), not an asset.
Theme.assets = {
	iconShop = "rbxassetid://10564712711",           -- white cart, transparent
	iconItems = "rbxassetid://119865765676356",      -- white backpack, transparent
	iconSettings = "rbxassetid://70515892818048",    -- bold white gear, transparent
	iconGem = "rbxassetid://82204383580968",         -- white diamond outline (gems / sparkle stand-in)
	iconRobux = "rbxassetid://3609651064",           -- white coin stack (Robux stand-in)
	itemAcorn = "rbxassetid://17673338597",          -- full-color flat, transparent
	itemFeather = "rbxassetid://100041384303356",    -- white, tintable
	itemCrystal = "rbxassetid://9019175526",         -- white cluster, tintable
	itemLantern = "rbxassetid://76487404033438",     -- full-color w/ glow, transparent
	itemCompass = "rbxassetid://696398371",          -- white circle compass, tintable
	itemCrown = "rbxassetid://360172301",            -- full-color gold (legendary pop)
}

return Theme
