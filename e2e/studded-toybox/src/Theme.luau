-- Theme tokens generated from design-md/studded-toybox/DESIGN.roblox.md front
-- matter. Kebab-case tokens become camelCase fields:
--   surface-deep -> surfaceDeep, on-surface -> onSurface,
--   currency-soft -> currencySoft, currency-hard -> currencyHard,
--   accent-rare -> accentRare, outline-heavy -> outlineHeavy,
--   rim-light -> rimLight, text-outline -> textOutline,
--   text-outline-display -> textOutlineDisplay.

local Theme = {}

Theme.colors = {
	primary = Color3.fromHex("#0BD520"), -- CTA green: Enter/Spin/Equip family (gradient midpoint)
	secondary = Color3.fromHex("#02B9F2"), -- robux-purchase cyan: "Buy 1" tier and utility CTAs
	danger = Color3.fromHex("#E13B38"), -- the squared close slab; red is close-only
	surface = Color3.fromHex("#0DA21F"), -- studded chrome (green-zone variant observed; theme-tinted per zone)
	onSurface = Color3.fromHex("#FFFFFF"), -- all UI text is white
	currencySoft = Color3.fromHex("#FFD902"), -- gold offer/token banner fill
	currencyHard = Color3.fromHex("#A93FE6"), -- premium price pill purple (gradient midpoint)
	accentRare = Color3.fromHex("#AA42BB"), -- event/offer magenta panels and "Buy 5" tier
	outline = Color3.fromHex("#0A0A0F"), -- near-black ink: text outlines, well and chip borders
}

-- "{colors.surface-deep}: #111111B3" -> alpha 0xB3 = 179 -> Transparency = 1 - 179/255 = 0.30
Theme.colors.surfaceDeep = Color3.fromHex("#111111")
Theme.surfaceDeepTransparency = 0.30

local fredoka = Font.fromName("FredokaOne", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

Theme.typography = {
	-- single-weight family everywhere; hierarchy is size + outline weight only
	display = { font = fredoka, textSize = 46, uppercase = false },
	heading = { font = fredoka, textSize = 40, uppercase = false }, -- Title Case, never all-caps
	body = { font = fredoka, textSize = 22, uppercase = false },
	label = { font = fredoka, textSize = 28, uppercase = false },
	caption = { font = fredoka, textSize = 18, uppercase = false },
}

Theme.spacing = { xs = 4, sm = 8, md = 12, lg = 20, xl = 32 }

Theme.rounded = {
	sm = UDim.new(0, 6),
	md = UDim.new(0, 10),
	lg = UDim.new(0, 14),
	-- NOTE: no `full` token -- Shapes section is explicit: "no pill/circle
	-- step... a circle or pill silhouette breaks the taste." Any component
	-- that would reach for Theme.rounded.full elsewhere must use `lg` instead.
}

Theme.strokes = {
	outline = { thickness = 2, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border },
	outlineHeavy = { thickness = 4, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border },
	rimLight = { thickness = 2, color = Color3.fromHex("#A8A8A8"), mode = Enum.ApplyStrokeMode.Border },
	textOutline = { thickness = 2, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Contextual },
	textOutlineDisplay = { thickness = 3, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Contextual },
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

-- Gradients (component tokens the DESIGN.md inlines as `gradient: vertical(a, b)`):
Theme.gradients = {
	windowHeader = { Color3.fromHex("#67E1F7"), Color3.fromHex("#306FF2") }, -- window-header
	buttonPrimary = { Color3.fromHex("#02ED25"), Color3.fromHex("#0CB51C") }, -- button-primary
	buttonPrimaryHero = { Color3.fromHex("#E3FC00"), Color3.fromHex("#60D500") }, -- oversized Equip variant (Colors prose)
	buttonSecondary = { Color3.fromHex("#02D6FC"), Color3.fromHex("#0195E7") }, -- button-secondary ("Buy 1" cyan tier)
	buttonBuy = { Color3.fromHex("#C658F1"), Color3.fromHex("#792BD9") }, -- button-buy price pill
	bannerOffer = { Color3.fromHex("#FFE202"), Color3.fromHex("#FEA800") }, -- banner-offer gold bundle
	buttonTierRare = { Color3.fromHex("#AA42BB"), Color3.fromHex("#7A1F8C") }, -- "Buy 5" tier: accent-rare magenta escalation, same anatomy as buttonSecondary
}

-- Component tokens with no single-hex front-matter value (fixed heights, aspects):
Theme.metrics = {
	windowHeaderHeight = 84,
	buttonCloseAspect = 1.1,
	buttonPrimaryAspect = 4.4,
	buttonSecondaryAspect = 4.4,
	buttonBuyAspect = 3.4,
	bannerOfferHeight = 64,
	currencyBarHeight = 44,
	sideButtonAspect = 1.1,
	cardGridAspect = 1,
}

-- Values the DESIGN.md itself inlines (component tokens / prose colors):
Theme.inks = {
	sideButtonFill = Color3.fromHex("#1A1A1A"), -- side-button backgroundColor #1A1A1A80
	cardGridFill = Color3.fromHex("#000000"), -- card-grid backgroundColor #00000066
	badgeSlotFill = Color3.fromHex("#000000"), -- badge-slot backgroundColor #00000099
}

Theme.transparencies = {
	sideButtonFill = 1 - 0x80 / 255, -- #1A1A1A80 -> 0.50
	cardGridFill = 1 - 0x66 / 255, -- #00000066 -> 0.60
	badgeSlotFill = 1 - 0x99 / 255, -- #00000099 -> 0.40
	currencyBar = 1, -- currency-bar token: transparency 1 (containerless, text-only)
}

-- Derived (no front-matter token; see comments for the rule each follows):
Theme.derived = {
	-- Derived (Components prose: "No pressed/disabled/selected states were
	-- observed; implementing agents should derive them (darken fill ~15% for
	-- pressed, desaturate for disabled) and keep the squash feedback").
	primaryPressed = Color3.fromHex("#0CB51C"):Lerp(Color3.new(0, 0, 0), 0.15),
	secondaryPressed = Color3.fromHex("#0195E7"):Lerp(Color3.new(0, 0, 0), 0.15),
	buyPressed = Color3.fromHex("#792BD9"):Lerp(Color3.new(0, 0, 0), 0.15),
	dangerPressed = Color3.fromHex("#E13B38"):Lerp(Color3.new(0, 0, 0), 0.15),
	tierRarePressed = Color3.fromHex("#7A1F8C"):Lerp(Color3.new(0, 0, 0), 0.15),
	-- Desaturated disabled fill: same darkening family, flattened toward gray
	-- (Grey(0.55) is a mid gray -- "desaturate" per the same prose sentence).
	disabledFill = Color3.fromHex("#8A8A8A"),
	disabledGradientBottom = Color3.fromHex("#6E6E6E"),
	-- Derived (Elevation & Depth prose #2: "stud emboss... ~24px cell at
	-- reference... implement as a tiled ImageLabel over the fill at high
	-- transparency"). This is a REAL sourced image asset (Theme.assets.stud),
	-- unlike other tastes in this catalog that render studs procedurally --
	-- the DESIGN.md explicitly calls for a tiled ImageLabel here, and
	-- asset-sourcing.md flags this taste's stud texture as a prime real-asset
	-- candidate. Contrast/transparency below tune the sourced tile to read
	-- as "low contrast" per the same prose.
	studCellSize = 24, -- px cell at reference
	studTransparency = 0.82, -- keeps the emboss subtle/low-contrast per prose
	-- Derived (Screen Patterns: spin overlay "radial glow around the wheel";
	-- Elevation #3: "no separate dim layer... Spin-wheel overlays skip the
	-- panel entirely and rely on a radial glow"). Not used by the standard
	-- showcase set (no Spin story requested) but kept for completeness /
	-- future stories; a soft gold glow matching the currency-soft family.
	spinGlow = Color3.fromHex("#FFE202"),
	-- Derived (story backdrop only: stand-in for the gameplay world behind
	-- HUD/dialog chrome; not a UI token). No world screenshot token exists in
	-- this DESIGN.md (Elevation prose: windows self-dim via their own well,
	-- so there is deliberately no dim-overlay token) -- a mid-saturation
	-- "midway carnival" green-blue was chosen to match the Overview's "toy
	-- bricks dumped on a carnival midway" reference without competing with
	-- the studded chrome hues.
	worldBackdrop = Color3.fromHex("#2E8B57"),
	-- Derived (Elevation #4: "Watermark echo: the window title repeats as a
	-- huge, very transparent ghost headline behind the content rows"). No
	-- opacity number is given; picked low enough to read as texture, not text.
	watermarkTransparency = 0.92,
}

-- Theme.assets: the single audit point for every real image asset consumed
-- by components. Components read Theme.assets.* only -- never a literal id
-- in a component file. See asset-sourcing.md for the search/verification
-- process this table records.
Theme.assets = { -- resolved image IDs (in-engine arbitrated 2026-07-13); decal provenance in comments
	-- Creator Store free asset 11888845578 "shopping cart icon" by elementerzz
	-- (searched: "shopping cart icon white ui") -- resolved IMAGE id from
	-- asset-sourcing.md's arbitrated canonical table -- HUD launcher: Shop.
	iconShop = "rbxassetid://10564712711",
	-- Creator Store free asset 116023502336195 "Backpack@2x" by kayo27c
	-- (searched: "backpack bag icon white ui") -- arbitrated canonical id --
	-- HUD launcher: Items.
	iconItems = "rbxassetid://119865765676356",
	-- Creator Store free asset 73681023273119 "Settings" by l1am19 (searched:
	-- "gear settings icon white ui") -- arbitrated canonical id -- HUD
	-- launcher: Settings.
	iconSettings = "rbxassetid://70515892818048",

	-- Creator Store free asset 132924702799420 "green stud background" by
	-- beebeebishop (searched: "toy brick lego stud pattern texture") --
	-- seamless tileable rounded-stud pattern, verified in capture: a 150x150
	-- thumbnail read as a clean repeating grid of same-hue raised studs.
	-- Elevation & Depth prose #2 calls for exactly this: "tiled ImageLabel
	-- over the fill at high transparency."
	studTexture = "rbxassetid://113837420468152",

	-- Shop item renders (standard-showcase.md's fixed 6-item set). Prefer
	-- white/monochrome line icons per the tinting rule so ImageColor3 can
	-- carry rarity/theme tinting; each was judged from its thumbnail pixels,
	-- not its name.
	-- Creator Store free asset 3197036011 (searched: "acorn icon white") was
	-- the original pick but FAILS to load in-engine (ImageLabel.IsLoaded
	-- stays false 2s+ after mount, verified 2026-07-13 studded-toybox
	-- verification pass) -- moderated/deleted since redemption. Replaced with
	-- the catalog's arbitrated canonical id 17673338597 (full-color flat,
	-- transparent; not tintable), verified loaded in-engine. common tier.
	itemAcorn = "rbxassetid://17673338597",
	-- Creator Store free asset 121746910148552 "[bw] feathers"-style line
	-- feather by search (searched: "feather icon white") was the original pick
	-- but FAILS to load in-engine (IsLoaded stays false, same failure mode as
	-- the Acorn pick above, verified 2026-07-13). Replaced with the catalog's
	-- arbitrated canonical id 100041384303356 (white, tintable), verified
	-- loaded in-engine. common tier.
	itemFeather = "rbxassetid://100041384303356",
	-- Creator Store free asset 9019175558 (searched: "crystal gem icon
	-- white") -- faint white outline crystal cluster on transparent. rare tier.
	itemCrystal = "rbxassetid://9019175526",
	-- Creator Store free asset 11631359254 "Lantern Icon" by
	-- xxxscrapfredbearxxx (searched: "lantern lamp icon") -- clean black
	-- linework on transparent; tints to white/theme colors via ImageColor3.
	-- rare tier.
	itemLantern = "rbxassetid://76487404033438",
	-- Creator Store free asset 78599299293421 "Explorarium Compass 1"-style
	-- result (searched: "compass icon") -- gray compass rose on a white
	-- circular badge backing; reads clean as a small item render. epic tier.
	itemCompass = "rbxassetid://696398371",
	-- Creator Store free asset 8448496698 (searched: "crown icon") -- pale
	-- cream/gold outline crown on transparent, matches the legendary/gold
	-- emphasis this taste already uses for currency-soft and banner-offer.
	-- legendary tier (Crown gets the taste's emphasized/limited treatment).
	itemCrown = "rbxassetid://360172301",
}

return Theme
