-- Theme tokens mechanically translated from
-- design-md/loud-slab/DESIGN.roblox.md front matter.
-- Taste: flat square slabs of translucent charcoal under color-coded chrome
-- header bands; thick black-outlined white type shouts every number in its
-- own semantic color; NO rounding except prompts/price-pills, NO bevels, NO
-- gradients, NO shadows -- depth is blur+dim plus surface-tone steps and thin
-- white strokes only.

local Theme = {}

Theme.colors = {
	primary = Color3.fromHex("#519E56"), -- buy/price-pill + toggle-on green: the repeated "yes"
	secondary = Color3.fromHex("#C2C2C2"), -- light-gray utility button (Regenerate-class)
	danger = Color3.fromHex("#922626"), -- close-square chrome ONLY; muted brick red
	warning = Color3.fromHex("#FF1715"), -- destructive/"you will lose everything" WARNING text ONLY
	surface = Color3.fromHex("#1B2123"), -- window body charcoal (rendered translucent over blurred world)
	surfaceDeep = Color3.fromHex("#0C1011"), -- wells: cards, filter pills, progress track
	surfaceDark = Color3.fromHex("#3F3B3C"), -- small floating plates: prompts, settings rows, hotbar slots
	onSurface = Color3.fromHex("#FFFFFF"),
	chrome = Color3.fromHex("#557080"), -- default header-band slate; event windows retheme only this slot
	cta = Color3.fromHex("#826B1A"), -- one-off mustard footer commitment button, one per window at most
	currencySoft = Color3.fromHex("#73FF00"), -- cash counters / money values
	accentValue = Color3.fromHex("#FFED1F"), -- section headings + per-second/price values
	accentRare = Color3.fromHex("#FFDE59"), -- gold-tier rarity text
	accentEpic = Color3.fromHex("#26C3FE"), -- cyan higher-tier rarity text (named in prose, not front matter)
	positive = Color3.fromHex("#10A031"), -- common-rarity / confirmation green TEXT
	progress = Color3.fromHex("#F0BB7B"), -- tan progress fill
	outline = Color3.fromHex("#000000"), -- universal text-ink outline: pure black, never tinted
}

-- "#00000059" -> alpha 0x59 (89/255 = 0.35 opaque) -> Transparency 0.65.
-- ESTIMATED per DESIGN.md notes (single dimmed shot, no undimmed pair).
Theme.colors.dim = Color3.fromHex("#000000")
Theme.dimTransparency = 0.65

-- window body: "always rendered semi-transparent over the blurred world".
Theme.surfaceTransparency = 0.15

local fredoka = Font.fromName("FredokaOne", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local builderSansMedium = Font.fromName("BuilderSans", Enum.FontWeight.Medium, Enum.FontStyle.Normal)

Theme.typography = {
	display = { font = fredoka, textSize = 52, uppercase = false },
	heading = { font = fredoka, textSize = 36, uppercase = true },
	body = { font = fredoka, textSize = 26, uppercase = false },
	label = { font = fredoka, textSize = 28, uppercase = false },
	-- caption drops to BuilderSans for engine-adjacent chrome (leaderboard
	-- columns, slot numbers, timers) so tiny text stays legible.
	caption = { font = builderSansMedium, textSize = 18, uppercase = false },
}

Theme.spacing = { xs = 4, sm = 8, md = 12, lg = 20, xl = 32 }

Theme.rounded = {
	none = UDim.new(0, 0),
	sm = UDim.new(0, 6),
	md = UDim.new(0, 10),
	full = UDim.new(1, 0),
}

Theme.strokes = {
	-- Universal text ink: 3px pure black, Contextual (never tinted).
	textOutline = { thickness = 3, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Contextual },
	-- Wells/cards: 2px white border. "Don't thin the strokes -- 1px vanishes
	-- against the blurred world."
	slotOutline = { thickness = 2, color = Color3.fromHex("#FFFFFF"), mode = Enum.ApplyStrokeMode.Border },
	-- Selected hotbar slot / selected card.
	selectedOutline = { thickness = 3, color = Color3.fromHex("#FFFFFF"), mode = Enum.ApplyStrokeMode.Border },
}

Theme.motion = {
	durations = { instant = 0.08, fast = 0.15, normal = 0.25, slow = 0.4 },
	easings = {
		pop = { style = Enum.EasingStyle.Back, direction = Enum.EasingDirection.Out },
		settle = { style = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.Out },
		exit = { style = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.In },
		bounce = { style = Enum.EasingStyle.Elastic, direction = Enum.EasingDirection.Out }, -- reward moments only
	},
}

-- Derived tokens: this taste's Do's-and-Don'ts explicitly bans bevels/shadows
-- ("Pressed state not observed -- implementers use the motion squash, not a
-- color shift"), so buttons rely on the squash alone. Toggle track colors ARE
-- given (gray Off #7D6F6F, green On == primary); everything else pressable
-- here is squash-only and needs no derived pressed-fill.
Theme.derived = {
	toggleOff = Color3.fromHex("#7D6F6F"), -- component-level token (toggle.backgroundColor, DESIGN.md-inlined)
	-- Story-only backdrop: a bright, blurred-looking game-world stand-in so
	-- the translucent charcoal slabs and white strokes read in context (the
	-- taste's own world-facing token is the blur+dim treatment, not a color).
	worldBackdrop = Color3.fromHex("#6FA8C9"),
}

-- Real image assets for icon/texture slots (asset-sourcing.md). Components
-- consume Theme.assets.* only -- never a literal id in a component file.
Theme.assets = { -- resolved image IDs (in-engine arbitrated 2026-07-13); decal provenance in comments
	-- Creator Store free asset 11888845578 "shopping cart icon" by elementerzz
	-- (searched: "shopping cart icon white ui") -- HUD side-button: Shop
	iconShop = "rbxassetid://10564712711",
	-- Creator Store free asset 116023502336195 "Backpack@2x" by kayo27c
	-- (searched: "backpack bag icon white ui") -- HUD side-button: Items
	iconItems = "rbxassetid://119865765676356",
	-- Creator Store free asset 73681023273119 "Settings" by l1am19
	-- (searched: "gear settings icon white ui") -- HUD side-button: Settings
	iconSettings = "rbxassetid://70515892818048",
	-- Creator Store free asset 17673338621 "Acorn (Base)" by Just_Summa
	-- (searched: "acorn nut icon transparent" / "acorn simple silhouette game
	-- icon") -- shop item: Acorn (common). Full-color flat-shaded icon, not
	-- monochrome outline like its siblings below -- no clean flat glyph acorn
	-- surfaced after multiple searches (store is dominated by naturalistic
	-- 3D-rendered acorns and an unrelated Animal-Crossing turnip icon set);
	-- this was the flattest, most isolated candidate. Noted tradeoff.
	itemAcorn = "rbxassetid://17673338597",
	-- Creator Store free asset 82728088435421 "feather" by ohmyolo243RR
	-- (searched: "feather icon white flat") -- shop item: Feather (common)
	itemFeather = "rbxassetid://100041384303356",
	-- Creator Store free asset 9019175558 "Crystal" by cooljeremy777
	-- (searched: "crystal gem icon white flat") -- shop item: Crystal (rare)
	itemCrystal = "rbxassetid://9019175526",
	-- Creator Store free asset 11631359254 "Lantern Icon"
	-- (searched: "lantern icon white flat") -- shop item: Lantern (rare)
	itemLantern = "rbxassetid://76487404033438",
	-- Creator Store free asset 696398374 "Images/Compass" by Vmena
	-- (searched: "compass icon white flat") -- shop item: Compass (epic)
	itemCompass = "rbxassetid://696398371",
	-- Creator Store free asset 11322089619 "Crown Icon" by EgizianoEG
	-- (searched: "crown icon white flat") -- shop item: Crown (legendary, emphasized)
	itemCrown = "rbxassetid://360172301",
}

return Theme
