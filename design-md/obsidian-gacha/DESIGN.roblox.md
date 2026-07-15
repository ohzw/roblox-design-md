---
version: alpha
name: Obsidian Gacha
description: >
  Disciplined near-black glass that exists to frame LUMINOUS content: gems,
  icons, and holographic aura wordmarks that glow and bloom against the dark.
  Chrome stays quiet (corner-bracket reticles, dark tiles that speak through a
  colored stroke) so the emitted light is the subject; fast fades over an
  animated depth-of-field blur, bounce reserved for the reward reveal.
taste: [obsidian-gacha, neon-rarity, hud-reticle, premium-gacha]
genre: [rng, aura-collector, gacha, simulator]
inspiration: "Jule's RNG — aura-RNG genre (Sol's RNG lineage). On-screen version tag: ARC 4.0-7051."

colors:
  primary: "#3961E1"        # confirm/brand blue — Equip, toggles ON, section headers, Join Group, currency gloss
  secondary: "#66D82E"      # affordable/success green — "Free", claim-ready, backpack (shares hex with currency-hard)
  danger: "#D64359"         # destructive — Salvage Mode, delete, Hardcore Mode, shop
  surface: "#12171B"        # window/panel fill — near-black with a cold navy cast
  surface-deep: "#0D0D10"   # inset wells and button fills — near-pure black
  surface-dark: "#14253C"   # currency pill / dark glossy chrome
  on-surface: "#F2F6FA"     # primary text — a cool near-white, never pure #FFFFFF
  on-surface-dim: "#9AA6B2" # secondary text, placeholders, disabled labels (cool gray)
  currency-soft: "#60FFF7"  # gems (cyan diamond) — the earned currency
  currency-hard: "#66D82E"  # Robux price accent — premium spend (same green as secondary; roles may diverge in other games)
  accent-gold: "#E3B36E"    # lock / favorite / VIP / premium tier
  accent-rare: "#B14DE0"    # ONE representative of the holographic rarity spectrum (see Colors prose)
  outline: "#AEBCCB"        # neutral panel/well hairline + corner-bracket reticles (silver-blue)
  dim: "#05070Acc"          # popup backdrop darken (paired with an animated depth-of-field blur — see Motion)

typography:
  display:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 40px          # reward/aura reveal, hero numbers (size inferred — no celebration frame captured)
  heading:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 26px          # window titles ("Aura Storage", "Settings")
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 22px          # buttons ("Equip", "Roll", "Skip")
  body:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 18px          # rows, values, offer subtitles
  caption:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 14px          # counters, quantity badges, helper microcopy

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px, xl: 32px }
rounded: { sm: 8px, md: 14px, lg: 20px, full: full }

strokes:
  panel:    { thickness: 2px, color: "{colors.outline}", mode: Border }     # window & well hairline
  bracket:  { thickness: 3px, color: "{colors.outline}", mode: Border }     # corner reticle brackets
  confirm:  { thickness: 3px, color: "{colors.primary}", mode: Border }     # Equip / affirmative buttons
  destroy:  { thickness: 3px, color: "{colors.danger}", mode: Border }      # Salvage / delete
  favorite: { thickness: 3px, color: "{colors.accent-gold}", mode: Border } # Lock / favorite
  affirm:   { thickness: 3px, color: "{colors.secondary}", mode: Border }   # buy / claim price pills
  neutral:  { thickness: 2px, color: "{colors.on-surface-dim}", mode: Border } # Enter / Use / non-committal

# Emission — the LOAD-BEARING craft of this taste (see Elevation & Depth §Emission).
# This taste is a dark jewel-case whose whole job is to make content EMIT LIGHT.
# A glow is a soft additive halo in the element's own accent color, placed
# BEHIND the element and recolored to match it in situ. Implement it as an
# ImageLabel holding a soft RADIAL glow texture (a standard round "blob"
# gradient image, bright center -> transparent edge; source one per
# asset-sourcing), tinted via ImageColor3 to the element's color, sized
# `spread` beyond the element, at Transparency ~ (1 - intensity), on a lower
# ZIndex sibling. It must read as a CONTINUOUS soft bloom. Do NOT fake it with
# stacked UIStroke rings or nested frames — those render as discrete concentric
# BORDERS, not light, and are an instant tell of a missed reproduction.
# `spread` = how far it bleeds (offset px at reference); `intensity` = peak
# opacity (0..1). A flat accent with no glow is a FAILED reproduction of this
# taste — glow is not garnish here, it is the identity.
glow:
  accent: { color: "{colors.primary}",      spread: 10px, intensity: 0.5 } # accent strokes, glyphs, section headers, toggles-ON
  gem:    { color: "{colors.currency-soft}", spread: 12px, intensity: 0.7 } # currency gem + the pill's rim bloom
  rarity: { color: "{colors.accent-rare}",   spread: 14px, intensity: 0.6 } # aura wordmarks + top-tier tile bloom (recolor per aura)
  reward: { color: "{colors.on-surface}",    spread: 24px, intensity: 0.9 } # the aura-reveal burst — the brightest emission in the taste

motion:
  durations: { instant: 0.08s, fast: 0.15s, normal: 0.25s, slow: 0.4s }
  easings:
    pop:    { style: Back, direction: Out }       # reward / rarity reveal ONLY
    settle: { style: Quad, direction: Out }        # window content settle, value count-up
    exit:   { style: Quad, direction: In }         # window dismiss
    blur:   { style: Sine, direction: InOut }      # depth-of-field backdrop fade

components:
  currency-bar:
    backgroundColor: "{colors.surface-dark}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    rounded: "{rounded.full}"
    stroke: "{strokes.confirm}"          # cyan/blue glossy rim; gem glyph in currency-soft
    gradient: "vertical(#1B3B5C, #0E1B2E)"
    height: 60px
    size: "scale 0.12 wide, aspect 3.6:1"
  side-button:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.md}"
    stroke: "{strokes.panel}"
    size: "66px square"
    aspectRatio: 1                       # glowing semantic-colored glyph; stroke tints to the glyph's role
  window:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.md}"
    stroke: "{strokes.panel}"
    gradient: "vertical(#141B21, #0C0F13)"
    shadow: none
    transparency: 0.04                   # a whisper of translucency lets the blurred world tint the panel
    size: "scale 0.60 wide, aspect 1.7:1"
  window-header:
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"   # integrated top-left: semantic icon + white title, no overlapping band
  button-close:
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"   # a bare white X glyph top-right — no fill, no stroke
  dim-overlay:
    backgroundColor: "{colors.dim}"      # plus an animated depth-of-field blur on the world (see Motion)
  button-primary:
    backgroundColor: "{colors.surface-deep}"
    textColor: "{colors.primary}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.confirm}"
    height: 48px
    shadow: none
  button-primary-pressed:
    transparency: 0.15                   # fill lifts toward the stroke color; no scale bounce on chrome
  button-secondary:
    backgroundColor: "{colors.surface-deep}"
    textColor: "{colors.accent-gold}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.favorite}"
    height: 48px
  button-danger:
    backgroundColor: "{colors.surface-deep}"
    textColor: "{colors.danger}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.destroy}"
    height: 44px
  button-buy:
    backgroundColor: "{colors.surface-deep}"
    textColor: "{colors.secondary}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.affirm}"           # price pill: Robux/gem glyph + amount, colored to the currency
    height: 44px
  button-icon:
    backgroundColor: "{colors.surface-deep}"
    rounded: "{rounded.md}"
    stroke: "{strokes.panel}"
    size: "110px square"                 # Auto / Skip / reroll / pagination — dark tile + white glyph
    aspectRatio: 1
  button-roll:
    backgroundColor: "{colors.surface-deep}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.panel}"
    size: "130px square"                 # the hero: bigger dark tile, white dice glyph, "Roll" label beneath
    aspectRatio: 1
    shadow: none
  card-grid:
    backgroundColor: "{colors.surface-deep}"
    stroke: "{strokes.bracket}"          # bracket + name text recolor to the aura's rarity in situ
    typography: "{typography.caption}"
    rounded: "{rounded.sm}"
    size: "90px square, 12px cell gap"
    aspectRatio: 1
  card-grid-selected:
    backgroundColor: "#223349"           # fill brightens toward the rarity hue; brackets go full-bright
    stroke: "{strokes.confirm}"
  badge-slot:
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"   # quantity, anchored bottom-right of a tile
  progress-bar:
    backgroundColor: "{colors.surface-deep}"
    rounded: "{rounded.full}"
    stroke: "{strokes.panel}"
    gradient: "horizontal(#3961E1, #5591E5)"   # fill is primary; height ~14px
    height: 14px
  segmented-tab:
    backgroundColor: "{colors.surface-deep}"
    textColor: "{colors.on-surface-dim}"
    typography: "{typography.body}"
    rounded: "{rounded.full}"
  segmented-tab-selected:
    backgroundColor: "#2E3338"           # selected pill lifts to a mid-gray; text goes on-surface
    textColor: "{colors.on-surface}"
  toggle-switch:
    backgroundColor: "{colors.surface-deep}"
    rounded: "{rounded.full}"
    size: "54px x 28px track, white knob"
  toggle-switch-selected:
    backgroundColor: "{colors.primary}"  # ON: primary track, knob slides right
  banner-offer:
    textColor: "{colors.on-surface}"
    typography: "{typography.display}"
    rounded: "{rounded.md}"
    stroke: "{strokes.panel}"
    gradient: "horizontal(#12324F, #0E1B2E)"   # per-offer hue (cyan 2X, purple INF, gold VIP); holds icon + title + price pill

extraction:
  inputs:
    - id: clip-1
      kind: video
      describes: "53s desktop screen-recording (1800x1102, HEVC) of an aura-RNG game: HUD, Aura Storage (+ aura detail), Inventory, Exclusive Shop, Achievements, Settings; window open/close transitions"
  confidence:
    Overview: high
    Colors: high
    Typography: medium
    Layout: high
    "Elevation & Depth": high
    Shapes: medium
    Motion: medium
    Components: high
    "Screen Patterns": high
    "Do's and Don'ts": high
  notes: >
    Single clip: a WINDOWED capture of the Roblox client on a macOS 4K display,
    saved at 1800x1102. px scale was CALIBRATED, not assumed: the Roblox unibar
    measures ~34px tall inside a ~55px top inset in the image, matching Roblox's
    canonical topbar offset dimensions (inset ~58px desktop) at factor ~1.0. This
    rules out a 2x retina backing-store capture (which would have shown a ~70-88px
    unibar and required halving every token). So image px ≈ Roblox offset px; px
    tokens stand as measured (residual uncertainty ±~30% on absolute px is absorbed
    by scale-first sizing + friendly rounding — spacing 4px, radii 2px, strokes 1px).
    Colors sampled per-element with ImageMagick (center-of-fill, 8x8 averages) — high
    confidence. Motion derived from 40fps sampling of the Aura Storage open/close:
    chrome fades in/out in <=2 frames (no scale-down observed) while an animated
    depth-of-field blur on the world clears over ~0.4s; easing families for the
    chrome were not resolvable at that speed, so `pop`/reward motion is a taste-family
    preset (Motion=medium). No celebration/reward frame was captured: `display` size
    and reward `pop` are inferred. currency-hard duplicates the secondary green hex
    (Robux vs "Free" both green) — coincidence recorded, roles kept separate. In-game
    text references "Jule's RNG"; credited in `inspiration`, never used as the taste name.
---

# Obsidian Gacha

## Overview

Obsidian Gacha is the taste of a **premium loot vault at midnight**: near-black
glass panels floating over a blurred world, every one framed by thin white
**corner brackets** like a targeting reticle, and a neon rarity system that lets
the *content* (the auras) supply all the color while the chrome stays dark and
disciplined. It feels like the equipment screen of a sci-fi collectathon crossed
with a slot machine — think the loadout menus of a looter-shooter, restyled for
a Roblox aura-RNG grinder.

**The one load-bearing property is EMITTED LIGHT.** Read this before anything
else: everything that matters in this taste *glows* against the black — the
gem in the currency pill, the rail icons, the holographic aura wordmarks, the
banner art, the accent strokes. The dark chrome is disciplined precisely so
that this light reads as light. Reproduce the layout and the semantic strokes
perfectly but render the accents as flat fills and line-art, and you get a
competent dark-mode UI that has *missed this taste entirely* — the glow is not
optional polish, it is the subject. When in doubt, ask "is this thing emitting,
or is it just painted?" and make it emit.

The emotional job is **anticipation and status**. The core loop is one giant
button — *Roll* — and everything else is the display case for what you pull. So
the chrome is deliberately quiet and expensive-looking (dark, glossy, precise)
to make the bright holographic aura reveals feel like the reward they are. This
is NOT the bouncy, sticker-outlined cartoon-simulator taste; it is its cooler,
more restrained cousin. Restraint in the chrome, *fireworks* — literal light —
in the payoff.

Adjectives: dark, **luminous**, neon, glossy, collector-grade. (Not: flat,
matte, line-art, utility.)

**Reference game (analyzed, not affiliated):** an aura-RNG game whose in-game
text references *Jule's RNG* (Sol's RNG lineage). Credited openly; the taste
below is the reusable thing, not the game.

## Colors

The palette is **one dark stage and a small cast of neon roles**. Backgrounds
are near-black with a cold navy cast (`surface` `#12171B`), inset wells drop to
near-pure black (`surface-deep` `#0D0D10`), and pure `#000000`/`#FFFFFF` are
avoided — text is a cool near-white (`on-surface` `#F2F6FA`) and the darks carry
a faint blue temperature. Record this: the whole taste reads *cold*, never warm.

Roles are assigned by **behavior, not hue**:
- `primary` `#3961E1` — the confirm/brand blue. It is the "yes, commit" voice:
  Equip, toggles that are ON, section headers, *Join Group*, the glossy rim of
  the currency pill, and the progress-bar fill.
- `danger` `#D64359` — anything destructive or high-stakes: *Salvage Mode*, the
  delete/trash button, *Hardcore Mode*'s row tint, the shop entry.
- `secondary` `#66D82E` — the affordable/success green: the *Free* tag, a
  claim-ready achievement, the backpack glyph.
- `accent-gold` `#E3B36E` — lock, favorite, and premium tier (VIP, the medal).
- Currencies get their own accents: `currency-soft` `#60FFF7` (cyan gem diamond,
  the earned currency shown as `260K`) and `currency-hard` `#66D82E` (the Robux
  price accent). currency-hard and secondary share the same green hex — a
  coincidence in this game; keep the roles separate because another game in this
  taste may recolor one and not the other.

**Rarity is a spectrum, not a token.** Each aura owns a signature color, and the
tile carries it two ways in UI — a very dark tint of that hue as the tile fill,
and the corner brackets recolored to it — plus the aura's **name wordmark, which
is a per-aura IMAGE ASSET, not UI text** (see the UI-vs-asset boundary in
Elevation §Emission). `accent-rare` `#B14DE0` is a single representative default
for the UI parts (fill + brackets); the real system is "pick the aura's color
and drive fill + bracket from it." Never flatten rarity to one swatch.

**Every accent color is a light source, not a paint.** The palette values above
are the *hue* of each emission — but in this taste a hue is always delivered as
light: the primary blue on a button is a stroke *plus* a faint `{glow.accent}`
halo; the cyan gem *blooms* (`{glow.gem}`, a UI glow behind the gem icon-asset);
the top-tier tile glows. (The aura *name* is an art asset with its glow baked
in — do not add a UI glow behind it; see §Emission.) Contrast is deliberately
wide — surfaces sink to near-black, accents spike bright and bleed — so the
accents read as *emitting* against the dark, never as evenly-lit flat shapes. If
you set a color and stop, you are half-done.

`outline` `#AEBCCB` is the neutral silver-blue used for the panel/well hairlines
and the corner brackets. It is *not* a universal stroke color the way a cartoon
taste has one brown ink: **action buttons override the stroke with their
semantic color** (see Components), and that semantic-stroke system is the taste.

`dim` `#05070Acc` darkens the world behind a popup — but the more important
backdrop treatment is the animated blur (Motion), not the darken.

## Typography

**One family, many sizes.** The entire UI is set in a rounded, heavy, friendly
bold sans (mapped to `FredokaOne`; runner-up `BuilderSans` if a lighter, more
neutral read is wanted) — rounded terminals, even weight, geometric but warm.
Using a single family across titles, buttons, values, and microcopy is a taste
feature here, not a shortcut; keep it uniform. Helper microcopy renders at a
lighter optical weight simply by being smaller — do not switch families for it.

Hierarchy: `display` (40px) for reward/aura reveals and hero numbers; `heading`
(26px) for window titles; `label` (22px) for buttons; `body` (18px) for rows and
values; `caption` (14px) for counters, quantity badges, and the "You will
automatically rejoin" line.

**Casing is Title Case / sentence case, never shouty ALL-CAPS.** Casing is not
where this taste finds emphasis — color and glow are.

**Text strokes are minimal.** Chrome text (titles, labels, rows, counters) is
clean — no thick contextual outline — and lives in the one UI font family.

**The aura NAME is not UI text at all — it is a per-aura image asset.** In the
real game each aura's name is bespoke pre-rendered art: its own display font,
its own gradient, its own baked glow, unique per aura (a graffiti "Prodigy", a
pixel "Numerical BINARY", an italic "Reborn - True Farm"). Do NOT rebuild this
with a `UIGradient` on the UI font plus a glow — that is the taste's single
worst failure mode (it yields uniform, identity-less names and a glowing
elliptical halo the real game never has; see the UI-vs-asset boundary in
Elevation §Emission). Represent the name as an `ImageLabel` asset slot keyed by
aura. A `UIGradient`-on-one-font rendering is an explicit *low-fidelity
fallback* only, and even then its glow must clamp to the letterforms
(Contextual `UIStroke`), never a radial halo behind the text.

## Layout

Sizes are Scale-first (`UDim2` Scale + `UIAspectRatioConstraint`); the `px`
tokens here are offset details — pill heights, tile sizes, gaps, stroke weights —
delegated to `UIListLayout`/`UIGridLayout`/`UIPadding`, never hand-positioned.

- **Spacing scale** `{spacing}`: grid cells sit on a `md` (12px) `CellPadding`;
  window inner breathing room is `lg` (20px); tight clusters (a glyph and its
  label, price pill internals) use `sm` (8px).
- **Density is moderate-to-high but calm.** The HUD keeps a single vertical rail
  of ~7 icon buttons on the left and one action cluster bottom-center; it never
  crowds the center where the avatar and the reward reveal live. Windows are
  denser (grids, dual panes) but always inside generous padding so the darkness
  reads as space, not clutter.
- **Tap targets** stay at/above 44px: side-buttons are 66px squares, action
  tiles 110px, the Roll hero 130px. Do not shrink touch controls below 44px at
  reference.
- **Safe areas & reserved zones**: HUD roots use `ScreenInsets = DeviceSafeInsets`
  and query `GuiService:GetInsetArea()` for the topbar — never hardcode it. Keep
  the HUD clear of the bottom-left (virtual joystick), bottom-right (jump), and
  the top strip (unibar). The left rail starts *below* the currency pill, which
  itself sits just under the topbar.

## Elevation & Depth

Depth here is built from **emission, strokes, brackets, and a blurred backdrop —
not shadows or bevels.** There is no fake-3D bottom edge and no drop shadow
anywhere; `shadow: none` is the correct default for this taste. Recording the
*absence* of bevels is as important as any positive token — a cartoon bevel
would instantly break it. But the dominant depth cue is **light**: bright
accents that bloom read as *nearer* and *emitting* than the sunken near-black
chrome around them. If you implement only this section's strokes/brackets and
skip §Emission, the UI goes flat and reads as generic dark-mode.

Two stroke weights form the scale:
- **2px** hairline (`strokes.panel`, `strokes.neutral`) for window edges, well
  edges, and non-committal buttons.
- **3px** (`strokes.bracket` and every semantic button stroke) for the corner
  reticles and for action buttons.

**The corner-bracket motif is the signature elevation cue.** Instead of stroking
a panel's full perimeter, this taste draws thin light **L-shaped brackets at the
four corners** of every panel *and* every sub-well (the aura preview, the action
well, each grid tile). Read them as four small `Frame`s (or a 9-slice image)
anchored to the corners, `outline`-colored, 3px thick with ~26px arms. On a
selected or high-rarity element the brackets go full-bright and recolor.

Layer stack, bottom to top: **blurred world → `dim` darken → window panel →
corner brackets + chrome → floating close X.** Set `ScreenGui.ZIndexBehavior =
Sibling` explicitly and band by `DisplayOrder`: HUD low, windows mid, the reward
reveal above everything. The panel carries a hair of translucency
(`transparency 0.04`) so the blurred backdrop faintly tints it — that is why the
Inventory panel reads faintly green over grass and the Aura Storage panel reads
navy; do not bake a solid opaque fill.

### Emission (the load-bearing craft — do not skip)

**First, the UI-vs-asset boundary (get this wrong and you fake art badly).**
Some of this taste's shine is UI you build; some of it is pre-rendered ART you
place. Classifying an effect wrong is the worst failure mode — it makes an
implementer rebuild baked art out of `UIGradient`/`Frame`s and produce cheap,
identity-less imitations (the verified example: per-aura name wordmarks faked as
UIGradient text, which came out uniform with a glowing elliptical halo).

- **UI primitives (build these):** flat/gradient fills (`UIGradient`),
  strokes, corner brackets, the specular sheen, single-color glow halos behind
  an *icon or stroke*, dim, blur, layout.
- **Image-asset slots (place these, never rebuild):** anything with **baked
  stylized typography, per-item bespoke design, 3D/faceted shading, or a
  light-burst** — the per-aura **name wordmarks**, the faceted **currency gem**,
  the shop **offer icons / light-bursts / glowing medallions**. Describe their
  style in prose and expose an `ImageLabel` slot (per asset-sourcing); do not
  reconstruct them in UI.
- **The rule of thumb:** *if it differs per item, or has baked type/3D/burst,
  it is an asset.* If it is a fill, stroke, sheen, or a plain colored glow, it
  is UI. (Counter-example so you don't over-assetize: the magenta gradient on
  the storage rail icon, the pill's gloss, banner *background* gradients, and
  price pills are all trivially UI — build them.)

Now the concrete UI treatments — the "luminous in the dark" identity. Each is a
Roblox-native recipe; apply liberally and recolor per element.

1. **Glow halo** (`{glow.*}` tokens). Behind any accent glyph, gem, accent
   stroke, or rarity wordmark, place a soft additive halo in that element's
   color: an `ImageLabel` holding a **soft radial glow texture**,
   `ImageColor3`-tinted to the element's color, sized `spread` beyond it, at
   `Transparency ≈ 1 - intensity`, on a lower-`ZIndex` sibling. It must read as
   a **continuous soft bloom**. The texture must be a round blob whose bright
   center fades to **fully transparent edges** — when sourcing (per
   asset-sourcing), reject a *hollow ring*, a *square canvas* whose corners
   stay tinted, or anything with a hard edge; verify the pick renders as a soft
   halo over a dark fill before committing (these three failure modes are common
   in Creator Store "glow" results). **Do NOT** approximate the halo with
   stacked `UIStroke` rings or nested frames — those render as hard concentric
   borders, worse than no glow (verified: a blind build did exactly this and it
   read as double-bordered boxes, not light). The halo color always matches the
   thing it lights. Use it behind **icons and strokes** — the gem icon, rail
   glyphs, accent button strokes. Do **not** put a radial halo behind the aura
   *name* (that is an art asset with its glow baked in; a UI halo behind it is
   the elliptical-donut artifact).

2. **Specular gloss** (glass sheen on pills, banners, filled tiles). Overlay a
   **top-anchored white `UIGradient`** — `Transparency` ~0.82 at the top edge →
   1.0 by the vertical middle — so the upper half catches a soft highlight and
   the lower half stays matte. This is what turns the currency pill and offer
   banners from "gradient rectangles" into *lit glass*. Pair with a faint
   inner top-edge highlight line on panels.

3. **Aura wordmark = ASSET (not a UI treatment).** The aura name is placed as a
   per-aura `ImageLabel` art slot, not built here (see the boundary above). The
   only UI job around it is fitting the image into the tile. Hero reward text may
   likewise be art; a plain neon `TextLabel` is the fallback.

4. **Top-tier tile bloom.** A high-rarity tile becomes a **full-bleed bright
   fill** (a `Frame` at a bright tint of the rarity hue filling the tile) with a
   soft glow that HUGS the tile rectangle — implement the glow *inside* the tile
   with `ClipsDescendants = true` so it never bleeds past the tile bounds and
   breaks the grid. This is a *filled, evenly-glowing* tile (Telekinesis is solid
   green edge-to-edge), NOT a centered radial halo spilling outside the square.

5. **Contrast grading.** Keep surfaces genuinely near-black (`surface`,
   `surface-deep`) and let accents spike bright and bleed. Do not lift panels
   toward mid-navy or desaturate accents — the wide range (black floor, neon
   peaks) *is* the mood. A middle-grey, evenly-lit image has lost it.

The reward reveal uses the brightest emission of all (`{glow.reward}`) — a
white-hot burst behind the pulled aura — and is the payoff the whole dark stage
is built to frame.

## Shapes

A calm rounded-rectangle world with two pill exceptions.

- **Corner radii** `{rounded}`: `sm` (8px) on buttons, grid tiles, and wells;
  `md` (14px) on windows, side-buttons, and offer banners; `lg` (20px) on the
  Roll hero tile. Nothing is sharp-cornered; nothing is heavily rounded either —
  the radii are tight and precise, matching the "equipment screen" mood.
- **Pills** (`full`): the currency bar, the search field, the segmented tabs
  (Normal/Hardcore, Items/Amulets/Materials), and toggle tracks are fully
  rounded. Pagination arrows are circular.
- Silhouette rule: **chrome is rounded-rectangles; switches and filters are
  pills; avatars/pagination are circles.** Squares (icon tiles, aura cards) keep
  a 1:1 `UIAspectRatioConstraint`.

## Motion

Motion splits cleanly into **restrained chrome** and **loud rewards** — honor
both or the taste collapses into either "too sluggish" or "too toylike."

Observed from the clip (40fps sampling of Aura Storage open/close):
- **Windows fade fast.** Chrome appears and disappears in under ~2 frames with
  **no scale-down** — treat window enter/exit as a `fast` (0.15s) transparency
  fade, `settle`/`exit` easing, *not* a `pop` scale. Overshoot on chrome would
  read as cheap here.
- **The backdrop blur is the signature transition.** A depth-of-field blur on
  the world animates in as the window opens and clears over ~`slow` (0.4s) after
  it closes, using the `blur` easing (Sine InOut). This animated blur — more
  than the darken — is what sells "a panel came forward." Implement via
  `Lighting` DOF or a blurred backdrop `Frame` tweened on transparency.
- Values **count up** rather than snap (the `66 / 800` style counters), `settle`
  easing.

Reserved (inferred — no reward frame in the clip, so taste-family preset):
- **Rarity/aura reveals get the `pop`** (Back Out) and may scale 0.8→1.0 with a
  flash; this is the ONE place bounce belongs. Higher rarity = bigger, longer
  celebration. Keep `Elastic` for only the very top pulls.
- **Press feedback** on buttons is a fill lift toward the stroke color
  (`button-*-pressed`), not a squash — the chrome does not deform.

**Reduced motion:** drop the backdrop blur animation and reward scale/flash to
plain `fast` fades; never remove the state change itself. All motion must remain
optional garnish over an already-legible static layout.

## Components

Every button in this taste is the **same object wearing a different stroke**: a
`surface-deep` near-black fill, a 3px semantic-colored `UIStroke`, and text in
that same semantic color. The stroke *is* the button — and it carries a faint
`{glow.accent}` halo recolored to the stroke, so even the buttons emit a low
light rather than sitting as crisp flat lines. Read that once and the whole
component set follows.

- **currency-bar** — top-left pill. UI parts: `surface-dark` navy vertical
  `UIGradient`, a bright cyan rim (`{glow.gem}` behind the stroke), a
  **top-anchored white specular gloss** over the upper half (glass), white
  amount (`260K`). Asset part: the **gem is a faceted 3D-shaded icon asset**
  (`ImageLabel`) — its shine is baked, not a UIGradient — with a `{glow.gem}` UI
  halo behind it. Feel: *a lit display readout* — glass and emission, not a
  matte gradient pill.
- **side-button** — 66px `md`-rounded dark tile, 2px hairline, holding one
  **filled, saturated glyph that blooms** in its semantic color (aura index,
  storage, backpack=green, reroll, shop=red, achievements=gold, settings) — the
  glyph wears a `{glow.accent}` halo recolored to its role and bleeds light onto
  the tile. Filled + glowing, NEVER a thin line-icon (that reads as a settings
  app). Feel: *a rack of glowing switches.*
- **window** — `surface` panel, `md` corners, 2px hairline, faint top-to-bottom
  `UIGradient`, a whisper of translucency, `shadow: none`. Feel: *black glass.*
- **window-header** — integrated top-left inside the panel: a semantic-colored
  icon + white `heading` title. No overlapping band, no separate header bar.
- **button-close** — a bare white **X** glyph anchored top-right, no fill and no
  stroke. It floats on the panel, not in a button.
- **dim-overlay** — `dim` darken plus the animated backdrop blur (Motion).
- **button-primary** — dark fill, `confirm` (blue) stroke + blue label; the
  Equip/commit voice. Pressed: fill lifts, no bounce.
- **button-secondary** — dark fill, `favorite` (gold) stroke + gold label
  (Lock/favorite).
- **button-danger** — dark fill, `destroy` (red) stroke + red label (Salvage,
  delete).
- **button-buy** — dark fill, `affirm` (green) stroke, a currency glyph
  (Robux/gem) + amount; the price pill on offers and cards.
- **button-icon** — 110px dark tile + white glyph (Auto, Skip, reroll,
  pagination arrows go circular).
- **button-roll** — the hero: a larger 130px `lg`-rounded dark tile with a white
  dice glyph and a "Roll" label beneath, flanked by Auto and Skip. Feel: *the
  lever you came to pull.*
- **card-grid** — 90px square aura tile. UI parts: `surface-deep` fill, corner
  brackets recolored to the aura's rarity, a quantity badge bottom-right, and
  `ClipsDescendants = true`. Asset part: the aura **name wordmark is a per-aura
  `ImageLabel` art slot** (baked font + gradient + glow, unique per aura) — do
  NOT rebuild it as UIGradient text with a radial halo (that is the elliptical-
  donut artifact). Top rarities escalate to a **full-bleed bright fill** (a
  bright tint of the hue filling the tile) with a soft glow **clipped to the
  tile bounds** — an evenly-lit filled tile (Telekinesis green edge-to-edge), not
  a centered radial halo spilling outside the square and breaking the grid.
- **card-grid-selected** — fill brightens toward the rarity hue and the brackets
  go full-bright (this is a *selection* highlight — a brighter fill + brackets —
  distinct from the rarity ribbon/glow, which is the tile's baseline styling).
- **badge-slot** — small `caption` quantity anchored bottom-right of a tile.
- **progress-bar** — `full`-rounded dark track (~14px) with a `primary`
  horizontal-gradient fill that **glows** (`{glow.accent}` along the fill); used
  for achievement completion. Rows may carry a bright `primary` left-edge accent
  bar. The lit fill against the dark track is the point.
- **segmented-tab** — a pill group (Normal/Hardcore, Items/Amulets/Materials);
  the selected segment lifts to a mid-gray fill with `on-surface` text, others
  stay transparent with `on-surface-dim` text.
- **toggle-switch** — pill track; ON = `primary` fill with the white knob slid
  right, OFF = `surface-deep` with a gray knob. The Hardcore row additionally
  tints its whole row faintly red.
- **banner-offer** — a *lavish, lit* shop card. UI parts: per-offer hue
  `UIGradient` card background, a top specular gloss, `display` title, and one or
  two `button-buy` price pills whose strokes glow. Asset part: the **offer icon,
  its light-burst, and the glowing circular medallion are baked ART** — expose an
  `ImageLabel` slot per offer; do NOT reconstruct the burst/medallion out of
  `Frame`s and gradients. Feel: *a premium storefront that emits* — but the
  premium is in the art, not in faked UI. A flat white outline icon on a plain
  gradient card is the under-reach failure.

## Screen Patterns

**HUD (gameplay).** A quiet frame around a busy center:
- **Top-left:** the currency pill, just under the topbar.
- **Left rail:** a single vertical column of ~7 `side-button` tiles (aura index,
  storage, inventory, reroll, shop, achievements, settings), evenly spaced.
- **Bottom-center:** the action cluster — `button-roll` in the middle with Auto
  (and a green *Free* tag) to its left and Skip (with a blue *Join Group* label)
  to its right, three roll counters stacked above (`66 / 800`, `66 / 100`,
  `6 / 10`), and a helper line beneath ("You will automatically rejoin").
- **Top-right:** two small platform/system glyphs.
- **Reserved clear:** center stage (avatar + reward reveals), bottom-left/right
  (joystick/jump), top strip. Persistent HUD element count is low — the taste
  keeps the world visible.

**Windows** (Aura Storage, Inventory, Shop, Achievements, Settings) share one
grammar: a centered `surface` panel over the dimmed+blurred world, integrated
top-left header (icon + title), a pill **search field** top-center-right, a
floating white **X** top-right, corner brackets on the panel and on every
sub-well, and a footer strip carrying filters/toggles (Normal|Hardcore) and
pagination (circular arrows + "Page 1/2"). Content patterns seen:
- **Aura Storage / Inventory:** a left detail column (preview well + action
  well, each bracketed) beside a right scrolling grid of `card-grid` tiles.
  Footer shows Total Value / Storage `30/30` and the Normal|Hardcore filter.
- **Shop:** a vertical stack of `banner-offer` cards, each with its own gradient
  hue and price pills.
- **Achievements:** a left "current achievement" detail card + REWARDS/Locked
  panel beside a right scrolling list of rows, each with a `progress-bar` and an
  `x / y` count; Daily|All Time segmented tabs in the footer.
- **Settings:** grouped rows (Profile Settings, Gameplay Settings) of label +
  `toggle-switch` (or an Edit button); the Hardcore row is tinted red.

**Information density:** windows are grid- and list-dense but always inside `lg`
padding; the darkness does the work of separating regions, so dividers are rare.

## Do's and Don'ts

- **Do classify every ornament as UI-vs-ASSET before building it.** Fills,
  gradients, strokes, sheens, and single-color glows behind an *icon/stroke* are
  UI. Anything with baked stylized typography, per-item bespoke design, 3D
  shading, or a light-burst — the **per-aura name wordmarks, the faceted gem,
  the shop offer icons/bursts/medallions** — is an **image-asset slot**.
  **Don't** rebuild asset-art out of `UIGradient`/`Frame`s: faking a per-aura
  wordmark with gradient text + a radial glow is this taste's worst failure
  (uniform names, an elliptical-donut halo the real game never has). If it
  differs per item or has baked type/3D/burst, it is an asset.
- **Do make accents EMIT** — but only the UI ones. Gems (icon-asset), rail icons,
  accent button strokes, and progress fills wear a color-matched glow halo
  (`{glow.*}`); the aura name does NOT (its glow is baked into the art). A build
  with flat, un-glowing UI accents has missed the taste; a build with a UI halo
  behind the aura name has faked an asset. **Don't** stop at a color; **don't**
  glow an asset.
- **Don't** use thin line-art / outline icons. Rail and header glyphs are
  **filled, saturated, and blooming** in their semantic color. A gray gear
  line-icon reads as a utility app, not a luminous game HUD.
- **Do** give pills, banners, and filled tiles a **top specular gloss** and
  glassy sheen; **don't** render them as flat matte gradients — this taste is
  *lit glass*, not paper.
- **Do** keep surfaces genuinely near-black and let accents spike bright and
  bleed (wide contrast). **Don't** lift panels toward mid-navy or desaturate
  accents — a flat, evenly-lit mid-grey image is the failure mode.
- **Do** frame panels and wells with thin light corner brackets. This reticle
  motif is the single most recognizable thing about the taste — omit it and the
  windows look like generic dark boxes.
- **Do** make buttons speak through their stroke color over a shared dark fill.
  **Don't** give buttons solid saturated fills — a solid blue "Equip" pill is
  the wrong taste entirely.
- **Don't** add bevels or drop shadows. Depth comes from strokes, brackets, and
  the blurred backdrop. A fake-3D bottom edge reads as cartoon-simulator, not
  this.
- **Don't** let the chrome bounce. Windows fade; they do not pop or scale in.
  Reserve overshoot and flashes exclusively for aura/rarity reveals.
- **Do** keep chrome color-quiet so the holographic rarity content supplies the
  color. **Don't** paint the panels with the rarity palette — the vault is dark
  on purpose.
- **Don't** use pure black or pure white. Everything is cold-tinted: near-black
  navies and a cool near-white.
- **Don't** set thick contextual text outlines on chrome text. Only accent/rarity
  text gets a soft glow.
- **Do** recolor a tile's fill *and* brackets from one rarity hue (the name is a
  per-aura asset, carrying its own color); **don't** hardcode `accent-rare` for
  every rare — it is only a fallback swatch for the UI fill/brackets.
- **Don't** hardcode the topbar inset; query `GuiService:GetInsetArea()` after a
  Heartbeat.

## Agent Prompt Guide

**Cheat sheet**
- Vibe: midnight loot vault. Dark cold glass + neon rarity + white corner
  brackets (reticle). Restraint in chrome, fireworks in rewards.
- **#1 rule — UI vs ASSET:** classify each ornament first. Baked art (per-aura
  name wordmarks, faceted gem, shop offer icons/bursts/medallions) = **image-
  asset slots**, never rebuilt in UI. Faking a wordmark with UIGradient text +
  radial glow is the worst failure (elliptical-donut artifact).
- **#2 rule — EMISSION (UI accents only):** accents are light, not paint. Gems
  (icon-asset), rail icons, accent strokes, progress fills wear a color-matched
  `{glow.*}` halo; pills/banners get a top specular gloss; icons are filled +
  blooming (never line-art); top-tier tiles are full-bleed fill + glow CLIPPED to
  bounds. The aura name does NOT get a UI glow (baked in the art). Flat UI
  accents = failed reproduction.
- Backgrounds: `surface #12171B` panels, `surface-deep #0D0D10` wells; no pure
  black/white; a whisper of panel translucency.
- Buttons = shared dark fill + 3px **semantic-colored stroke** + same-color text.
  Blue=confirm, red=danger, gold=lock/favorite, green=buy/claim, gray=neutral.
- Corner brackets (`outline #AEBCCB`, 3px, ~26px arms) on every panel AND well;
  full-bright + recolored when selected/high-rarity.
- Depth = strokes + brackets + blurred backdrop. **No bevels, no drop shadows.**
- Motion: windows fade `fast` (no scale); backdrop blur clears over `slow`;
  count-up values; `pop`/Back-Out reserved for rarity reveals only.
- Font: one rounded heavy sans (`FredokaOne`), Title Case, no shouty caps, no
  thick text outlines (soft glow on accents only).
- Radii: `sm 8` buttons/tiles, `md 14` windows/side-buttons, `lg 20` Roll hero;
  pills for currency/search/tabs/toggles.

**Canned prompts**
1. "Build the gameplay HUD in the Obsidian Gacha taste: top-left glossy navy
   currency pill (cyan gem glyph), a left vertical rail of 66px dark rounded-tile
   side-buttons with glowing semantic-colored glyphs, and a bottom-center action
   cluster — a 130px dark 'Roll' hero tile (white dice) flanked by Auto and Skip
   icon tiles, with three stacked roll counters above. `ScreenInsets =
   DeviceSafeInsets`, keep joystick/jump/topbar zones clear."
2. "Make an Aura Storage window: centered near-black `surface` panel over a
   dimmed, blurred world, white corner brackets on the panel and each sub-well,
   integrated top-left header (sparkle icon + 'Aura Storage'), pill search field,
   floating white X top-right. Left = aura preview well + action well with
   Equip (blue-stroke), Lock (gold-stroke), Salvage (red-stroke) buttons; right =
   a grid of 90px aura tiles (ClipsDescendants) whose fill and brackets take the
   aura's rarity color, with the aura NAME placed as a per-aura ImageLabel art
   slot (NOT UIGradient text), quantity badge bottom-right; top-tier tiles get a
   full-bleed fill + glow clipped to bounds. Footer: Total Value / Storage 30/30
   + Normal|Hardcore pill tabs + circular pagination."
3. "Animate window open/close: fade the panel `fast` with `settle`/`exit` easing
   and NO scale, while a depth-of-field backdrop blur eases in/out over `slow`.
   Reserve a Back-Out `pop` and a flash for the aura reveal moment only. Count
   currency and roll numbers up rather than snapping. Provide a reduced-motion
   path that drops the blur and reward scale to plain fades."
4. "Make it EMIT (do this pass last, over the built layout): behind every accent
   glyph, gem icon, and accent button stroke, add a color-matched radial glow
   halo (`{glow.*}`, recolored to the element) — but NOT behind aura names (those
   are art assets). Give the currency pill and offer banners a top-anchored white
   specular gloss over their upper half. Make top-tier tiles a full-bleed fill +
   glow clipped to the tile bounds. Swap any line-art icons for filled,
   saturated, blooming glyphs. Keep aura name wordmarks and shop offer
   icons/bursts as image-asset slots (do not fake them in UI). Darken surfaces
   toward near-black and brighten accents so the whole thing reads as neon lit in
   a dark vault, not flat dark-mode."

---

*Independent analysis of publicly observable UI conventions, provided as-is for
inspiration. Not affiliated with or endorsed by any game or studio. Reference
game analyzed: an aura-RNG game whose in-game text references "Jule's RNG"
(Sol's RNG lineage). Rights holders may request changes or removal at any time
via the repository's issue tracker; requests are honored promptly.*
