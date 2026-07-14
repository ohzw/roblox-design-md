---
version: alpha
name: Sticker Toybox
description: >
  Bright, outlined, toy-like UI for cheerful collection games: cream panels,
  candy-colored chunky buttons with fake-3D bottom edges, everything wrapped
  in one dark warm outline like puffy stickers on a toy chest.
taste: [cartoon-chunky, playful, juicy]
genre: [simulator, pet-collector]

colors:
  primary: "#5BC13D"
  secondary: "#4D9EE8"
  danger: "#E8483E"
  surface: "#FAF1D8"
  surface-deep: "#EFE3C2"
  surface-dark: "#372B4E"
  on-surface: "#4A3826"
  currency-soft: "#F6C846"
  currency-hard: "#B06CE8"
  accent-rare: "#4D9EE8"
  accent-epic: "#A052D8"
  accent-legend: "#E8862F"
  outline: "#46351F"
  dim: "#2B1A5EB3"

typography:
  heading:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 28px
    uppercase: true
  body:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 18px
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 24px
    uppercase: true
  caption:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 14px
    uppercase: true

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px, xl: 32px }

rounded: { md: 14px, lg: 22px, full: full }

strokes:
  outline:      { thickness: 4px, color: "{colors.outline}", mode: Border }
  outline-thin: { thickness: 2px, color: "{colors.outline}", mode: Border }
  text-outline: { thickness: 3px, color: "{colors.outline}", mode: Contextual }

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
    shadow: "bevel(6px #3E8A28)"
    height: 72px
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
    shadow: "bevel(6px #2E6FB5)"
    height: 72px
    aspectRatio: 3.2
  button-close:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(4px #B02F28)"
    size: "circle, 52-64px diameter observed; never below 52px"
  side-button:
    backgroundColor: "{colors.currency-soft}"
    textColor: "#FFFFFF"
    typography: "{typography.caption}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(5px #C9962F)"
    size: "72px square at reference; icon circle centered, caption label hugging bottom edge"
  currency-bar:
    backgroundColor: "{colors.surface-dark}"
    textColor: "#FFFFFF"
    typography: "{typography.body}"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    height: 40px
    size: "scale-anchored to the top-right; roughly 195px wide at reference per pill"
  window:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline}"
    shadow: none
    size: "centered, roughly scale 0.29 wide at 16:9 desktop, aspect ~1.2:1"
  window-header:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.heading}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    size: "tab roughly 280x50px at reference, centered, overlapping the window's top edge"
  dim-overlay:
    backgroundColor: "{colors.dim}"
  card-grid:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    size: "cells roughly 112px square at reference, gaps {spacing.md}, on a {colors.surface-deep} well"
  badge-notification:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    typography: "{typography.caption}"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline-thin}"
    size: "circle ~22px, straddling the parent's top-right corner"

extraction:
  inputs:
    - id: shot-1
      kind: screenshot
      describes: "HUD during gameplay, desktop 16:9-ish (2660x1034 logical viewport)"
    - id: shot-2
      kind: screenshot
      describes: "Pet shop window over dimmed gameplay, same viewport"
    - id: shot-3
      kind: screenshot
      describes: "Button lineup closeup: primary, secondary, close, icon side-button"
  confidence:
    Colors: high
    Typography: medium
    Layout: medium
    "Elevation & Depth": medium
    Shapes: medium
    Motion: low
    Components: medium
    "Screen Patterns": medium
  notes: >
    Captures taken via Studio MCP at logical viewport 2660x1034; analyzed
    image is 1920px wide, so all measurements were converted at 2660/1920 =
    1.385x before tokenization, then rounded (spacing to 4px, radii to 2px,
    strokes to 1px; +-1px residual uncertainty on strokes/radii from the
    downscale). Colors: primary from HATCH/CLAIM/BUY buttons (shot-1/2/3);
    secondary from SHOP button + PET SHOP header + RARE ribbon (merged, all
    within cluster tolerance); danger from close X + notification badges;
    surface/surface-deep from window panel and inset well (shot-2);
    surface-dark, currency-soft, currency-hard from currency pills (shot-1);
    accent-epic/accent-legend from EPIC/LEGEND ribbons (shot-2); outline
    sampled on button/window/card strokes. dim solved from sky #87CEEB
    (shot-1) vs dimmed sky (shot-2): approx #2B1A5E at ~70% opacity -
    estimate, medium confidence. Typography: single rounded chunky family
    everywhere -> FredokaOne (runner-up: Nunito ExtraBold); display tier
    never observed (no reward screen) and omitted; body 18px taken from
    currency amounts; sizes are TextScaled-adjusted lower bounds rounded up.
    rounded.sm and spacing.xs were not directly observed (xs kept as scale
    filler, noted in Layout). Motion is entirely the cartoon-chunky taste
    preset (no video input): confidence low. button-primary-pressed
    (bevel collapse) is INFERRED, not observed. progress-bar and tooltip
    never observed -> omitted. Missing recommended inputs: reward/celebration
    still, progress bar screen, phone capture, video.
---

# Sticker Toybox — DESIGN.roblox.md

## Overview

This taste feels like a page of puffy vinyl stickers stuck onto a toy chest:
every element — buttons, windows, pills, badges — is die-cut with the same
dark warm-brown outline and filled with one flat candy color. Panels are warm
cream, actions are saturated green/blue/red/yellow, and pressable things carry
a fake-3D bottom edge that begs to be squished. Think of a cheerful cereal-box
mascot aesthetic applied to a pet-collecting simulator. Adjectives: chunky,
bright, outlined, toy-like. Target genre: simulators and collect-a-thons where
players are children or play like them — everything readable at a glance,
nothing thin, nothing subtle.

## Colors

The world is bright sky blue, so UI chrome separates itself with warm cream
surfaces ({colors.surface}) and a single universal dark warm-brown outline
({colors.outline}) — the taste uses NO pure black anywhere; the darkest UI
color is that brown, and text on light surfaces is the same warm brown
({colors.on-surface}), never gray. White is used only for text on saturated
fills, always with a brown text stroke.

- {colors.primary} — the "yes, tap me" green. Every forward action (HATCH,
  CLAIM, BUY) uses it. It never labels anything informational.
- {colors.secondary} — friendly blue for neutral navigation (SHOP button,
  window header tab). Doubles as the RARE rarity accent.
- {colors.danger} — close buttons and notification badges only. Danger red
  and currency yellow never sit adjacent without an outline between them.
- {colors.surface} / {colors.surface-deep} — window panel fill and the inset
  content well inside it (one step darker/tanner, same warmth).
- {colors.surface-dark} — the one cool color in the chrome: deep plum for
  currency pills and other dark HUD chips, so counters pop against the sky.
- {colors.currency-soft} (coin yellow, also the side-button fill) and
  {colors.currency-hard} (gem violet) are the two currency identities.
- Rarity ladder observed: {colors.accent-rare} (blue) → {colors.accent-epic}
  (violet) → {colors.accent-legend} (orange), shown as ribbon pills on cards.
- {colors.dim} — a deep indigo (not black) backdrop behind windows; estimated
  ~70% opacity from comparing dimmed vs undimmed sky.

## Typography

One family carries the whole game: a rounded, chunky, single-weight cartoon
bold mapped to `FredokaOne` (Regular — boldness is baked in). That
single-family look is a deliberate taste feature. Everything the player can
tap or that names a thing is ALL CAPS.

- {typography.heading} (28px) — window header tabs ("PET SHOP").
- {typography.label} (24px) — button labels ("HATCH", "CLAIM", "BUY").
- {typography.body} (18px) — currency amounts and stat counters ("1.2M").
- {typography.caption} (14px) — card names, side-button labels, badge counts,
  rarity ribbons.
- display tier: not observed in these inputs — omitted rather than invented.

Text stroke convention: ALL white text carries {strokes.text-outline} (3px
Contextual brown). Dark text on cream (card names) is unstroked. Component
rules may use TextScaled inside fixed slots; the sizes above are the intended
size at the 1920x1080 reference and should anchor UITextSizeConstraint bounds.
Numbers abbreviate at 4+ digits ("1.2M"), keeping pills short.

## Layout

Spacing scale: {spacing.xs} 4 / {spacing.sm} 8 / {spacing.md} 12 /
{spacing.lg} 20 / {spacing.xl} 32. Observed anchors: sm = gap between stacked
side-buttons; md = card-grid cell gaps; lg = gaps between peer buttons;
xl = window inner inset from panel edge to the content well. (xs was not
directly observed; it is scale filler for hairline nudges — noted here
honestly.)

Delegate all positioning: UIListLayout for the side-button column and button
rows (Padding = {spacing.sm} or {spacing.lg}), UIGridLayout for card grids
(CellPadding = {spacing.md} both axes), UIPadding for window insets. Sizes are
Scale-first with UIAspectRatioConstraint; px offsets are reserved for strokes,
radii, and spacing tokens.

Safe areas: HUD roots use ScreenInsets = DeviceSafeInsets; the top strip is
reserved for the platform unibar (query GuiService:GetInsetArea(), read after
a Heartbeat). Reserved engine zones stay empty: bottom-left (virtual
joystick), bottom-right (jump). Tap targets: every pressable observed is well
above the 44px minimum (buttons 72px tall, close 52px+); never go below 44px.
Density is low: five persistent HUD elements total in the observed HUD.

## Elevation & Depth

Depth is drawn, not blurred — there are no soft drop shadows anywhere in the
observed shots; absence of drop shadows is part of the taste.

- Strokes: {strokes.outline} (4px Border, {colors.outline}) wraps every
  container — buttons, windows, cards, pills, close circles. Tiny elements
  (badges, rarity ribbons) step down to {strokes.outline-thin} (2px) so the
  outline doesn't swallow them. One stroke color everywhere is the signature.
- Bevels: pressables carry a `bevel(...)` — a bottom strip of the fill color
  darkened ~25-30% (6px on 72px buttons, 4-5px on smaller circles/squares).
  It reads as fake-3D "clickability". Flat panels (window, cards, pills) have
  NO bevel: if it doesn't press, it doesn't bevel.
- Dim: windows float over a {colors.dim} full-screen overlay (deep indigo,
  ~70% opaque) so the bright world stays faintly visible.
- Layering: ScreenGuis always set ZIndexBehavior = Sibling explicitly.
  DisplayOrder bands: HUD at 0, dim + window at 10, transient popups/toasts
  above that. The close button and header tab overlap the window's outer
  edge, so windows must NOT ClipsDescendants at the root.

## Shapes

Everything is rounded; there are no sharp corners in the taste.

- {rounded.md} (14px) — action buttons, grid cards, the window-header tab.
- {rounded.lg} (22px) — window panels, the inset content well, side-buttons
  (which read as squircles at 72px).
- {rounded.full} — pills and circles: currency bars, rarity ribbons, close
  buttons, icon disks, notification badges.

Silhouette rules: rectangular things are rounded-rects (md for small, lg for
large); anything that holds a single count or a single glyph is a pill or a
circle. No observed use of a small 6-8px radius step, so none is defined.

## Motion

No video input was provided, so this section ships the cartoon-chunky taste
preset (confidence: low) — durations/easings in front matter are defaults,
not observations. The stills support the family choice: chunky bevels and
sticker outlines pair with snappy, bouncy motion.

- Entrances: windows scale 0.8 → 1.0 with `pop` (Back Out) over `normal`;
  the dim fades in over `fast` simultaneously.
- Exits: faster than entrances — scale down with `exit` (Quad In) over
  `fast`; never make the player wait to leave a screen.
- Press feedback: buttons squash to ~0.92 scale over `instant` and collapse
  their bevel (see button-primary-pressed), springing back with `settle`.
- Rewards/currency: count-up numbers over `slow`; `bounce` (Elastic Out) is
  reserved for reward moments only — never for navigation.
- Reduced-motion stance: all motion is decorative; every transition must
  remain functional if tweens are skipped (state changes apply instantly).

## Components

- **button-primary** — the green CTA. Cream-white label in {typography.label}
  caps with text stroke, md corners, 4px outline, 6px darker-green bevel.
  Feels like a rubber toy button you push down. Pressed (inferred, not
  observed): bevel collapses to none and the button shifts down its height.
- **button-secondary** — identical anatomy in {colors.secondary} blue with a
  darker-blue bevel; used for navigation ("SHOP") next to a primary action.
- **button-close** — red circle with a white stroked X, straddling the
  window's top-right corner from OUTSIDE the panel edge. Feels like a
  cartoon "nope" sticker.
- **side-button** — 72px yellow squircle, lg corners: colored icon disk in
  the middle, tiny caption label hugging the bottom edge inside the outline,
  optional badge-notification on the top-right corner. Stacks vertically on
  the left screen edge.
- **currency-bar** — dark plum pill: currency icon disk flush left, white
  stroked amount, and a small green "+" circle flush right (the buy hook).
  Two pills stack at top-right, one per currency.
- **window** — cream lg-rounded panel, 4px outline, no drop shadow, centered
  over the dim. Anatomy top-to-bottom: header tab overlapping the top edge,
  a {colors.surface-deep} inset well holding content, a centered green
  footer CTA. Close button rides the top-right corner.
- **window-header** — blue md-rounded tab, centered, overlapping the
  window's top edge like a label on a jar; {typography.heading} caps with
  text stroke.
- **dim-overlay** — {colors.dim} full-screen frame behind any window; blocks
  input to the HUD.
- **card-grid** — cream cards (md corners, 4px outline) on the surface-deep
  well; item art disk centered, caption name in {colors.on-surface} at the
  bottom, and for rare+ items a rounded rarity ribbon pill in the tier accent
  overlapping the card's top edge. No selected state was observed; the
  ribbons are rarity styling, not selection.
- **badge-notification** — small red circle with white count ("3", "99+"),
  thin outline, straddling the parent's top-right corner.
- progress-bar, tooltip, button-icon beyond the side-button: never observed —
  intentionally undefined so implementers fall back to taste defaults
  knowingly.

## Screen Patterns

**HUD (from shot-1):** top-right holds the currency pill stack (soft above
hard). Left edge, vertically centered: the side-button column (SHOP / PETS /
GIFTS) with badges. Bottom-center: the single big primary CTA (HATCH).
Bottom-left and bottom-right corners stay empty for the joystick and jump
button; the top strip stays clear of the unibar. Information density is low —
five persistent elements — and nothing competes with the world's center.

**Shop window (from shot-2):** centered panel roughly a third of the screen
wide; header tab centered on the top edge; close outside the top-right
corner; content is a 3-column card grid inside an inset well; footer is one
centered primary CTA (BUY). One window at a time over one dim layer.

Settings, inventory-as-fullscreen, and reward popups were not observed; no
conventions are claimed for them.

## Do's and Don'ts

- Never use thin 1px strokes — this taste reads them as unfinished. Container
  outlines are 4px; even badges get 2px.
- Never use pure black or pure gray: darks are warm brown ({colors.outline})
  or deep plum ({colors.surface-dark}); body text is brown, not #000000.
- Never put a bevel on a non-pressable surface, and never ship a pressable
  without one — the bevel IS the affordance.
- Don't use drop shadows or blurs; depth comes from outlines, bevels, and the
  dim layer only.
- Don't mix families or weights: one chunky font, caps for anything tappable.
- White text without its 3px brown text stroke is a bug, not a variant.
- Never require a -hover variant for usability; most sessions are touch.
  Press feedback carries the interaction feel.
- Don't let green mean anything but "advance/confirm", or red anything but
  "close/destructive/alert". Blue is the neutral workhorse.
- Don't hardcode the topbar inset; query GuiService:GetInsetArea() after a
  Heartbeat.

## Agent Prompt Guide

Cheat sheet:

- Palette: primary #5BC13D, secondary #4D9EE8, danger #E8483E, surface
  #FAF1D8, outline #46351F, dim #2B1A5EB3. One outline color everywhere.
- Font: FredokaOne Regular everywhere; caps for labels; 3px brown text
  stroke on all white text.
- Shape: md 14px buttons/cards, lg 22px windows, pills/circles for counters.
- Depth: 4px outline + bevel on pressables; no drop shadows; indigo dim.
- Motion: Back Out entrances 0.25s, Quad In exits 0.15s, squash on press.
- Layout: UIListLayout/UIGridLayout + UIPadding only; Scale-first sizes with
  UIAspectRatioConstraint; 44px minimum tap targets.

Canned prompts:

1. "Build a settings window in the Sticker Toybox taste: cream lg-rounded
   panel over the indigo dim, blue header tab overlapping the top edge
   reading SETTINGS, red close circle straddling the top-right corner,
   rows of 72px-tall toggle buttons in the content well, all outlined 4px."
2. "Add a QUESTS side-button to the left column: 72px yellow squircle,
   lg corners, icon disk centered, QUESTS caption at the bottom, red 2px-
   outlined badge with the open-quest count on the top-right corner."
3. "Implement the press feel for button-primary: squash to 0.92 scale over
   0.08s, collapse the 6px bevel so the face drops flush, then settle back
   with Quad Out over 0.15s on release."

---

Independent analysis of publicly observable UI conventions, provided as-is
for inspiration. Not affiliated with or endorsed by any game or studio.
