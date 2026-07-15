# Asset sourcing (icons & textures are real assets, not glyph placeholders)

Glyphs (◆ ⚙ ✕) and procedural stand-ins mark WHERE an image belongs, but
they break the moment someone swaps in real art — the slot's sizing,
aspect, and contrast were never exercised. Catalog implementations therefore
use REAL image assets, sourced legitimately.

**Never rebuild baked ART with UI primitives (the fake-art anti-pattern).**
When the DESIGN.md describes an effect that is pre-rendered art — a per-item
stylized name wordmark, a faceted 3D gem, a shop offer's light-burst / glowing
medallion — place an `ImageLabel` asset in that slot. Do NOT reconstruct it out
of `UIGradient`/`UIStroke`/`Frame`s: a per-item wordmark faked as gradient text +
a radial glow comes out uniform and identity-less, with a glowing elliptical
halo the real UI never has (verified in an in-engine review). Rule of thumb: if
a visual **differs per item, or has baked stylized typography / 3D shading / a
light-burst, it is an asset slot** — fills, strokes, sheens, and single-color
glows behind an icon/stroke are UI. If the DESIGN.md itself mis-labels a baked-
art effect as a "gradient/glow" UI recipe, implement it as an asset slot anyway
and note the conflict in delivery (per SKILL.md precedence) — do not fake the art
just because the prose said "UIGradient".

## Where assets come from (in order)

1. **Creator Store free assets**, found via the Studio MCP `search_asset`
   tool: `scope="creator_store"`, `priceFilter="free"`, `assetType="Image"`
   (fall back to `"Decal"`). Usable in any experience per Roblox's Creator
   Store terms.
2. Roblox built-ins (`rbxasset://textures/...`) for generic patterns when
   they fit.
3. NEVER: asset IDs harvested from other games, wikis, or paid packs. (This
   rule is about implementation inputs; catalog DESIGN.md files themselves
   still contain NO asset IDs at all — they describe icon STYLE in prose,
   which you translate into search keywords.)

## Process (per icon/texture slot)

1. Derive search keywords from the DESIGN.md's icon-style prose + the slot
   (e.g. "flat white gear icon", "wooden crate texture seamless").
2. `search_asset` → for each candidate, fetch pixels and Read them — **judge
   the actual pixels against the taste** (stroke weight, filled vs outline,
   perspective) before committing. Name/description lie; thumbnails don't.
   Mechanics: the result's `thumbnailUrl` returns JSON metadata, not image
   bytes — parse its `data[0].imageUrl` and curl THAT. Creator Store search
   is noisy by nature: expect to inspect 5-10 candidates per slot across 2-3
   keyword phrasings (synonyms, +style words) before giving up — the first
   page being all fan art doesn't mean the asset doesn't exist.
3. Record the pick in `Theme.assets` — the single audit point:

```lua
Theme.assets = {
	-- Creator Store free asset 11888845578 "shopping cart icon" by elementerzz
	-- (searched: "shopping cart icon white ui")
	iconShop = "rbxassetid://11888845578",
}
```

4. Components consume `Theme.assets.*` only — never a literal id in a
   component file.
5. **Verify in capture**: moderated/deleted/Decal-vs-Image mismatches render
   blank. A blank ImageLabel in the screenshot = try the next candidate.
   (Decal IDs usually auto-resolve in `ImageLabel.Image`, but the capture is
   the proof, not the assumption.)

## Fallback

No acceptable asset after an honest search → keep a procedural/glyph
placeholder, mark it `-- ASSET SLOT: <description> (no suitable free asset
found; searched: <keywords>)`, and list every such slot in your delivery
notes. An honest placeholder beats a wrong-style asset.

Tie-break: a genuine, on-topic, rights-clean asset that merely breaks style
consistency (full-color among monochrome siblings) BEATS the placeholder —
take it and note the inconsistency. "Wrong-style" that justifies the
placeholder means wrong SUBJECT or unreadable pixels, not wrong palette.

## Shared asset registry (institutional knowledge — update it when you learn something)

Verified picks for the Standard Showcase slots. Reuse these first (after your
own pixel check against YOUR taste's fills — "verified" means subject and
transparency, not fit-for-every-palette). Add rows/caveats as you verify new
assets; move failures to known-bad with the reason.

**CRITICAL: search results return DECAL ids; ImageLabel needs IMAGE ids.**
Even with `assetType="Image"`, `search_asset` returns Decal assets — and a
Decal id in `ImageLabel.Image` renders NOTHING (verified in-engine: every
icon blank). Resolve before use, in a Server-context `execute_luau`:

```lua
local model = game:GetService("InsertService"):LoadAsset(decalId)
local imageId = model:FindFirstChildWhichIsA("Decal", true).Texture -- "rbxassetid://<imageId>"
model:Destroy()
```

Store the RESOLVED image id in Theme.assets; keep the decal id in the
provenance comment.

**Thumbnail checks are NOT ground truth.** The thumbnails API can serve
placeholder frames, and independent agents returned contradictory verdicts
on the same ids. The arbiter is an in-engine render over dark + light fills
(all candidates on one diagnostic frame, one capture). Disqualifier: baked
opaque canvas (blocks fills). White-on-dark-invisible is FINE for
transparent monochrome icons — they get tinted via ImageColor3.

## Arbitrated canonical set (in-engine verified 2026-07-13; IMAGE ids)

| Slot | Image id | Notes |
|---|---|---|
| iconShop | 10564712711 | solid white cart, transparent |
| iconItems | 119865765676356 | white backpack, transparent |
| iconSettings | 70515892818048 | bold white gear, transparent |
| iconCurrencySoft | 3609651064 | white coin stack, line art |
| iconCurrencyPremium | 82204383580968 | white diamond outline |
| itemAcorn | 17673338597 | full-color flat, transparent (not tintable) |
| itemFeather | 100041384303356 | white, tintable |
| itemCrystal | 9019175526 | white cluster, tintable |
| itemLantern | 76487404033438 | full-color w/ glow, transparent |
| itemCompass | 696398371 | white circle compass, tintable |
| itemCrown | 360172301 | full-color gold (legendary pop); tintable alt 11322089611 |
| studTexture | 13569455869 | monochrome dot grid, tintable — the canonical emboss/texture tile (tune ImageTransparency ~0.5, TileSize ~40) |
| studTexture (green) | 113837420468152 | baked-in GREEN — multiplicative tint muddies non-green surfaces; only for green-chrome tastes |

Known-bad (baked canvas / broken texture — decal ids):
11888845578 (cart: baked checkerboard), 73681023273119 (gear:
checker-textured glyph), 11631359254 (lantern: opaque white canvas),
3197036011 (acorn: green canvas), 80521757255689 (crystal: white canvas),
553032694 (compass: white canvas), 116738642913108 (gear: baked border),
81888477593570 (compass: fails to load / IsLoaded never true, likely
moderated since original redemption — see note below).
Redeemed by in-engine render (earlier thumbnail flags were wrong):
78599299293421 (fine transparent white compass). 81888477593570 was
previously listed here too but re-verification on 2026-07-13 (honey-ledger
taste) found `ImageLabel.IsLoaded` stays false 3s+ after mount while sibling
icons in the same tree load fine — moved to known-bad below (asset likely
moderated/deleted since the original redemption note). Use the canonical
696398371 for itemCompass.

**Known-bad lists are non-exhaustive** — run your own render check for new
picks; update this table when you arbitrate.

## Tinting rule

Prefer white/monochrome icons + `ImageColor3` from Theme over pre-colored
assets — one asset serves every state (idle/pressed/disabled) and recolors
with the palette, which is exactly how the structure-over-palette philosophy
wants it. Precision: **transparent background is the hard requirement**
(baked-in canvases can't be tinted and lock the palette); literally-white
strokes are a soft preference — dark-on-transparent icons still tint
acceptably via ImageColor3. A baked-canvas asset is usable only as a
full-bleed render (note the tint limitation where you record it).

## Glow / emission textures (for luminous tastes)

Dark, neon, or "glowing" tastes call for a soft glow halo behind gems, icons,
accent strokes, and rarity text. Implement it as an `ImageLabel` holding a
**soft radial glow texture**, `ImageColor3`-tinted to the element's color, at a
lower ZIndex, sized past the element, `Transparency ≈ 1 - intensity`.

- **The texture must be a round blob: bright center → FULLY transparent edges.**
  Creator Store "glow" search is especially noisy; three common failure modes to
  REJECT on a dark-fill render: a *hollow ring* (renders as an outline circle),
  a *square canvas* whose corners stay tinted (renders as a tinted square), and
  any *hard edge*. Arbitrate by rendering the candidate tinted over a near-black
  fill and confirming a continuous soft halo — the in-engine render is the only
  reliable check (thumbnails lie).
- **Do NOT substitute a stack of `UIStroke` rings or nested/concentric frames**
  for a real glow texture. They render as discrete concentric BORDERS, not
  light — an instant tell of a missed reproduction (verified: a blind build did
  exactly this and read as double-bordered boxes). If no acceptable radial
  texture is found, that is a documented gap for a human, not a ring-stack.
- A soft radial glow texture found + verified this way is worth adding to the
  shared registry below with its provenance and a "verified soft radial over
  dark" note.
