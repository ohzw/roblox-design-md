-- Theme tokens generated from design-md/candlelit-parlor/DESIGN.roblox.md
-- front matter. Kebab-case tokens become camelCase fields:
--   surface-deep -> surfaceDeep, surface-dark -> surfaceDark,
--   surface-gold -> surfaceGold, surface-rose -> surfaceRose,
--   on-surface -> onSurface, on-surface-dim -> onSurfaceDim,
--   accent-rose -> accentRose, currency-soft -> currencySoft,
--   currency-ink -> currencyInk, danger-ink -> dangerInk,
--   outline-heavy -> outlineHeavy, outline-dim -> outlineDim,
--   outline-rose -> outlineRose, text-rim -> textRim.

local Theme = {}

Theme.colors = {
	primary = Color3.fromHex("#FFDEBC"), -- candle-cream: the single brand ink AND the CTA fill
	secondary = Color3.fromHex("#541D1F"), -- dark maroon tile fill (Back)
	danger = Color3.fromHex("#F45665"), -- salmon-red: revive/life price pills
	surface = Color3.fromHex("#1A0F10"), -- near-black warm plum window fill (used translucent)
	surfaceDeep = Color3.fromHex("#271718"), -- inset wells: LIGHTER than surface, never darker
	surfaceDark = Color3.fromHex("#26150E"), -- "#26150ECC" -> see surfaceDarkTransparency below
	surfaceGold = Color3.fromHex("#623A27"), -- chestnut banner well (commerce)
	surfaceRose = Color3.fromHex("#522227"), -- maroon-rose banner well (revive/life)
	onSurface = Color3.fromHex("#EAB6A3"), -- rose-parchment serif body text
	onSurfaceDim = Color3.fromHex("#907A74"), -- placeholders / de-emphasis
	accentRose = Color3.fromHex("#FEB2B7"), -- section headers, life-themed emphasis
	currencySoft = Color3.fromHex("#FAD594"), -- gold price-pill fill
	currencyInk = Color3.fromHex("#8E552D"), -- dark amber digits ON the gold pill
	dangerInk = Color3.fromHex("#732327"), -- deep maroon digits ON the salmon pill
	outline = Color3.fromHex("#FFDEBC"), -- duplicate of primary by observation; kept separate
}

-- "#26150ECC": alpha 0xCC = 204 -> Transparency = 1 - 204/255 = 0.2
Theme.surfaceDarkTransparency = 0.2

local montserratExtraBold = Font.fromName("Montserrat", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
local montserratBold = Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local merriweatherBold = Font.fromName("Merriweather", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local merriweatherRegular = Font.fromName("Merriweather", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local oswaldBold = Font.fromName("Oswald", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

Theme.typography = {
	display = { font = montserratExtraBold, textSize = 40, uppercase = true }, -- banner headlines, card amounts
	heading = { font = merriweatherBold, textSize = 40, uppercase = false }, -- window titles, serif parlor voice
	eyebrow = { font = montserratExtraBold, textSize = 28, uppercase = true }, -- section labels inside windows
	cta = { font = oswaldBold, textSize = 36, uppercase = true }, -- lobby CTA / launcher labels
	-- label has no uppercase flag in the front matter; Typography prose:
	-- "everything Montserrat/Oswald is uppercase".
	label = { font = montserratExtraBold, textSize = 24, uppercase = true }, -- price digits, in-window buttons
	body = { font = merriweatherRegular, textSize = 16, uppercase = false }, -- flavor copy, hints
	caption = { font = montserratBold, textSize = 16, uppercase = true }, -- sub-lines under headlines
}

Theme.spacing = { xs = 4, sm = 8, md = 16, lg = 28 }

Theme.rounded = {
	sm = UDim.new(0, 8),
	md = UDim.new(0, 12),
	lg = UDim.new(0, 20),
	full = UDim.new(1, 0),
}

Theme.strokes = {
	outline = { thickness = 2, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border, transparency = 0 },
	outlineHeavy = { thickness = 3, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border, transparency = 0 },
	-- "#FFDEBC4D": alpha 0x4D = 77 -> Transparency = 1 - 77/255 = 0.70
	outlineDim = { thickness = 3, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border, transparency = 0.70 },
	outlineRose = { thickness = 2, color = Theme.colors.accentRose, mode = Enum.ApplyStrokeMode.Border, transparency = 0 },
	textRim = { thickness = 1, color = Color3.fromHex("#3A1A14"), mode = Enum.ApplyStrokeMode.Contextual, transparency = 0 },
}

Theme.motion = {
	durations = { instant = 0.1, fast = 0.25, normal = 0.45, slow = 0.8 },
	easings = {
		pop = { style = Enum.EasingStyle.Sine, direction = Enum.EasingDirection.Out },
		settle = { style = Enum.EasingStyle.Sine, direction = Enum.EasingDirection.InOut },
		exit = { style = Enum.EasingStyle.Sine, direction = Enum.EasingDirection.In },
	},
}

-- Values the DESIGN.md itself inlines (component tokens and prose):

Theme.inks = {
	onPrimary = Color3.fromHex("#402419"), -- button-primary textColor: dark chocolate, never pure black
	onSecondary = Color3.fromHex("#FFFFFF"), -- button-secondary textColor (front matter)
}

-- window component token: panel is ~8% see-through, never opaque
Theme.windowTransparency = 0.08

-- Typography prose: gradient display treatments (UIGradient on the label)
Theme.gradients = {
	celebration = { Color3.fromHex("#FFE9E8"), Color3.fromHex("#ED6F75") }, -- white -> salmon (default)
	commerce = { Color3.fromHex("#F3E2C1"), Color3.fromHex("#F8DBA3") }, -- cream -> gold (commerce banners)
}

-- Colors prose: a featured launcher may deepen its fill to near-black #000000CC
Theme.featuredLauncher = { color = Color3.fromHex("#000000"), transparency = 0.2 }

-- Derived (no front-matter token; see comments for the rule each follows):
Theme.derived = {
	-- Derived (Motion prose: press = "a brightness or stroke lift, not a squash";
	-- Components prose: "default to a stroke-brightness lift for pressed").
	-- Bright fills lift 12% toward white; dark chrome lifts 12% toward cream
	-- ("candlelight catching"), staying inside the one-ink rule.
	primaryPressed = Color3.fromHex("#FFDEBC"):Lerp(Color3.new(1, 1, 1), 0.12),
	currencySoftPressed = Color3.fromHex("#FAD594"):Lerp(Color3.new(1, 1, 1), 0.12),
	dangerPressed = Color3.fromHex("#F45665"):Lerp(Color3.new(1, 1, 1), 0.12),
	surfaceDarkPressed = Color3.fromHex("#26150E"):Lerp(Color3.fromHex("#FFDEBC"), 0.12),
	featuredPressed = Color3.fromHex("#000000"):Lerp(Color3.fromHex("#FFDEBC"), 0.12),
	-- Derived (Components prose: "reduced opacity for disabled").
	disabledTransparency = 0.45,
	-- Derived (Elevation prose: dim overlay is "a low-opacity black wash";
	-- its opacity was not separable from the scene — verify in-game).
	dim = { color = Color3.fromHex("#000000"), transparency = 0.55 },
	-- Derived (story backdrop only: stand-in for the darkened game world the
	-- translucent panels need behind them; not a UI token).
	worldBackdrop = Color3.fromHex("#221514"),
	-- Identity tint (no-op ImageColor3) for full-color/baked-canvas image
	-- assets that must NOT be recolored (asset-sourcing.md tinting rule:
	-- "a baked-canvas asset is usable only as a full-bleed render" at its
	-- native color) — kept here so no component file holds a bare Color3.new.
	imageTintNone = Color3.new(1, 1, 1),
}

-- Derived component: this taste's DESIGN.md defines no dedicated
-- "currency-display" token (Components prose is silent on a HUD currency
-- readout — the Screen Patterns/extraction notes explicitly say "currency-bar
-- ... not observed and intentionally undefined"). Per generation-procedure.md
-- §Derived tokens, filled consistently with the taste's own grammar: same
-- anatomy as button-buy (gold pill, dark amber digits, rectangle not capsule)
-- since Colors prose ties currency-soft/currency-ink together as one system
-- ("Buy buttons are bright pills with dark digits") — a HUD currency readout
-- is the passive reading of the same system, so it reuses the pill fill/ink
-- pair rather than inventing a new hue.
Theme.currencyDisplay = {
	fill = Theme.colors.currencySoft,
	ink = Theme.colors.currencyInk,
}

-- ARBITRATED 2026-07-13 (Studio verification pass): this e2e slice's shop
-- grammar renders items as a scrolling column of full-width STRIPS (Layout
-- section: "one column of full-width strips inside windows" — kept, it is
-- genuinely native to this taste and correct at 6 items). The strip's
-- SURFACE treatment, however, now follows the DESIGN.md's own `card-grid`
-- token instead of the window/hotbar-slot stroke grammar: the prior
-- implementation gave every row a visible 2px cream border, and in-engine
-- capture showed this reading as a stack of boxed list cells — a direct
-- contradiction of the DESIGN.md's own emphatic, load-bearing claim that
-- "cards are the ONLY major element without an edge, which makes them read
-- as artwork" (Components prose). That rule is stated as a defining taste
-- fact, not an incidental detail, so the stroke loses the conflict on
-- reverification (see ItemRow.luau's header comment for the resolution).
-- Anatomy: card-grid's own vertical gradient fill (`gradient` token,
-- Components: "tier-tinted vertical gradient fill ... slightly translucent,
-- 8px corners, no stroke"), NO UIStroke at all. This taste defines no
-- rarity ladder (commerce vs. life is its only two-way split), so the base
-- gradient is shared by all ordinary tiers; Crown keeps its own top/
-- exclusive treatment (brighter gold gradient fill + the display gradient
-- title already in place) rather than inventing a rarity-color system the
-- DESIGN.md doesn't have.
Theme.itemRow = {
	fill = Theme.colors.surfaceDeep, -- retained: Well/Info backgrounds still use this as a compatible base if ever needed
	gradient = { Color3.fromHex("#8A652C"), Color3.fromHex("#9D6A42") }, -- card-grid token: vertical(#8A652C, #9D6A42)
	gradientEmphasized = { Color3.fromHex("#B98A3E"), Color3.fromHex("#F8DBA3") }, -- Crown: brighter gold variant ("brighter gold above" tier prose), stays in the gold/commerce system
	transparency = 0.1, -- card-grid token
}

-- Real image assets for icon/texture slots (asset-sourcing.md). Components
-- consume Theme.assets.* only — never a literal id in a component file.
-- Picks are the arbitrated canonical IMAGE ids (in-engine verified
-- 2026-07-13, asset-sourcing.md's Shared asset registry) — reused directly,
-- no fresh search needed for the standard showcase slots.
Theme.assets = {
	-- Creator Store free asset 11888845578 "shopping cart icon" by
	-- elementerzz (searched: "shopping cart icon white ui"), resolved to its
	-- underlying Image id 10564712711 — in-engine verified transparent/solid
	-- white, tints cleanly via ImageColor3. HUD launcher: Shop.
	iconShop = "rbxassetid://10564712711",
	-- Creator Store free asset 92424634177694 "Inventory" (searched: "backpack
	-- bag icon white flat"), resolved image id 119865765676356 — white
	-- backpack, transparent, tintable. HUD launcher: Items.
	iconItems = "rbxassetid://119865765676356",
	-- Creator Store free asset 73681023273119 "Settings" (searched: "gear
	-- settings icon white flat"), resolved image id 70515892818048 — bold
	-- white gear, transparent, tintable. HUD launcher: Settings.
	iconSettings = "rbxassetid://70515892818048",
	-- Creator Store free asset 17673338621 "Acorn (Base)" (searched: "acorn
	-- icon white flat"), resolved image id 17673338597 — full-color flat
	-- acorn, transparent bg but NOT tintable (baked color); shown at natural
	-- color inside the item-row well rather than tinted cream. Shop item:
	-- Acorn (common).
	itemAcorn = "rbxassetid://17673338597",
	-- Creator Store free asset (searched: "feather icon white flat"),
	-- resolved image id 100041384303356 — white feather, transparent,
	-- tintable. Shop item: Feather (common).
	itemFeather = "rbxassetid://100041384303356",
	-- Creator Store free asset 9019175558 "Crystal" (searched: "crystal gem
	-- icon white flat"), resolved image id 9019175526 — white cluster,
	-- transparent, tintable. Shop item: Crystal (rare).
	itemCrystal = "rbxassetid://9019175526",
	-- Creator Store free asset "Classic Lamp (For Item icon)" (searched:
	-- "lantern lamp icon flat"), resolved image id 76487404033438 —
	-- full-color glow lantern, transparent bg, NOT tintable (baked glow
	-- color); shown at natural color. Shop item: Lantern (rare).
	itemLantern = "rbxassetid://76487404033438",
	-- Creator Store free asset 696398374 "Images/Compass" (searched: "compass
	-- icon white flat"), resolved image id 696398371 — white circle compass,
	-- transparent, tintable. (Known-bad sibling 81888477593570 fails
	-- IsLoaded in-engine per asset-sourcing.md — NOT used here.) Shop item:
	-- Compass (epic).
	itemCompass = "rbxassetid://696398371",
	-- Creator Store free asset 360172302 "crown-gold-icon" (searched: "crown
	-- icon gold"), resolved image id 360172301 — full-color gold crown,
	-- transparent bg, NOT tintable (baked gold — appropriate for the
	-- legendary/emphasized tier anyway, reads as the taste's one "special"
	-- render). Shop item: Crown (legendary, emphasized).
	itemCrown = "rbxassetid://360172301",
}

return Theme
