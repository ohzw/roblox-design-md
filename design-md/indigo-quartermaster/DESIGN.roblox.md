---
version: alpha
name: Indigo Quartermaster
description: >
  Flat one-hue utility UI: rectangular indigo panels with an integrated
  lighter header band (bare white X flush right, inline tab strip on hubs),
  full-width list rows and split label/control rows, pill price chips,
  full-width color verdict bands on card bottoms, and thin square-ended
  progress strips — depth built entirely from value steps of a single hue,
  with no strokes, no bevels, and no drop shadows.
taste: [flat-utility, one-hue, competitive-casual]
genre: [pvp, minigame, casual-competitive]
inspiration: "BedWars"

extraction:
  inputs:
    - id: shot-hud
      kind: screenshot
      describes: "Top-center HUD crop: timer pill, kill-counter pill, team-roster pill of colored squares (UI-only crop)"
    - id: shot-hotbar
      kind: screenshot
      describes: "Bottom-center hotbar crop: translucent slate slots with corner keybind tags"
    - id: shot-health
      kind: screenshot
      describes: "Red objective health bar with centered white number (UI-only crop)"
    - id: shot-prompt
      kind: screenshot
      describes: "In-world gameplay with centered dark interaction prompt (keybind chip + cost line + action line) and green team bar"
    - id: shot-queue
      kind: screenshot
      describes: "Match-countdown banner, monospaced status text on indigo band"
    - id: shot-play
      kind: screenshot
      describes: "Lobby mega-CTA: green horizontal-gradient slab with white caps label"
    - id: shot-play2
      kind: screenshot
      describes: "Small green PLAY AGAIN button crop"
    - id: shot-buy
      kind: screenshot
      describes: "Green premium-currency price pill crop"
    - id: shot-rank
      kind: screenshot
      describes: "Green rank/monthly-wins banner crop with + affordance"
    - id: shot-event1
      kind: screenshot
      describes: "Full-screen seasonal event hub, Shop tab: header band with title/subtitle, tab strip, currency pill, close glyph; card grid with price pills and bottom color strips (~1993px wide desktop capture)"
    - id: shot-event2
      kind: screenshot
      describes: "Same event hub window, second season, Shop tab scrolled (downscaled capture)"
    - id: shot-missions
      kind: screenshot
      describes: "Event hub Missions tab: daily/weekly full-width rows with reward chips, gray percent-complete chips, thin bottom progress strips"
    - id: shot-settings1
      kind: screenshot
      describes: "Settings window: split rows (lighter label segment / darker control segment), sliders, On/Off text toggle"
    - id: shot-settings2
      kind: screenshot
      describes: "Settings window scrolled: red Off and green On active toggle segments, slider, scrollbar"
    - id: shot-gift
      kind: screenshot
      describes: "Gift purchase popup: header band with icon+title+X, left friends panel with search field, inset text fields, green footer CTA"
    - id: shot-gifted
      kind: screenshot
      describes: "Gift-received popup: header band, hairline-outlined feature row, inset message well, green bottom-right CTA"
    - id: shot-creative
      kind: screenshot
      describes: "Creative inventory window: category tab pills, search bar, dense slot grid with 1px hairline slot outlines"
    - id: shot-contract
      kind: screenshot
      describes: "Kit contract screen: dark header strip with back arrow, reward track of numbered tier cards with lock/check tags, stats side panel"
    - id: shot-armory1
      kind: screenshot
      describes: "Purchase card: icon+title+description, divider, hairline-outlined item slots, full-width red cost band on bottom edge"
    - id: shot-armory2
      kind: screenshot
      describes: "Same purchase card in unlocked state: gray full-width status band"
    - id: shot-friends
      kind: screenshot
      describes: "Social overlay (divergent dark voice): near-black backdrop, white rows, red SPECTATE buttons, caps grotesque type"
    - id: shot-emote
      kind: screenshot
      describes: "Radial emote wheel with circular blue edit / red close icon buttons (low-quality upscaled capture; used for pattern only, not sampled)"
    - id: shot-forge
      kind: screenshot
      describes: "In-match forge menu (divergent dark voice): near-black panel, star ratings, white selection frame, orange accent CTA"
    - id: shot-grid
      kind: screenshot
      describes: "Armory grid crop: dark slate wells and cell grid (weak evidence)"
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
    24 of 35 unique source images were usable UI; the rest were renders, promo
    art, or fan art and were discarded. All inputs are UI crops with no
    verified viewport: px tokens are normalized by assuming shot-event1
    (1993px wide, full-screen window) is a 1920-wide desktop capture (factor
    0.96) and chaining other shots through the shared header/tab elements —
    every px token carries a constant-factor caveat. Colors sampled with
    ImageMagick from flat fill centers; header band #6467A8 and inset well
    #3D3F6A each recurred identically across 3+ shots. dim and
    interaction-prompt fills are estimated through translucency (marked in
    prose). Motion is the competitive taste-family preset; no video input.
    Font family is a nearest-match mapping (BuilderSans; runner-up
    SourceSansPro — the social overlay lettering leans SourceSansPro).
    -selected outside tab strips, -pressed, and -hover were never observed.
    shot-friends and shot-forge show a divergent near-black in-match/overlay
    voice, described in Screen Patterns but not tokenized.

colors:
  primary: "#27AE60"          # solid confirm green — Gift, Awesome!, PLAY AGAIN, robux price pills, toggle-On
  secondary: "#597CBC"        # muted blue of soft-currency price pills on cards
  danger: "#FE383B"           # hot red — destructive/negative actions (SPECTATE-style hot buttons)
  danger-soft: "#E4696A"      # desaturated red — Off toggle segments, cost/locked verdict bands
  surface: "#4F5081"          # window body indigo
  surface-raised: "#5A65A3"   # rows and cards, one value step lighter than their backdrop
  surface-deep: "#3D3F6A"     # inset wells: text fields, search bars, message boxes
  surface-dark: "#383660"     # dark chrome pills (currency counters in headers)
  header: "#6467A8"           # header bands and split-row label segments — the signature light step
  hud-ink: "#1E3B50"          # in-match HUD pill navy (darker, colder than the lobby indigo)
  on-surface: "#FFFFFF"
  on-surface-muted: "#A9A9D0" # subtitles, placeholders, disabled labels
  accent-info: "#5EACFE"      # item names, card bottom strips, informational highlights
  accent-soft: "#B9BCFF"      # progress fills, slider tracks, active-tab underline strip
  progress-track: "#787EC7"   # progress strip track
  dim: "#4F5081AA"            # ESTIMATED: tinted wash behind hub windows, judged through translucency

typography:
  display:
    fontFamily: BuilderSans
    fontWeight: Bold
    textSize: 40px
  heading:
    fontFamily: BuilderSans
    fontWeight: Bold
    textSize: 24px
  body:
    fontFamily: BuilderSans
    fontWeight: Regular
    textSize: 18px
  label:
    fontFamily: BuilderSans
    fontWeight: Bold
    textSize: 18px
  caption:
    fontFamily: BuilderSans
    fontWeight: SemiBold
    textSize: 14px
  timer:
    fontFamily: RobotoMono
    fontWeight: Regular
    textSize: 20px

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px, xl: 32px }

rounded: { none: 0px, sm: 4px, md: 8px, full: full }

strokes:
  hairline:  { thickness: 1px, color: "#9C9ED7", mode: Border }
  selection: { thickness: 2px, color: "#FFFFFF", mode: Border }

motion:
  durations: { instant: 0.06s, fast: 0.12s, normal: 0.18s, slow: 0.3s }
  easings:
    pop:    { style: Quart, direction: Out }
    settle: { style: Linear, direction: Out }
    exit:   { style: Quart, direction: In }

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    shadow: none
    height: 44px
  button-primary-disabled:
    backgroundColor: "#4D5076"
    textColor: "{colors.on-surface-muted}"
  button-cta:
    gradient: "horizontal(#31E856, #22DA34)"
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"
    rounded: "{rounded.sm}"
    shadow: none
    size: "scale ~0.25 wide, aspect ~4:1 — the lobby mega-slab"
  button-buy:
    backgroundColor: "{colors.secondary}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    rounded: "{rounded.full}"
    height: 44px
  button-danger:
    backgroundColor: "{colors.danger}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    height: 44px
  button-close:
    backgroundColor: "#00000000"
    textColor: "{colors.on-surface}"
    size: "bare 24px X glyph, 44px+ touch target, flush right inside the header band"
  tab:
    backgroundColor: "#00000000"
    textColor: "{colors.on-surface-muted}"
    typography: "{typography.label}"
    rounded: "{rounded.none}"
  tab-selected:
    backgroundColor: "#363E70"
    textColor: "{colors.on-surface}"
  currency-bar:
    backgroundColor: "{colors.surface-dark}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    rounded: "{rounded.full}"
    height: 44px
  window:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.md}"
    shadow: none
  window-header:
    backgroundColor: "{colors.header}"
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"
    rounded: "{rounded.none}"
    height: 48px
  dim-overlay:
    backgroundColor: "{colors.dim}"
  list-row:
    backgroundColor: "{colors.surface-raised}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    rounded: "{rounded.sm}"
    height: 150px
  card-grid:
    backgroundColor: "{colors.surface-raised}"
    textColor: "{colors.accent-info}"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    aspectRatio: 0.9
  toggle-split:
    backgroundColor: "{colors.surface-deep}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    rounded: "{rounded.none}"
  toggle-split-selected:
    backgroundColor: "{colors.primary}"
  progress-bar:
    backgroundColor: "{colors.progress-track}"
    rounded: "{rounded.none}"
    height: 8px
  badge-slot:
    backgroundColor: "{colors.surface-dark}"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    rounded: "{rounded.none}"
  hud-pill:
    backgroundColor: "{colors.hud-ink}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    height: 48px
  interaction-prompt:
    backgroundColor: "#26262B"
    transparency: 0.25
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
---

# Indigo Quartermaster

## Overview

Indigo Quartermaster is the taste of a fast casual-PvP lobby that treats its
UI like back-office software for kids: flat, legible, and completely
un-precious. One concrete reference: **a chat-app sidebar** — a single indigo
hue stepped lighter and darker to make panels, rows, wells, and header bands,
with white bold type on everything and solid green/red buttons delivering
verdicts. Nothing is outlined for decoration, nothing casts a shadow, nothing
bounces to entertain you.

Three rules of thumb:

1. **One hue, many values.** Panels, rows, headers, and wells are all the
   same indigo at different lightness steps. If you need "closer to the
   player", go one step lighter; "recessed", one step darker.
2. **Color is a verdict, not a theme.** Green means go/own/on, red means
   cost/off/destructive, light blue means information. These arrive as solid
   fills — a full button, a full toggle segment, a full band across a card's
   bottom edge — never as tints or glows.
3. **The row is the atom.** Content ships as generous full-width rows and
   simple grids of flat cells; the whole row is the touch surface, and its
   meta-state (progress, rarity, status) is pinned to its bottom edge as a
   thin strip or band.

Target genre: session-based competitive minigames — queue lobbies, event
hubs, mission boards, item shops, kit selection.

## Colors

The palette is a value ladder of one indigo plus verdict colors. Sampled
consistently across three windows: `{colors.header}` header bands,
`{colors.surface}` bodies, `{colors.surface-deep}` wells recurred to the
exact hex.

- `{colors.surface}` is the window body. Rows and cards sit on it at
  `{colors.surface-raised}`; text fields, search bars, and message wells sink
  to `{colors.surface-deep}`; currency counters use the darkest chrome step
  `{colors.surface-dark}`.
- `{colors.header}` — the lightest step — marks header bands and the label
  half of settings rows. Lighter = labeled/structural, darker = interactive
  content wells. This inversion of the usual "dark header" habit is a taste
  signature.
- `{colors.primary}` green is the universal "yes": confirm CTAs, active On
  segments, and (notably) prices in premium currency. The lobby mega-CTA
  brightens it into the `button-cta` gradient.
- `{colors.danger}` hot red is for destructive/negative hot buttons;
  `{colors.danger-soft}` is its calmer sibling for Off segments and
  cost/locked verdict bands. Red and green never appear in the same control
  except as the two poles of a toggle.
- `{colors.accent-info}` light blue carries item names and card bottom
  strips; `{colors.accent-soft}` periwinkle carries progress fills, slider
  tracks, and the active-tab underline. Neither is ever a button fill.
- Text is pure `#FFFFFF` on all indigo steps — this taste does use true
  white, and it works because every fill is mid-value. Secondary text drops
  to `{colors.on-surface-muted}` lavender, never to gray.
- In-match HUD chrome switches to `{colors.hud-ink}` navy — colder and darker
  than the lobby indigo so it recedes against bright game worlds.
- `{colors.dim}` is **estimated** (judged through window translucency, no
  undimmed pair available): a tinted indigo wash, never black.

## Typography

One neutral grotesque, almost always Bold, always white: mapped to
`BuilderSans` (runner-up `SourceSansPro` — the social overlay lettering leans
that way; noted in extraction). Hierarchy is carried by size and the muted
lavender step, not by family changes. **No text ever carries a stroke** — in
a genre addicted to outlined type, the total absence of text strokes is this
taste's loudest signature.

- `{typography.display}` — event hub titles ("Halloween Event 2022"-scale
  banners). Sentence case.
- `{typography.heading}` — popup window titles, section headers ("Daily
  Missions"), left-aligned in the header band. Sentence case.
- `{typography.body}` — row labels, descriptions. Secondary clauses inline in
  `{colors.on-surface-muted}`, sometimes italic (observed in settings row
  hints).
- `{typography.label}` — button labels and card item names. Buttons are caps
  or title case; card item names are ALL CAPS in `{colors.accent-info}`.
- `{typography.caption}` — keybind tags, counters, field counters ("0/100").
- `{typography.timer}` — a monospaced status voice observed on the
  match-countdown banner ("Match starting in 00:00"). Use it for anything
  that ticks.

px sizes are normalized from crops with a constant-factor caveat (see
extraction notes); treat the hierarchy ratios as load-bearing, not the exact
values. TextScaled policy: fixed textSize everywhere except the mega-CTA and
display banners, which may use TextScaled with `UITextSizeConstraint` capped
at the token size.

## Layout

Density is utilitarian-medium: hubs happily show 8 cards and 4 tabs at once,
but every element is generously padded.

- `{spacing.md}` is the default sibling gap inside rows; `{spacing.lg}` is
  the grid gutter between cards and the gap between stacked rows (observed
  ~20px at reference in the event hub); `{spacing.xl}` is window inner
  padding on hubs; `{spacing.xs}` only for icon-to-label gaps.
- Rows are **full-bleed**: mission and settings rows run edge to edge of the
  content area, and the entire row is the tap surface (~150px tall at
  reference — tall rows, few per screen). Never shrink a row to fit its text.
- Split rows (settings): label segment left at `{colors.header}` takes
  ~60% width; control segment right shares the row height, flush, no gap
  between the segments — the value change IS the divider.
- Card grids: 4 columns on desktop hubs, cells near-square, laid by
  `UIGridLayout` with `{spacing.lg}` CellPadding. Dense utility grids
  (creative inventory) drop to ~44px cells with `{spacing.sm}` gaps.
- All repetition is `UIListLayout`/`UIGridLayout`; sizes are Scale-first with
  `UIAspectRatioConstraint` on cards and pills. Offsets only for spacing,
  strip heights, and the hairline stroke.
- Safe areas: HUD roots use `ScreenGui.ScreenInsets = DeviceSafeInsets`;
  query `GuiService:GetInsetArea()` rather than hardcoding the topbar. Keep
  bottom-left (joystick) and bottom-right (jump) clear; this taste's HUD
  lives top-center and bottom-center.
- Tap targets 44px minimum; the tall-row convention makes most targets far
  larger for free.

## Elevation & Depth

Depth is a value ladder, full stop. No drop shadows, no bevels, no outlines
around containers were observed anywhere in the lobby system.

1. **Value steps** — backdrop → `{colors.surface}` → `{colors.surface-raised}`
   rows → `{colors.header}` bands going "up"; `{colors.surface-deep}` and
   `{colors.surface-dark}` going "down". A reader should be able to tell an
   element's layer by lightness alone.
2. **Hairlines** — the only stroke in the system is
   `{strokes.hairline}` (1px light periwinkle) on inset slot cells and
   featured rows: it marks "this well contains discrete things", not
   elevation. `{strokes.selection}` (2px white) marks the selected cell in a
   grid (observed in the in-match forge; inferred for lobby grids).
3. **Translucency** — in-match chrome (hotbar slots, interaction prompt) is
   semi-transparent over the world; lobby windows sit on the **estimated**
   tinted `{colors.dim}` wash.

Layer stack for popups: dim wash → flat panel (no shadow) → header band and
content (same plane). Reserve DisplayOrder bands per ScreenGui: HUD 0–9,
windows 10–19, popups/toasts 20–29 — with `ZIndexBehavior.Sibling` set
explicitly.

## Shapes

Silhouettes are rectangles first; softness is rationed by element size.

- `{rounded.none}` — full-bleed rows, tabs, toggle segments, progress
  strips, verdict bands, hub windows that fill the screen. Square is the
  default state of this taste.
- `{rounded.sm}` (4px) — buttons, small chips, keybind tags, hotbar slots.
- `{rounded.md}` (8px) — floating popup windows, cards, HUD pills, the
  interaction prompt.
- `{rounded.full}` — price/currency pills only (icon + amount). The pill
  shape is reserved for "this costs/holds a number"; do not spend it on
  ordinary buttons.

Corner strips and bands terminate flush with their parent's corners (the
card's bottom strip inherits the card's bottom radius). Circles exist only in
the radial emote wheel and its satellite icon buttons — an in-match special
case, not a lobby shape.

## Motion

No video input was available: values below are the competitive taste-family
preset (confidence: low), chosen because everything observed in stills points
to speed-over-charm — flat fills, square corners, no celebratory chrome.

- **Entrances** (`{motion.easings.pop}`, `{motion.durations.normal}`): panels
  slide in 12–16px with a fade, or simply appear. No scale-overshoot — in
  this taste bounce would read as lag.
- **Exits** (`{motion.easings.exit}`, `{motion.durations.fast}`): fade +
  slight slide out, always faster than entrances.
- **Press feedback** (`{motion.durations.instant}`): darken the fill one
  value step. No squash.
- **Value changes** (`{motion.easings.settle}`): progress strips and sliders
  interpolate linearly; timers tick in the monospaced voice without tweening.
- Toggle segments swap fills instantly — a settings menu should feel like a
  switchboard, not a game.
- Reduced-motion stance: this taste is already near-static; honoring a
  reduced-motion setting means replacing slides with fades.

## Components

- **button-primary** — flat green rectangle, white bold label, 4px corners,
  no stroke, no shadow. Feels like a form submit. The observed gray
  chip state (`button-primary-disabled`, "0.0% COMPLETE") keeps the shape and
  mutes fill and label.
- **button-cta** — the lobby PLAY slab: oversized, bright green horizontal
  gradient, white caps heading-size label. Exactly one per screen, center
  stage. The only gradient in the entire system.
- **button-buy** — full pill with currency icon left and bold amount right,
  `{colors.secondary}` for soft currency; premium-currency prices swap the
  fill to `{colors.primary}`. Lives centered near card bottoms and inline in
  rows.
- **button-danger** — hot red rectangle, same anatomy as button-primary; for
  destructive/negative actions only.
- **button-close** — a bare white ✕ glyph, no fill, no circle, flush right
  inside the header band, vertically centered. It never overlaps a corner.
  Give it a 44px+ invisible touch target.
- **tab** — text-only segments in the hub header: inactive = muted label on
  band color; selected = darker fill `#363E70` + white label + a 4px
  `{colors.accent-soft}` underline strip flush with the band's bottom edge.
- **currency-bar** — dark `{colors.surface-dark}` pill, icon left, white
  amount; anchored in the hub header band right of the tabs.
- **window / window-header** — see the anatomy below.
- **dim-overlay** — estimated tinted indigo wash behind popups; tap-to-close
  for dismissible windows (inferred, unobserved).
- **list-row** — full-width `{colors.surface-raised}` bar: bold title top,
  muted meta line below, reward/status chips right-aligned, and an optional
  thin `progress-bar` strip pinned along the bottom edge.
- **card-grid** — flat near-square card: art or chunky item name centered,
  ALL-CAPS name in `{colors.accent-info}` below, `button-buy` pill under
  that, and a full-width 6px status strip flush with the bottom edge in the
  item's verdict color. Purchase-prompt variant (armory card): icon + title +
  muted description, hairline divider, hairline-outlined item slots, and a
  full-height verdict footer band (red = cost, gray = owned) across the
  card's bottom.
- **toggle-split** — the settings control: two text segments (On / Off)
  sharing the dark control well; the active segment fills solid green (On)
  or `{colors.danger-soft}` red (Off). No knob, no pill — pure fill swap.
- **progress-bar** — square-ended strip, `{colors.progress-track}` track,
  `{colors.accent-soft}` fill, 8px tall under rows (a taller red variant with
  a centered white number serves as the in-match objective health bar).
- **badge-slot** — tiny dark square keybind/counter tag pinned to a slot's
  top-left corner, white caption digit.
- **hud-pill** — `{colors.hud-ink}` rounded-rect pill for timer / kill count /
  team roster; roster renders each player as a small colored square with a
  white count digit inside.
- **interaction-prompt** — centered dark translucent rounded rect (fill
  estimated through the world behind it): white keybind chip (rounded square,
  dark glyph) left, muted cost line + bold action line right.

### Window anatomy (drawable from prose)

A popup window is a flat `{colors.surface}` rectangle, 8px corners, **no
stroke, no shadow** — it separates from the world only by the dim wash and
its own lightness. The header is an **integrated band**, full window width,
48px tall, one value step lighter (`{colors.header}`), square where it meets
the body; the window's top radius clips its outer corners. Title sits left in
the band, white Bold, sentence case, optionally preceded by a small white
glyph icon; the close ✕ is a bare white glyph flush right **inside** the
band — never a filled circle, never overlapping a corner. Full-screen hubs
stretch the band to ~130px to stack title + muted subtitle left, run the tab
strip inline beside them, and dock the dark currency pill left of the ✕.
Body content is wells and rows on the surface; the footer convention is
either a green `button-primary` bottom-right (forms/popups) or a full-width
verdict band flush with the bottom edge (purchase cards). Layer stack: dim →
panel → band/content, all on one visual plane.

## Screen Patterns

- **In-match HUD**: timer, kill counter, and team-roster pills sit
  top-center in `{colors.hud-ink}`; hotbar bottom-center as translucent slate
  squares with `badge-slot` keybind tags (selected slot darkens and pops its
  tag to white); contextual `interaction-prompt` floats center-right of the
  crosshair; team/objective health bars top-left. Corners stay quiet;
  bottom-left/right reserved zones stay empty. Persistent element count: ~6.
- **Event hub** (shop/missions): full-screen window; header band per the
  anatomy above with Missions/Shop tabs; one muted body line of copy under
  the band; then either a 4-column card grid (Shop) or stacked `list-row`s
  grouped under bold section headings with right-aligned reset timers
  (Missions).
- **Purchase/confirm popups**: compact window per the anatomy; featured
  content in a hairline-outlined row or `{colors.surface-deep}` well; single
  green CTA bottom-right. Two-pane variant (gifting): left
  `{colors.surface-deep}` panel with search field + list, right pane with
  labeled input wells and the CTA.
- **Settings**: full-width split rows, one setting per row, whitespace rows
  of raw surface between them; sliders show the numeric value left of a
  periwinkle track; a slim scrollbar hugs the right edge.
- **Progression track** (contracts/passes): dark header strip with a back
  arrow (the one back-navigation pattern observed), hero art center, then a
  horizontal rail of numbered tier cards — number tab on top, green progress
  fill under it, lock/check tag in the corner — with prev/next arrows and a
  floating stats side panel.
- **Divergent in-match voice**: heavy overlays (forge menu) and the social
  overlay drop to a near-black theme — charcoal panel, white rows or slots,
  star ratings, white `{strokes.selection}` frames, a single warm accent for
  the CTA, hot red action buttons. Treat it as the same grammar (flat fills,
  full-width rows, verdict colors) with the indigo swapped for
  near-black; it is deliberately *not* tokenized here — implement lobby
  screens in indigo.

## Do's and Don'ts

**Do:**
- Build every layer distinction as a lightness step of the base indigo.
- Make the whole row tappable and pin its progress to its bottom edge.
- Deliver status as solid fills: verdict bands, filled toggle segments,
  colored bottom strips.
- Keep the header band lighter than the body, title left, bare ✕ right.
- Reserve the pill silhouette for prices and counters.

**Don't:**
- Never add drop shadows, bevels, or container outlines — the only permitted
  stroke is the 1px hairline on inset slots and the white selection frame.
- Never stroke or outline text, and never use gray text — muted means
  `{colors.on-surface-muted}` lavender.
- Never use green and red in the same element except as toggle poles.
- Never round a full-bleed row or tab; square is correct.
- Never animate with overshoot or bounce; this taste reads bounce as lag.
- Never put a filled circle close button on a window; the ✕ is a bare glyph
  inside the band.

## Agent Prompt Guide

Quick reference for implementing agents:

- Fills: body `#4F5081`, rows `#5A65A3`, header band + split-row labels
  `#6467A8`, wells `#3D3F6A`, dark pills `#383660`, HUD `#1E3B50`. Text
  white; muted `#A9A9D0`. Verdicts: green `#27AE60`, hot red `#FE383B`, soft
  red `#E4696A`, info blue `#5EACFE`, progress `#B9BCFF` on `#787EC7`.
- No UIStroke on containers (1px `#9C9ED7` on inset slots only), no shadows,
  no gradients except the PLAY slab. Corners: 0 for rows/tabs/hubs, 4px
  buttons, 8px popups/cards, pills for prices.
- Font: `Font.fromName("BuilderSans", Enum.FontWeight.Bold)` for nearly
  everything; body Regular 18px; monospaced `RobotoMono` for tickers.
- Windows: flat panel, integrated lighter 48px header band, title left, bare
  white ✕ right, green CTA bottom-right or full-width verdict band on the
  bottom edge.
- Motion: 0.12–0.18s slides/fades, Quart Out in / Quart In out, press =
  darken one step, zero bounce.

Canned prompts:

1. *"Using DESIGN.roblox.md (Indigo Quartermaster), build the event hub
   window: full-screen panel, 130px header band with title + subtitle, an
   inline Missions/Shop tab strip with accent-soft underline on the active
   tab, a currency pill and bare ✕ right, and a Missions tab of full-width
   list-rows with reward chips and bottom-edge progress strips. react-lua,
   Scale-first, safe areas respected."*
2. *"Using DESIGN.roblox.md (Indigo Quartermaster), build the in-match HUD:
   top-center hud-pills (timer, kills, team roster of colored squares), a
   bottom-center translucent hotbar with badge-slot keybind tags, and a
   centered interaction-prompt with keybind chip. Keep joystick/jump zones
   clear."*
3. *"Review this screenshot of my implementation against DESIGN.roblox.md
   (Indigo Quartermaster) and list every deviation — especially any shadow,
   container outline, text stroke, bounce easing, or non-indigo layer color —
   ordered by visual impact."*

---

*Independent analysis of publicly observable UI conventions in BedWars, provided as-is for inspiration. Not affiliated with or endorsed by its creators or any studio. Rights holders may request changes or removal at any time.*
