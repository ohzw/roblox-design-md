-- Theme tokens mechanically translated from
-- design-md/honey-ledger/DESIGN.roblox.md front matter.
-- Taste: dense legacy-flat ledger UI -- borderless flat rectangles stacked
-- into full-width rows, hierarchy read entirely through hard color steps
-- (no strokes/shadows except the ONE beveled close button and the 2px text
-- stroke / 3px selection outline / thin blue dialog frame). Comic lettering
-- (ComicNeueAngular) carries game content; a stock sans (SourceSansPro)
-- carries HUD/system plumbing -- the two-voice split is deliberate, never mix.

local Theme = {}

Theme.colors = {
	primary = Color3.fromHex("#1B772A"), -- CTA green: craft/confirm/redeem, identical hex everywhere
	secondary = Color3.fromHex("#2868CC"), -- blue header bands + neutral prompt strips
	danger = Color3.fromHex("#C9271C"), -- No / destructive / active-OFF toggle
	surface = Color3.fromHex("#CABD57"), -- mustard window base
	surfaceRow = Color3.fromHex("#E5DEA5"), -- cream full-width stat/list row fill
	surfaceBlock = Color3.fromHex("#F8EEAE"), -- pale-yellow description block fill
	surfaceDeep = Color3.fromHex("#797132"), -- dark olive inset wells (image viewports)
	surfaceHeader = Color3.fromHex("#FEEC6C"), -- bright honey header band; reused as title ink over dark fills
	surfaceInfo = Color3.fromHex("#2257A8"), -- royal-blue info panel / CTA frame fill
	surfaceInfoDeep = Color3.fromHex("#1B4280"), -- darker blue inner text wells on blue panels
	surfaceDark = Color3.fromHex("#404040"), -- translucent charcoal HUD bars (alpha estimated, see below)
	onSurface = Color3.fromHex("#1E2B32"), -- near-black cool charcoal body text
	currencySoft = Color3.fromHex("#FDDF8E"), -- cream-gold resource numerals in the HUD
	success = Color3.fromHex("#6EFF62"), -- progress fill green
	successComplete = Color3.fromHex("#7AF882"), -- completed quest rows read slightly brighter
	trackIncomplete = Color3.fromHex("#F06D59"), -- salmon quest-task track (NOT a danger color)
	accentSelect = Color3.fromHex("#3283FF"), -- bright blue selection outline / dialog outer frame
	outline = Color3.fromHex("#1E2B32"), -- text-stroke ink; deliberately == onSurface
	white = Color3.fromHex("#FFFFFF"),
}

-- "#404040A6" -> alpha 0xA6 (166/255 = 0.65 opaque) -> Transparency 0.35.
-- ESTIMATED per DESIGN.md notes (compared HUD track over dark vs bright world,
-- no undimmed pair existed).
Theme.surfaceDarkTransparency = 0.35

local comicBold = Font.fromName("ComicNeueAngular", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local comicRegular = Font.fromName("ComicNeueAngular", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local sourceSansBold = Font.fromName("SourceSansPro", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

Theme.typography = {
	heading = { font = comicBold, textSize = 30, uppercase = false }, -- sentence/Title Case, never shouts
	body = { font = comicRegular, textSize = 17, uppercase = false },
	label = { font = comicBold, textSize = 26, uppercase = false },
	caption = { font = comicRegular, textSize = 14, uppercase = false },
	utility = { font = sourceSansBold, textSize = 24, uppercase = false }, -- system voice: HUD numerals, terse dialogs
}

Theme.spacing = { xs = 4, sm = 8, md = 12, lg = 20 }

Theme.rounded = {
	none = UDim.new(0, 0),
	sm = UDim.new(0, 6),
	md = UDim.new(0, 10),
	full = UDim.new(1, 0),
}

Theme.strokes = {
	-- text-outline: white text on saturated fills / over the world.
	textOutline = { thickness = 2, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Contextual },
	-- select: 3px bright-blue square outline on the active hotbar slot.
	select = { thickness = 3, color = Theme.colors.accentSelect, mode = Enum.ApplyStrokeMode.Border },
	-- frame: thin navy edging on blue info/dialog panels.
	frame = { thickness = 2, color = Theme.colors.surfaceInfoDeep, mode = Enum.ApplyStrokeMode.Border },
}

Theme.motion = {
	durations = { instant = 0.08, fast = 0.15, normal = 0.25, slow = 0.4 },
	easings = {
		pop = { style = Enum.EasingStyle.Back, direction = Enum.EasingDirection.Out }, -- reserved; NEVER on windows (overshoot reads too modern)
		settle = { style = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.Out },
		exit = { style = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.In },
		bounce = { style = Enum.EasingStyle.Elastic, direction = Enum.EasingDirection.Out }, -- reserved for celebration moments; none observed
	},
}

-- Derived tokens: this taste bans squash/bevel-everywhere; Motion prose says
-- press feedback is "a brief fill darken ... no squash" (the one exception,
-- button-close-beveled, collapses its bevel while held instead). Precomputed
-- here at a consistent ~14% darken ratio so every pressable fill has a partner.
Theme.derived = {
	primaryPressed = Color3.fromHex("#176624"),
	dangerPressed = Color3.fromHex("#AD2218"),
	buttonBuyPressed = Color3.fromHex("#CE4C45"),
	-- Bevel shade for button-close-beveled (the ONE bevel in the system,
	-- 10px darker-red bottom edge) -- DESIGN.md-inlined literal per its own
	-- `shadow: bevel(10px #771C16)` token, kept here as the Theme's single
	-- audit point rather than a component-file literal.
	closeBeveledBevel = Color3.fromHex("#771C16"),
	closeBeveledFill = Color3.fromHex("#E9594A"), -- component-level token (button-close-beveled.backgroundColor)
	closeBeveledText = Color3.fromHex("#B03024"), -- component-level token (button-close-beveled.textColor)
	closeBeveledPressed = Color3.fromHex("#C84D40"), -- bevel-collapsed-while-held darken of the fill above
	-- toggle idle/off-state pastels: observed values, not computed, kept here
	-- so components never hold a literal.
	toggleOnDisabled = Color3.fromHex("#96BCB6"),
	toggleOffDisabled = Color3.fromHex("#ECE8F0"),
	-- Story-only backdrop: this taste's windows "sit straight on the world"
	-- with no dim layer (declared gap) -- a bright sky stand-in so strokeless
	-- flat fills read in context, matching shot-1's outdoor daylight scene.
	worldBackdrop = Color3.fromHex("#8FD1F2"),
	-- Derived (no dedicated token in the DESIGN.md front matter): currency-bar
	-- label-chip fill, a light-neutral Honey-family step between surfaceRow
	-- and surfaceBlock so the chip reads as its own grouping without a stroke.
	currencyChip = Color3.fromHex("#D9D3AE"),
}

-- Real image assets for icon/texture slots (asset-sourcing.md). Components
-- consume Theme.assets.* only -- never a literal id in a component file.
Theme.assets = { -- resolved image IDs (in-engine arbitrated 2026-07-13); decal provenance in comments
	-- Creator Store free asset 11888845578 "shopping cart icon" by elementerzz
	-- (searched: "shop cart icon white flat") -- HUD icon toolbar: Shop
	iconShop = "rbxassetid://10564712711",
	-- Creator Store free asset 92424634177694 "Inventory" by SonicBrYouTube
	-- (searched: "backpack bag icon white flat") -- HUD icon toolbar: Items
	iconItems = "rbxassetid://119865765676356",
	-- Creator Store free asset 73681023273119 "Settings" by l1am19
	-- (searched: "gear settings icon white flat") -- HUD icon toolbar: Settings
	iconSettings = "rbxassetid://70515892818048",
	-- Creator Store free asset 17673338621 "Acorn (Base)" by Just_Summa
	-- (searched: "acorn icon white flat" / "acorn nut icon transparent") --
	-- shop item: Acorn (common). Full-color flat-shaded icon, not monochrome
	-- outline like its siblings -- no clean flat glyph acorn surfaced after
	-- multiple searches (store dominated by naturalistic 3D acorns / an
	-- unrelated Animal-Crossing turnip set); flattest isolated candidate.
	-- CORRECTED 2026-07-13: the prior id 3197036011 is documented known-bad
	-- in asset-sourcing.md (baked green canvas, renders opaque/wrong -- caught
	-- during Studio verification, not a fresh pick).
	itemAcorn = "rbxassetid://17673338597",
	-- Creator Store free asset 82728088435421 "feather" by ohmyolo243RR
	-- (searched: "feather icon white flat") -- shop item: Feather (common)
	itemFeather = "rbxassetid://100041384303356",
	-- Creator Store free asset 9019175558 "Crystal" by cooljeremy777
	-- (searched: "crystal gem icon white flat") -- shop item: Crystal (rare)
	itemCrystal = "rbxassetid://9019175526",
	-- Creator Store free asset 11631359254 "Lantern Icon" by xxxscrapfredbearxxx
	-- (searched: "lantern lamp icon flat white glyph") -- shop item: Lantern (rare)
	itemLantern = "rbxassetid://76487404033438",
	-- Creator Store free asset 696398374 "Images/Compass" by Vmena
	-- (searched: "compass icon white flat") -- shop item: Compass (epic).
	-- CORRECTED 2026-07-13: the prior id 81888477593570 ("Explorarium Compass
	-- 1"), listed as redeemed-good in asset-sourcing.md, fails to load in this
	-- session (ImageLabel.IsLoaded stayed false after 3s+ while sibling icons
	-- loaded fine -- likely moderated/deleted since that note was written).
	-- 696398371 verified IsLoaded=true in-engine and renders real pixels
	-- (same id used successfully by the loud-slab taste).
	itemCompass = "rbxassetid://696398371",
	-- Creator Store free asset 360172302 "crown-gold-icon" by Mantines
	-- (searched: "crown icon gold") -- shop item: Crown (legendary, emphasized)
	itemCrown = "rbxassetid://360172301",
}

return Theme
