---
version: alpha
name: Cartoon Chunky
description: >
  Bright, toy-like UI for pet-collecting and clicker simulators. Everything is
  thick, outlined, and bouncy: buttons look like candy you can press, numbers
  celebrate you, and nothing on screen is thin, gray, or quiet.
taste: [cartoon-chunky, playful, juicy]
genre: [simulator, pet-collector, clicker]
inspiration: "Pet Simulator-class collectors (genre-wide exemplar, no single title)"

colors:
  primary: "#5FCB3F"          # CTA green — buy, claim, hatch. The "yes" color.
  secondary: "#4FA8F5"        # friendly blue — navigation, neutral actions
  danger: "#F24E4E"           # close buttons, delete, warnings
  surface: "#FFF7E0"          # warm cream panel background, never pure white
  surface-deep: "#F5E3B8"     # inset areas inside windows (list wells, slots)
  on-surface: "#5C3A0E"       # warm dark brown text — never pure black
  currency-soft: "#FFD84D"    # coins/gold
  currency-hard: "#B96BF5"    # gems/premium
  accent-rare: "#FF8A3D"      # rarity highlights, "NEW!" flashes
  outline: "#4A2E14"          # the universal sticker-outline dark brown
  dim: "#26195Caa"            # purple-navy dim behind popups (alpha = 33% opaque)

typography:
  display:
    fontFamily: FredokaOne
    fontWeight: Regular       # FredokaOne is single-weight; its boldness is baked in
    textSize: 42px
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
  outline:       { thickness: 3px, color: "{colors.outline}", mode: Border }
  outline-heavy: { thickness: 5px, color: "{colors.outline}", mode: Border }
  text-outline:  { thickness: 2px, color: "{colors.outline}", mode: Contextual }
  text-outline-display: { thickness: 3px, color: "{colors.outline}", mode: Contextual }

motion:
  durations: { instant: 0.08s, fast: 0.15s, normal: 0.25s, slow: 0.4s }
  easings:
    pop:    { style: Back, direction: Out }    # entrances — overshoot is the taste
    settle: { style: Quad, direction: Out }    # value changes, bar fills
    exit:   { style: Quad, direction: In }     # dismissals — leave faster than you arrived
    bounce: { style: Elastic, direction: Out } # rewards only; use sparingly

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(5px #3E8A28)"
    aspectRatio: 3.2
  button-primary-pressed:
    shadow: none
  button-primary-disabled:
    backgroundColor: "#9DB596"
    shadow: "bevel(5px #75886F)"
  button-secondary:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(5px #2F79BE)"
    aspectRatio: 3.2
  button-close:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
    shadow: "bevel(4px #B23030)"
    aspectRatio: 1
  button-icon:
    backgroundColor: "{colors.secondary}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    shadow: "bevel(4px #2F79BE)"
    aspectRatio: 1
  currency-bar:
    backgroundColor: "#3A2A5E"
    textColor: "#FFFFFF"
    typography: "{typography.body}"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    height: 44px
  side-button:
    backgroundColor: "{colors.currency-soft}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline}"
    shadow: "bevel(4px #C9A22E)"
    aspectRatio: 1
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
    backgroundColor: "#FFEFC2"
  progress-bar:
    backgroundColor: "#3A2A5E"
    gradient: "vertical(#7CE85A, #4CB82E)"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
    height: 26px
  badge-notification:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.full}"
    stroke: "{strokes.outline}"
  tooltip:
    backgroundColor: "#2C1F52"
    textColor: "#FFFFFF"
    typography: "{typography.caption}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
---

# Cartoon Chunky

## Overview

Cartoon Chunky is the taste of pet-collecting and clicker simulators: a toy
store shelf, not an app. Think of a claw machine at a family arcade — saturated
plastic colors, thick dark outlines around every shape like stickers, buttons
that look physically pressable because they have a visible bottom edge, and a
UI that celebrates the player constantly.

One concrete reference: **a vending machine full of capsule toys**. Every
element is a capsule — self-contained, outlined, glossy, slightly oversized.
Nothing shares an edge with anything else; everything floats with confident
spacing on top of the game world.

Three rules of thumb that define the taste:

1. **If it matters, it's outlined.** Every container, button, and piece of
   text sitting on the world gets the dark-brown outline. The outline is the
   brand.
2. **Chunky beats elegant.** When in doubt, make it 20% bigger, rounder, and
   louder. Thin lines, small text, and subtle grays read as *broken* in this
   taste.
3. **The UI is a hype man.** Numbers count up, rewards overshoot on entry,
   buttons squash when pressed. Static is the enemy.

## Colors

The palette is warm cream surfaces with saturated candy accents on a
purple-navy world backdrop.

- `{colors.primary}` (green) is exclusively for **forward actions**: buy,
  claim, hatch, equip. A screen should have at most one dominant primary
  button visible per region.
- `{colors.secondary}` (blue) handles navigation and neutral actions — tab
  switches, "info", toggles. It must never be used for anything destructive.
- `{colors.danger}` (red) means close, delete, or "you can't afford this". The
  close button is always this red; players locate it by color before shape.
- `{colors.surface}` (cream) is the panel base. **Never pure white** — white
  reads clinical and kills the toy warmth. Inset wells inside a window use
  `{colors.surface-deep}` to create depth without shadows.
- `{colors.on-surface}` (warm brown) is the only body text color on surfaces.
  **Never pure black** — same reason as white.
- Currencies are sacred: `{colors.currency-soft}` yellow-gold for coins,
  `{colors.currency-hard}` purple for gems. These two colors must not be used
  for unrelated decoration, or players will misread affordances.
- `{colors.accent-rare}` orange marks rarity and newness ("NEW!", legendary
  glow). It is a spice, not a base — under 5% of any screen.
- `{colors.dim}` is the popup backdrop: purple-navy at ~33% opacity, tinting
  the world rather than blacking it out. Black dims feel like an error state.

## Typography

One family, sized loudly: `FredokaOne` everywhere. The hierarchy is built on
size and outline weight, not on weight or family changes — this is what makes
the taste read as "toy", and it conveniently sidesteps mixed-font layout bugs.

- `{typography.display}` — reward reveals, hatch results, big numbers.
  Always with `{strokes.text-outline-display}`.
- `{typography.heading}` — window headers, uppercase.
- `{typography.label}` — button labels, uppercase.
- `{typography.body}` — descriptions, stat lines. The only tier that may skip
  the text outline when sitting on `{colors.surface}`.
- `{typography.caption}` — badges, counters, tooltips.

Text stroke convention: **any text over the game world or over an image gets
`{strokes.text-outline}`**; text on plain surfaces may omit it except display
tier, which is always outlined. Buttons use white text with outline regardless
of background — contrast comes from the outline, not the fill.

TextScaled policy: buttons and headers use `TextScaled` (with the token size
as the intended size at reference resolution, upper-bounded via
`UITextSizeConstraint`); body/caption text uses fixed `textSize`.

## Layout

Density is low and confident: few, large elements. If a screen needs more than
~7 interactive elements visible at once, split it into tabs.

- Spacing scale: `{spacing.md}` (12px) is the default gap between siblings in
  a list or grid; `{spacing.lg}` between groups; `{spacing.xl}` window inner
  padding (via UIPadding). `{spacing.xs}` exists only for icon-to-label gaps.
- All repeating content is laid out by `UIListLayout`/`UIGridLayout` with the
  spacing tokens as `Padding`/`CellPadding` — the taste has zero tolerance for
  eyeballed manual positions because misalignment breaks the toy illusion.
- Sizes are Scale-first with `UIAspectRatioConstraint` locking element shapes
  (see component `aspectRatio` tokens). Offsets appear only in spacing and
  stroke thickness.
- Safe areas: HUD roots use `ScreenGui.ScreenInsets = DeviceSafeInsets`; never
  hardcode the topbar height (58px desktop / ~52px mobile currently — query
  `GuiService:GetInsetArea()`).
- Tap targets: 44px minimum at reference; side buttons and close buttons
  target 56px+. This taste's chunkiness makes generous targets free.

## Elevation & Depth

Depth is drawn, not blurred. Three tools, in order of importance:

1. **Outlines** — `{strokes.outline}` (3px) on every element;
   `{strokes.outline-heavy}` (5px) on windows and selected states. Stroke
   thickness IS the elevation cue: heavier outline = closer to the player.
2. **Bevels** — the signature fake-3D bottom edge on buttons
   (`shadow: bevel(...)` tokens, colored as a darkened fill color). Pressing a
   button removes the bevel and nudges the content down — that's the press
   feedback (see Motion).
3. **Drop shadows** — only windows get one (`drop(0px 8px #00000040)`),
   implemented as a 9-slice image behind the frame. Never stack drop shadows
   on small elements.

Popup layering: `dim-overlay` → window → floating rewards/tooltips. Reserve
`DisplayOrder` bands per ScreenGui: HUD 0–9, windows 10–19, popups/toasts
20–29, tooltips 30+.

## Shapes

Round is the default; sharp corners do not exist in this taste.

- `{rounded.md}` (16px) — buttons, cards, inputs.
- `{rounded.lg}` (24px) — windows and side buttons.
- `{rounded.sm}` (10px) — small inset elements (tooltips, list wells).
- `{rounded.full}` — pills (currency bars, progress bars) and circles (close
  buttons, badges). A circle is a pill with `aspectRatio: 1`.

Silhouette rules: windows are rounded rectangles wider than tall; buttons are
capsule-adjacent rectangles; anything countable (badges) is a circle. Decorative
rotation (a card tilted 2–3°) is welcome on reward reveals, never on
interactive elements.

## Motion

Motion is the "juice" layer: fast, bouncy, and always asymmetric (enter with
personality, leave quickly).

- **Entrances** (`{motion.easings.pop}`, `{motion.durations.normal}`): windows
  and popups scale from 0.8 → 1.0 with Back-Out overshoot. Never fade-only —
  fades read as web, not toy.
- **Exits** (`{motion.easings.exit}`, `{motion.durations.fast}`): scale to 0.9
  + fade. Exits must be faster than entrances; lingering UI feels sticky.
- **Press feedback** (`{motion.durations.instant}`): buttons squash to 0.92
  scale and lose their bevel while held, restore with `{motion.easings.settle}`
  on release. This is mandatory on every button — it is the single highest
  value juice in the taste.
- **Value changes** (`{motion.easings.settle}`, `{motion.durations.slow}`):
  currency counts tween numerically (count-up), progress bars fill smoothly.
  Currency gains also fly a coin icon from the source to the currency bar.
- **Rewards** (`{motion.easings.bounce}`): reserved for hatch/reward reveals —
  scale in with Elastic-Out at `{motion.durations.slow}`. Using bounce on
  ordinary UI cheapens rewards.
- Respect reduced motion if the game offers such a setting: swap pop/bounce
  for settle, keep durations.

Defaults provenance: these values are the taste-family defaults; when a
reference video is provided, extraction re-buckets durations and easing
families but should keep the asymmetry rules above.

## Components

- **button-primary** — the "yes" button. Green fill, white outlined uppercase
  label, 5px bevel. One dominant instance per screen region. Disabled state
  desaturates fill AND bevel (never remove the bevel while disabled — that
  reads as pressed).
- **button-secondary** — blue sibling for navigation/neutral choices. Same
  anatomy as primary; never larger than the primary it accompanies.
- **button-close** — red circle with a white ✕ glyph, top-right of every
  window, oversized (56px+ target). Players find it by color+position; do not
  move it, restyle it, or replace ✕ with other glyphs.
- **button-icon** — square blue capsule for toolbars inside windows (sort,
  filter, info). Icon-only, with tooltip on desktop hover.
- **currency-bar** — dark navy pill anchored top-right: coin icon (left,
  slightly overflowing the pill top), white outlined amount, and a green `+`
  buy button flush right. One pill per currency, stacked vertically with
  `{spacing.sm}`. Amounts abbreviate at 5 digits (12.4K, 1.2M).
- **side-button** — the yellow square launchers stacked on the left edge
  (Shop, Pets, Rewards...). Icon on top, tiny caption under it,
  `badge-notification` pinned to the top-right corner when there is something
  to claim.
- **window / window-header** — cream rounded panel with heavy outline and a
  blue header band containing the uppercase title; header sits proud of the
  window top edge (overlapping ~40%), like a label on a toy box. Close button
  overlaps the top-right corner.
- **dim-overlay** — purple-navy tint behind any window; clicking/tapping it
  closes dismissible windows.
- **card-grid** — square inset cards for pets/items on `surface-deep` wells.
  Rarity is shown by an inner gradient or corner ribbon in `accent-rare` (or
  rarity-specific hues), never by changing the card's outline color. Selected
  state upgrades to heavy outline + lighter fill.
- **progress-bar** — pill with green vertical-gradient fill over navy track;
  percentage or fraction label centered, white with text outline. Fills
  animate with `settle`; never snap.
- **badge-notification** — red circle counter, white outlined number. Cap
  display at "99+".
- **tooltip** — dark navy rounded rectangle, caption text, appears above the
  element after 0.4s hover (desktop only). Touch UIs must not depend on it.

## Screen Patterns

- **HUD**: side-buttons column on the left edge (vertically centered, out of
  the joystick zone), currency pills top-right under the safe-area inset,
  primary contextual action (e.g. "HATCH") bottom-center, lifted clear of the
  jump zone. Keep bottom-left (virtual joystick) and bottom-right (jump
  button) clear. Maximum ~8 persistent HUD elements; everything else lives behind
  side buttons.
- **Shop**: full window with left category rail (button-icon column), content
  grid of card-grid items, price on `button-primary` per card (icon + amount).
  Featured/limited items get an `accent-rare` ribbon and a slot at the top.
- **Gacha / egg screen**: dim overlay + centered egg/capsule display with the
  cost pill directly beneath and two primaries side by side ("HATCH 1" /
  "HATCH 3"). Reveal sequence uses the reward motion pattern with rarity color
  burst.
- **Inventory**: window with search/sort toolbar (button-icon row), card
  grid in a `surface-deep` well (5–6 columns desktop, 3–4 phone landscape),
  selection opens a detail side panel (desktop) or bottom sheet (phone) with
  equip/delete actions — delete always `danger` and never adjacent to equip.
- **Settings**: single-column list rows on surface; each row = label left,
  chunky toggle/slider right. Toggles are outlined pills with the knob
  carrying the bevel.
- **Reward popup**: dim → display-tier headline ("LEVEL UP!") → reward cards
  pop in sequentially (80ms stagger) → single primary "CLAIM". Auto-dismiss is
  forbidden; celebrating is the point.

## Do's and Don'ts

**Do:**
- Outline every element that sits on the game world.
- Keep one dominant green primary per screen region.
- Animate every press (squash + bevel collapse) — no dead buttons.
- Use count-up tweens for any number the player earned.
- Oversize touch targets; this taste has no small buttons.

**Don't:**
- Never use thin (1px) strokes anywhere — they read as unfinished.
- Never use pure black or pure white; use `{colors.outline}` browns and
  `{colors.surface}` cream.
- Never fade-only an entrance; popups must scale with overshoot.
- Never use `{colors.currency-soft}`/`{colors.currency-hard}` for
  non-currency decoration.
- Never rely on hover for meaning — most players are on touch.
- Never use drop shadows on small elements or stack them; bevels carry depth.
- Never put text on the world without a text outline.

## Agent Prompt Guide

Quick reference for implementing agents:

- Fill = token color; every container gets `UIStroke` (3px `#4A2E14`, 5px for
  windows/selected). Corners: buttons 16px, windows 24px, pills/circles full.
- Font: `Font.fromName("FredokaOne")` for everything; buttons/headers
  uppercase + `TextScaled`; white button text with 2px contextual stroke.
- Buttons have a bevel (darkened bottom edge ~5px) that collapses while
  pressed, plus a 0.92 squash at 0.08s. Entrances: scale 0.8→1.0, Back-Out,
  0.25s. Exits: 0.15s, Quad-In, scale+fade.
- Layout: UIListLayout/UIGridLayout only, 12px default gaps, Scale+aspect
  sizing, DeviceSafeInsets, 44px+ tap targets, joystick/jump zones clear.

Canned prompts:

1. *"Using DESIGN.roblox.md (Cartoon Chunky), build the HUD: left side-button
   column (Shop, Pets, Rewards), top-right coin and gem currency pills, and a
   bottom-center HATCH primary button. react-lua, Scale-first, safe areas
   respected."*
2. *"Using DESIGN.roblox.md (Cartoon Chunky), build the Shop window: header
   'SHOP', close button, left category rail, 4×N grid of item cards with
   price buttons. Include pressed/disabled button states and entrance/exit
   motion per the Motion section."*
3. *"Review this screenshot of my implementation against DESIGN.roblox.md
   (Cartoon Chunky) and list every deviation from the Do's and Don'ts and
   Components sections, ordered by visual impact."*

---

*Independent analysis of publicly observable UI conventions in the Pet Simulator-class pet-collector genre (this entry is a hand-written genre exemplar, not extracted from any single title), provided as-is for inspiration. Not affiliated with or endorsed by any game or studio. Rights holders may request changes or removal at any time.*
