---
version: alpha
name: Candlelit Parlor
description: >
  Cozy-dark UI for horror escape games. Near-black translucent panels float
  over the game world, everything is drawn in one warm candle-cream ink with
  thin 1-3px strokes, flavor text speaks in a serif voice, and two accent
  systems — amber-gold for spending, salmon-rose for lives and leaving —
  carry all the emotional color. Flat, quiet, and warm in the dark.
taste: [candlelit-parlor, cozy-dark, flat-translucent, thin-stroke]
genre: [horror, escape-survival, co-op]

colors:
  primary: "#FFDEBC"          # candle-cream — the single brand ink AND the main CTA fill
  secondary: "#541D1F"        # dark maroon tile fill — neutral in-window buttons (Back)
  danger: "#F45665"           # salmon-red — revive/life price pills, danger-adjacent actions
  surface: "#1A0F10"          # near-black warm plum — window/panel fill (used translucent)
  surface-deep: "#271718"     # inset wells (code inputs, card price strips) — LIGHTER than surface
  surface-dark: "#26150ECC"   # HUD chrome at 80% opacity — icon launchers, hotbar slots
  surface-gold: "#623A27"     # chestnut banner well — commerce/boost offer strips
  surface-rose: "#522227"     # maroon-rose banner well — revive/life offer strips
  on-surface: "#EAB6A3"       # rose-parchment serif body text on dark surfaces
  on-surface-dim: "#907A74"   # muted placeholder / de-emphasized text
  accent-rose: "#FEB2B7"      # soft salmon — section headers and life-themed emphasis
  currency-soft: "#FAD594"    # warm gold — price pill fill, currency context
  currency-ink: "#8E552D"     # dark amber digits ON the gold pill
  danger-ink: "#732327"       # deep maroon digits ON the salmon pill
  outline: "#FFDEBC"          # duplicate of primary by observation — one cream serves ink,
                              # fills, and strokes; roles may diverge in sibling games

typography:
  display:
    fontFamily: Montserrat
    fontWeight: ExtraBold
    textSize: 40px
    uppercase: true           # banner headlines, card amounts; usually gradient-filled (see prose)
  heading:
    fontFamily: Merriweather
    fontWeight: Bold
    textSize: 40px            # window titles ("Shop") — mixed case, serif parlor voice
  eyebrow:
    fontFamily: Montserrat
    fontWeight: ExtraBold
    textSize: 28px
    uppercase: true           # section labels inside windows (item-category headers)
  cta:
    fontFamily: Oswald
    fontWeight: Bold
    textSize: 36px
    uppercase: true           # lobby CTA / launcher labels — condensed impact voice
  label:
    fontFamily: Montserrat
    fontWeight: ExtraBold
    textSize: 24px            # price digits, in-window button labels, counters
  body:
    fontFamily: Merriweather
    fontWeight: Regular
    textSize: 16px            # flavor copy, hints, input placeholder
  caption:
    fontFamily: Montserrat
    fontWeight: Bold
    textSize: 16px
    uppercase: true           # sub-lines under banner headlines

spacing: { xs: 4px, sm: 8px, md: 16px, lg: 28px }

rounded: { sm: 8px, md: 12px, lg: 20px, full: full }

strokes:
  outline:       { thickness: 2px, color: "{colors.outline}", mode: Border }     # windows, inputs, launchers
  outline-heavy: { thickness: 3px, color: "{colors.outline}", mode: Border }     # small tags (slot-number badges)
  outline-dim:   { thickness: 3px, color: "#FFDEBC4D", mode: Border }            # hotbar slots — cream at ~30% opacity
  outline-rose:  { thickness: 2px, color: "{colors.accent-rose}", mode: Border } # rose-context tiles (Back)
  text-rim:      { thickness: 1px, color: "#3A1A14", mode: Contextual }          # subtle dark rim on gradient display digits

motion:
  durations: { instant: 0.1s, fast: 0.25s, normal: 0.45s, slow: 0.8s }
  easings:
    pop:    { style: Sine, direction: Out }
    settle: { style: Sine, direction: InOut }
    exit:   { style: Sine, direction: In }

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#402419"
    typography: "{typography.cta}"
    rounded: "{rounded.md}"
    shadow: none
    aspectRatio: 5
  button-icon:
    backgroundColor: "{colors.surface-dark}"
    textColor: "{colors.primary}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline}"
    shadow: none
    aspectRatio: 1
    size: "~68px square at reference; labeled variant widens to ~2.4:1"
  button-secondary:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline-rose}"
    shadow: none
  button-close:
    transparency: 1
    textColor: "{colors.primary}"
    size: "bare glyph, no container; keep a 44px+ touch frame"
  button-buy:
    backgroundColor: "{colors.currency-soft}"
    textColor: "{colors.currency-ink}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    shadow: none
    height: 36px
  button-buy-rose:
    backgroundColor: "{colors.danger}"
    textColor: "{colors.danger-ink}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    shadow: none
    height: 36px
  window:
    backgroundColor: "{colors.surface}"
    transparency: 0.08
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    shadow: none
  window-header:
    transparency: 1
    textColor: "{colors.primary}"
    typography: "{typography.heading}"
  text-input:
    backgroundColor: "{colors.surface-deep}"
    textColor: "{colors.on-surface-dim}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    height: 38px
  banner-offer:
    backgroundColor: "{colors.surface-gold}"
    typography: "{typography.display}"
    rounded: "{rounded.sm}"
    shadow: none
  card-grid:
    gradient: "vertical(#8A652C, #9D6A42)"
    textColor: "#FFFFFF"
    typography: "{typography.display}"
    rounded: "{rounded.sm}"
    shadow: none
    transparency: 0.1
    aspectRatio: 0.92
  hotbar-slot:
    backgroundColor: "{colors.surface-dark}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline-dim}"
    shadow: none
    size: "~112px square at reference, aspect 1"
  badge-slot:
    backgroundColor: "{colors.surface-dark}"
    textColor: "{colors.primary}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline-heavy}"
    aspectRatio: 1
  progress-bar:
    backgroundColor: "#2E241E"
    rounded: "{rounded.full}"
    height: 8px

extraction:
  inputs:
    - id: shot-1
      kind: screenshot
      describes: "Lobby play menu crop (primary CTA + icon launcher row), 1900x573, transparent background"
    - id: shot-2
      kind: screenshot
      describes: "In-game shop window over darkened gameplay, 696x560, bottom edge cropped"
    - id: shot-3
      kind: screenshot
      describes: "HUD inventory hotbar strip crop, 738x140"
  confidence:
    Colors: high
    Typography: medium
    Layout: medium
    "Elevation & Depth": medium
    Shapes: medium
    Motion: low
    Components: medium
    "Screen Patterns": low
  notes: >
    Viewport unknown for all three inputs (crops, no device info). Assumed
    shot-2 and shot-3 are near logical scale (1:1 at the 1920x1080 reference)
    based on plausible window/hotbar proportions; shot-1 measured ~3.5x above
    logical scale, inferred by matching its ~7px launcher strokes to the 2px
    strokes shared by shot-2/shot-3 — every px token carries this assumption
    and could skew by a constant factor. Required input "HUD full view during
    gameplay" is missing (shot-3 is a hotbar crop only): HUD placement map,
    currency-bar, side-button, and dim-overlay opacity are unextractable —
    currency-bar/side-button/dim tokens omitted rather than defaulted, and
    Screen Patterns is capped at low. No video: motion block is the
    horror/tension taste-family preset, unmodified. Provenance highlights:
    primary/outline cream #FFDEBC sampled identically in all three shots
    (CTA fill + STORE glyphs shot-1, close X + KNOBS header shot-2,
    durability bar + badge numerals shot-3); surface-dark alpha CC read
    directly from shot-1's preserved alpha channel (a=204); surface #1A0F10
    merged from #170D0B/#180D0C/#1E1417 window samples in shot-2;
    surface-deep from the code-input fill #271718; gold system from the 5x
    boost banner (#623A27 well, #FAD594 pill, #8E552D digits, cream-to-gold
    headline gradient #F3E2C1 to #F8DBA3); rose system from the revives
    section (#FEB2B7 header, #522227 well, #F45665 pill, #732327 digits,
    white-to-salmon gradients #FFE9E8 to #ED6F75 and #FAEDDD to #E69489 on
    card amounts); secondary #541D1F + outline-rose from the Back tile;
    outline-dim alpha solved from hotbar slot stroke #5A4E44 over #130F10
    (about 30% cream). Font mapping: Montserrat chosen for the rounded
    geometric ExtraBold caps (runner-up FredokaOne — observed lettering is
    Poppins-like, between the two); Oswald chosen for the condensed squared
    lobby CTA lettering (runner-up Montserrat, the mapping table's nearest
    row — Oswald is the closer engine family); Merriweather chosen for the
    serif title/body voice (runner-up Garamond; observed serif is more
    condensed/slab than either). Component states (pressed/disabled/
    selected) never observed — none defined. text-rim stroke observed as a
    subtle dark edge on gradient card digits in shot-2; thickness estimated.
    button-primary text ink #402419 sampled from HOST GAME lettering and play
    glyph. The wide launcher tile in shot-1 uses a near-black #000000CC fill
    vs #26150ECC on its siblings — read as featured emphasis, kept in prose.
---

# Candlelit Parlor

## Overview

Candlelit Parlor is the taste of cozy-dark horror escape games: the menus of
an old haunted hotel, not a blood-splattered slasher. One concrete reference:
**the front desk of a 1930s hotel lobby at night** — cream lettering stamped
on dark leather luggage tags, a brass key rack in candlelight, a handwritten
ledger. The UI is warm and quiet so the game can be scary; nothing on screen
shouts, glows neon, or bounces.

Three rules of thumb define the taste:

1. **One ink.** A single candle-cream (`{colors.primary}`) is the text color,
   the icon color, the stroke color, the gauge fill, and the one big CTA
   fill. Hierarchy comes from opacity and size, never from new hues.
2. **Thin lines, translucent panels.** Strokes are 1-3px and fills let the
   darkened world breathe through. Depth is drawn with light edges on dark
   glass — there are no shadows, no bevels, nothing chunky.
3. **Two candles, two moods.** Amber-gold colors everything about spending
   (boosts, currency pills); salmon-rose colors everything about life and
   leaving (revives, back/exit). The systems never blend.

Adjectives: cozy-dark, candlelit, flat, hushed.

## Colors

The palette is candle-cream ink on near-black warm plum, with a gold accent
system and a rose accent system.

- `{colors.primary}` cream is the protagonist. It is simultaneously the fill
  of the biggest CTA (lobby "play" button), the glyph/label ink on all dark
  chrome, every stroke, and the fill of progress gauges. `{colors.outline}`
  duplicates its hex by observation — one cream genuinely serves both roles
  in this taste; keep them as separate tokens because sibling games may
  split them.
- `{colors.surface}` is the window fill: near-black with a warm plum cast,
  rendered slightly translucent (~8% see-through, estimated) so the darkened
  game world ghosts through. **Never pure black and never opaque** — opaque
  black reads as a crash screen here.
- Depth inverts the usual rule: inset wells (`{colors.surface-deep}`, code
  inputs, card price strips) are *lighter* than the panel, like candlelight
  catching a recess. Do not darken to create insets.
- `{colors.surface-dark}` (note the baked-in CC alpha = 80% opacity) is HUD
  chrome: launcher tiles and hotbar slots. A featured/emphasized launcher
  may deepen to near-black `#000000CC` (observed on the store tile).
- **Gold system** (commerce): `{colors.surface-gold}` chestnut banner wells,
  `{colors.currency-soft}` price-pill fill, `{colors.currency-ink}` dark
  amber digits *on* the pill. Buy buttons are bright pills with dark digits
  — never white text on an accent.
- **Rose system** (life/danger-adjacent): `{colors.accent-rose}` section
  headers and soft emphasis, `{colors.surface-rose}` banner wells,
  `{colors.danger}` salmon price pills for revive-class purchases,
  `{colors.danger-ink}` deep maroon digits on them. `{colors.secondary}`
  maroon with an `{strokes.outline-rose}` edge marks neutral-but-cautious
  actions like Back.
- Gold never touches a life/revive context and rose never touches a
  commerce/boost context; a cross-accent garnish is allowed only as a small
  caption (observed: a pale-gold "price of..." caption inside a rose banner).
- Body text is `{colors.on-surface}` rose-parchment, lifting toward
  `#FCE6E4` for emphasized notes; `{colors.on-surface-dim}` is placeholders
  and de-emphasis. Text ink on cream fills is dark chocolate `#402419` —
  never pure black.
- There is no red-circle close affordance: closing is a bare cream ✕ glyph.
  Danger-red exists only as the salmon rose system.

## Typography

Three voices, deliberately cast:

- **Serif parlor voice** — `Merriweather`. `{typography.heading}` window
  titles ("Shop") in mixed case, and `{typography.body}` flavor copy, hints,
  and input placeholders. The serif is what makes panels feel like a ledger
  instead of an app; do not swap it for a sans.
- **Geometric merchandising voice** — `Montserrat` ExtraBold, uppercase.
  `{typography.display}` banner headlines and card amounts,
  `{typography.eyebrow}` section labels, `{typography.label}` price digits
  and in-window button labels, `{typography.caption}` sub-lines.
- **Condensed impact voice** — `Oswald` Bold, uppercase, `{typography.cta}`:
  reserved for the lobby's big actions (play, store launcher). It never
  appears inside gameplay windows.

Display text is habitually **gradient-filled** (UIGradient on the label):
white-to-salmon (`#FFE9E8` → `#ED6F75`) is the default celebration
treatment, seen on both banner headlines and card amounts; cream-to-gold
(`#F3E2C1` → `#F8DBA3`) replaces it inside commerce banners. Gradient digits
carry the hairline `{strokes.text-rim}` so they stay legible on bright card
art. Ordinary text carries **no text stroke** — thin type on dark panels
needs none, and outlining everything would break the quiet.

Casing: everything Montserrat/Oswald is uppercase; everything Merriweather
is sentence case. TextScaled policy: display/heading/cta scale within their
containers (token sizes are the reference intent, bounded by
UITextSizeConstraint); body/caption/label use fixed textSize.

Scale caveat: sizes were normalized under the viewport assumption recorded
in the extraction notes and may share a constant-factor skew.

## Layout

Density is editorial, like a menu card: one column of full-width strips
inside windows, generous but not cartoon-loose.

- `{spacing.md}` (16px) is the default gap between siblings (cards in a row,
  banner to section content); `{spacing.lg}` (28px) is window inner padding
  via UIPadding and the gap between sections; `{spacing.sm}` for icon-to-
  label gaps and title-row clusters; `{spacing.xs}` for hairline gaps
  (gauge tick spacing, tag insets).
- Repeating content is delegated to `UIListLayout`/`UIGridLayout` with
  spacing tokens as Padding/CellPadding. Windows compose vertically:
  header row → section label → full-width banner → card row → next section.
- Sizing is Scale-first with `UIAspectRatioConstraint`: the lobby CTA is a
  wide ~5:1 strip, launcher tiles are 1:1 squares (~68px at reference),
  shop cards ~0.92:1, hotbar slots 1:1 (~112px). Offsets are reserved for
  strokes, gauge heights, and spacing tokens.
- Tap targets: 44px minimum at reference. Launchers (~68px) and hotbar
  slots (~112px) clear it comfortably; the bare-glyph close ✕ must be given
  an invisible 44px+ frame because the glyph alone is too small.
- Safe areas: HUD roots use `ScreenGui.ScreenInsets = DeviceSafeInsets`;
  query `GuiService:GetInsetArea()` rather than hardcoding the topbar.
  (Defaulted guidance — no full-viewport shot was available to observe
  safe-area habits; confidence low for this bullet.)

## Elevation & Depth

Depth is "dark glass edged with light": three tools, no shadows.

1. **Translucency** — panels and chrome are see-through (`{colors.surface}`
   at ~8% transparency estimated, `{colors.surface-dark}` at 20%). The
   world showing through IS the elevation cue: the more transparent, the
   more ambient the element.
2. **Thin cream strokes** — `{strokes.outline}` (2px) on windows, inputs,
   and launchers; `{strokes.outline-heavy}` (3px) only on tiny tags where
   2px would vanish; `{strokes.outline-dim}` (30% cream) on ambient HUD
   furniture like hotbar slots. Brighter stroke = more interactive;
   passive containers get the dim stroke. Contextual accent strokes
   (`{strokes.outline-rose}`) recolor the edge, never thicken it.
3. **Lightened wells** — insets go *lighter* (`{colors.surface-deep}`),
   never darker, and banners tint their well by accent system
   (`{colors.surface-gold}` / `{colors.surface-rose}`).

`shadow: none` everywhere — no drop shadows, no bevels; both were absent on
every element observed and their absence is a defining taste fact. Popup
layering: dim → window → floating text. Dim overlay exists (gameplay behind
the shop is visibly darkened) but its color/opacity was not separable from
the scene; treat it as a low-opacity black wash and verify in-game.
DisplayOrder bands (Sibling ZIndexBehavior): HUD 0-9, windows 10-19,
popups 20-29.

## Shapes

Softly rounded rectangles at small radii; nothing is aggressively pill-like
or perfectly circular.

- `{rounded.sm}` (8px) — cards, price pills, banner wells, tags, and the
  window shell itself (measured ~10px; sits between sm and md).
- `{rounded.md}` (12px) — the lobby CTA, text inputs, hotbar slots
  (measured ~14px).
- `{rounded.lg}` (20px) — launcher tiles only; the largest curve in the
  taste.
- `{rounded.full}` — gauge/progress strips only.

Silhouette rules: buttons are rectangles, not capsules — even the 36px-tall
price pills keep 8px corners rather than going full-pill. Circles do not
exist; the slot-number tags are rounded squares. Everything sits axis-
aligned; no decorative rotation was observed anywhere.

## Motion

No video input was provided: the block below is the horror/tension
taste-family preset, unmodified, and this section is inferred — treat every
value as a default, not an observation.

- **Entrances** (`{motion.easings.pop}`, `{motion.durations.normal}`):
  windows fade in with at most a small slide; no scale overshoot. The still
  evidence (flat, quiet, shadow-less composition) is consistent with
  fade-first motion.
- **Exits** (`{motion.easings.exit}`, `{motion.durations.fast}`): fade out,
  slightly quicker than entrances.
- **Press feedback** (`{motion.durations.instant}`): a brightness or stroke
  lift, not a squash — chunky squash-and-bounce would break the hush.
- **Value changes** (`{motion.easings.settle}`): gauge fills glide; no
  count-up fireworks.
- The UI must never startle: abruptness is the game's scare vocabulary, so
  menus stay slow and smooth. Reserve anything snappy for gameplay scares,
  not chrome.

## Components

- **button-primary** — the lobby "play" strip: the only large cream-filled
  surface in the taste, dark chocolate condensed-caps label with a leading
  glyph, strokeless and shadowless. Feel: a brass plaque catching the light.
  One per screen, maximum.
- **button-icon** — square launcher tile: 80%-opaque dark fill, cream glyph,
  2px cream stroke, 20px corners. A labeled variant widens to ~2.4:1 (icon +
  condensed-caps label); a featured launcher may deepen its fill to
  near-black `#000000CC`. Feel: dark keys on a key rack.
- **button-secondary** — in-window neutral tile (observed as "Back"): maroon
  fill, white ExtraBold label, thin rose stroke. Cautious, not alarming.
- **button-close** — a bare cream ✕ glyph in the window's header row,
  top-right. No circle, no red, no container; give it an invisible 44px+
  touch frame.
- **button-buy / button-buy-rose** — the price pill: bright accent fill
  (gold for goods, salmon for revive-class items), platform-currency glyph
  left, dark same-family digits. Dark-ink-on-bright-pill is the signature —
  never white text here. Feel: a price tag tied with string.
- **window** — near-black translucent panel, 2px cream stroke, ~10px
  corners, no shadow. Content composes as stacked full-width strips.
- **window-header** — not a band: a transparent row containing the serif
  title (left), utility chips/inputs (middle), and the ✕ (right).
- **text-input** — lightened well (`surface-deep`), 2px cream stroke, serif
  placeholder in `on-surface-dim`, ~38px tall.
- **banner-offer** — full-width offer strip inside a section: accent-tinted
  well (gold or rose), item render left, gradient display headline + caption
  stacked, price pill flush right. Strokeless.
- **card-grid** — product card: tier-tinted vertical gradient fill (olive-
  gold for low tiers, brighter gold above, full rainbow for the top tier),
  slightly translucent, 8px corners, **no stroke** — cards are the only
  major element without an edge, which makes them read as artwork. Gradient
  amount digits with the hairline rim sit over the render; a darker
  translucent price strip runs along the bottom edge.
- **hotbar-slot** — 1:1 dark slot at 80% opacity with the 30%-cream dim
  stroke; item render centered, quantity ("x1") in cream at bottom-right,
  durability gauge along the bottom inset.
- **badge-slot** — the keybind number tag overlapping a slot's top-left
  corner: dark fill, 3px bright cream stroke, cream numeral. The brightest
  edge in the HUD — it is the interaction hint.
- **progress-bar** — 8px cream strip on a dark warm track, full-rounded
  ends, subtle segment ticks (darker hairlines every few px). Used as item
  durability; fills glide with `settle`.

States: no pressed/disabled/selected variants were observed in any input;
none are defined. Implementers should default to a stroke-brightness lift
for pressed and reduced opacity for disabled, staying inside the one-ink
rule. currency-bar, side-button, dim-overlay, and tooltip were not
observed and are intentionally undefined — fall back to taste defaults
knowingly.

## Screen Patterns

Only three surfaces were observed; patterns below are limited to them, and
the HUD map is low-confidence (no full gameplay view was provided).

- **Lobby menu**: a vertical stack — one wide cream CTA on top, a row of
  square launcher tiles beneath it (the first tile widened and labeled as
  the featured entry). Third-party/social chips sit small at the row's
  top-right corner, outside the tile rhythm.
- **Shop window**: single panel, no tabs or side rail. Header row: serif
  title left, small utility chip (cream pill, dark label), code text-input,
  bare ✕ right. Then per merchandise section: eyebrow label (cream caps for
  commerce, rose caps for life items) with a serif hint sentence beside or
  under it → full-width banner-offer strip → row of 3 product cards plus a
  Back tile occupying the first card slot. Section accent (gold vs rose)
  recolors the banner well, headline gradient, and price pills together.
  The window's footer was cropped in the input; footer conventions unknown.
- **HUD hotbar**: bottom-center strip of numbered 1:1 slots with keybind
  tags overlapping each slot's top-left corner; a trailing, smaller
  half-size slot (overflow/next item) tucks against the row's right end. A
  thin cream underline rail runs beneath the whole strip, going dashed
  where it passes the overflow slot. Persistent information per slot is
  capped at three: keybind, quantity, durability. Nothing else of the HUD
  was observed — currency readouts, objective text, and side buttons are
  unknown; keep bottom-left (virtual joystick) and bottom-right (jump)
  clear on touch as standard practice.

## Do's and Don'ts

**Do:**
- Keep strokes thin: 2px standard, 3px only on tiny tags. The hairline
  edge IS the taste — in this system a thin stroke reads as crafted.
- Let the world through: every panel and chrome fill keeps some
  transparency; opaque surfaces are reserved for the single cream CTA.
- Put dark digits on bright price pills (`currency-ink` on gold,
  `danger-ink` on salmon).
- Lighten insets (`surface-deep`), never darken them.
- Keep gold strictly for commerce and rose strictly for life/exit contexts.
- Use the serif for every title and flavor sentence — it is the parlor's
  voice.

**Don't:**
- Never add drop shadows or bevels; depth here is translucency plus a lit
  edge, and a bevel instantly re-skins the UI as a cartoon.
- Never use pure black fills or pure white text; blacks are warm plum
  (`{colors.surface}`), whites are cream or rose-parchment.
- Never put a red circle close button on a window — closing is a bare
  cream ✕.
- Never thicken strokes past 3px or outline body text; heavy outlines are
  the opposite of this taste.
- Never bounce, overshoot, or squash UI elements — abrupt motion belongs
  to the game's scares, not its menus.
- Never make buttons capsule/pill-shaped; corners stay at 8-12px.
- Never use the cream CTA fill on more than one element per screen.

## Agent Prompt Guide

Quick reference for implementing agents:

- One ink: `#FFDEBC` cream for text, glyphs, strokes, gauges; `#402419`
  chocolate for text on cream. Panels `Color3.fromHex("#1A0F10")` with
  `BackgroundTransparency` ~0.08; HUD chrome `#26150E` at 0.2.
- Every container gets a `UIStroke` (2px cream; 3px on small tags; 30%
  transparent cream on ambient HUD slots). No shadows, no bevels, ever.
- Fonts: `Font.fromName("Merriweather")` for titles/body,
  `Font.fromName("Montserrat", Enum.FontWeight.ExtraBold)` uppercase for
  labels/amounts, `Font.fromName("Oswald", Enum.FontWeight.Bold)` uppercase
  for lobby CTAs. Display amounts get a white→salmon `UIGradient`
  (`#FFE9E8`→`#ED6F75`; gold variant `#F3E2C1`→`#F8DBA3` in commerce
  banners) plus a 1px dark Contextual stroke.
- Corners: `UICorner` 8px on cards/pills/windows, 12px on CTAs/inputs,
  20px on launcher tiles. Motion: fades at Sine easing, 0.45s in / 0.25s
  out; nothing snaps or bounces.
- Layout: UIListLayout/UIGridLayout only, 16px sibling gaps, 28px window
  padding, Scale+aspect sizing, DeviceSafeInsets, 44px+ touch targets.

Canned prompts:

1. *"Using DESIGN.roblox.md (Candlelit Parlor), build the shop window: serif
   'Shop' header row with code input and bare ✕, a KNOBS section with a
   gold banner-offer strip and three gradient product cards with gold price
   pills, and a REVIVES section with a rose banner and salmon price pill.
   react-lua, Scale-first, translucent surfaces per the Colors section."*
2. *"Using DESIGN.roblox.md (Candlelit Parlor), build the lobby menu: one
   cream button-primary with a leading glyph, then a row of six dark
   launcher tiles (first one widened and labeled). Thin cream strokes, no
   shadows, fade-only motion."*
3. *"Review this screenshot of my implementation against DESIGN.roblox.md
   (Candlelit Parlor) and list every deviation from the Do's and Don'ts and
   Components sections, ordered by visual impact — flag any shadow, thick
   stroke, or pure black/white immediately."*

---

*Independent analysis of publicly observable UI conventions in the co-op
horror escape genre, provided as-is for inspiration. Not affiliated with or
endorsed by any game or studio.*
