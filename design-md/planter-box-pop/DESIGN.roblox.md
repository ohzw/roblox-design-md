---
version: alpha
name: Planter Box Pop
description: >
  Stud-embossed planter-box windows with an integrated header band (title left,
  gold action pill + square red close flush-right inside the band), full-width
  list-row commerce on quilted dirt surfaces, bevel-raised rarity chips, and
  overshoot-pop cartoon motion.
taste: [garden-chunky, blocky, playful]
genre: [simulator, farming]

colors:
  primary: "#F7C11E"          # gold action plates — RESTOCK, Claim, selected tab
  secondary: "#4EAD3B"        # grass green — header bands, HUD shop launcher
  danger: "#E03C3C"           # close button, NO STOCK / sold-out text
  surface: "#8A5A2E"          # quilted dirt-brown window body
  surface-deep: "#54331B"     # dark brown inset list rows
  surface-well: "#96602F"     # lighter brown item-thumbnail wells inside rows
  on-surface: "#FFFFFF"       # all display text is white over the brown boards
  on-surface-muted: "#C9C9C9" # stock counts, descriptions, sub-captions
  currency-soft: "#21DB21"    # vivid green price text (the in-game cent sign)
  currency-hard: "#8A3FE8"    # premium purple price buttons
  accent-common: "#ABABAB"
  accent-uncommon: "#4CAF50"
  accent-rare: "#3B96F0"
  accent-legendary: "#F2E23A"
  accent-divine: "#FF7D1A"
  accent-transcendent: "#FFC736"
  outline: "#2B1A0A"          # warm near-black ink for every text and card edge
  highlight: "#FFFFFF"        # white rim that marks interactive/selected chrome

typography:
  display:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 40px
  heading:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 30px
  body:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 18px
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 20px
  caption:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 16px

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px, xl: 32px }

rounded: { sm: 6px, md: 10px, lg: 14px, full: full }

strokes:
  outline:              { thickness: 2px, color: "{colors.outline}", mode: Border }
  outline-white:        { thickness: 2px, color: "{colors.highlight}", mode: Border }
  text-outline:         { thickness: 2px, color: "{colors.outline}", mode: Contextual }
  text-outline-display: { thickness: 4px, color: "{colors.outline}", mode: Contextual }

motion:
  durations: { instant: 0.08s, fast: 0.15s, normal: 0.25s, slow: 0.4s }
  easings:
    pop:    { style: Back, direction: Out }
    settle: { style: Quad, direction: Out }
    exit:   { style: Quad, direction: In }
    bounce: { style: Elastic, direction: Out }

components:
  window:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline}"
    shadow: none
  window-header:
    backgroundColor: "{colors.secondary}"
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"
    textStroke: "{strokes.text-outline}"
    height: 64px
  button-close:
    backgroundColor: "{colors.danger}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    shadow: "bevel(3px #A02525)"
    aspectRatio: 1
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline-white}"
    shadow: "bevel(3px #C8940A)"
  button-buy:
    backgroundColor: "{colors.currency-hard}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
  button-buy-disabled:
    backgroundColor: "#9E9E9E"
    textColor: "{colors.on-surface}"
    shadow: none
  row-card:
    backgroundColor: "{colors.surface-deep}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    padding: 12px
  rarity-chip:
    backgroundColor: "{colors.accent-common}"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline-white}"
    shadow: "bevel(2px #8A8A8A)"
  progress-bar:
    backgroundColor: "{colors.surface-deep}"
    gradient: "vertical(#8CE84A, #35B520)"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    height: 28px
  side-button:
    backgroundColor: "#31C931"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
  tab:
    backgroundColor: "#B98F0F"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
  tab-selected:
    backgroundColor: "{colors.primary}"
    stroke: "{strokes.outline-white}"
  badge-slot:
    backgroundColor: "#33200FCC"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
  banner-offer:
    backgroundColor: "#7458B0"
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    padding: 12px
  currency-counter:
    textColor: "{colors.on-surface}"
    typography: "{typography.display}"
    textStroke: "{strokes.text-outline-display}"

extraction:
  inputs:
    - id: shot-seed-shop
      kind: screenshot
      describes: "Seed shop window: green stud header with countdown, gold RESTOCK, red close; list rows with thumbnail wells, prices, rarity chips"
    - id: shot-gear-shop
      kind: screenshot
      describes: "Gear shop window: same grammar, adds right-aligned muted description text and an Uncommon (green) chip"
    - id: shot-egg-shop
      kind: screenshot
      describes: "Egg shop window: orange header hue variant; expanded purchase row with gray NO STOCK + purple premium price buttons; circular info badge"
    - id: shot-daily-deals
      kind: screenshot
      describes: "Daily Deals window: purple ad-rewards inset panel, Watch/Claim chain, rarity chips (Divine/Rare/Uncommon/Legendary), right-edge Shop / Daily Deals tabs"
    - id: shot-limited-shop
      kind: screenshot
      describes: "Seed shop during a limited event: animated rainbow rim around the window, Limited! corner ribbon, Transcendent star chips, blue RESTOCK variant"
    - id: shot-daily-quests
      kind: screenshot
      describes: "Daily Quests window: reward-track icon row with gold label plates, wide quest rows, green Completed! bars"
    - id: shot-quests-tabbed
      kind: screenshot
      describes: "Daily Quests inside the player-menu shell: left vertical tab rail, red reset banner, three quest cards, gold gradient Completed! bars, footer claim strip"
    - id: shot-hud
      kind: screenshot
      describes: "Full desktop HUD 1440x900: left-edge Shop launcher, bottom-center hotbar slots, bottom-left oversized italic currency counter, top-right translucent leaderboard"
    - id: shot-currency-zoom
      kind: screenshot
      describes: "Close crop of the HUD currency counter: italic white numerals with very thick warm-brown text stroke"
    - id: shot-offer-banner
      kind: screenshot
      describes: "Forever Pack reward-track banner: dark red stud panel, coin chain with arrows, green premium price chip and FREE chips"
    - id: shot-boost-text
      kind: screenshot
      describes: "Friend Boost +10% floating yellow italic outlined text over the world"
  confidence:
    Overview: high
    Colors: medium
    Typography: medium
    Layout: medium
    "Elevation & Depth": medium
    Shapes: medium
    Motion: low
    Components: high
    "Screen Patterns": medium
  notes: >
    All inputs are public wiki/store captures (UI-only crops except shot-hud).
    px tokens were calibrated from shot-hud (1440x900 viewport, x1.333 to the
    1920 reference) and cross-matched through the shared close-button and
    header-band sizes across the shop crops; all window-internal px values
    carry a constant-factor caveat. Colors sampled from flat fill centers;
    wiki compression may shift hues slightly. Font mapped to FredokaOne per
    the rounded-chunky rule; runner-up considered was a comic family
    (PatrickHand rejected: observed terminals are too uniform and geometric).
    The HUD currency counter renders slanted; treated as an implementation
    skew, not a fontStyle token, since the mapped family ships one style.
    No popup-over-gameplay/undimmed pair was available: dim token omitted,
    Elevation prose flags it as a declared gap. No inventory grid beyond the
    hotbar: card-grid omitted. Motion is the cartoon-chunky taste-family
    preset; no video input, confidence low. Pressed states never observed;
    bevel-collapse press feedback is marked inferred.
---

# Planter Box Pop

## Overview

Planter Box Pop is the taste of blocky garden and farming simulators: every
window is a wooden planter box filled with dirt, and every piece of chrome is
a toy brick pressed into it. The concrete real-world reference is **a raised
garden bed built from plastic building blocks** — stud-embossed boards in
grass green and soil brown, seed-packet rows lined up inside, and price tags
stapled onto each row.

What makes it feel right, in three rules:

1. **Texture over flatness.** Headers and window bodies carry an embossed
   stud/brick pattern (rendered as a tiled image or repeated inset frames),
   not flat fills. A flat green band reads as a different, cheaper taste.
2. **Blocky beats bubbly.** Corners are modest (6–14px), silhouettes are
   rectangles, and nothing is a capsule. The chunk comes from thick text
   strokes and raised plates, not from pill shapes.
3. **Commerce is a list, not a grid.** Items live in full-width rows —
   thumbnail well left, big outlined name, stock count, price in currency
   green, rarity chip bottom-right. The row is the unit of the whole taste.

## Colors

A grass-and-soil base with candy accents reserved for meaning.

- `{colors.secondary}` green and `{colors.surface}` brown are the chrome:
  green for header bands and launchers, brown for window bodies. The egg-shop
  variant re-skins the header to a pumpkin orange while keeping the grammar —
  header hue is a re-skinnable slot, the brown body is not (shot-egg-shop).
- `{colors.primary}` gold marks forward actions: RESTOCK, Claim, the selected
  tab. It always sits on a plate with a `{colors.highlight}` white rim.
- `{colors.danger}` red is the close button and "NO STOCK"/sold-out text.
  Never use it for prices or rarity.
- `{colors.surface-deep}` rows sit inside the `{colors.surface}` body;
  `{colors.surface-well}` is the lighter square well holding the item render.
  Depth is drawn with these three browns, not with shadows.
- Currencies never mix: `{colors.currency-soft}` vivid green is exclusively
  price text (always suffixed with the game's cent glyph), and
  `{colors.currency-hard}` purple is exclusively the premium price button.
- Rarity is a six-step chip scale (`accent-common` gray → `accent-uncommon`
  green → `accent-rare` blue → `accent-legendary` yellow → `accent-divine`
  orange → `accent-transcendent` gold-with-stars). Rarity color appears ONLY
  on chips — never on the row fill or the item name.
- Text ink is `{colors.outline}` warm near-black, never pure black; the HUD
  currency counter uses a slightly lighter chocolate stroke of the same
  family (shot-currency-zoom). White is always `#FFFFFF` — this taste does
  use pure white for text fills.
- `dim` is intentionally absent: no popup backdrop was observable in the
  inputs. If a dim is needed, default to a dark warm brown at low opacity and
  mark it as a taste-family guess.

## Typography

One rounded chunky family everywhere (`FredokaOne`); hierarchy is size plus
stroke weight, never a family or weight change.

- `{typography.display}` — the HUD currency counter and celebration text,
  always with `{strokes.text-outline-display}` (4px). The counter renders
  with an italic slant; implement as a skew/rotation garnish, not a font
  style.
- `{typography.heading}` — window titles and item names inside rows. Item
  names are deliberately header-sized: the row IS the product page.
- `{typography.label}` — action plates (RESTOCK, NO STOCK, Claim). Action
  text is ALL CAPS; item names and chips are Title Case.
- `{typography.body}` — quest text, item descriptions (right-aligned,
  `{colors.on-surface-muted}`).
- `{typography.caption}` — stock counts ("X5 Stock"), chips, hotbar slots.

Text stroke convention: **every piece of text in this taste is outlined** —
on windows, on the world, everywhere. There is no unstroked text tier.
TextScaled policy: row names and hotbar slot text visibly scale to fit their
containers; treat token sizes as intended reference sizes with
UITextSizeConstraint upper bounds.

## Layout

Density is medium: shop rows are tall (roughly 3.5:1 width-to-height) and a
window shows 2–3 rows per screenful, scrolled. All px values here carry the
crop-calibration caveat from the extraction notes.

- `{spacing.md}` between sibling rows in a list; `{spacing.lg}` between
  content groups (e.g. ad-rewards panel to deal rows); `{spacing.xl}` window
  inner UIPadding; `{spacing.xs}` icon-to-label gaps.
- Rows are Scale-first full-width children of a scrolling frame with
  UIListLayout; the thumbnail well is square (UIAspectRatioConstraint 1) and
  spans the row height minus row UIPadding.
- The scrolling frame keeps a slim light scrollbar inside the right edge of
  the window body — visible scrollbars are part of the look, do not hide
  them.
- Safe areas: HUD roots use ScreenGui.ScreenInsets = DeviceSafeInsets; the
  observed HUD is desktop-only, so mobile joystick/jump clearances are
  applied from platform rules, not observation.
- Tap targets: 44px minimum; the close button and action plates sit around
  56px at reference.

## Elevation & Depth

Depth is embossed, not cast. Ranked tools:

1. **Stud emboss** — the signature. Header bands and window bodies tile a
   raised stud/brick motif (light top edge, dark bottom edge per stud). Inset
   rows omit the studs, which is what makes them read as recessed dirt.
2. **Raised plates** — action buttons and rarity chips are small plates with
   a `bevel(2–3px darker-fill)` bottom edge and, for interactive/selected
   ones, a white rim (`{strokes.outline-white}`). Press feedback (inferred,
   never observed) collapses the bevel.
3. **Ink edges** — `{strokes.outline}` 2px around rows and the window rim.
   No element uses a heavier outline step; weight lives in text strokes
   instead.
4. **No drop shadows** — windows sit flat over the world with no detached
   darkness (all window shots). Absence of shadow is a taste fact.

Special layer: limited-time windows replace the outer rim with an **animated
rainbow border-image rim** (shot-limited-shop) — reserve this strictly for
time-limited events.

Layering plan: ScreenGuis use Sibling ZIndexBehavior with DisplayOrder bands
HUD 0–9, windows 10–19, floating text/toasts 20+. No dim layer was observed
(declared gap, see Colors).

## Shapes

Blocky and modest — this taste's corners are the smallest in the cartoon
family.

- `{rounded.sm}` (6px) — rows, chips, action plates, hotbar slots, tabs.
- `{rounded.md}` (10px) — thumbnail wells, larger inset panels.
- `{rounded.lg}` (14px) — the window shell.
- `{rounded.full}` — ONLY the small circular info badge on item thumbnails
  (shot-egg-shop). There are no pills: progress bars, currency displays, and
  buttons are all rounded rectangles.

Silhouette rules: windows are portrait-leaning rounded rectangles; the close
button is a rounded SQUARE (aspect 1), not a circle; anything selected keeps
its rectangle and gains the white rim. If you find yourself drawing a
capsule, you have left the taste.

## Motion

No video input existed, so these are the cartoon-chunky taste-family preset
values (confidence: low); stills support the family choice (oversized
celebration text, count-down timers, animated rainbow rim all imply a lively
tween culture).

- **Entrances** (`{motion.easings.pop}`, `{motion.durations.normal}`):
  windows scale 0.8 → 1.0 with Back-Out overshoot.
- **Exits** (`{motion.easings.exit}`, `{motion.durations.fast}`): scale to
  0.9 + fade; always faster than entrances.
- **Press feedback** (`{motion.durations.instant}`): squash to ~0.94 and
  collapse the plate bevel (inferred, mandatory on every plate).
- **Value changes** (`{motion.easings.settle}`): restock countdowns tick per
  second without tween; currency counter count-ups tween numerically.
- **Rewards** (`{motion.easings.bounce}`): reserved for claim/reveal moments.
- The limited-event rainbow rim cycles hue continuously and slowly (~3s per
  loop) — decorative, never tied to input.

## Components

- **window** — the planter box: brown stud-quilted body, 14px corners, 2px
  ink rim, no shadow. Feels like a physical board leaned against the screen.
- **window-header** — integrated full-width band at the window top (NOT a
  floating tab, NOT overlapping the top edge): stud-embossed green (or event
  hue), title left-aligned in `{typography.heading}`, and the utility
  cluster — gold action plate then red close square — flush-right INSIDE the
  band. A countdown ("New seeds in 3m 9s") may replace the title.
- **button-close** — red rounded square with a white outlined X, last item in
  the header cluster, inside the corner (never overlapping it). Players find
  it by the red plate, not by position outside the window.
- **button-primary** — the gold plate (RESTOCK, Claim). White outlined
  uppercase label, white rim, darker-gold bevel. One per header/footer
  region. A blue variant appeared once for an event restock — treat hue as
  swappable, plate anatomy as fixed.
- **button-buy** — flat purple premium-price plate showing the premium icon +
  amount; paired left with a gray **button-buy-disabled** ("NO STOCK") when
  the soft-currency path is unavailable. The pair sits in its own full-width
  row beneath the item row (shot-egg-shop).
- **row-card** — the taste's core molecule: dark brown row, square lighter
  well (item render) left, heading-size name top, muted stock caption,
  currency-green price, rarity-chip bottom-right, optional muted description
  right-aligned. Limited items pin a red "Limited!" ribbon over the row's
  top-left corner.
- **rarity-chip** — small raised plate, rarity-colored fill, white Title Case
  outlined text, white rim, 2px bevel in a darker rarity tone. Transcendent
  adds star sparkles at the plate's left and right edges.
- **progress-bar** — green-gradient fill in a dark brown track, centered
  outlined label ("Completed!"); a gold-gradient variant appears in the
  player-menu quest cards. Fills settle, never snap.
- **side-button** — bright green world-anchored launcher ("Shop" + basket
  icon) on the HUD's left edge; rectangle, not circle.
- **tab / tab-selected** — flat gold rectangles attached to a window's outer
  right edge (Shop / Daily Deals) or stacked as a left rail in the player
  menu (Player, Daily Quests, Achievements...). Selection = brighter gold +
  white rim; unselected tabs are darker and rimless.
- **badge-slot** — hotbar tile: translucent dark brown square, tiny outlined
  white item text, slot number top-left, red notification dot bottom-right
  when relevant.
- **banner-offer** — inset promo panel inside windows (purple ad-rewards
  chain) or a standalone strip (dark red stud "Forever Pack!" track): title
  left, timer right, horizontal chain of reward cells joined by white
  triangle arrows, each cell footed by a Watch/Claim/FREE plate.
- **currency-counter** — the HUD money readout: no plate at all, just huge
  white display numerals with the 4px warm-brown stroke and a slight italic
  skew, bottom-left. Abbreviates aggressively (K/M/B/QA) with the cent glyph.
- Not defined (never observed): dim-overlay, card-grid, tooltip,
  badge-notification counts. Implementing agents should fall back to
  taste-family defaults knowingly.

## Screen Patterns

- **HUD (desktop, observed)**: engine chrome top-left; green Shop launcher on
  the left edge at mid-height; hotbar of 9–10 badge-slot tiles bottom-center;
  oversized currency-counter bottom-left; translucent dark leaderboard panel
  top-right under the topbar inset; circular avatar badge on the right edge.
  Floating boost text (yellow italic outlined) hovers over the world near the
  top. Persistent element count is ~7 — moderate density. Mobile placement
  was not observed; keep joystick/jump zones clear by rule.
- **Shop window**: header band (countdown + RESTOCK + close) → scrolling
  list of row-cards → optional expanded purchase row (NO STOCK + premium
  price pair) under the focused item. External tabs on the right outer edge
  switch between sibling shops. No footer CTA — purchases happen in-row.
- **Daily deals**: same window shell with a banner-offer (ad-reward chain)
  pinned above the deal rows; rarity chips also appear loose along the
  window's bottom edge as a legend.
- **Quest windows**: header band (title + inline reset timer or a full-width
  red reset banner) → reward track (icon frames with gold label plates) →
  quest rows or three-up quest cards, each footed by a progress-bar →
  footer strip with the meta-reward text left and a Claim plate right.
- **Player menu**: left vertical tab rail outside the window body; the window
  re-renders per tab while rail and shell persist.

## Do's and Don'ts

**Do:**
- Emboss the studs — header bands and window bodies must carry the tiled
  brick motif; it is the single strongest identity cue.
- Outline every piece of text, everywhere, no exceptions.
- Keep commerce as full-width rows with the well-name-price-chip anatomy.
- Put the close button INSIDE the header band, square and red, rightmost.
- Reserve rarity colors for chips and the rainbow rim for limited events.

**Don't:**
- Never use pills or circles for buttons and bars — blocky rectangles only
  (the lone circle is the small info badge).
- Never cast drop shadows; depth is emboss and ink edges.
- Never color prices in anything but `{colors.currency-soft}` green, and
  never reuse that green for non-price text.
- Never float the header as a separate tab above the window — the band is
  integrated, full-width, and flush with the window top.
- Never use pure black ink; the outline family is warm near-black brown.
- Never hide scrollbars in windows; the slim light scrollbar is part of the
  furniture.

## Agent Prompt Guide

Quick reference for implementing agents:

- Window = brown stud-textured board, 14px corners, 2px `#2B1A0A` rim, green
  stud header band with title left + gold plate + red close square right, no
  shadow, no dim observed.
- Rows = `#54331B` full-width cards, square `#96602F` well left, white
  FredokaOne name (heading size) with 2px stroke, `#21DB21` price, rarity
  chip bottom-right.
- Buttons are raised plates: fill + white rim + 2–3px darker bevel + white
  outlined uppercase label. Close = red square. Premium price = flat purple.
- Motion (preset, low confidence): enter scale 0.8→1.0 Back-Out 0.25s, exit
  Quad-In 0.15s, press squash 0.08s with bevel collapse.
- Layout: UIListLayout rows, 12px sibling gaps, 32px window UIPadding,
  Scale-first sizing, DeviceSafeInsets, 44px+ targets.

Canned prompts:

1. *"Using DESIGN.roblox.md (Planter Box Pop), build the seed-shop window: a
   stud-embossed green header with a countdown, gold RESTOCK plate and red
   close square, plus a scrolling list of item rows (well, name, stock,
   price, rarity chip). react-lua, Scale-first."*
2. *"Using DESIGN.roblox.md (Planter Box Pop), build the desktop HUD: green
   Shop launcher on the left edge, bottom-center hotbar of translucent brown
   slots, and the oversized outlined currency counter bottom-left."*
3. *"Review this screenshot against DESIGN.roblox.md (Planter Box Pop) and
   list every deviation from the Do's and Don'ts and Components sections,
   ordered by visual impact."*

---

*Independent analysis of publicly observable UI conventions in the farming
simulator genre, provided as-is for inspiration. Not affiliated with or
endorsed by any game or studio.*
