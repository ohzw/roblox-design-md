---
version: alpha
name: Sticker Pop
description: >
  Chunky, flat-color cartoon UI where every element is outlined in the same
  warm brown ink like a puffy vinyl sticker. Green says "go", blue navigates,
  red closes, gold and purple are money. Depth comes from fake-3D bottom
  bevels, never soft shadows. Built for pet-collecting simulators.
taste: [cartoon-chunky, playful, juicy]
genre: [simulator, pet-collector]

colors:
  primary: "#5CC244"        # CTA green — HATCH / BUY / CLAIM
  secondary: "#4FA3EA"      # navigation blue — SHOP button, window header tab
  danger: "#E64B45"         # close buttons and notification badges
  surface: "#CDC5AB"        # window panel tan
  surface-well: "#F2E8C4"   # cream content wells and cards inside windows
  on-surface: "#463521"     # dark warm brown text on cream/tan surfaces
  outline: "#463521"        # the universal sticker-outline ink (same as on-surface)
  currency-soft: "#FFCD45"  # coin gold; doubles as the side-button fill
  currency-hard: "#B569E3"  # gem purple
  accent-rare: "#4FA3EA"    # RARE ribbon (reuses the navigation blue)
  accent-epic: "#A55BD6"    # EPIC ribbon
  accent-legend: "#EE8A3E"  # LEGEND ribbon orange
  surface-dark: "#3A2D4D"   # dark plum pill behind currency readouts
  dim: "#2E2156B3"          # popup backdrop, estimated ~70% opacity navy-purple

typography:
  heading:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 24px
    uppercase: true
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 22px
    uppercase: true
  body:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 14px
  caption:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 12px
    uppercase: true

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px }

rounded: { sm: 10px, md: 14px, lg: 20px, full: full }

strokes:
  outline: { thickness: 3px, color: "{colors.outline}", mode: Border }
  outline-heavy: { thickness: 5px, color: "{colors.outline}", mode: Border }
  outline-sm: { thickness: 2px, color: "{colors.outline}", mode: Border }
  text-outline: { thickness: 2px, color: "{colors.outline}", mode: Contextual }

motion:
  durations: { instant: 0.08s, fast: 0.15s, normal: 0.25s, slow: 0.4s }
  easings:
    pop: { style: Back, direction: Out }
    settle: { style: Quad, direction: Out }
    exit: { style: Quad, direction: In }
    bounce: { style: Elastic, direction: Out }

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(5px #3F8F2B)"
    aspectRatio: 3.2
  button-primary-pressed:
    shadow: none            # inferred, not observed — the bevel collapses on press
  button-secondary:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(5px #2E6FB4)"
    aspectRatio: 3.2
  button-close:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    rounded: full
    stroke: "{strokes.outline}"
    shadow: "bevel(4px #B03230)"
    aspectRatio: 1
    size: "44px diameter at reference"
  side-button:
    backgroundColor: "{colors.currency-soft}"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    shadow: "bevel(4px #D8A032)"
    size: "about 52px square at reference; icon disc above caption"
  currency-bar:
    backgroundColor: "{colors.surface-dark}"
    textColor: "#FFFFFF"
    typography: "{typography.body}"
    rounded: full
    stroke: "{strokes.outline-sm}"
    height: 30px
  window:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline-heavy}"
    shadow: "bevel(6px {colors.outline})"
    size: "scale ~0.21 wide on desktop, roughly 6:5"
  window-header:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.heading}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
  dim-overlay:
    backgroundColor: "{colors.dim}"
  card-grid:
    backgroundColor: "{colors.surface-well}"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    aspectRatio: 0.95
  card-grid-selected:
    stroke: "{strokes.outline-heavy}"   # one card showed a visibly heavier outline
  badge-notification:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    typography: "{typography.caption}"
    rounded: full
    stroke: "{strokes.outline-sm}"

extraction:
  inputs:
    - id: shot-1
      kind: screenshot
      describes: "HUD during gameplay, desktop landscape, captured at ~1920px width"
    - id: shot-2
      kind: screenshot
      describes: "Pet shop window over dimmed gameplay, desktop landscape"
    - id: shot-3
      kind: screenshot
      describes: "Button lineup closeup: CLAIM, SHOP, close circle, PETS side-button with badge"
  confidence:
    Overview: high
    Colors: high
    Typography: medium
    Layout: medium
    "Elevation & Depth": high
    Shapes: high
    Motion: low
    Components: medium
    "Screen Patterns": medium
  notes: >
    Provenance — primary green: HATCH (shot-1), BUY (shot-2), CLAIM (shot-3);
    secondary blue: SHOP button (shot-3), PET SHOP header + RARE ribbon (shot-2);
    danger red: close circle (shot-2, shot-3), badges (shot-1, shot-3);
    surface/surface-well/on-surface/outline: window panel, wells, cards, card
    captions (shot-2); currency-soft/hard + surface-dark: currency pills
    (shot-1); accent-epic/legend: EPIC and LEGEND ribbons (shot-2); dim:
    computed by comparing the sky in shot-1 vs shot-2 (same world region),
    opacity estimated, medium confidence on the exact value. Well fill and
    card fill differ by only a few RGB points; merged into surface-well.
    accent-epic vs currency-hard purples differ by ~15 RGB points; kept
    separate but they may be one token. Strokes/radii measured on buttons,
    cards, window (all shots); two-step stroke scale (3px standard, 5px
    window) observed. Bevels observed under every button and under the window
    bottom edge. Typography sizes are estimates from renders whose viewport
    was ~1920x745, not full 1080 tall — vertical sizes carry a few px of
    uncertainty, hence Typography medium. No video: Motion is the
    cartoon-chunky taste-family preset (low). button-primary-pressed and the
    press behavior are inferred conventions, not observed states.
    card-grid-selected is read from a single emphasized card (UNICORN,
    shot-2). Not observed at all, therefore omitted: display typography tier
    (no reward screen), progress-bar, tooltip, button-icon, hover states,
    phone layout. No inventory screen beyond the shop grid; grid density read
    from shot-2 only.
---

# Sticker Pop — DESIGN.roblox.md

## Overview

Bright, chunky, flat-color cartoon UI that feels like a sheet of puffy vinyl
stickers pressed onto a toy box: every button, window, card, and badge is cut
out with the same warm brown outline, filled with one saturated flat color,
and given a fake-3D bottom edge that begs to be squished. Nothing is subtle
and nothing is translucent except the popup dim. Color is language — green
means "do the thing", blue means "go somewhere", red means "close or look at
me", gold and purple mean money. Target genre: pet-collecting / hatching
simulators and similar casual loops. Adjectives: chunky, sunny, tactile,
toy-like.

## Colors

The palette is a small set of saturated flat fills on warm neutrals. Roles:

- `{colors.primary}` green is the forward-action color — HATCH, BUY, CLAIM.
  It is the only color allowed on the main CTA.
- `{colors.secondary}` blue is navigation and chrome: the SHOP button, the
  window header tab, and (reused) the RARE rarity ribbon (`{colors.accent-rare}`).
- `{colors.danger}` red is reserved for the close button and notification
  badges. It never fills a commerce CTA.
- `{colors.surface}` tan is the window panel; `{colors.surface-well}` cream is
  the content well and cards *inside* the panel — unusually, the inset well is
  LIGHTER than the panel, like paper glued onto cardboard. Keep that
  relationship.
- `{colors.on-surface}` is the warm brown ink for text on cream/tan. It is the
  same color as `{colors.outline}` — one ink for lettering and outlines.
- `{colors.currency-soft}` gold and `{colors.currency-hard}` purple are the
  two currency accents, shown as coin/gem discs on a `{colors.surface-dark}`
  plum pill so the money always reads against the sky.
- Rarity ribbons climb blue → purple → orange: `{colors.accent-rare}`,
  `{colors.accent-epic}`, `{colors.accent-legend}`.
- `{colors.dim}` is the navy-purple backdrop behind windows (opacity
  estimated from comparing dimmed vs undimmed sky — treat the alpha as
  approximate).

There is no pure black and no pure white surface anywhere: darks are warm
brown or plum, lights are cream. Text white is the only true white. Danger red
and currency gold never appear on the same element.

## Typography

One family serves every tier — a rounded, chunky, single-weight cartoon
letterform; nearest engine family is `FredokaOne` (runner-up considered:
Baloo-alikes; FredokaOne is the cross-platform match). Boldness is baked in,
so weight is always `Regular`.

- `heading` (24px): window header tabs ("PET SHOP"). Uppercase, white, with
  the 2px brown text stroke.
- `label` (22px): button faces ("HATCH", "BUY", "CLAIM", "SHOP"). Uppercase,
  white, always text-stroked.
- `body` (14px): currency readouts ("1.2M", "4821") — white on the dark pill,
  no stroke needed.
- `caption` (12px): card names ("DOG", "CAT"), side-button labels ("SHOP",
  "PETS"), badge digits and rarity ribbons. Uppercase; brown ink on light
  fills, white with stroke on colored fills.

No `display` tier is defined — no reward/celebration screen was provided;
implementing agents should scale up `heading` proportionally if needed.
Everything user-facing is UPPERCASE. Text stroke rule: white text on any
saturated fill carries `{strokes.text-outline}`; brown text on cream carries
none. Prefer TextScaled inside buttons with the token sizes as the intended
size at reference resolution.

## Layout

Spacing scale: `{spacing.xs}` for badge offsets and hairline gaps,
`{spacing.sm}` for sibling gaps in lists and grids (card grid gap, side-button
column gap), `{spacing.md}` for HUD offsets from the screen edges and header/content gaps,
`{spacing.lg}` for window inner UIPadding (the well sits ~20px inside the
panel). No larger step was observed; do not invent one — repeat `lg` if a
bigger gap is needed.

Delegation: lay out grids with `UIGridLayout` (cell gap `{spacing.sm}`),
stacks with `UIListLayout`, and insets with `UIPadding`; never hand-place with
Position arithmetic. Sizes are Scale-first with `UIAspectRatioConstraint`
(buttons ~3.2:1, cards ~1:1, close button 1:1).

Tap targets: the smallest touchable observed (close circle, side-buttons) is
~44–52px at reference — keep 44px as the floor. Density is low: the HUD holds
six persistent elements total and the screen center stays empty for gameplay.
Only desktop-shaped captures were provided; phone-specific behavior is
undefined here (defaulted assumption: same anchors, safe-area insets via
`ScreenGui.ScreenInsets = DeviceSafeInsets`).

## Elevation & Depth

Depth is drawn, not blurred — there are no soft drop shadows anywhere.

- Stroke scale, one ink (`{colors.outline}`): `{strokes.outline}` 3px on
  buttons, cards, pills, ribbons; `{strokes.outline-heavy}` 5px on the window
  panel (and the emphasized/selected card); `{strokes.outline-sm}` 2px on tiny
  elements (badges, currency pills); `{strokes.text-outline}` 2px Contextual
  on light text over color.
- Every pressable element carries a `bevel(...)` — a strip of its own fill
  darkened ~25–30%, 4–5px tall at the bottom edge (fake-3D). The window itself
  has a heavier 6px bottom edge. Press feedback = collapse the bevel (inferred
  convention, not observed).
- Popups sit on `{colors.dim}` — a navy-purple full-screen dim (~70% opacity,
  estimated) that pushes the world back hard.
- Layering plan: ScreenGuis with `ZIndexBehavior = Sibling`; DisplayOrder
  bands — HUD low, dim + window above it, close button and header tab overlap
  the window silhouette (they straddle its top edge), badges topmost within
  their button.

## Shapes

- `{rounded.sm}` (10px): cards and content wells.
- `{rounded.md}` (14px): buttons, side-buttons, the header tab.
- `{rounded.lg}` (20px): window panels.
- `full`: currency pills, close button, icon discs, notification badges,
  rarity ribbons — anything small and countable is a pill or a circle.

Silhouette rules: rectangles are always visibly rounded (nothing sharper than
10px); pure circles are reserved for icon/close/badge; the window is a single
rounded slab with the header tab and close circle breaking its top edge like
stickers layered on top.

## Motion

No video input was provided, so all motion tokens are the cartoon-chunky
taste-family preset — defaults, not observations (confidence: low).

- Entrances `pop` (`Back Out`, `{motion.durations.normal}`): windows scale
  0.8 → 1.0 with overshoot; the dim fades in over `{motion.durations.fast}`.
- Exits use `exit` (`Quad In`) at `{motion.durations.fast}` — always faster
  than entrances; the dim fades last.
- Press feedback: squash to ~0.92 scale for `{motion.durations.instant}` while
  the bevel collapses, `settle` back on release.
- `bounce` (`Elastic Out`) is reserved for reward moments and badge pops —
  never for routine navigation.
- Numbers (currency) count up rather than snap.
- Reduced-motion stance: replace scale-pops with fades at the same durations;
  never remove press feedback.

## Components

- `button-primary` — the green go-button (HATCH/BUY/CLAIM). Flat green fill,
  3px brown outline, 14px corners, darker-green 5px bottom bevel, white
  uppercase label with 2px brown text stroke. Feels like a springy arcade
  button. `-pressed` (inferred): bevel collapses to none.
- `button-secondary` — identical construction in navigation blue with a
  darker-blue bevel (SHOP). Same size grammar as primary; only the hue changes
  meaning.
- `button-close` — red circle with a white X, brown outline, darker-red bevel,
  perched overlapping the window's top-right corner from OUTSIDE the panel.
- `side-button` — gold rounded square (~52px) with a flat colored icon disc on
  top and a tiny uppercase caption below, brown outline, darker-gold bevel.
  Stacks in a vertical column on the left screen edge.
- `currency-bar` — dark plum full-rounded pill: currency disc on the left,
  white amount, and a small green "+" circle flush right (the "+" reuses the
  primary green). Two bars stack in the top-right corner.
- `window` — tan slab, 5px brown outline, 20px corners, 6px bottom edge; the
  header tab and close button break its silhouette.
- `window-header` — blue rounded tab straddling the window's top edge,
  centered, uppercase white title with text stroke.
- `dim-overlay` — full-screen navy-purple dim behind any window.
- `card-grid` — cream near-square cards on the cream well, 3px outline, 10px
  corners: flat item disc centered, uppercase brown name at the bottom, and an
  optional rarity ribbon pill overlapping the card's top edge (RARE blue /
  EPIC purple / LEGEND orange, white micro-caption with stroke).
  `-selected`: the outline thickens to the 5px heavy stroke (read from one
  emphasized card; treat as medium-confidence).
- `badge-notification` — small red circle pinned to a button's top-right
  corner, white count ("3", "99+"), thin outline. Red is allowed here even
  though the button below is gold — badges are alerts, not commerce.

Not defined (never observed): `button-icon`, `progress-bar`, `tooltip`,
disabled states, hover states. Their absence is deliberate — fall back to
taste defaults knowingly.

## Screen Patterns

**HUD (from shot-1).** Top-right: two currency-bars stacked vertically with a
small gap, right-aligned. Left edge, vertically centered: a column of three
side-buttons (SHOP / PETS / GIFTS) with notification badges on their
top-right corners. Bottom-center: one big button-primary (HATCH) — the single
most important action gets the thumb-friendliest spot. Kept clear: the entire
bottom-left (virtual joystick), bottom-right (jump button), and the top strip
(unibar). Information density is deliberately low — six persistent elements,
center screen empty.

**Shop window (from shot-2).** Centered panel about a fifth of the screen
wide. Header tab straddles the top edge, centered; close circle overlaps the
top-right corner from outside. Inside: one cream well holding a 3-column card
grid (rows of near-square cards, `{spacing.sm}` gaps), then a centered
button-primary (BUY) as the footer CTA below the well. One window at a time
over a full-screen dim; gameplay HUD is not visible behind it.

No inventory, settings, or reward screens were provided — those compositions
are undefined in this document.

## Do's and Don'ts

- **Do** outline every UI element with the one brown ink. A strokeless fill
  reads as unfinished in this taste.
- **Never** use pure black or pure grey — darks are warm brown
  (`{colors.outline}`) or plum (`{colors.surface-dark}`).
- **Never** use 1px strokes; the minimum visible stroke is 2px, standard is 3px.
- **Never** put soft drop shadows on buttons — depth is the bottom bevel only,
  and it must be the fill's own color darkened, not black.
- **Never** fill a commerce CTA with red. Green acts, blue navigates, red
  closes/alerts.
- **Do** uppercase every label and title, and stroke white text whenever it
  sits on a saturated fill; unstroked white text is illegible against these
  colors.
- **Never** make the inset well darker than the window — in this taste inner
  surfaces get LIGHTER (cream on tan), the opposite of most UI kits.
- **Never** place HUD elements in the bottom corners or the topbar strip —
  joystick, jump button, and unibar own those zones.
- **Do** keep windows singular and centered over the dim; no side-drawers, no
  stacked windows.
- **Never** introduce gradients — every observed fill is flat; the taste's
  richness comes from outlines and bevels, not shading.

## Agent Prompt Guide

Cheat sheet — the default recipe for ANY new element:

1. Flat fill from the semantic palette (`{colors.primary}` act,
   `{colors.secondary}` navigate, `{colors.danger}` close/alert).
2. `UIStroke` 3px `{colors.outline}`, `UICorner` `{rounded.md}`.
3. Bottom bevel: same fill darkened ~25–30%, 4–5px.
4. Text: FredokaOne Regular, uppercase, white + 2px Contextual stroke on
   color, or `{colors.on-surface}` bare on cream.
5. Size with Scale + `UIAspectRatioConstraint`; lay out with
   UIListLayout/UIGridLayout/UIPadding; ≥44px touchable.

Canned prompts:

- "Build a settings window in the Sticker Pop taste: tan `{colors.surface}`
  panel with 5px `{colors.outline}` stroke and 20px corners, blue header tab
  straddling the top edge reading SETTINGS, red close circle overlapping the
  top-right from outside, a cream `{colors.surface-well}` well with 20px
  UIPadding, and a green `{colors.primary}` SAVE button-primary centered
  below the well."
- "Add a daily-reward button to the left side-button column: gold
  `{colors.currency-soft}` rounded square, icon disc + uppercase REWARDS
  caption, brown outline, darker-gold bevel, red `{colors.danger}`
  badge-notification pinned top-right."
- "Animate the shop opening: dim fades in over `{motion.durations.fast}`,
  window scales 0.8→1.0 with Back Out over `{motion.durations.normal}`; on
  close, reverse with Quad In at `{motion.durations.fast}`, dim last."

---

Independent analysis of publicly observable UI conventions, provided as-is
for inspiration. Not affiliated with or endorsed by any game or studio.
