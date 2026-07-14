-- Theme tokens generated from design-md/planter-box-pop/DESIGN.roblox.md
-- front matter. Kebab-case tokens become camelCase fields:
--   surface-deep -> surfaceDeep, surface-well -> surfaceWell,
--   on-surface -> onSurface, on-surface-muted -> onSurfaceMuted,
--   currency-soft -> currencySoft, currency-hard -> currencyHard,
--   accent-common -> accentCommon, accent-uncommon -> accentUncommon,
--   accent-rare -> accentRare, accent-legendary -> accentLegendary,
--   accent-divine -> accentDivine, accent-transcendent -> accentTranscendent,
--   outline-white -> outlineWhite, text-outline -> textOutline,
--   text-outline-display -> textOutlineDisplay.

local Theme = {}

Theme.colors = {
	primary = Color3.fromHex("#F7C11E"), -- gold action plates: RESTOCK, Claim, selected tab
	secondary = Color3.fromHex("#4EAD3B"), -- grass green: header bands, HUD shop launcher
	danger = Color3.fromHex("#E03C3C"), -- close button, NO STOCK / sold-out text
	surface = Color3.fromHex("#8A5A2E"), -- quilted dirt-brown window body
	surfaceDeep = Color3.fromHex("#54331B"), -- dark brown inset list rows
	surfaceWell = Color3.fromHex("#96602F"), -- lighter brown item-thumbnail wells inside rows
	onSurface = Color3.fromHex("#FFFFFF"), -- all display text is white over the brown boards
	onSurfaceMuted = Color3.fromHex("#C9C9C9"), -- stock counts, descriptions, sub-captions
	currencySoft = Color3.fromHex("#21DB21"), -- vivid green price text (the in-game cent sign)
	currencyHard = Color3.fromHex("#8A3FE8"), -- premium purple price buttons
	accentCommon = Color3.fromHex("#ABABAB"),
	accentUncommon = Color3.fromHex("#4CAF50"),
	accentRare = Color3.fromHex("#3B96F0"),
	accentLegendary = Color3.fromHex("#F2E23A"),
	accentDivine = Color3.fromHex("#FF7D1A"),
	accentTranscendent = Color3.fromHex("#FFC736"),
	outline = Color3.fromHex("#2B1A0A"), -- warm near-black ink for every text and card edge
	highlight = Color3.fromHex("#FFFFFF"), -- white rim that marks interactive/selected chrome
}

local fredoka = Font.fromName("FredokaOne", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

Theme.typography = {
	display = { font = fredoka, textSize = 40, uppercase = false },
	heading = { font = fredoka, textSize = 30, uppercase = false },
	body = { font = fredoka, textSize = 18, uppercase = false },
	label = { font = fredoka, textSize = 20, uppercase = true }, -- Typography prose: action text is ALL CAPS
	caption = { font = fredoka, textSize = 16, uppercase = false },
}

Theme.spacing = { xs = 4, sm = 8, md = 12, lg = 20, xl = 32 }

Theme.rounded = {
	sm = UDim.new(0, 6),
	md = UDim.new(0, 10),
	lg = UDim.new(0, 14),
	full = UDim.new(1, 0),
}

Theme.strokes = {
	outline = { thickness = 2, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Border },
	outlineWhite = { thickness = 2, color = Theme.colors.highlight, mode = Enum.ApplyStrokeMode.Border },
	textOutline = { thickness = 2, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Contextual },
	textOutlineDisplay = { thickness = 4, color = Theme.colors.outline, mode = Enum.ApplyStrokeMode.Contextual },
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

-- Component shadow: bevel(<height> <color>) values the DESIGN.md itself
-- inlines under components: (kept here per generation-procedure.md so no
-- component file carries a literal hex; the values ARE literal in the
-- DESIGN.md's components section, not derived).
Theme.bevels = {
	close = { height = 3, color = Color3.fromHex("#A02525") },
	primary = { height = 3, color = Color3.fromHex("#C8940A") },
	rarity = { height = 2, color = Color3.fromHex("#8A8A8A") }, -- accent-common bevel; per-rarity bevels derived below
}

-- Story-adjacent DESIGN.md component fills that are not part of this slice's
-- required component set (side-button, badge-slot) but still trace to the
-- DESIGN.md's own literal component tokens, not story-invented colors.
Theme.storyComponents = {
	sideButton = Color3.fromHex("#31C931"), -- components.side-button.backgroundColor
	badgeSlot = Color3.fromHex("#33200F"), -- components.badge-slot.backgroundColor (base; alpha below)
}

-- "#33200FCC" -> alpha 0xCC = 204 -> Transparency = 1 - 204/255 = 0.2
Theme.badgeSlotTransparency = 0.2

-- Derived (no per-rarity bevel token in the DESIGN.md; Elevation prose only
-- specifies the common-chip bevel color explicitly). Same darkening ratio
-- (~0.68x value) applied to each accent-* fill for its raised-plate bevel.
Theme.derived = {
	rarityBevels = {
		common = Color3.fromHex("#8A8A8A"), -- explicit in DESIGN.md components.rarity-chip.shadow
		uncommon = Color3.fromHex("#347A34"),
		rare = Color3.fromHex("#2A66A3"),
		legendary = Color3.fromHex("#A69A27"),
		divine = Color3.fromHex("#A85410"),
		transcendent = Color3.fromHex("#A88625"),
	},
	-- Derived (Components prose on button-primary: "A blue variant appeared
	-- once for an event restock -- treat hue as swappable, plate anatomy as
	-- fixed"). Reuses accent-rare as the swapped fill; bevel darkened at the
	-- same ratio as the rarity-chip rare bevel above.
	eventButtonBevel = Color3.fromHex("#2A66A3"),
	-- Derived (no dim token: DESIGN.md Colors section explicitly declares dim
	-- absent and instructs "default to a dark warm brown at low opacity" if
	-- ever needed). Not used by window (no shadow/no dim per Elevation), kept
	-- for completeness / story backdrops that need a popup-over-gameplay look.
	dim = { color = Color3.fromHex("#2B1A0A"), transparency = 0.6 },
	-- Derived (story backdrop only, not a UI token): a grassy world-like
	-- background so window rim/outline strokes read in context, matching the
	-- garden-chunky taste.
	worldBackdrop = Color3.fromHex("#3F7A2C"),
	-- Derived (Elevation prose: "Press feedback collapses the bevel", inferred
	-- never observed): press squash target, same convention as the
	-- cartoon-chunky taste family.
	pressSquash = 0.94,
}

-- Theme.assets: the single audit point for every real image asset consumed
-- by components (asset-sourcing.md). Components read Theme.assets.* only --
-- never a literal id in a component file. Every pick below was pixel-checked
-- by compositing its thumbnail over this taste's surfaceWell brown (#96602F)
-- before committing (asset-sourcing.md's "thumbnails don't lie" rule) --
-- Read tool renders transparent PNGs on a white artifact canvas, which can
-- make a solid-white glyph look blank; the brown-composite check is what
-- actually matters for this taste's item wells.
Theme.assets = { -- resolved image IDs (in-engine arbitrated 2026-07-13); decal provenance in comments
	-- Monochrome dot-grid texture (Creator Store free decal 13569455910 "Black
	-- dots pattern" -> resolved image id; in-engine verified on brown + green
	-- fills). Tiled + tinted via ImageColor3 by Window's StudField emboss.
	-- (The registry's other stud texture 113837420468152 has baked-in green
	-- and muddies non-green surfaces under multiplicative tint.)
	studTexture = "rbxassetid://13569455869",
	-- HUD launcher icons (side-button / HUD icon toolbar). White monochrome
	-- glyphs on transparent backgrounds -- tint cleanly per the tinting rule.
	-- IDs reused from e2e/loud-slab and e2e/honey-ledger (same free Creator
	-- Store assets already pixel-verified there); re-verified here by
	-- compositing over both surfaceWell brown and secondary green.
	-- Creator Store free asset 11888845578 "shopping cart icon" by
	-- elementerzz (searched: "shopping cart icon white ui") -- HUD launcher: Shop
	iconShop = "rbxassetid://10564712711",
	-- Creator Store free asset 116023502336195 "Backpack@2x" by kayo27c
	-- (searched: "backpack bag icon white ui") -- HUD launcher: Items
	iconItems = "rbxassetid://119865765676356",
	-- Creator Store free asset 73681023273119 "Settings" by l1am19
	-- (searched: "gear settings icon white ui") -- HUD launcher: Settings
	iconSettings = "rbxassetid://70515892818048",

	-- Shop item renders (standard-showcase.md's fixed 6-item set), composited
	-- into RowCard's square surface-well. This taste's Overview is a
	-- full-color cartoon illustration style (unlike loud-slab/honey-ledger's
	-- monochrome-tint grammar), so full-color flat-shaded art was preferred
	-- over white glyphs wherever an on-topic candidate existed -- see notes
	-- per item below.
	-- Creator Store free asset 17673338621 "Acorn (Base)" by Just_Summa
	-- (searched: "acorn nut icon transparent") -- full-color flat-shaded
	-- acorn, transparent bg (verified: corner alpha 0). Matches this taste's
	-- illustrative register better than a white silhouette would. common tier.
	itemAcorn = "rbxassetid://17673338597",
	-- Creator Store free asset 82728088435421 "feather" by ohmyolo243RR
	-- (searched: "feather icon white flat") -- white filled feather on
	-- transparent; reads cleanly against the brown well. common tier.
	itemFeather = "rbxassetid://100041384303356",
	-- Creator Store free asset 9019175558 "Crystal" by cooljeremy777
	-- (searched: "crystal gem icon white flat") -- white filled crystal
	-- cluster on transparent, reads cleanly against the brown well. rare tier.
	itemCrystal = "rbxassetid://9019175526",
	-- Creator Store free asset 116045137845215 "Lamp" ("Classic Lamp (For
	-- Item icon)") by gfire428 (searched: "lantern lamp game icon" /
	-- "lantern icon flat cartoon") -- full-color dark lantern with a warm
	-- glowing interior, transparent bg (verified: corner alpha 0). Chosen
	-- over the outline-style "Lantern Icon" (11631359254, this catalog's
	-- other tastes' pick) after a pixel check found THAT asset bakes an
	-- opaque white square canvas behind the linework (corners read solid
	-- white, not transparent) -- it would show as a white box in this
	-- taste's brown well. rare tier.
	itemLantern = "rbxassetid://76487404033438",
	-- Creator Store free asset 696398374 "Images/Compass" by Vmena (searched:
	-- "compass icon white flat") -- white filled compass ring+needle on
	-- transparent, reads cleanly against the brown well. NOT the known-bad
	-- compass 81888477593570 (white-on-white, invisible) used by
	-- e2e/honey-ledger -- a different, working candidate. epic tier.
	itemCompass = "rbxassetid://696398371",
	-- Creator Store free asset 11322089619 "Crown Icon" by EgizianoEG
	-- (searched: "crown icon") -- white filled crown on transparent, reads
	-- cleanly against the brown well; reused from e2e/loud-slab's pick,
	-- re-verified here. legendary tier, this taste's emphasized/limited item.
	itemCrown = "rbxassetid://360172301",
}

return Theme
