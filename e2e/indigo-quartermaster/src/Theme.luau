-- Theme tokens mechanically translated from
-- design-md/indigo-quartermaster/DESIGN.roblox.md front matter.
-- Taste: flat one-hue utility UI — depth is a lightness ladder of a single
-- indigo, verdict colors (green/red/blue) arrive as solid fills only. NO
-- shadows, NO bevels, NO gradients except button-cta's slab, NO text strokes.

local Theme = {}

Theme.colors = {
	primary = Color3.fromHex("#27AE60"), -- confirm green: Gift, Awesome!, PLAY AGAIN, robux pills, toggle-On
	secondary = Color3.fromHex("#597CBC"), -- soft-currency price pills
	danger = Color3.fromHex("#FE383B"), -- hot red: destructive/negative hot buttons
	dangerSoft = Color3.fromHex("#E4696A"), -- Off toggle segment, cost/locked verdict bands
	surface = Color3.fromHex("#4F5081"), -- window body
	surfaceRaised = Color3.fromHex("#5A65A3"), -- rows, cards (one step lighter than surface)
	surfaceDeep = Color3.fromHex("#3D3F6A"), -- inset wells: text fields, search bars, message boxes
	surfaceDark = Color3.fromHex("#383660"), -- dark chrome pills (currency counters)
	header = Color3.fromHex("#6467A8"), -- header bands + split-row label segments (lightest step)
	hudInk = Color3.fromHex("#1E3B50"), -- in-match HUD pill navy (colder/darker than lobby indigo)
	onSurface = Color3.fromHex("#FFFFFF"),
	onSurfaceMuted = Color3.fromHex("#A9A9D0"), -- subtitles, placeholders, disabled labels (never gray)
	accentInfo = Color3.fromHex("#5EACFE"), -- item names, card bottom strips
	accentSoft = Color3.fromHex("#B9BCFF"), -- progress fills, slider tracks, active-tab underline
	progressTrack = Color3.fromHex("#787EC7"),
}

-- "#4F5081AA" -> alpha 0xAA (170/255 = 0.667 opaque) -> Transparency 0.33.
-- ESTIMATED per DESIGN.md notes (judged through translucency, no undimmed pair).
Theme.colors.dim = Color3.fromHex("#4F5081")
Theme.dimTransparency = 0.33

local builderSansBold = Font.fromName("BuilderSans", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local builderSansRegular = Font.fromName("BuilderSans", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local builderSansSemiBold = Font.fromName("BuilderSans", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
local robotoMono = Font.fromName("RobotoMono", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

Theme.typography = {
	display = { font = builderSansBold, textSize = 40, uppercase = false }, -- sentence case
	heading = { font = builderSansBold, textSize = 24, uppercase = false }, -- sentence case
	body = { font = builderSansRegular, textSize = 18, uppercase = false },
	label = { font = builderSansBold, textSize = 18, uppercase = false }, -- caps/title case decided per-use
	caption = { font = builderSansSemiBold, textSize = 14, uppercase = false },
	timer = { font = robotoMono, textSize = 20, uppercase = false },
}

Theme.spacing = { xs = 4, sm = 8, md = 12, lg = 20, xl = 32 }

Theme.rounded = {
	none = UDim.new(0, 0),
	sm = UDim.new(0, 4),
	md = UDim.new(0, 8),
	full = UDim.new(1, 0),
}

Theme.strokes = {
	hairline = { thickness = 1, color = Color3.fromHex("#9C9ED7"), mode = Enum.ApplyStrokeMode.Border },
	selection = { thickness = 2, color = Color3.fromHex("#FFFFFF"), mode = Enum.ApplyStrokeMode.Border },
}

Theme.motion = {
	durations = { instant = 0.06, fast = 0.12, normal = 0.18, slow = 0.3 },
	easings = {
		pop = { style = Enum.EasingStyle.Quart, direction = Enum.EasingDirection.Out },
		settle = { style = Enum.EasingStyle.Linear, direction = Enum.EasingDirection.Out },
		exit = { style = Enum.EasingStyle.Quart, direction = Enum.EasingDirection.In },
	},
}

-- Derived tokens: this taste bans bevels/shadows, so "press feedback" is a
-- one-value-step darken of the fill (Motion prose: "darken the fill one
-- value step. No squash."). Precomputed here (not in components) at a 12%
-- darken ratio, consistent across every fill that can be pressed.
Theme.derived = {
	primaryPressed = Color3.fromHex("#229954"),
	secondaryPressed = Color3.fromHex("#4E6DA5"),
	dangerPressed = Color3.fromHex("#E03134"),
	surfacePressed = Color3.fromHex("#464672"),
	surfaceRaisedPressed = Color3.fromHex("#4F598F"),
	headerPressed = Color3.fromHex("#585B94"),
	surfaceDarkPressed = Color3.fromHex("#313054"),
	-- White is already the lightest possible value, so its "pressed" step
	-- darkens toward the header tint instead of true black (same 12% ratio).
	onSurfacePressed = Color3.fromHex("#DADAF0"),
	-- Story-only backdrop: a bright game-world stand-in so translucent/flat
	-- chrome reads in context (this taste has no world-facing token itself).
	worldBackdrop = Color3.fromHex("#8FBF6B"),
	-- Derived (component token button-cta: "gradient: horizontal(#31E856,
	-- #22DA34)" -- the DESIGN.md-inlined gradient stops themselves, kept here
	-- rather than as component literals since Theme is the single audit
	-- point). Pressed variant follows the same 12%-darken ratio as every
	-- other pressed step in this table.
	ctaGradientTop = Color3.fromHex("#31E856"),
	ctaGradientBottom = Color3.fromHex("#22DA34"),
	ctaGradientTopPressed = Color3.fromHex("#2ACB4A"),
	ctaGradientBottomPressed = Color3.fromHex("#1EBF2E"),
}

-- Fully-transparent placeholder fill for elements that are BackgroundTransparency
-- = 1 (bare-glyph buttons, inactive tabs) but still need a BackgroundColor3 value.
Theme.colors.none = Color3.fromHex("#000000")

-- Real image assets for icon/texture slots (asset-sourcing.md). Components
-- consume Theme.assets.* only -- never a literal id in a component file.
-- Tinting: all monochrome picks below are white-or-dark line art on a
-- VERIFIED transparent background (pixel-checked via curl + Read, not
-- assumed from the thumbnail), so ImageColor3 = Theme.colors.onSurface (or
-- any fill) recolors them per this taste's "one hue, many values" ladder --
-- exactly the structure-over-palette fit asset-sourcing.md calls for. Two
-- items (Acorn, Crown) are kept full-color per the tie-break rule (genuine,
-- on-topic, rights-clean asset beats a placeholder even off-palette); this
-- is noted per-slot below and does not use ImageColor3.
Theme.assets = { -- resolved image IDs (in-engine arbitrated 2026-07-13); decal provenance in comments
	-- Creator Store free asset 11888845578 "shopping cart icon" by elementerzz
	-- (searched: "shopping cart icon white flat") -- HUD launcher: Shop.
	-- White glyph, transparent bg verified (corner alpha 0). Tint with
	-- ImageColor3 = Theme.colors.onSurface.
	iconShop = "rbxassetid://10564712711",
	-- Creator Store free asset 92424634177694 "Inventory" by SonicBrYouTube
	-- (searched: "backpack bag icon white flat") -- HUD launcher: Items.
	-- White outline backpack, transparent bg verified. ImageColor3-tintable.
	iconItems = "rbxassetid://119865765676356",
	-- Creator Store free asset 73681023273119 "Settings" by l1am19
	-- (searched: "gear settings icon white flat") -- HUD launcher: Settings.
	-- White gear glyph, transparent bg verified. ImageColor3-tintable.
	iconSettings = "rbxassetid://70515892818048",
	-- Creator Store free asset 3609651069 "White Coin Stack" by BlackeyeI
	-- (searched: "coin icon white flat simple"; CC-attributed, Noun Project
	-- "Coin stack" by A.C.L.) -- currency-bar / button-buy (soft currency)
	-- icon slot. White line-art coin stack, transparent bg verified.
	-- ImageColor3-tintable.
	iconCurrencySoft = "rbxassetid://3609651064",
	-- Creator Store free asset 135318552860992 "diamond_white" by iStratix
	-- (searched: "gem icon white flat premium currency") -- button-buy
	-- (premium currency) icon slot. White diamond glyph, transparent bg
	-- verified. ImageColor3-tintable.
	iconCurrencyPremium = "rbxassetid://82204383580968",
	-- Creator Store free asset 3197017635 "Acorns" by Noob_racer95 (searched:
	-- "acorn nut icon transparent flat white" / "acorn icon transparent flat
	-- white") -- shop item: Acorn (common). Transparent bg verified, but the
	-- art itself is full-color green with a white outline, not monochrome --
	-- no clean monochrome acorn glyph surfaced after multiple phrasings
	-- (store results were dominated by an opaque-green-canvas "Acorns" decal,
	-- id 3197036011, rejected on pixel check: solid fill at the corner, no
	-- alpha) and an unrelated Animal Crossing leaf glyph. Kept per the
	-- tie-break rule (genuine on-topic asset beats a placeholder even
	-- off-palette); not ImageColor3-tinted, used as a full-bleed render.
	itemAcorn = "rbxassetid://17673338597",
	-- Creator Store free asset 82728088435421 "feather" by ohmyolo243RR
	-- (searched: "feather icon white flat") -- shop item: Feather (common).
	-- White outline feather, transparent bg verified. ImageColor3-tintable.
	itemFeather = "rbxassetid://100041384303356",
	-- Creator Store free asset 9019175558 "Crystal" by cooljeremy777
	-- (searched: "crystal gem icon white flat") -- shop item: Crystal (rare).
	-- White filled crystal cluster, transparent bg verified (reads faint
	-- against a checkerboard preview but solid and legible once composited
	-- over this taste's indigo surface -- checked directly). ImageColor3-tintable.
	itemCrystal = "rbxassetid://9019175526",
	-- Creator Store free asset 128190695880419 "Lantern ui 4" by
	-- picklepumpken12 (searched: "lantern lamp icon white glyph" / "lantern
	-- icon simple silhouette") -- shop item: Lantern (rare). Dark line-art
	-- lantern, transparent bg verified. REPLACES an earlier candidate
	-- (11631359254 "Lantern Icon" by xxxscrapfredbearxxx): its corner pixel
	-- checked as OPAQUE white (srgba(255,255,255,1), TrueColorAlpha Matte
	-- "grey74") -- a baked white canvas, not transparency, the same failure
	-- mode as the known-bad compass. Dark-on-transparent art still tints
	-- acceptably per the tinting rule's soft preference.
	itemLantern = "rbxassetid://76487404033438",
	-- Creator Store free asset 112070865936133 "GPS TH" by Tar_0933
	-- (searched: "compass icon outline white ui") -- shop item: Compass
	-- (epic). Black compass-rose glyph, transparent bg verified.
	-- DELIBERATELY AVOIDS the known-bad sibling pick 81888477593570
	-- "Explorarium Compass 1" (white-on-white, renders blank in capture --
	-- flagged bad in e2e/studded-toybox). Dark-on-transparent, tints
	-- acceptably.
	itemCompass = "rbxassetid://696398371",
	-- Creator Store free asset 360172302 "crown-gold-icon" by Mantines
	-- (searched: "crown icon gold") -- shop item: Crown (legendary,
	-- emphasized/limited treatment). Transparent bg verified (corner alpha
	-- 0), full-color gold/red/white art. Kept full-color per the tie-break
	-- rule -- fitting, since this is the ONE emphasized/limited item in the
	-- standard set and a gold crown reads as "special" even against the
	-- taste's flat monochrome siblings; not ImageColor3-tinted.
	itemCrown = "rbxassetid://360172301",
}

return Theme
