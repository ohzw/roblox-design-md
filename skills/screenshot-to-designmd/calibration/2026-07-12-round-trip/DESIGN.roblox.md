---
version: alpha
name: Cartoon Chunky
description: >
  Bright toy-like UI extracted from three screenshots of a pet-collecting
  simulator style interface: thick dark outlines on everything, candy-colored
  capsule buttons with a fake-3D bottom edge, cream panels, and loud rounded
  lettering.
taste: [cartoon-chunky, playful, juicy]
genre: [simulator, pet-collector]

extraction:
  inputs:
    - id: shot-1
      kind: screenshot
      describes: "HUD during gameplay, desktop 16:9 (side buttons, currency pills, HATCH button)"
    - id: shot-2
      kind: screenshot
      describes: "PET SHOP window over dimmed gameplay (header, close, card grid, BUY)"
    - id: shot-3
      kind: screenshot
      describes: "Button lineup close-up (primary, secondary, close, side button with badge)"
  confidence:
    Overview: high
    Colors: high
    Typography: medium      # display tier never observed; sizes estimated from renders
    Layout: medium          # phone layout unseen; spacing lg interpolated
    "Elevation & Depth": high
    Shapes: high
    Motion: low             # no video — cartoon-chunky family preset
    Components: medium      # pressed/disabled states inferred, not observed
    "Screen Patterns": medium  # HUD + shop only; inventory/settings/reward unseen
  notes: >
    No reward/celebration screen: display typography tier omitted rather than
    invented. No video: motion is the cartoon-chunky preset. Pressed state
    inferred from the bevel affordance. progress-bar, tooltip, button-icon and
    disabled states not observed and therefore not defined. dim value derived
    by comparing dimmed vs undimmed sky in shot-2 vs shot-3 (~65% opacity).
    spacing.lg is an interpolated scale step (observed: 4/8/12/32).

colors:
  primary: "#5CC940"        # green forward-action buttons (HATCH, BUY, CLAIM) — shot-1/2/3
  secondary: "#4FA7F3"      # blue neutral buttons (SHOP) and window header band — shot-2/3
  danger: "#F04D4E"         # close buttons — shot-2/3
  surface: "#FFF6E0"        # warm cream window panel — shot-2
  surface-deep: "#F4E2B8"   # inset grid well inside the window — shot-2
  on-surface: "#5C3A0F"     # warm brown text on cream (card names, captions) — shot-2/3
  currency-soft: "#FFD84F"  # gold coin icon + side-button fill — shot-1
  currency-hard: "#B96BF4"  # purple gem icon — shot-1
  accent-rare: "#FF8A3E"    # LEGEND ribbon orange — shot-2
  outline: "#4A2E15"        # universal dark-brown stroke — all shots
  dim: "#261A5CA6"          # purple-navy popup backdrop at ~65% opacity — shot-2

typography:
  heading:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 30px
    uppercase: true
  body:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 20px
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 24px
    uppercase: true
  caption:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 16px

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px, xl: 32px }

rounded: { sm: 10px, md: 16px, lg: 24px, full: full }

strokes:
  outline:      { thickness: 3px, color: "{colors.outline}", mode: Border }
  outline-heavy: { thickness: 5px, color: "{colors.outline}", mode: Border }
  text-outline: { thickness: 2px, color: "{colors.outline}", mode: Contextual }

motion:
  durations: { instant: 0.08s, fast: 0.15s, normal: 0.25s, slow: 0.4s }
  easings:
    pop:    { style: Back, direction: Out }
    settle: { style: Quad, direction: Out }
    exit:   { style: Quad, direction: In }
    bounce: { style: Elastic, direction: Out }

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(5px #3F8A2A)"
    aspectRatio: 3.2
  button-primary-pressed:
    shadow: none
  button-secondary:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(5px #2F78BD)"
    aspectRatio: 3.2
  button-close:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
    shadow: "bevel(4px #B23031)"
    aspectRatio: 1
  side-button:
    backgroundColor: "{colors.currency-soft}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline}"
    shadow: "bevel(4px #C9A230)"
    aspectRatio: 1
  currency-bar:
    backgroundColor: "#3A2A5F"
    textColor: "#FFFFFF"
    typography: "{typography.body}"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    height: 44px
  window:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline-heavy}"
    shadow: "drop(0px 8px #00000040)"
  window-header:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.heading}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
  dim-overlay:
    backgroundColor: "{colors.dim}"
  card-grid:
    backgroundColor: "{colors.surface-deep}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    aspectRatio: 1
  card-grid-selected:
    stroke: "{strokes.outline-heavy}"
    backgroundColor: "#FFEFC3"
  badge-notification:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
---

# Cartoon Chunky (extracted)

## Overview

This is toy-store UI: a pet-collecting simulator interface where every
element looks like a capsule toy — self-contained, thickly outlined in warm
dark brown, filled with saturated candy colors, and sitting confidently on
top of the game world. One concrete reference: **a claw machine at a family
arcade** — bright plastic, rounded everything, and buttons that beg to be
pressed because they visibly have a bottom edge.

Rules the screenshots consistently obey:

1. **Everything that matters is outlined.** Buttons, pills, windows, badges,
   and any text over the world carry the same dark-brown stroke.
2. **Chunky over elegant.** No thin lines, no small text, no muted grays
   anywhere in the observed screens.
3. **Color = function.** Green means "go", blue means "navigate", red means
   "close", gold/purple are reserved for the two currencies.

## Colors

Warm cream surfaces with candy accents; the world backdrop is tinted, never
blacked out.

- `{colors.primary}` green appears on every forward action (HATCH, BUY,
  CLAIM) and nowhere else — one dominant instance per screen region.
- `{colors.secondary}` blue does navigation-flavored actions (SHOP) and the
  window header band. Never destructive.
- `{colors.danger}` red is the close button on both observed windows and the
  notification badge fill.
- `{colors.surface}` is warm cream — notably NOT pure white — with
  `{colors.surface-deep}` as a darker inset well for content grids.
- `{colors.on-surface}` warm brown body text; pure black never appears.
- `{colors.currency-soft}` gold and `{colors.currency-hard}` purple are used
  exclusively for currency identity (coin/gem icons); the side buttons reuse
  the gold as fill, keeping the HUD palette tight.
- `{colors.accent-rare}` orange marks rarity ribbons only (tiny area share).
- `{colors.dim}` is a purple-navy tint at roughly 65% opacity — the world
  stays visible and colorful behind popups.

## Typography

A single family carries the whole interface: `FredokaOne` (rounded, chunky,
single-weight) — hierarchy is built purely from size and casing.

- `{typography.heading}` — window headers, UPPERCASE (observed: "PET SHOP").
- `{typography.label}` — button labels, UPPERCASE (HATCH, BUY, CLAIM, SHOP).
- `{typography.body}` — currency amounts and general values.
- `{typography.caption}` — badges, card names, small counters.
- A larger display tier for rewards/titles was **not observed** (no
  celebration screen in the inputs) — implementers should scale up the
  heading treatment (~42px with a heavier 3px text stroke) if one is needed.

Every piece of text over the world or over an image carries
`{strokes.text-outline}`; button text is white with the outline regardless of
fill. Buttons and headers appear TextScaled with generous padding.

## Layout

Density is low: the HUD shows 6 persistent elements, generously spaced.

- `{spacing.md}` (12px) is the default sibling gap (side-button column, card
  grid); `{spacing.sm}` between stacked currency pills; `{spacing.xl}` window
  inner padding. `{spacing.lg}` is an interpolated step (not directly
  observed).
- Repeating content (grids, columns) is evenly spaced — implementers should
  delegate to UIListLayout/UIGridLayout with the spacing tokens.
- Currency pills hang below the topbar area on the right; the HUD respects
  device safe areas (`ScreenGui.ScreenInsets = DeviceSafeInsets`).
- All observed touch targets are ≥44px at reference (side buttons ~72px).

## Elevation & Depth

Depth is drawn with three tools, in priority order:

1. **Outlines** — `{strokes.outline}` (3px) universally;
   `{strokes.outline-heavy}` (5px) on the window panel and the selected card.
2. **Bevels** — every button has a darker strip of its own fill color along
   the bottom edge (~4–5px): the signature fake-3D press affordance.
3. **Drop shadow** — only the window shows soft detached darkness
   (`drop(0px 8px ...)`); small elements never carry drop shadows.

Layering observed in shot-2: dim tint → window panel → header band and close
button overlapping the panel edge (rendered above it).

## Shapes

No sharp corners exist in the observed screens.

- `{rounded.md}` (16px) — buttons and grid cards.
- `{rounded.lg}` (24px) — the window panel and side buttons.
- `{rounded.sm}` (10px) — small inset elements (rarity ribbons).
- `{rounded.full}` — currency pills, close buttons, badges (circles).

Windows are landscape rounded rectangles; anything countable is a circle.

## Motion

**Not observed (no video input)** — the values in front matter are the
cartoon-chunky family defaults, consistent with the still evidence (bevel
affordance implies press feedback; the taste family implies overshoot
entrances):

- Entrances: scale 0.8 → 1.0 with `{motion.easings.pop}` at
  `{motion.durations.normal}`; never fade-only.
- Exits: `{motion.easings.exit}` at `{motion.durations.fast}` — faster than
  entrances.
- Press: squash + bevel collapse at `{motion.durations.instant}` on every
  button.
- Rewards: `{motion.easings.bounce}` reserved for celebration moments.

## Components

- **button-primary** — green capsule, white uppercase outlined label, 5px
  bevel; the single "go" action of its region. Pressed state (inferred from
  the bevel affordance): bevel collapses.
- **button-secondary** — blue sibling, same anatomy, used for navigation
  (SHOP); visually subordinate to the primary when both appear.
- **button-close** — red circle with white X, overlapping the window's
  top-right corner; oversized (~56px).
- **side-button** — gold rounded-square launcher on the HUD's left edge:
  icon on top, tiny uppercase caption below, red `badge-notification`
  pinned to its top-right corner ("3", "99+" observed).
- **currency-bar** — dark navy pill: currency icon left, white outlined
  amount, green "+" buy button flush right. Amounts abbreviate ("1.2M").
- **window / window-header** — cream panel with heavy outline; blue header
  band sits proud of the top edge like a label on a toy box; close button
  overlaps the corner.
- **dim-overlay** — purple-navy tint behind windows.
- **card-grid / -selected** — square cards on the deep well; rarity shown by
  a small colored corner ribbon (blue/purple/orange observed), selection by
  heavy outline + lighter fill.
- **badge-notification** — red circle counter, white outlined number, capped
  at "99+".
- Not observed (intentionally undefined): progress-bar, tooltip,
  button-icon, disabled states.

## Screen Patterns

- **HUD** (shot-1): side-button column vertically centered on the LEFT edge;
  two currency pills stacked TOP-RIGHT; one contextual primary (HATCH)
  BOTTOM-CENTER. Bottom-left and bottom-right corners are kept clear
  (virtual joystick / jump zones). 6 persistent elements total.
- **Shop window** (shot-2): centered landscape panel over the dim; header
  band top-center; close top-right; content = inset card grid; footer =
  single centered BUY primary. No secondary actions compete with the footer
  CTA.
- Inventory, settings, gacha, and reward screens were not provided —
  patterns for those are undefined here rather than guessed.

## Do's and Don'ts

**Do:**
- Outline every element and every piece of text over the world.
- Keep one green primary per screen region; blue for navigation, red for
  close — never mix these roles.
- Give every button a bevel and collapse it on press.
- Reserve gold/purple strictly for currency identity.

**Don't:**
- Never use thin (1px) strokes, pure black, or pure white.
- Never drop-shadow small elements; bevels carry button depth.
- Never restyle or relocate the red circular close button.
- Never let rarity accents exceed a small fraction of the screen.

## Agent Prompt Guide

Quick reference: fills from `colors.*`; 3px brown UIStroke on everything
(5px windows/selected); corners 16px buttons / 24px windows / full pills;
`Font.fromName("FredokaOne")` everywhere, uppercase + TextScaled on
buttons/headers, white button text with 2px contextual stroke; bevel =
darkened bottom strip that collapses on press; UIListLayout/UIGridLayout
with 12px gaps; DeviceSafeInsets; 44px+ targets.

Example prompt: *"Using this DESIGN.roblox.md, build the HUD: left
side-button column, top-right currency pills, bottom-center primary action.
react-lua, Scale-first, ZIndexBehavior=Sibling."*

---

*Independent analysis of publicly observable UI conventions, provided as-is
for inspiration. Not affiliated with or endorsed by any game or studio.*
