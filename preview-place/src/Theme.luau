-- Theme tokens hand-derived from design-md/cartoon-chunky/DESIGN.roblox.md.
-- The designmd-to-react-lua skill (Phase 3) will generate modules like this
-- from the DESIGN.roblox.md front matter; for now it is maintained by hand.

local Theme = {}

Theme.colors = {
	primary = Color3.fromHex("#5FCB3F"),
	secondary = Color3.fromHex("#4FA8F5"),
	danger = Color3.fromHex("#F24E4E"),
	surface = Color3.fromHex("#FFF7E0"),
	surfaceDeep = Color3.fromHex("#F5E3B8"),
	onSurface = Color3.fromHex("#5C3A0E"),
	currencySoft = Color3.fromHex("#FFD84D"),
	currencyHard = Color3.fromHex("#B96BF5"),
	accentRare = Color3.fromHex("#FF8A3D"),
	outline = Color3.fromHex("#4A2E14"),
	dim = Color3.fromHex("#26195C"),
	white = Color3.fromHex("#FFFFFF"),
}

-- "#26195Caa" -> alpha 0xaa = 67% opaque -> Transparency 0.33
Theme.dimTransparency = 0.33

local fredoka = Font.fromName("FredokaOne", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

Theme.typography = {
	display = { font = fredoka, textSize = 42, uppercase = false },
	heading = { font = fredoka, textSize = 30, uppercase = true },
	body = { font = fredoka, textSize = 20, uppercase = false },
	label = { font = fredoka, textSize = 24, uppercase = true },
	caption = { font = fredoka, textSize = 16, uppercase = false },
}

Theme.spacing = { xs = 4, sm = 8, md = 12, lg = 20, xl = 32 }

Theme.rounded = {
	sm = UDim.new(0, 10),
	md = UDim.new(0, 16),
	lg = UDim.new(0, 24),
	full = UDim.new(1, 0),
}

Theme.strokes = {
	outline = { thickness = 3, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border },
	outlineHeavy = { thickness = 5, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border },
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

-- Darkened fills for the signature bottom bevel (shadow: bevel(...) in DESIGN.md)
Theme.bevels = {
	primary = Color3.fromHex("#3E8A28"),
	secondary = Color3.fromHex("#2F79BE"),
	danger = Color3.fromHex("#B23030"),
	side = Color3.fromHex("#C9A22E"),
	disabled = Color3.fromHex("#75886F"),
	-- Derived (no toggle entry in the DESIGN.md front matter): darkened
	-- surface cream for the chunky-toggle knob, same darkening ratio as the
	-- other bevels.
	knob = Color3.fromHex("#D9BE85"),
}

Theme.disabledFill = Color3.fromHex("#9DB596")

-- Derived (no explicit "world backdrop" token in the DESIGN.md front matter;
-- story backdrops are a generation-procedure.md requirement, not a UI token
-- itself). A bright sky blue matches the Overview's "vending machine ... UI
-- that floats with confident spacing on top of the game world" framing —
-- this taste's world is meant to read as a sunny arcade, not a dim one.
Theme.derived = {
	worldBackdrop = Color3.fromHex("#87CEEB"),
}

-- Rarity ladder for card-grid (DESIGN.md Components: "Rarity is shown by an
-- inner gradient or corner ribbon in {colors.accent-rare} (or rarity-specific
-- hues), never by changing the card's outline color."). The DESIGN.md names
-- only accent-rare for "rarity highlights" generally; common/rare/epic/
-- legendary rungs below are Derived, reusing existing taste hues already in
-- play elsewhere in this exemplar (secondary blue for "rare", currency-hard
-- purple for "epic") so the ladder doesn't invent new palette outside the
-- token set, topping out at accent-rare for legendary (the taste's "NEW!"/
-- glow color, its most emphasized rung).
Theme.rarity = {
	common = nil, -- no ribbon: the untreated default per Components prose
	rare = Theme.colors.secondary,
	epic = Theme.colors.currencyHard,
	legendary = Theme.colors.accentRare,
}

-- Theme.assets: the single audit point for every real image asset consumed
-- by components (asset-sourcing.md). Components read Theme.assets.* only —
-- never a literal id in a component file. IDs below are the catalog's
-- arbitrated canonical set (in-engine verified 2026-07-13, IMAGE ids —
-- resolved from Decal ids per asset-sourcing.md's resolve-before-use rule).
-- Icons are white/transparent monochrome where noted and tinted via
-- ImageColor3 per the tinting rule, so one asset serves idle/pressed/
-- disabled states and recolors with this taste's palette.
Theme.assets = {
	-- Creator Store free asset 10564712711, solid white cart, transparent
	-- (canonical arbitrated set). Used by SideButton's Shop launcher icon.
	iconShop = "rbxassetid://10564712711",
	-- Creator Store free asset 119865765676356, white backpack, transparent.
	-- Used by SideButton's Items launcher icon.
	iconItems = "rbxassetid://119865765676356",
	-- Creator Store free asset 70515892818048, bold white gear, transparent.
	-- Used by SideButton's Settings launcher icon.
	iconSettings = "rbxassetid://70515892818048",
	-- Creator Store free asset 3609651064, white coin stack, line art,
	-- transparent. Used by CurrencyBar's soft-currency icon slot.
	iconCurrencySoft = "rbxassetid://3609651064",
	-- Creator Store free asset 82204383580968, white diamond outline,
	-- transparent. Used by CurrencyBar's hard-currency icon slot.
	iconCurrencyPremium = "rbxassetid://82204383580968",

	-- Shop item renders (standard-showcase.md's fixed 6-item set).
	-- Creator Store free asset 17673338597, full-color flat, transparent
	-- (not tintable — rendered at native color, no ImageColor3 tint applied).
	itemAcorn = "rbxassetid://17673338597",
	-- Creator Store free asset 100041384303356, white, tintable.
	itemFeather = "rbxassetid://100041384303356",
	-- Creator Store free asset 9019175526, white cluster, tintable.
	itemCrystal = "rbxassetid://9019175526",
	-- Creator Store free asset 76487404033438, full-color w/ glow,
	-- transparent (not tintable).
	itemLantern = "rbxassetid://76487404033438",
	-- Creator Store free asset 696398371, white circle compass, tintable.
	itemCompass = "rbxassetid://696398371",
	-- Creator Store free asset 360172301, full-color gold (legendary pop);
	-- tintable alt 11322089611 exists in the registry but the full-color gold
	-- pick suits this taste's "legendary glow" treatment better than a
	-- tinted monochrome would.
	itemCrown = "rbxassetid://360172301",
}

return Theme
