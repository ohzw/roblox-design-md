---
version: alpha
name: Loud Slab
description: >
  Flat square slabs of translucent charcoal under themed chrome header bands
  with an integrated dark-red close square; thick black-outlined white type
  shouts every number in color code, HUD docks pile onto every screen edge,
  and motion runs chunky overshoot defaults.
taste: [flat-slab, loud, meme-maximal, dense]
genre: [collector, pvp-simulator, meme]
inspiration: "Steal a Brainrot"

colors:
  primary: "#519E56"        # buy/price-pill and toggle-on green — the repeated "yes" action
  secondary: "#C2C2C2"      # light-gray utility button (regenerate/secondary actions)
  danger: "#922626"         # close buttons; muted brick red, not neon
  warning: "#FF1715"        # loss/destructive WARNING body text (custom role)
  surface: "#1B2123"        # window body charcoal (rendered semi-transparent over blurred world)
  surface-deep: "#0C1011"   # card wells, filter pills, progress track
  surface-dark: "#3F3B3C"   # interaction prompt plates, settings rows, hotbar slots
  on-surface: "#FFFFFF"
  chrome: "#557080"         # default header-band slate; event windows retheme this slot
  cta: "#826B1A"            # one-off mustard footer CTA (rebirth-style commitment button)
  currency-soft: "#73FF00"  # cash counters and money values — searing yellow-green
  accent-value: "#FFED1F"   # section headings and per-second/price values in yellow
  accent-rare: "#FFDE59"    # gold-tier labels; higher tiers recolor text (e.g. cyan #26C3FE)
  positive: "#10A031"       # common-rarity / confirmation green text (custom role)
  progress: "#F0BB7B"       # tan progress fill
  outline: "#000000"        # universal text ink outline — pure black, never tinted
  dim: "#00000059"          # backdrop darkening behind windows (opacity estimated)

typography:
  display:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 52px
  heading:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 36px
    uppercase: true
  body:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 26px
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 28px
  caption:
    fontFamily: BuilderSans
    fontWeight: Medium
    textSize: 18px

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px, xl: 32px }
rounded: { none: 0px, sm: 6px, md: 10px }
strokes:
  text-outline: { thickness: 3px, color: "{colors.outline}", mode: Contextual }
  slot-outline: { thickness: 2px, color: "#FFFFFF", mode: Border }
  selected-outline: { thickness: 3px, color: "#FFFFFF", mode: Border }

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
    transparency: 0.15
    rounded: "{rounded.none}"
    size: "scale 0.45-0.70 wide, centered; tall windows run near full height"
  window-header:
    backgroundColor: "{colors.chrome}"
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
    height: 72px
  button-close:
    backgroundColor: "{colors.danger}"
    textColor: "#FFFFFF"
    typography: "{typography.heading}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
    aspectRatio: 1
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    shadow: none
  button-secondary:
    backgroundColor: "{colors.secondary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
    shadow: none
  button-buy:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    size: "wide pill-shaped rectangle spanning most of its card, white currency glyph leading the price"
  button-cta:
    backgroundColor: "{colors.cta}"
    textColor: "#FFFFFF"
    typography: "{typography.heading}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
    size: "scale ~0.35 of window width, centered in the footer zone"
  toggle:
    backgroundColor: "#7D6F6F"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
  toggle-selected:
    backgroundColor: "{colors.primary}"
  side-button:
    backgroundColor: "{colors.surface-deep}"
    transparency: 0.25
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
    size: "≈90px square at reference; icon fills the slab, caption label sits inside the bottom edge"
  card-grid:
    backgroundColor: "{colors.surface-deep}"
    stroke: "{strokes.slot-outline}"
    rounded: "{rounded.none}"
    size: "4 columns in a ~0.7-wide window; near-square cells"
  progress-bar:
    backgroundColor: "{colors.surface-deep}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.none}"
    height: 30px
  badge-slot:
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
  prompt-pill:
    backgroundColor: "{colors.surface-dark}"
    transparency: 0.2
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
  currency-bar:
    textColor: "{colors.currency-soft}"
    typography: "{typography.display}"
    textStroke: "{strokes.text-outline}"
  dim-overlay:
    backgroundColor: "{colors.dim}"

extraction:
  inputs:
    - id: hud-full-1
      kind: screenshot
      describes: "Full HUD during gameplay, Windows desktop 1365px client (side rail, hotbar, cash counter, interaction prompts)"
    - id: hud-full-2
      kind: screenshot
      describes: "Full HUD, macOS 1500px client (side rail, leaderboard, timer badge, world signage) — plus one near-duplicate capture"
    - id: hud-full-3
      kind: screenshot
      describes: "Full HUD, macOS client, base overview with billboard nameplates"
    - id: window-index
      kind: screenshot
      describes: "Collection index window: header with search, 4-col card grid, detached tier filter rail, progress dock (UI crop)"
    - id: window-rebirth
      kind: screenshot
      describes: "Rebirth window: slate header, warning text, unlock cards, requirement bar, mustard footer CTA (crop)"
    - id: window-truck
      kind: screenshot
      describes: "Limited-stock vendor window, yellow-themed header, card grid with sold-out state and gray secondary buttons (Spanish locale)"
    - id: window-settings
      kind: screenshot
      describes: "Settings window with toggle rows (full window + one zoomed crop)"
    - id: shop-event
      kind: screenshot
      describes: "Event-skinned shop window with tab row and gear cards (seasonal pixel-lettering variant)"
    - id: shop-money
      kind: screenshot
      describes: "Shop money section: dark-green offer cards with price pills (crop)"
    - id: banner-offers
      kind: screenshot
      describes: "Two promotional banner strips: limited-time offer and starter pack with struck-through worth"
    - id: world-labels
      kind: screenshot
      describes: "World-space collect labels and conveyor nameplates (three shots incl. two in-world signage shots)"
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
    30 sourced files triaged; 10 excluded as non-UI (wiki pages, browser/Paint
    chrome, isolated character renders, promo thumbnails). No video: Motion is
    the cartoon-chunky family preset, low confidence. px calibration anchored
    on hud-full-1 (1365px-wide client, x1.41 to reference) and hud-full-2
    (1500px client, x1.28); window shots are crops without a viewport, so
    their px tokens carry a constant-factor caveat and were reconciled via the
    shared close-button and text-stroke sizes. Dim opacity estimated from a
    single dimmed shot (no undimmed pair of the same region). Toggle off-state
    and sold-out state observed; pressed/disabled states of buttons are NOT
    observed and are left undefined. All inputs are desktop captures — no
    mobile evidence. FredokaOne chosen for the rounded heavy lettering;
    runner-up Baloo-like families noted. Event shop lettering is a seasonal
    pixel-face variant (PressStart2P-adjacent), kept out of tokens.
---

# Loud Slab

## Overview

Loud Slab is the taste of meme-collector megahits: a flat, square, unapologetic
UI that feels like a stack of painted street-market crates with a megaphone on
top. Every panel is a hard-edged charcoal slab dropped over the blurred game
world; every window gets a solid color-coded header band; every number shouts
in its own semantic color with a thick black ink outline. There is no
roundness, no soft shadow, no gloss — the charm comes from density, loudness,
and color-coding, not from toy-like polish. Real-world reference: a hand-
painted taquería menu board — flat colored bands, heavy lettering, prices in a
different color so you can't miss them. Target genre: collector / steal-and-
defend simulators and other meme-driven live games. Adjectives: loud, flat,
dense, color-coded.

## Colors

The chrome is cool and muted so the content can scream. `{colors.chrome}`
slate paints default header bands and requirement panels; event windows
retheme only this slot (observed: yellow vendor band, and prose reports of
purple event bands) while the body stays charcoal. `{colors.surface}` is the
window body, always rendered semi-transparent over the blurred world;
`{colors.surface-deep}` is for wells — cards, filter pills, progress tracks;
`{colors.surface-dark}` is for small floating plates (prompts, settings rows,
hotbar slots). Text is `{colors.on-surface}` white over everything, always
carrying the pure-black `{colors.outline}` ink — this taste never uses warm or
tinted near-blacks; the outline is #000000 flat.

Action colors are strictly behavioral: `{colors.primary}` green marks every
repeatable "yes" (price pills, toggles ON); `{colors.secondary}` light gray
marks utility actions; `{colors.danger}` brick red is reserved for the close
square, while `{colors.warning}` neon red is text-only, for "you will lose
everything" warnings — the two reds never swap jobs. `{colors.cta}` mustard
appears once per window at most, on the big commitment button.
Money is double-coded: `{colors.currency-soft}` yellow-green for cash amounts,
`{colors.accent-value}` yellow for rates and section headings. Rarity is a
text-color ladder (common `{colors.positive}` green, gold `{colors.accent-rare}`,
cyan #26C3FE for a higher tier, rainbow gradients above that) — rarity recolors
TEXT, it does not recolor panels. Danger red never touches money green.

## Typography

One heavy rounded family does almost everything: FredokaOne across display,
heading, body, and label tiers — the single-family look is a taste feature.
`{typography.caption}` drops to BuilderSans for engine-adjacent chrome
(leaderboard columns, slot numbers, timers) so tiny text stays legible.
Window titles and section headings are UPPERCASE or Title Case shouts; row
labels and buttons are Title Case ("Music", "On", "Regenerate"-style); nothing
is lowercase. Every FredokaOne string carries `{strokes.text-outline}` — text
without its black outline reads as broken in this taste. Long windows use
TextScaled on card labels (they visibly shrink to fit), so treat textSize
tokens as intended size at reference and anchor UITextSizeConstraint with
them. Sizes are estimates from mixed-scale captures (see extraction notes).
A seasonal event shop swapped display lettering to a pixel arcade face; treat
that as a skin, not part of the core hierarchy.

## Layout

Density is a feature: the HUD happily shows 10+ persistent elements. The left
edge is the menu: a vertical stack of `side-button` slabs hugging the screen
edge with `{spacing.sm}` gaps, delegated to a UIListLayout. The right edge
mirrors it with a shorter stack (rewards/data). The bottom-left corner is the
money corner — a huge naked `currency-bar` text block with a small caption
line under it. The bottom-center is the hotbar row; the top-right is the
leaderboard plate; the bottom-right holds a tiny timer badge. Windows center
on screen at scale 0.45–0.70 width and delegate their content to
UIListLayout/UIGridLayout with `{spacing.md}` cell gaps and `{spacing.lg}`
inner UIPadding. Keep the bottom-left joystick and bottom-right jump zones
clear on touch devices (all evidence here is desktop; mobile layout is a
declared gap) and keep the top strip free for the platform bar. Tap targets
stay at or above 44px at reference — the side-button slabs run ~90px.

## Elevation & Depth

Depth is achieved with exactly two tricks, and neither is a shadow. First:
windows sit on a blurred, slightly darkened rendering of the live world (a
DepthOfField/blur effect plus `dim-overlay`), which makes flat slabs read as
"above" the game with zero decoration. Second: contrast steps between the
three surface tones (surface, surface-deep, surface-dark) plus thin white
`{strokes.slot-outline}` strokes around wells and cards. There are no bevels,
no drop images, no gradients on chrome. Layering plan (back to front):
world → blur+dim → window slab → header band and close square → floating
banners/toasts. ScreenGuis set ZIndexBehavior Sibling with DisplayOrder bands:
HUD 10, windows 20, promotional banners 30, toasts/alerts 40. Text ink
outlines (3px black) do the "pop" work everywhere else.

## Shapes

Square is the silhouette. Windows, header bands, close buttons, cards, filter
pills, toggles, CTA buttons, side-buttons: all `{rounded.none}` hard corners.
The only rounding lives on small floating conveniences — interaction prompt
plates at `{rounded.md}` and price pills at `{rounded.sm}` — which makes them
read as "temporary" against the permanent square furniture. There are no
circles and no full-pill shapes anywhere in the observed UI. If an element
looks too harsh, the taste answer is a thin white stroke or a surface-tone
step, never a bigger radius.

## Motion

No video input existed, so motion ships the cartoon-chunky family preset
(low confidence, defaulted): overshoot entrances with `{motion.easings.pop}`
scaling 0.8→1.0 over `{motion.durations.normal}`, exits with
`{motion.easings.exit}` at `{motion.durations.fast}` (exits always faster than
entrances), squash-on-press for buttons at `{motion.durations.instant}`, and
`{motion.easings.bounce}` reserved for reward moments. Stills support the
juicy family: world-space collect labels and celebration text render oversized
mid-emphasis, hinting at count-up numbers and scale pops (inferred, not
observed). Respect reduced-motion preferences by collapsing pops to fades at
the same durations.

## Components

**Window anatomy** (the load-bearing prose): a Loud Slab window is a single
square-cornered charcoal slab (`window`) over the blurred world. Its header is
a full-width solid band (`window-header`) flush with the slab's top edge —
not a floating tab, not an overlapping ribbon — in the window's theme color
(default `{colors.chrome}` slate; events swap the band color). The title sits
left-aligned inside the band in heavy white outlined type. The close button
(`button-close`) is a brick-red square docked INSIDE the right end of the
header band, matching its height, never overlapping a corner. Corners resolve
dead sharp: 0 radius, no stroke around the slab, no bevel, no drop image —
the band/body color seam IS the frame. Layer stack: dim+blur → slab → band →
content. The footer convention is a single centered `button-cta` slab
(mustard) for commitments, or a full-width `progress-bar` dock for collection
screens; list windows simply end.

- `window` — feels like a crate lid over the world; content scrolls inside,
  ClipsDescendants on.
- `window-header` — the loudest color on screen; title + optional inline
  search well (`surface-deep` field with white outline text).
- `button-close` — square, brick red, white outlined X; the only red chrome.
- `button-primary` / `button-buy` — green slab with white outlined label; buy
  variant leads with a white currency glyph then the price. Feels like a
  price sticker. Pressed state not observed — implementers use the motion
  squash, not a color shift.
- `button-secondary` — light-gray slab, white outlined label ("Regenerate"
  class utilities). Sold-out cards pair it with a red UPPERCASE caption above.
- `button-cta` — mustard commitment slab, heading-tier text; one per window.
- `toggle` / `toggle-selected` — settings rows are `surface-dark` strips with
  the label left and a square toggle right; gray Off, green On (observed both).
- `side-button` — HUD rail slab: icon fills it, caption sits inside the
  bottom edge; stacked vertically on the screen's left edge.
- `card-grid` — near-black wells with thin white strokes; name caption at the
  top of the cell, rarity caption color-coded at the bottom.
- `progress-bar` — square track in `surface-deep`, tan `{colors.progress}`
  fill, white outlined fraction text ON the bar.
- `prompt-pill` — world-anchored interaction plate: rounded charcoal with a
  keycap square and action text; destructive variants tint dark red.
- `currency-bar` — no plate at all: a naked display-tier TextLabel in
  `{colors.currency-soft}` with the black ink outline, plus a caption line.
- `badge-slot` — white outlined number tucked in a hotbar slot corner;
  selected slot gains `{strokes.selected-outline}`.
- `dim-overlay` — pairs with the world blur; estimated ~35% black.

## Screen Patterns

HUD (desktop evidence): left-edge vertical rail of ~90px square side-buttons
(collection, rebirth, shop, VIP, premium currency, admin); right edge a
shorter mirrored rail; bottom-left the mega cash counter with a boost caption;
bottom-center a 10-slot hotbar of numbered dark squares; top-right a
translucent leaderboard plate (columns: player, steals, rebirths, cash);
bottom-right a tiny timer badge. That is high information density — embrace
it. Shop/vendor windows: themed header band + close, then stacked sections
labeled by yellow uppercase headings, each a grid of cards with green price
pills; promotional banners (limited offers, starter packs) are self-contained
wide slabs with their own dark header strip, item mini-cards, struck-through
old price, and one green buy pill — they float above the HUD near screen
center-bottom. Collection index: header with inline search and a count badge,
4-column card grid, a DETACHED tier-filter rail floating outside the slab's
left edge (black pills, tier-colored labels), and a full-width progress dock
along the window bottom. Settings: single column of toggle rows. World-space
signage repeats the HUD voice: white outlined names, color-coded rarity and
money lines on small dark rounded plates. Mobile composition: not observed —
declared gap.

## Do's and Don'ts

- Never round a window, header, card, or close button — squares are the
  signature; rounding reads as a different game. Only prompts and price pills
  may use `{rounded.sm}`/`{rounded.md}`.
- Never render FredokaOne text without the 3px black ink outline; unoutlined
  text looks unfinished here.
- Never use drop images, bevels, or gradients for depth — depth is blur+dim
  plus surface-tone steps and thin white strokes only.
- Never let the two reds trade jobs: `{colors.danger}` is chrome (close
  squares), `{colors.warning}` is text; and neither may touch money green.
- Never put cash amounts in white — money is always `{colors.currency-soft}`
  or `{colors.accent-value}`; recoloring numbers is how this taste
  communicates.
- Don't invent panel-level rarity theming — rarity lives in text color, not
  in card fills.
- Don't rely on desktop pointing affordances: every action needs a visible
  slab or pill; keycap prompts are a desktop garnish, not the interaction.
- Don't thin the strokes: 2px white on wells, 3px black on text; 1px strokes
  vanish against the blurred world.

## Agent Prompt Guide

Cheat sheet:

- Panels: square `{colors.surface}` slabs (transparency ~0.15) over a blurred,
  dimmed world; header band `{colors.chrome}` (retheme per event), brick-red
  square close at the band's right end.
- Text: FredokaOne everywhere + `{strokes.text-outline}`; BuilderSans for tiny
  chrome. UPPERCASE headers, Title Case labels.
- Actions: green `{colors.primary}` slabs/pills = yes; gray = utility;
  mustard `{colors.cta}` = one big commitment; brick red = close only.
- Numbers: cash `{colors.currency-soft}`, rates/prices `{colors.accent-value}`,
  rarity = text-color ladder, warnings `{colors.warning}`.
- Layout: edge-docked HUD rails of ~90px squares, mega cash counter
  bottom-left, hotbar bottom-center; delegate placement to
  UIListLayout/UIGridLayout; ZIndexBehavior Sibling.
- Motion: pop-in Back/Out 0.25s, exit Quad/In 0.15s, squash on press.

Canned prompts:

1. "Build a shop window in the Loud Slab taste: square charcoal slab over a
   blurred world, slate header band with left title and a brick-red square
   close button inside the band, yellow uppercase section headings, 2-column
   item cards with thin white strokes and green price pills with a leading
   currency glyph."
2. "Build the Loud Slab HUD: left-edge vertical rail of five ~90px square
   dark buttons with icon + white outlined caption, a giant yellow-green
   outlined cash counter bottom-left, a 10-slot numbered hotbar
   bottom-center, and a translucent leaderboard plate top-right."
3. "Build a settings window in the Loud Slab taste: slate header band,
   full-width dark rows with white outlined labels on the left and square
   toggles on the right — green when On, warm gray when Off."

---

*Independent analysis of publicly observable UI conventions in Steal a Brainrot, provided as-is for inspiration. Not affiliated with or endorsed by its creators or any studio. Rights holders may request changes or removal at any time.*
