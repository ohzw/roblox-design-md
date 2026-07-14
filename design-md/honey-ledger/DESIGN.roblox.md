---
version: alpha
name: Honey Ledger
description: >
  Dense legacy utility UI: borderless flat rectangles stacked edge-to-edge
  into full-width ledger rows, header bands that carry the close block inside
  the band itself, hierarchy drawn entirely with hard color steps instead of
  strokes or shadows, and text-stroked comic lettering doing all the contrast
  work — windows snap in and out with no ceremony.
taste: [legacy-flat, dense, utilitarian, retro-simulator]
genre: [simulator, resource-grinder]

colors:
  primary: "#1B772A"          # CTA green — craft/confirm/redeem; same hex on 3 screens
  secondary: "#2868CC"        # blue header bands and neutral prompt strips
  danger: "#C9271C"           # No / destructive / active-OFF toggle
  surface: "#CABD57"          # mustard window base the ledger rows sit on
  surface-row: "#E5DEA5"      # cream full-width stat/list row fill
  surface-block: "#F8EEAE"    # pale-yellow description block fill
  surface-deep: "#797132"     # dark olive inset wells (image viewports)
  surface-header: "#FEEC6C"   # bright honey header band; same yellow is reused as title ink over dark fills
  surface-info: "#2257A8"     # royal-blue info panel / CTA frame fill
  surface-info-deep: "#1B4280" # darker blue inner text wells on blue panels
  surface-dark: "#404040A6"   # translucent charcoal HUD bars (alpha estimated)
  on-surface: "#1E2B32"       # near-black cool charcoal body text — not pure black
  currency-soft: "#FDDF8E"    # cream-gold resource numerals in the HUD
  success: "#6EFF62"          # progress fill green; completed rows read "#7AF882"
  track-incomplete: "#F06D59" # salmon quest-task track before the green fill covers it
  accent-select: "#3283FF"    # bright blue selection outline and dialog outer frame
  outline: "#1E2B32"          # text-stroke ink; deliberately the same hex as on-surface

typography:
  heading:
    fontFamily: ComicNeueAngular
    fontWeight: Bold
    textSize: 30px
  body:
    fontFamily: ComicNeueAngular
    fontWeight: Regular
    textSize: 17px
  label:
    fontFamily: ComicNeueAngular
    fontWeight: Bold
    textSize: 26px
  caption:
    fontFamily: ComicNeueAngular
    fontWeight: Regular
    textSize: 14px
  utility:
    fontFamily: SourceSansPro
    fontWeight: Bold
    textSize: 24px

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px }

rounded: { none: 0px, sm: 6px, md: 10px }

strokes:
  text-outline: { thickness: 2px, color: "{colors.outline}", mode: Contextual }
  select: { thickness: 3px, color: "{colors.accent-select}", mode: Border }
  frame: { thickness: 2px, color: "{colors.surface-info-deep}", mode: Border }

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
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
    shadow: none
    size: "fixed strip inside its frame, roughly 230x44px at reference; aspect ~5:1"
  button-close:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    typography: "{typography.utility}"
    rounded: "{rounded.none}"
    shadow: none
    size: "square matching the header band height, docked flush to the band's left end"
  button-close-beveled:
    backgroundColor: "#E9594A"
    textColor: "#B03024"
    rounded: "{rounded.md}"
    shadow: "bevel(10px #771C16)"
    size: "floats inside the right end of the honey header band; ~64px square at reference"
  button-buy:
    backgroundColor: "#F05850"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
    size: "price tag docked to the card's top-right corner, full-bleed to the edge"
  button-icon:
    backgroundColor: "{colors.surface-dark}"
    rounded: full
    size: "~56px circle at reference, in a bottom-center hotbar row"
  button-icon-selected:
    stroke: "{strokes.select}"
  currency-bar:
    backgroundColor: "{colors.surface-dark}"
    textColor: "{colors.currency-soft}"
    typography: "{typography.utility}"
    rounded: "{rounded.sm}"
    height: 34px
  progress-bar:
    backgroundColor: "{colors.surface-dark}"
    textColor: "#FFFFFF"
    typography: "{typography.utility}"
    rounded: "{rounded.sm}"
    height: 34px
  window:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.none}"
    shadow: none
  window-header:
    backgroundColor: "{colors.surface-header}"
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"
    rounded: "{rounded.none}"
  window-info:
    backgroundColor: "{colors.surface-info}"
    textColor: "#FFFFFF"
    stroke: "{strokes.frame}"
    rounded: "{rounded.none}"
  window-header-info:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.utility}"
    rounded: "{rounded.none}"
  list-row:
    backgroundColor: "{colors.surface-row}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    rounded: "{rounded.none}"
    padding: 8px
  toggle-on:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.none}"
  toggle-on-disabled:
    backgroundColor: "#96BCB6"
  toggle-off:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.none}"
  toggle-off-disabled:
    backgroundColor: "#ECE8F0"
  badge-slot:
    textColor: "#FFFFFF"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
  tooltip:
    backgroundColor: "{colors.surface-info}"
    textColor: "#FFFFFF"
    typography: "{typography.body}"
    stroke: "{strokes.frame}"
    rounded: "{rounded.none}"

extraction:
  inputs:
    - id: shot-1
      kind: screenshot
      describes: "desktop 1920x1080 gameplay: full HUD, crafting shop (left item list, right blue info panels, bottom CTA frame)"
    - id: shot-2
      kind: screenshot
      describes: "desktop 1920x991 gameplay: HUD counters, event panels (green with red header bands), red/green pager, chat-style event log"
    - id: shot-3
      kind: screenshot
      describes: "tablet 1063x797 gameplay: mobile HUD — icon toolbar, translucent leaderboard, circular hotbar with selection outline, joystick/jump zones"
    - id: shot-4
      kind: screenshot
      describes: "tall crop 644x1608: honey-yellow detail window (header band, beveled close, stacked stat rows, description blocks)"
    - id: shot-5
      kind: screenshot
      describes: "crop 613x431: blue dialog window (red close block at header-left, navy body, pastel option chips)"
    - id: shot-6
      kind: screenshot
      describes: "crop 882x388: confirmation dialog (bright blue frame, darker inner text well, green Yes / red No)"
    - id: shot-7
      kind: screenshot
      describes: "crop 304x731: quest window (pale blue base, salmon task rows filling green on completion)"
    - id: shot-8
      kind: screenshot
      describes: "crop 403x796: settings menu (icon tab strip, near-white panel, inset text field, green action buttons, ON/OFF paired toggles)"
    - id: shot-9
      kind: screenshot
      describes: "crop 585x577: premium offer card (tan panel, red price tag, cream footer band)"
    - id: shot-10
      kind: screenshot
      describes: "crop 308x440: premium egg list (yellow title ink, red price tags, white stroked body text)"
    - id: shot-11
      kind: screenshot
      describes: "closeup 1400x80: HUD resource bars (label chip, translucent dark track, gold numerals, green progress sliver)"
    - id: shot-12
      kind: screenshot
      describes: "closeup 640x360: beveled close button on the honey window"
    - id: shot-13
      kind: screenshot
      describes: "closeup 960x210: blue window header band with square red close at its left end"
    - id: shot-14
      kind: screenshot
      describes: "closeup 338x95: HUD icon toolbar glyphs"
  confidence:
    Colors: high
    Typography: medium
    Layout: medium
    "Elevation & Depth": medium
    Shapes: high
    Motion: low
    Components: medium
    "Screen Patterns": high
  notes: >
    px measured directly on shot-1/shot-2 (native 1920-wide desktop captures,
    conversion factor 1.0); crop-only shots calibrated against shared elements
    (header band heights, close blocks) and rounded to friendly steps.
    Dominant lettering mapped to ComicNeueAngular (the engine's angular comic
    family, cross-platform); the mapping-table nearest bucket would be
    PatrickHand (hand-written/comic) — rejected as visually farther, noted as
    runner-up. HUD/system dialogs use a neutral bold sans mapped to
    SourceSansPro. surface-dark alpha estimated by comparing the HUD track
    over a dark world (shot-1) vs bright sky (shot-11) — no undimmed pair
    existed. No dim-overlay, card-grid, inventory grid, reward/celebration
    moment, or hard-currency accent was observed: all omitted rather than
    guessed. Toggle active-ON sampled slightly desaturated (#69A578) vs the
    action-button green; bound to primary with the ambiguity noted here.
    Button pressed/disabled states never observed; toggle idle chips
    (#96BCB6 / #ECE8F0) are observed, encoded as -disabled siblings. Motion is
    the cartoon-chunky/playful family preset; no video input. Rejected
    non-UI materials from the sourcing folder (character/item renders, fan
    art, key art) were excluded from evidence.
---

# Honey Ledger

## Overview

Honey Ledger is the taste of long-running legacy simulators whose UI grew
row by row for years: a spreadsheet wearing a cartoon costume. One concrete
reference: **a hand-ruled paper ledger taped to a beekeeper's clipboard** —
every fact gets its own full-width colored strip, strips butt against each
other with almost no air, and nothing is decorated beyond the color of its
row. Dense, flat, honest, slightly janky — and that jank is the charm, not a
defect to fix.

Three rules of thumb:

1. **Rows, not cards.** Information stacks as full-width horizontal bars that
   fill their window edge-to-edge. Nothing floats; nothing is a rounded
   island.
2. **Color steps replace chrome.** There are no container outlines, no drop
   shadows, no dim layer — a fill two steps darker or lighter IS the grouping,
   the inset, and the elevation.
3. **Text carries the contrast.** Comic lettering, near-black on light fills,
   white with a dark 2px stroke on saturated or world backgrounds. If text
   might ever sit over the world, stroke it.

Target genre: grind-heavy collection simulators with big numbers and many
subsystems, where players read the UI like a dashboard for hours.

## Colors

Two panel families share one ink system:

- **Honey family** (detail windows, ledgers): `{colors.surface}` mustard base,
  `{colors.surface-row}` cream rows, `{colors.surface-block}` pale description
  blocks, `{colors.surface-deep}` olive inset wells, `{colors.surface-header}`
  bright honey header band. The four yellows are four distinct tokens — the
  hard step between them is the taste's only grouping device, so never blend
  or gradient between them.
- **Info family** (dialogs, floating info cards): `{colors.secondary}` header
  bands, `{colors.surface-info}` panel fill, `{colors.surface-info-deep}`
  inner text wells, `{colors.accent-select}` bright frame/selection blue.
- `{colors.primary}` green is exclusively forward action — craft, confirm,
  redeem. The identical hex recurs across unrelated screens; keep it exact.
- `{colors.danger}` red is No/close/active-OFF. It sits directly beside
  `{colors.primary}` in Yes/No pairs and ON/OFF toggles — this taste happily
  shows both at once and lets color do the reading.
- `{colors.success}` green fills progress tracks and floods completed quest
  rows; `{colors.track-incomplete}` salmon is the unfilled quest-task track.
  Salmon is a track color, not an error color — don't confuse it with danger.
- `{colors.currency-soft}` cream-gold is reserved for resource numerals in
  the HUD. No hard-currency accent was observed; premium offers instead use
  the `#F05850` price-tag red (see `button-buy`).
- `{colors.on-surface}` is a near-black cool charcoal, and `{colors.outline}`
  (text-stroke ink) deliberately shares the same hex — one ink for body text
  and letter strokes. Backgrounds are never pure white; the closest is the
  settings panel's `#EBF6FB` blue-white.
- No dim backdrop was observed behind any window (declared gap): windows sit
  straight on the world.

## Typography

Two voices, strict division of labor:

- **ComicNeueAngular** is the game voice: window titles, ledger rows, buttons,
  quest text, shop copy. Bold for `{typography.heading}` and
  `{typography.label}`, Regular for `{typography.body}` and
  `{typography.caption}`. Casing is sentence/Title Case as written — this
  taste never shouts in all caps.
- **SourceSansPro Bold** (`{typography.utility}`) is the system voice: HUD
  resource numerals, leaderboard rows, terse machine dialogs ("Transform
  Diamond Bee?"), and blue header bands. The two-voice split is a taste
  feature — game content feels drawn, plumbing feels stock.

Text stroke convention: white text on saturated fills (buttons, price tags,
blue panels) and ANY text over the game world (event logs, NPC dialog lines,
proximity labels) carries `{strokes.text-outline}`. Dark text on light rows
carries no stroke. Accent titles over dark or green fills reuse the header
yellow `{colors.surface-header}` as ink, stroked.

TextScaled policy: ledger rows and buttons use TextScaled inside fixed-height
strips (token sizes are the intended size at reference, bounded with
UITextSizeConstraint); HUD numerals use fixed textSize so digits don't jitter
as values grow. Confidence: medium — family identification is from stills;
sizes were measured on the native desktop shots.

## Layout

Density is the identity: a window is a single column of full-width strips
with tiny gaps, scrolling when needed. Twelve-plus rows in one window is
normal, not a smell.

- Rows span the window's full inner width; only `{spacing.xs}`–`{spacing.sm}`
  vertical gaps between them (mustard base showing through the cracks).
- Window inner padding is `{spacing.sm}` at most — content runs nearly
  edge-to-edge. `{spacing.md}` separates logical groups, `{spacing.lg}` is
  the maximum gap anywhere.
- Delegate stacking to UIListLayout with the spacing tokens as Padding;
  rows are Scale-width, fixed-offset height. Option chips (dialog choices)
  use a centered UIGridLayout with `{spacing.md}` CellPadding.
- Two-column pattern inside detail windows: a square image well
  (`{colors.surface-deep}`) left, a stack of short tag rows right; below,
  the full-width ledger resumes.
- Safe areas: HUD roots use ScreenGui.ScreenInsets = DeviceSafeInsets; the
  resource bars center under the top inset, the icon toolbar hugs the
  top-left below it. Query GuiService:GetInsetArea() rather than hardcoding.
- Tap targets: 44px minimum still applies — rows are short (34–44px) but
  full-width, so they pass; the hotbar circles are ~56px.
- Keep bottom-left (virtual joystick) and bottom-right (jump) clear; the
  hotbar row sits bottom-center between them (observed on the tablet shot).

Confidence: medium — spacing from crops was calibrated through shared
elements, so values carry a small constant-factor caveat.

## Elevation & Depth

Almost everything is flat; that flatness is load-bearing.

- **No container strokes.** Rows, windows, buttons, header bands: all
  strokeless hard-edged fills. The only UIStroke uses are the 2px text
  stroke, the 3px `{strokes.select}` selection square on the active hotbar
  slot, and a thin `{strokes.frame}` navy edging on blue dialogs.
- **No drop shadows, no dim layer.** Windows sit directly over the world;
  separation comes from fill saturation against the scene. If a consuming
  game needs a dim for readability it must be added knowingly as an
  extension — it was not observed (declared gap).
- **One bevel in the whole system**: the honey window's close button carries
  a chunky 10px darker-red bottom edge (`button-close-beveled`) — the single
  fake-3D flourish, which makes it the most findable element on the screen.
  Do not spread bevels to other components.
- **Inset = darker fill**, never a shadowed well: image viewports use
  `{colors.surface-deep}`, blue dialogs nest `{colors.surface-info-deep}`
  text wells inside `{colors.surface-info}` frames.
- Layering plan: ScreenGuis use ZIndexBehavior Sibling with DisplayOrder
  bands — HUD 0–9, windows 10–19, floating info cards/toasts 20–29. Within a
  window, everything is one flat layer; overlap simply does not happen.

## Shapes

Square is the default silhouette; curvature is rationed.

- `{rounded.none}` (0px) — windows, header bands, rows, buttons, toggles,
  price tags, close blocks. When in doubt, sharp.
- `{rounded.sm}` (6px) — HUD resource bars and their tracks; the honey bar's
  label chip also skews its right edge slightly (a parallelogram cut — a
  rotated ImageLabel or slanted 9-slice, the taste's one decorative cut).
- `{rounded.md}` (10px) — the beveled close button and dialog option chips.
- `full` — only the hotbar item circles.

Silhouette rules: windows are portrait or square hard rectangles; buttons are
wide flat strips; anything selectable gets a square outline, not a shape
change. Pills do not exist in this taste.

## Motion

No video input existed, so these are the cartoon-chunky/playful family
presets (confidence: low); the stills suggest even less choreography than the
preset — legacy windows of this kind typically snap. Guidance:

- **Entrances**: windows may appear instantly (a hard cut is period-correct)
  or scale 0.95 → 1.0 with `{motion.easings.settle}` at
  `{motion.durations.fast}`. Never a slow fade; never Back-Out overshoot on
  windows — overshoot reads too modern for this taste.
- **Exits**: instant, or `{motion.easings.exit}` at
  `{motion.durations.instant}`. Exits never slower than entrances.
- **Press feedback**: a brief fill darken at `{motion.durations.instant}`;
  no squash. The beveled close button may collapse its bevel while held.
- **Value changes**: resource numerals count up with
  `{motion.easings.settle}` over `{motion.durations.slow}`; progress fills
  and quest-row green floods tween width with `settle`, never snap.
- **Rewards**: `{motion.easings.bounce}` reserved for rare celebration
  moments (none observed; inherited from the family preset).
- Reduced-motion stance: trivially satisfied — instant everything is already
  on-taste.

## Components

- **button-primary** — flat green strip, white stroked label, sharp corners,
  no bevel. Feels like a stamp, not a candy button. Often mounted centered
  inside a blue `window-info` frame flanked by pager arrows. Pressed/disabled
  states were not observed — if needed, darken the fill one step (inferred).
- **button-close** — flat danger-red square docked flush to the LEFT end of a
  blue header band, white X in the system voice. No inset, no rounding: the
  band and the block share edges.
- **button-close-beveled** — the honey-window variant: rounded red block
  floating inside the RIGHT end of the header band, darker-red X glyph, 10px
  bottom bevel. The only beveled element in the system.
- **button-buy** — red price tag docked to a card's top-right corner,
  full-bleed to the card edge, white stroked amount. Price lives in the tag,
  never inside a green button.
- **button-icon / -selected** — dark translucent circle in the bottom-center
  hotbar with the item icon and a stroked count caption (`badge-slot`);
  selection is a square 3px `{colors.accent-select}` outline around the
  circle plus a label above — the square-on-circle clash is authentic.
- **currency-bar** — the HUD signature: a light-gray label chip (skewed right
  edge) butted against a translucent charcoal track; amount in
  `{colors.currency-soft}` gold (primary resource) or white (secondary).
  height 34px at reference, centered at the top of the screen as a pair.
- **progress-bar** — same charcoal track with a `{colors.success}` fill
  growing from the left and a "current/max" white numeral overlay. The
  quest-task rows are the same component recolored: salmon
  `{colors.track-incomplete}` track, green flood, caption centered.
- **window / window-header** — see anatomy below.
- **window-info / window-header-info** — blue family: royal-blue panel with a
  thin navy frame, `{colors.secondary}` header band, white stroked text,
  darker `{colors.surface-info-deep}` wells for body copy. Used for dialogs,
  confirmations, and floating info cards.
- **list-row** — cream full-width strip: bold title line centered or leading,
  Regular description lines below, optional icon flush-left with its count
  overlapped. Stat variants recolor the fill (pale green rows for buffed
  stats, blue tag rows with white stroked text).
- **toggle-on / toggle-off** — settings rows end in a side-by-side ON/OFF
  chip pair; the active side is saturated (`primary` / `danger`), the
  inactive side is its desaturated pastel (-disabled siblings). Both chips
  are always visible; state is read by which one is lit.
- **badge-slot** — stroked white "xN" count tag overlapping an item icon's
  corner; no background fill.
- **tooltip** — manifests as a world-anchored info card (blue family):
  title band, optional red/darker sub-band, body copy in white stroked text.
  Anchored beside the 3D object it describes, not to the cursor.

**Window anatomy** (draw it from this): a hard-edged, strokeless rectangle,
usually portrait. The header is a full-width band in a brighter step of the
panel's own family (`{colors.surface-header}` honey on mustard;
`{colors.secondary}` blue on royal blue) sitting flush inside the top edge —
never overlapping, never floating, no gap above it. The title sits in the
band: centered dark text (honey family) or left-aligned white stroked text
(blue family). The close control lives INSIDE the band: honey family floats a
rounded beveled red block at the band's right end; blue family docks a flat
red square flush to the band's left end, sharing the band's full height.
Below the band, content is an uninterrupted column of full-width color-step
rows with `{spacing.xs}`–`{spacing.sm}` cracks between them; corners stay
sharp everywhere; there is no footer convention — confirm/CTA actions appear
as green strips inline (dialogs) or in a separate blue CTA frame floating
near the bottom of the screen (shops). Layer stack: world → window → nothing
else (no dim, no shadow).

## Screen Patterns

- **HUD (desktop)**: twin resource bars (`currency-bar` + `progress-bar`)
  centered at the very top; white glyph icon toolbar (egg, quests, mask,
  badges, settings, premium) top-left as a horizontal row; event/chat log as
  bare stroked colored text lines down the right edge — no panel behind it;
  world-anchored info cards (tooltip) float beside relevant objects.
- **HUD (tablet/phone)**: hamburger + chat icons top-left with the icon
  toolbar beside them; translucent charcoal leaderboard rows top-right
  (name left, values right, white system text); circular item hotbar
  bottom-center between the joystick and jump zones, selected slot outlined
  `{colors.accent-select}` with a label above; count tags on every slot.
  Persistent element count is high (12+) — this taste tolerates dashboard
  density.
- **Proximity prompts**: full-width colored band (red for exit/leave, blue
  for talk) with huge white stroked text and a white keycap square ("E" /
  "Tap") at its left — a HUD-layer strip, not a bubble.
- **Shop / crafting**: left third = scrolling column of `list-row` items on a
  white panel with a thin scrollbar; center = the 3D world shows the selected
  item; right = blue info card stack (title band, price sub-band, long stat
  list in white stroked text; separate ingredients card above); bottom-center
  = blue CTA frame containing `button-primary` flanked by square arrow
  paddles for prev/next.
- **Quest window**: pale blue base, near-white title band with dark blue
  centered text, then a straight column of salmon task rows ("Collect X.
  0/X") that flood green as they complete; a fully green "Complete!" banner
  row sits at the top when done. Progress is read per-row, not in a summary
  bar.
- **Settings**: near-white panel under the icon tab strip (active tab = large
  white glyph on dark); inset gray text field + green action button pair;
  full-width green utility buttons with emoji-style leading icons; dark
  translucent section header bands; then label + ON/OFF toggle-pair rows
  separated by hairline value steps.
- **Premium offers**: tan/khaki cards, white stroked title, red price tag
  top-right (`button-buy`), body copy in white stroked text, cream footer
  band with dark fine print. Item tiers titled in the header yellow ink.
- **Pager**: square arrow paddles flanking a center count strip ("1 / 16");
  paddle color follows the host window family (red on event panels, blue on
  shop CTA frames).
- Inventory grids, reward popups, and dimmed modal moments were not observed
  — patterns for them are intentionally not specified.

## Do's and Don'ts

**Do:**
- Stack full-width rows edge-to-edge with tiny gaps; let the base color show
  through the cracks as the only divider.
- Keep corners sharp by default; ration curvature to the three-step scale.
- Stroke every glyph that sits on a saturated fill or the open world.
- Reuse the exact `{colors.primary}` hex for every forward action, however
  small — the repetition is the affordance.
- Let ON/OFF and Yes/No pairs show both options at once, reading state by
  which side is saturated.
- Accept high density: 12+ rows per window and 12+ HUD elements are
  on-taste.

**Don't:**
- Never outline containers or add drop shadows — flat color steps carry all
  depth; a stroked panel instantly breaks the period look.
- Never add a dim layer behind windows by default; they sit raw on the
  world.
- Never use pills or capsule buttons; the only circles are hotbar slots.
- Never bevel anything except the honey window's close button.
- Never gradient between the yellow steps (or any two fills) — hard steps
  only, so UIGradient stays unused.
- Never replace the comic voice with the system voice on game content, or
  vice versa — the two-voice split is deliberate.
- Never use `{colors.track-incomplete}` salmon for errors or danger; it is a
  progress track color.
- Never animate window entrances with overshoot; a hard cut beats a bouncy
  tween here.

## Agent Prompt Guide

Quick reference for implementing agents:

- Fills are flat and strokeless; corners 0px except HUD bars (6px), close
  bevel/chips (10px), hotbar circles (full). Depth = darker/lighter fill
  step, plus one 10px bevel on the honey close button only.
- Fonts: Font.fromName("ComicNeueAngular", Bold) for titles/labels, Regular
  for body; Font.fromName("SourceSansPro", Enum.FontWeight.Bold) for HUD
  numerals and system dialogs. White text on saturated fills gets a 2px
  Contextual UIStroke in #1E2B32.
- Windows: full-width header band flush inside the top edge, close block
  INSIDE the band (flat red square at left for blue windows; rounded beveled
  red block at right for honey windows), then a UIListLayout column of
  full-width rows with 4–8px Padding. No dim, no shadow, ZIndexBehavior
  Sibling, DisplayOrder bands HUD 0–9 / windows 10–19 / toasts 20–29.
- Motion: hard cuts or ≤0.15s Quad-Out scale-ins; count-up numerals and
  tweened progress fills are the only mandatory animation.

Canned prompts:

1. *"Using DESIGN.roblox.md (Honey Ledger), build the HUD: twin top-center
   resource bars (label chip + translucent track, gold numerals, green
   progress fill), a top-left white-glyph icon toolbar, and a bottom-center
   circular hotbar with count tags and a bright blue square selection
   outline. react-lua, Scale-first, DeviceSafeInsets, joystick/jump zones
   clear."*
2. *"Using DESIGN.roblox.md (Honey Ledger), build a detail window in the
   honey family: bright yellow header band with the name and a beveled red
   close block at its right end, an olive image well with tag rows beside
   it, then a dense column of cream and pale-green stat rows and pale-yellow
   description blocks, all sharp-cornered and strokeless."*
3. *"Review this screenshot against DESIGN.roblox.md (Honey Ledger) and list
   every deviation from the Do's and Don'ts — especially any container
   strokes, drop shadows, dim layers, pills, or rounded corners that crept
   in — ordered by visual impact."*

---

*Independent analysis of publicly observable UI conventions, provided as-is
for inspiration. Not affiliated with or endorsed by any game or studio.*
