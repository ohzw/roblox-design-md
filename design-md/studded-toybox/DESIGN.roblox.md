---
version: alpha
name: Studded Toybox
description: >
  Toy-brick UI where every surface carries a studded block emboss: windows are
  edge-to-edge gradient header bars with a squared red close slab over one big
  self-dimming dark well, buttons are squared two-tone gradient slabs, and all
  text is white with a heavy near-black outline.
taste: [studded-toybox, toy-brick, loud, juicy]
genre: [survival, collector, casual]

colors:
  primary: "#0BD520"          # CTA green — Enter/Spin/Equip family (mid of its gradient)
  secondary: "#02B9F2"        # robux-purchase cyan — "Buy 1" tier and utility CTAs
  danger: "#E13B38"           # the squared close slab; red is close-only
  surface: "#0DA21F"          # theme-tinted studded chrome (green-zone variant observed)
  surface-deep: "#111111B3"   # the big semi-transparent content well (~70% opaque)
  on-surface: "#FFFFFF"       # all UI text is white
  currency-soft: "#FFD902"    # gold offer/token banner fill
  currency-hard: "#A93FE6"    # premium price pill purple (mid of its gradient)
  accent-rare: "#AA42BB"      # event/offer magenta panels and "Buy 5" tier
  outline: "#0A0A0F"          # near-black ink for text outlines, well and chip borders

typography:
  display:
    fontFamily: FredokaOne
    fontWeight: Regular       # single-weight family; boldness is baked in
    textSize: 46px
  heading:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 40px
  body:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 22px
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 28px
  caption:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 18px

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px, xl: 32px }

rounded: { sm: 6px, md: 10px, lg: 14px }

strokes:
  outline:              { thickness: 2px, color: "{colors.outline}", mode: Border }
  outline-heavy:        { thickness: 4px, color: "{colors.outline}", mode: Border }
  rim-light:            { thickness: 2px, color: "#A8A8A8", mode: Border }
  text-outline:         { thickness: 2px, color: "{colors.outline}", mode: Contextual }
  text-outline-display: { thickness: 3px, color: "{colors.outline}", mode: Contextual }

motion:
  durations: { instant: 0.08s, fast: 0.15s, normal: 0.25s, slow: 0.4s }
  easings:
    pop:    { style: Back, direction: Out }
    settle: { style: Quad, direction: Out }
    exit:   { style: Quad, direction: In }
    bounce: { style: Elastic, direction: Out }

components:
  window:
    backgroundColor: "{colors.surface-deep}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline-heavy}"
    shadow: none
  window-header:
    gradient: "vertical(#67E1F7, #306FF2)"
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"
    textStroke: "{strokes.text-outline}"
    stroke: "{strokes.outline}"
    height: 84px
  button-close:
    backgroundColor: "{colors.danger}"
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    aspectRatio: 1.1
  button-primary:
    gradient: "vertical(#02ED25, #0CB51C)"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    shadow: none
    aspectRatio: 4.4
  button-secondary:
    gradient: "vertical(#02D6FC, #0195E7)"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.rim-light}"
    aspectRatio: 4.4
  button-buy:
    gradient: "vertical(#C658F1, #792BD9)"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    aspectRatio: 3.4
  banner-offer:
    gradient: "vertical(#FFE202, #FEA800)"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    height: 64px
  currency-bar:
    transparency: 1
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    textStroke: "{strokes.text-outline}"
    height: 44px
  side-button:
    backgroundColor: "#1A1A1A80"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    aspectRatio: 1.1
  card-grid:
    backgroundColor: "#00000066"
    rounded: "{rounded.sm}"
    stroke: "{strokes.outline}"
    aspectRatio: 1
  badge-slot:
    backgroundColor: "#00000099"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"

extraction:
  inputs:
    - id: shot-1
      kind: screenshot
      describes: "Full 1920x1080 HUD during gameplay with a spin-wheel overlay open: left launcher rail, bottom-left currency stack, bottom-center hotbar, bottom purchase row"
    - id: shot-2
      kind: screenshot
      describes: "Large item-purchase window (token spender), crop: gradient header bar, currency chip, close slab, two-column rows with price pills, watermark title"
    - id: shot-3
      kind: screenshot
      describes: "Collection index window, crop: lime gradient header, silhouette card grid, footer banner strip"
    - id: shot-4
      kind: screenshot
      describes: "Player-booth listing window, crop: green header with right-aligned notice, search field row with square icon buttons, add-listing card"
    - id: shot-5
      kind: screenshot
      describes: "Text-input dialog, crop: header with checkmark icon, inset input well, centered green Enter slab"
    - id: shot-6
      kind: screenshot
      describes: "Themed spin-wheel overlay (gold/green event recolor) with bottom purchase row"
    - id: shot-7
      kind: screenshot
      describes: "Themed spin-wheel overlay (pink event recolor) with purple purchase pills"
    - id: shot-8
      kind: screenshot
      describes: "Promotional offer row inside a store window: magenta gradient panel, corner tag, robux price bar, gift square"
    - id: shot-9
      kind: screenshot
      describes: "Cosmetic list row: item render left, name and description, oversized lime-to-green Equip slab right"
    - id: shot-10
      kind: screenshot
      describes: "Vertical token-purchase stack: three gold gradient banner buttons with icon chip, amount, robux price"
    - id: shot-11
      kind: screenshot
      describes: "Gold event banner button with icon and red sub-caption"
    - id: shot-12
      kind: screenshot
      describes: "Marketing thumbnails and world screenshots (used only to confirm genre and world palette, not for UI tokens)"
  confidence:
    Colors: high
    Typography: medium
    Layout: medium
    "Elevation & Depth": medium
    Shapes: high
    Motion: low
    Components: medium
    "Screen Patterns": medium
  notes: >
    shot-1 is native 1920x1080 and anchors all px tokens; window crops
    (shot-2..shot-5) were scale-calibrated against it via the close slab and
    text-outline weights — shot-2 is roughly a 2x-scale crop and was measured
    through that factor, so its px values carry a constant-factor caveat.
    Font family judged from letterform shape (rounded chunky single-weight
    cartoon bold -> FredokaOne; runner-up Montserrat ExtraBold). No video
    input: motion block is the cartoon-chunky taste-family preset. No
    pressed/disabled/selected states observed; none are defined. No progress
    bar, tooltip, or settings screen observed; those components/patterns are
    omitted. No separate dim overlay observed — windows self-dim via their
    translucent well; the dim token is intentionally absent. Several sourced
    images were rejected as non-UI (3D booth renders, world-only shots, a
    platform disconnect dialog).
---

# Studded Toybox

## Overview

Studded Toybox is the taste of loud, meme-flavored survival collectors: the
whole game — world and UI alike — looks molded from plastic building bricks,
and the interface keeps the joke going. Every fill, from window chrome to
buttons to the ground itself, carries a repeating rounded-square **stud
emboss**, like the top of a toy brick. One concrete reference: **a bin of
plastic interlocking bricks dumped on a carnival midway** — saturated molded
colors, everything squared-off and modular, prize banners shouting over it.

What makes it feel right:

1. **Studs everywhere.** The block emboss is the brand. A flat, untextured
   fill reads as foreign in this taste.
2. **Slabs, not pills.** Silhouettes are squared with small corner radii.
   There are no capsule buttons, no circles; even the close button is a
   rectangular slab.
3. **Ink-outlined white type.** Every piece of text, on every background, is
   white with a heavy near-black outline. Contrast never comes from the fill.
4. **Theme recoloring is a feature.** The same window and button anatomy is
   wholesale recolored per zone or event (blue, lime, pink, gold variants
   observed). Structure stays identical; hue is a parameter.

## Colors

Molded-plastic saturation over a dark, self-dimming well.

- `{colors.primary}` (bright green) is the forward-action color: confirm,
  equip, spin. Observed as a vertical two-tone gradient (see
  `button-primary`); the token is its midpoint. An oversized variant shifts
  lime at the top (`#E3FC00` → `#60D500` on a full-width Equip slab).
- `{colors.secondary}` (cyan) handles robux-priced utility purchases ("Buy 1"
  tier, listing actions). Its bigger sibling tier uses `{colors.accent-rare}`
  magenta ("Buy 5") — purchase tiers escalate cyan → magenta.
- `{colors.danger}` (red) is reserved for the close slab and warning
  sub-captions. It never fills a purchase button.
- `{colors.surface}` is the studded chrome around windows — but it is
  **theme-tinted**: green in the observed zone, blue/pink/gold in event
  recolors. Treat the hex as one observed variant, not a constant.
- `{colors.surface-deep}` is the taste's real constant: one large
  semi-transparent near-black well (~70% opaque) that holds all window
  content and dims the world behind it.
- `{colors.on-surface}` white is the only text color; hierarchy comes from
  size and outline weight.
- `{colors.currency-soft}` gold fills offer/token banners; the premium price
  pill uses `{colors.currency-hard}` purple. Keep both off decoration.
- `{colors.outline}` near-black ink borders wells, chips, and all text. The
  window chrome border can shift toward the theme hue (a navy `#0D2165` was
  observed on a blue window); the ink stays near-black on inner elements.

## Typography

One family everywhere: `FredokaOne` (rounded, chunky, single-weight cartoon
bold — judged from letterforms; Montserrat ExtraBold was the runner-up). The
hierarchy is size plus outline weight, never family or weight changes.

- `{typography.display}` — spin-wheel titles and floating world headlines,
  with `{strokes.text-outline-display}`.
- `{typography.heading}` — window header titles and the close glyph.
  Title-case, never all-caps.
- `{typography.label}` — button labels and price amounts.
- `{typography.body}` — row descriptions ("Double speed, nonstop spawns…").
  Even body text keeps its outline: it usually sits on the translucent well
  with the world showing through.
- `{typography.caption}` — sub-captions under prices ("Buy 1"), status lines,
  slot tags.

Text stroke convention: **all text is outlined, everywhere** — there is no
observed un-outlined tier. TextScaled policy: headers, buttons, and prices
use `TextScaled` with the token as intended size at reference (bounded by
`UITextSizeConstraint`); multi-line body copy uses fixed `textSize`.

## Layout

Density is mid-high: windows pack two-column row grids and full HUD rails,
but every element is large and outlined, so nothing reads cramped.

- `{spacing.md}` (12px) is the default sibling gap in rows and grids
  (`UIListLayout.Padding` / `UIGridLayout.CellPadding`); `{spacing.lg}`
  (20px) is window inner padding via `UIPadding`; `{spacing.sm}` separates an
  icon from its label; `{spacing.xl}` separates the header band from content
  groups in tall windows.
- Windows are wide: the observed purchase window spans roughly 85% of screen
  width with a two-column row grid. Rows are icon-tile left, text block
  center, price pill right/below.
- Sizes are Scale-first with `UIAspectRatioConstraint` (see component
  `aspectRatio` tokens); offsets are reserved for strokes and spacing.
- Safe areas: HUD roots use `ScreenGui.ScreenInsets = DeviceSafeInsets`; the
  observed HUD keeps its launcher rail below the platform top strip and its
  currency stack above the bottom edge. Never hardcode the topbar inset —
  query `GuiService:GetInsetArea()`.
- Tap targets: 44px minimum; observed buttons run 58–84px tall. The taste has
  no small touchables.

## Elevation & Depth

Depth is drawn with ink, texture, and self-dimming — there are no drop
shadows and no bevels anywhere.

1. **Ink borders**: `{strokes.outline}` (2px) on wells, cards, chips, and
   price pills; `{strokes.outline-heavy}` (4px) around window chrome.
   Gradient slab buttons on dark backgrounds instead take
   `{strokes.rim-light}` — a light gray rim that reads as molded plastic
   edge highlight.
2. **Stud emboss**: every opaque fill carries the repeating rounded-square
   stud pattern (~24px cell at reference) at low contrast — implement as a
   tiled ImageLabel over the fill at high transparency. This texture, not
   shadow, is what separates surfaces.
3. **Self-dimming well**: windows do not use a separate dim layer. The
   content well itself is `{colors.surface-deep}` (~70% opaque near-black),
   dimming the world behind the window. Spin-wheel overlays skip the panel
   entirely and rely on a radial glow around the wheel.
4. **Watermark echo**: the window title repeats as a huge, very transparent
   ghost headline behind the content rows — a signature depth cue.

Layering plan (ScreenGuis with `ZIndexBehavior = Sibling`): HUD DisplayOrder
0–9, windows 10–19, spin/reward overlays 20–29, toasts 30+.

## Shapes

Squared and modular, like brick studs themselves.

- `{rounded.sm}` (6px) — buttons, close slab, cards, wells, icon tiles. The
  workhorse radius; most of the UI uses it.
- `{rounded.md}` (10px) — window frames and price pills.
- `{rounded.lg}` (14px) — oversized CTA slabs (the full-width Equip variant).
- There is **no pill/circle step**: no capsule was observed anywhere. A
  circle or pill silhouette breaks the taste.

Silhouette rules: windows are wide rounded-corner slabs with the header as an
integrated top band; buttons are landscape slabs (aspect ~3–4.5:1); icon
tiles and grid cards are squares. The only round thing on screen is the spin
wheel itself, which is content, not chrome.

## Motion

No video input was available: the values in `motion` are the
cartoon-chunky taste-family preset (confidence: low), with prose patterns
inferred from stills.

- **Entrances** (`{motion.easings.pop}`, `{motion.durations.normal}`):
  windows scale 0.85 → 1.0 with Back-Out. The oversized glowing spin wheel
  and radial-burst offer art imply an overshoot-happy, juicy register —
  inferred, not observed.
- **Exits** (`{motion.easings.exit}`, `{motion.durations.fast}`): scale to
  0.9 plus fade; leave faster than you arrive.
- **Press feedback** (`{motion.durations.instant}`): squash slabs to 0.94
  scale while held; restore with `{motion.easings.settle}`. There is no bevel
  to collapse, so the squash carries all the feedback.
- **Value changes** (`{motion.easings.settle}`, `{motion.durations.slow}`):
  the HUD shows abbreviated earning counters ("2.58 T", a floating "M/s"
  rate) — count-up tweens for any earned number.
- **Rewards** (`{motion.easings.bounce}`, `{motion.durations.slow}`):
  reserved for spin results and rare drops.
- Reduced motion: swap pop/bounce for settle; keep durations.

## Components

- **window / window-header** — the core grammar. The header is an
  **edge-to-edge integrated band** (~84px tall) across the full window top:
  a themed vertical gradient (brightest at top), stud emboss, an icon at the
  far left, the left-aligned title in `{typography.heading}` white with ink
  outline, and optionally a white counter chip toward the right. The close
  slab occupies the header's right end. Below, the body is one large
  `{colors.surface-deep}` well with the watermark title echo behind content.
  A 4px border wraps the whole window; corners resolve at `{rounded.md}`,
  flat (no bevel). Layer stack: world → self-dimming well → chrome →
  content. Feel: a molded toy chest with a printed nameplate.
- **button-close** — red squared slab, full header height, flush with the
  window's top-right corner (it does not overlap outside the frame). White
  outlined X glyph at heading size. Red means close, nowhere else.
- **button-primary** — the green go-slab (Enter, Spin, Equip). Two-tone
  vertical gradient, stud emboss, white outlined label, squared corners.
  Oversized variants (full-width Equip) shift the top stop toward lime and
  step up to `{rounded.lg}`. Feel: a big plastic GO button.
- **button-secondary** — cyan robux-tier sibling, same anatomy, light-gray
  rim instead of ink border. The higher purchase tier reuses this anatomy in
  `{colors.accent-rare}` magenta.
- **button-buy** — the purple price pill on item rows: wave/coin icon chip
  left, white outlined amount right, `{rounded.md}` corners, stud emboss.
  Always inside a row or card, never free-floating.
- **banner-offer** — gold gradient landscape slab for token bundles and
  event offers: icon chip left, big amount center, price right; red
  sub-caption line for urgency variants. Stacks vertically with
  `{spacing.sm}`.
- **currency-bar** — deliberately containerless: currency icon plus white
  outlined amount sit directly on the world (bottom-left stack observed),
  with a small squared "+" buy tile beside each. The ink text outline does
  all the lifting.
- **side-button** — HUD launcher tiles in a 2-column grid (Store, Trade,
  Index…): dark translucent squared tile with icon, caption below, "NEW!"
  corner flash in gold when relevant.
- **card-grid** — squared dark translucent cells with 2px ink borders; the
  collection index shows silhouetted contents until unlocked. Rarity/status
  reads through content color, not through cell chrome.
- **badge-slot** — small dark squared tag with a white outlined number,
  pinned to hotbar slot corners.

No pressed/disabled/selected states were observed; implementing agents
should derive them (darken fill ~15% for pressed, desaturate for disabled)
and keep the squash feedback.

## Screen Patterns

- **HUD**: launcher tiles in a 2-column grid on the left edge (upper half,
  clear of the joystick zone), a wide toggle slab below them, currency stack
  (icon + naked outlined number + "+" tile per currency) bottom-left corner
  above the safe inset, hotbar slots bottom-center, and floating outlined
  world labels for stations. Bottom-right stays clear for the jump button.
  Roughly 10 persistent elements — busier than a lobby game, but everything
  is oversized.
- **Purchase window** (token spender): header band with counter chip →
  two-column grid of item rows (icon tile, name in label size, two-line body
  description, purple price pill) → scroll rail on the right. Watermark
  title echo behind the rows.
- **Spin overlay**: no panel — display-size title top-center, giant glowing
  wheel center with slice labels and odds, a symmetric bottom row: gift
  square / cyan "Buy 1" / green "Spin (cost)" / magenta "Buy 5" / gift
  square, plus a small labeled checkbox to the wheel's right. The whole
  overlay recolors per event theme.
- **Store offer rows**: full-width themed gradient panels stacked
  vertically; each has a corner tag ("NEW"), item render left over a radial
  burst, title in a theme accent with white outline (the one inverted-outline
  exception), body in white, then a price bar plus green gift square.
- **List rows** (cosmetics): full-width row — render left, name in heading
  size, one-line body description, availability caption, oversized green
  Equip slab right-aligned.
- **Input dialog**: compact window, header with a status icon, inset
  outlined input well on the translucent body, single centered green
  confirm slab.
- No settings or inventory-management screen was observed; those patterns
  are undefined here.

## Do's and Don'ts

**Do:**
- Put the stud emboss on every opaque fill — chrome, buttons, banners.
- Outline every piece of text with the near-black ink, no exceptions.
- Keep silhouettes squared; `{rounded.sm}` is the default answer.
- Recolor whole windows per theme/event while keeping the anatomy identical.
- Let the window body do the dimming; don't add a separate backdrop layer.
- Escalate purchase tiers by hue (cyan → magenta), not by size alone.

**Don't:**
- Never use pill or circle silhouettes — not even for the close button.
- Never add drop shadows or bevels; depth comes from ink, texture, and the
  translucent well.
- Never color a purchase action red, or a close action anything but red.
- Never set text in a color other than white (theme-accent titles on offer
  panels are the only exception, and they keep a white outline).
- Never use thin 1px ink — outlines are 2px minimum at reference.
- Never leave a fill flat and untextured; it reads as unfinished here.

## Agent Prompt Guide

Quick reference for implementing agents:

- Fills: themed vertical two-tone gradients (`UIGradient`, bright stop on
  top) + tiled stud-emboss ImageLabel at high transparency. Wells:
  near-black ~70% opaque. Borders: `UIStroke` 2px `#0A0A0F` (4px on window
  chrome; light-gray rim on gradient slabs over dark ground).
- Type: `Font.fromName("FredokaOne")` everywhere, white, contextual
  `UIStroke` 2px (3px display). Headers/buttons `TextScaled`.
- Shapes: `UICorner` 6px default, 10px windows/pills, 14px hero CTAs. No
  capsules, no circles.
- Window: integrated 84px gradient header band (icon left, title left, close
  slab flush right) over one big translucent dark well; ghost watermark
  title behind content; no separate dim layer.
- Motion (preset): entrances scale 0.85→1.0 Back-Out 0.25s; exits Quad-In
  0.15s; press squash 0.94 at 0.08s; count-up currency.

Canned prompts:

1. *"Using DESIGN.roblox.md (Studded Toybox), build the purchase window:
   84px blue gradient header with icon, title, counter chip, and flush red
   close slab; two-column rows (icon tile, name, description, purple price
   pill) on a 70%-opaque dark well with a watermark title. react-lua,
   Scale-first."*
2. *"Using DESIGN.roblox.md (Studded Toybox), build the HUD: 2-column
   launcher tile grid on the left, containerless currency stack with '+'
   tiles bottom-left, hotbar bottom-center; joystick/jump zones clear;
   stud emboss on every tile."*
3. *"Review this screenshot against DESIGN.roblox.md (Studded Toybox) and
   list every deviation from Do's and Don'ts and Components, ordered by
   visual impact — check especially for missing stud texture, un-outlined
   text, and pill silhouettes."*

---

*Independent analysis of publicly observable UI conventions, provided as-is
for inspiration. Not affiliated with or endorsed by any game or studio.*
