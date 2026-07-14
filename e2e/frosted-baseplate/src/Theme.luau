-- Theme tokens generated from design-md/frosted-baseplate/DESIGN.roblox.md
-- front matter. Kebab-case tokens become camelCase fields:
--   surface-deep -> surfaceDeep, surface-ice -> surfaceIce,
--   on-surface -> onSurface, currency-soft -> currencySoft,
--   currency-hard -> currencyHard, accent-rare -> accentRare,
--   outline-ice -> outlineIce, text-outline -> textOutline,
--   text-outline-display -> textOutlineDisplay.

local Theme = {}

Theme.colors = {
	primary = Color3.fromHex("#34CC33"), -- forward actions: redeem, reset, claim, spin
	secondary = Color3.fromHex("#1FA5DE"), -- tabs, gear/utility icons, mode-vote cyan
	danger = Color3.fromHex("#F8425A"), -- close cross, OFF toggles, locked states
	surface = Color3.fromHex("#545D61"), -- the studded charcoal window slab
	surfaceDeep = Color3.fromHex("#45494C"), -- inset rows and wells inside the slab
	surfaceIce = Color3.fromHex("#D6F4FD"), -- snow-capped banner/frame fill (status & rewards)
	onSurface = Color3.fromHex("#FFFFFF"), -- nearly all text is white over darker fills
	currencySoft = Color3.fromHex("#5FD9F7"), -- ice-cyan currency pills / soft-currency prices
	currencyHard = Color3.fromHex("#83EB39"), -- lime premium-currency price pills
	accentRare = Color3.fromHex("#FEC81F"), -- gold: featured reward columns, event headline text
	outline = Color3.fromHex("#26282B"), -- near-black; text outlines and arcade-pill strokes
}

-- "{colors.dim}: #0E1A2233" -> alpha 0x33 = 51 -> Transparency = 1 - 51/255 = 0.80
-- Estimated per extraction notes: windows rely on camera blur, not a dark
-- backdrop; the tint is deliberately light.
Theme.colors.dim = Color3.fromHex("#0E1A22")
Theme.dimTransparency = 0.80

local fredoka = Font.fromName("FredokaOne", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

Theme.typography = {
	-- single-weight family everywhere; hierarchy comes from size + outline only
	display = { font = fredoka, textSize = 44, uppercase = false },
	heading = { font = fredoka, textSize = 34, uppercase = false },
	body = { font = fredoka, textSize = 24, uppercase = false },
	label = { font = fredoka, textSize = 26, uppercase = false },
	caption = { font = fredoka, textSize = 16, uppercase = false },
}

Theme.spacing = { xs = 4, sm = 8, md = 12, lg = 24, xl = 48 }

Theme.rounded = {
	sm = UDim.new(0, 8),
	md = UDim.new(0, 14),
	lg = UDim.new(0, 20),
	full = UDim.new(1, 0),
}

Theme.strokes = {
	outline = { thickness = 3, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border },
	outlineIce = { thickness = 4, color = Color3.fromHex("#A7E9FF"), mode = Enum.ApplyStrokeMode.Border },
	textOutline = { thickness = 2, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Contextual },
	-- frosty-blue outline, NOT the usual near-black — reserved for display type on ice frames
	textOutlineDisplay = { thickness = 3, color = Color3.fromHex("#2C629B"), mode = Enum.ApplyStrokeMode.Contextual },
}

Theme.motion = {
	durations = { instant = 0.08, fast = 0.15, normal = 0.25, slow = 0.4 },
	easings = {
		pop = { style = Enum.EasingStyle.Back, direction = Enum.EasingDirection.Out },
		settle = { style = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.Out },
		exit = { style = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.In },
		bounce = { style = Enum.EasingStyle.Elastic, direction = Enum.EasingDirection.Out },
	},
}

-- Values the DESIGN.md itself inlines (component tokens and prose):

Theme.inks = {
	-- button-primary-disabled: flat gray, keeps its white label (observed on claimed cards)
	disabledFill = Color3.fromHex("#A2A2A2"),
	toggleOn = Color3.fromHex("#75FE99"), -- toggle-pill (mint ON)
	toggleOff = Color3.fromHex("#FA5055"), -- toggle-pill-off (red OFF)
	badgeSlot = Color3.fromHex("#A846FD"), -- badge-slot: small purple keybind square
}

-- window component token: shadow: drop(0px 6px #00000040) -> alpha 0x40=64 -> Transparency 1-64/255 = 0.75
Theme.windowShadow = { offset = 6, color = Color3.fromHex("#000000"), transparency = 0.75 }

Theme.gradients = {
	-- button-secondary: vertical(#0BBBFD, #25E7F3)
	secondaryButton = { Color3.fromHex("#0BBBFD"), Color3.fromHex("#25E7F3") },
	-- currency-bar: vertical(#A5E7FF, #5FD9F7)
	currencyBar = { Color3.fromHex("#A5E7FF"), Color3.fromHex("#5FD9F7") },
	-- card-grid: vertical(#62B7E8, #02245D)
	cardGrid = { Color3.fromHex("#62B7E8"), Color3.fromHex("#02245D") },
}

-- component tokens with no single-hex front-matter value (aspect ratios, fixed heights)
Theme.metrics = {
	buttonPrimaryAspect = 2.8,
	buttonSecondaryAspect = 4.1,
	currencyBarHeight = 52,
	sideButtonAspect = 1,
	togglePillHeight = 40,
	progressBarHeight = 24,
	closeCrossSize = 70, -- "free-floating cross glyph, ~70px tall"
	sideButtonSize = 100, -- "~100px square at reference"
}

-- Derived (no front-matter token; see comments for the rule each follows):
Theme.derived = {
	-- Derived (Motion prose: "pressed frame was not captured... inferred from
	-- the taste family"; Agent Prompt Guide: "press squash 0.93 at 0.08s").
	-- Pills/buttons squash in place; flat-fill components (no bevel token in
	-- this taste) get a brightness lift alongside the squash so press still
	-- reads on a still frame.
	primaryPressed = Color3.fromHex("#34CC33"):Lerp(Color3.new(1, 1, 1), 0.12),
	currencySoftPressed = Color3.fromHex("#5FD9F7"):Lerp(Color3.new(1, 1, 1), 0.12),
	currencyHardPressed = Color3.fromHex("#83EB39"):Lerp(Color3.new(1, 1, 1), 0.12),
	dangerPressed = Color3.fromHex("#F8425A"):Lerp(Color3.new(1, 1, 1), 0.12),
	togglePressedLift = 0.12,
	-- Derived (Elevation prose: "the stud pattern... subtle, ~10% contrast").
	-- Stud emboss is rendered procedurally (no image assets per rights
	-- policy): small circular studs slightly lighter than the fill they sit
	-- on, ~10% brightness step, laid out with UIGridLayout.
	studContrast = 0.10,
	studSize = 10, -- px diameter at reference
	studSpacing = 34, -- px cell size (gap reads as the flat plastic between studs)
	studTransparency = 0.55, -- keeps the texture "subtle" per prose
	-- Derived (Colors prose: dim is "barely there"; see Theme.dimTransparency
	-- above for the alpha-derived value; kept here too for discoverability).
	-- Derived (story backdrop only: stand-in for the blurred game world so
	-- floating chrome reads in context; not a UI token).
	worldBackdrop = Color3.fromHex("#2E6B8F"),
	-- Derived (Screen Patterns: "2x2 launcher grid... one hue per
	-- destination, observed: purple, red, green, orange"). Purple/red/green
	-- reuse existing semantic tokens (badge-slot, danger, primary); orange has
	-- no front-matter token, so it is derived here at the same saturation as
	-- its siblings rather than inlined at the call site.
	launcherHues = {
		Color3.fromHex("#A846FD"), -- = Theme.inks.badgeSlot (purple)
		Color3.fromHex("#F8425A"), -- = Theme.colors.danger (red)
		Color3.fromHex("#34CC33"), -- = Theme.colors.primary (green)
		Color3.fromHex("#FF9635"), -- orange: no front-matter token, matched to sibling saturation
	},
}

-- Real image assets for icon/texture slots (asset-sourcing.md). Components
-- consume Theme.assets.* only -- never a literal id in a component file.
-- Every pick below was fetched via its thumbnailUrl -> data[0].imageUrl and
-- Read as pixels before being recorded here (asset-sourcing.md step 2); see
-- delivery notes for the full search log, including rejected candidates.
--
-- The stud emboss is intentionally NOT in this table: generation-procedure.md
-- is explicit that tiled textures (stud emboss, fabric, noise) stay
-- PROCEDURAL, never an asset (rights policy, SPEC S7) -- StudField.luau is
-- unchanged. A sibling slice (studded-toybox) sources its stud pattern as a
-- baked-canvas image asset; that is a deviation from generation-procedure.md,
-- not a pattern to copy, and is called out in delivery notes rather than
-- followed here.
Theme.assets = { -- resolved image IDs (in-engine arbitrated 2026-07-13); decal provenance in comments
	-- Creator Store free asset 11888845578 "shopping cart icon" by elementerzz
	-- (searched: "shopping cart icon white ui") -- white cart on transparent,
	-- verified in pixels (clean silhouette, no moderation blank). HUD
	-- launcher: Shop. Reused from e2e/loud-slab and e2e/honey-ledger after an
	-- independent pixel check.
	iconShop = "rbxassetid://10564712711",
	-- Creator Store free asset 92424634177694 "Inventory" by SonicBrYouTube
	-- (searched: "backpack bag icon white flat") -- white backpack outline on
	-- transparent, verified in pixels. HUD launcher: Items. Reused from
	-- e2e/honey-ledger after an independent pixel check (loud-slab's own pick,
	-- 116023502336195, renders as a briefcase-like shape and reads less
	-- cleanly as "Items" at launcher scale -- not used).
	iconItems = "rbxassetid://119865765676356",
	-- Creator Store free asset 73681023273119 "Settings" by l1am19 (searched:
	-- "gear settings icon white ui") -- white gear on transparent, verified in
	-- pixels. HUD launcher: Settings. Reused from e2e/loud-slab and
	-- e2e/honey-ledger after an independent pixel check.
	iconSettings = "rbxassetid://70515892818048",

	-- Shop item renders (standard-showcase.md's fixed 6-item set), all
	-- verified in pixels before being recorded:
	-- Creator Store free asset 17673338621 "Acorn (Base)" by Just_Summa
	-- (searched: "acorn nut icon transparent") -- full-color flat-shaded
	-- acorn on a green gradient canvas, not a monochrome outline like its
	-- siblings below. No clean flat monochrome acorn glyph surfaced after
	-- multiple searches (store is dominated by naturalistic 3D-rendered
	-- acorns); used as a full-bleed render inside the item-art chip rather
	-- than a tintable glyph (tinting rule's baked-canvas exception). Reused
	-- from e2e/loud-slab after an independent pixel check. common tier.
	itemAcorn = "rbxassetid://17673338597",
	-- Creator Store free asset 11841933318 "FeatherLogoineed-removebg-preview"
	-- by CourtneyGarcia9 (searched: "feather icon flat colored game") --
	-- purple-gradient feather on transparent, full-bleed render. NEW pick for
	-- this slice: every sibling's feather (82728088435421, used by loud-slab
	-- and honey-ledger) is a near-invisible white-on-white outline under
	-- pixel inspection and was rejected here. common tier.
	itemFeather = "rbxassetid://100041384303356",
	-- Creator Store free asset 80521757255689 "Mystical Crystal Currency Icon
	-- for Flux 1" by svenii_i (searched: "crystal gem blue purple icon game
	-- asset") -- single faceted blue-cyan crystal, full-bleed render, matches
	-- this taste's ice-cyan currency family. NEW pick for this slice: the
	-- sibling pick (9019175558, used by loud-slab/honey-ledger/studded-toybox)
	-- renders as a blank white page under pixel inspection and was rejected.
	-- rare tier.
	itemCrystal = "rbxassetid://9019175526",
	-- Creator Store free asset 11631359254 "Lantern Icon" (searched: "lantern
	-- icon white flat") -- clean black linework lantern on transparent,
	-- verified in pixels. Reused from all three sibling slices after an
	-- independent pixel check. rare tier.
	itemLantern = "rbxassetid://76487404033438",
	-- Creator Store free asset 553032694 "Sunlight(R)" by fallen_soul
	-- (searched: "compass rose icon black outline") -- black compass-rose
	-- medallion on transparent, full-bleed render, clearly readable. NEW pick
	-- for this slice: every sibling's compass pick (696398374/loud-slab,
	-- 78599299293421/studded-toybox, 81888477593570/honey-ledger -- the one
	-- explicitly flagged known-bad) rendered as pale gray-on-white under
	-- pixel inspection and was rejected; this taste needed its own fourth
	-- candidate. epic tier.
	itemCompass = "rbxassetid://696398371",
	-- Creator Store free asset 8448496698 (searched: "crown icon") -- pale
	-- cream/gold outline crown on transparent, verified in pixels; matches
	-- this taste's accentRare gold emphasis token used for the legendary row.
	-- Reused from e2e/studded-toybox after an independent pixel check
	-- (loud-slab's own pick, 11322089619, renders fully blank/white and was
	-- rejected). legendary tier (Crown gets the emphasized/limited treatment).
	itemCrown = "rbxassetid://360172301",
}

return Theme
