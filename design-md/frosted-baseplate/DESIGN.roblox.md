---
version: alpha
name: Frosted Baseplate
description: >
  Charcoal slab windows embossed with a toy-brick stud pattern, chromed by
  floating elements instead of integrated bars: the title rides as a sticker
  tab over the top-left edge, the close control is an oversized free-floating
  cross over the top-right, and content stacks as full-width inset rows with
  pill controls. Status and reward chrome swaps the slab for a snow-capped ice
  frame. One chunky rounded family with dark text outlines; pop-overshoot
  entrance motion (preset).
taste: [frosted-baseplate, toy-arcade, chunky, wintry]
genre: [minigame, arena-battler, casual-pvp]
inspiration: "Knock Out!"

colors:
  primary: "#34CC33"          # forward actions — redeem, reset, claim, spin
  secondary: "#1FA5DE"        # tabs, gear/utility icons, mode-vote cyan
  danger: "#F8425A"           # close cross, OFF toggles, locked states
  surface: "#545D61"          # the studded charcoal window slab
  surface-deep: "#45494C"     # inset rows and wells inside the slab
  surface-ice: "#D6F4FD"      # snow-capped banner/frame fill for status & rewards
  on-surface: "#FFFFFF"       # nearly all text is white over darker fills
  currency-soft: "#5FD9F7"    # ice-cyan currency pills and soft-currency prices
  currency-hard: "#83EB39"    # lime premium-currency price pills
  accent-rare: "#FEC81F"      # gold — featured reward columns, event headline text
  outline: "#26282B"          # near-black; text outlines and arcade-pill strokes
  dim: "#0E1A2233"            # estimated — the world behind windows is mostly BLURRED, tint is light

typography:
  display:
    fontFamily: FredokaOne
    fontWeight: Regular       # single-weight family; boldness is baked in
    textSize: 44px
  heading:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 34px
  body:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 24px
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 26px
  caption:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 16px

spacing: { xs: 4px, sm: 8px, md: 12px, lg: 24px, xl: 48px }

rounded: { sm: 8px, md: 14px, lg: 20px, full: full }

strokes:
  outline:              { thickness: 3px, color: "{colors.outline}", mode: Border }
  outline-ice:          { thickness: 4px, color: "#A7E9FF", mode: Border }
  text-outline:         { thickness: 2px, color: "{colors.outline}", mode: Contextual }
  text-outline-display: { thickness: 3px, color: "#2C629B", mode: Contextual }

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
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.md}"
    aspectRatio: 2.8
  button-primary-disabled:
    backgroundColor: "#A2A2A2"
  button-secondary:
    gradient: "vertical(#0BBBFD, #25E7F3)"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.lg}"
    stroke: "{strokes.outline}"
    aspectRatio: 4.1
  button-close:
    backgroundColor: "{colors.danger}"
    stroke: "{strokes.outline}"
    size: "free-floating cross glyph, ~70px tall, overlapping the panel's top-right corner"
  button-buy:
    backgroundColor: "{colors.currency-soft}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.full}"
  button-buy-hard:
    backgroundColor: "{colors.currency-hard}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.full}"
  currency-bar:
    gradient: "vertical(#A5E7FF, #5FD9F7)"
    textColor: "{colors.on-surface}"
    typography: "{typography.body}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.md}"
    height: 52px
  side-button:
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.md}"
    aspectRatio: 1
    size: "~100px square at reference; fill hue varies per destination (see prose)"
  toggle-pill:
    backgroundColor: "#75FE99"
    textColor: "{colors.on-surface}"
    typography: "{typography.label}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.full}"
    height: 40px
  toggle-pill-off:
    backgroundColor: "#FA5055"
  window:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.lg}"
    shadow: "drop(0px 6px #00000040)"
  window-header:
    textColor: "{colors.on-surface}"
    typography: "{typography.heading}"
    textStroke: "{strokes.text-outline}"
    transparency: 1
  dim-overlay:
    backgroundColor: "{colors.dim}"
  card-grid:
    gradient: "vertical(#62B7E8, #02245D)"
    stroke: "{strokes.outline-ice}"
    rounded: "{rounded.md}"
  progress-bar:
    backgroundColor: "#C3CFCB"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    textStroke: "{strokes.text-outline}"
    rounded: "{rounded.sm}"
    height: 24px
  badge-slot:
    backgroundColor: "#A846FD"
    textColor: "{colors.on-surface}"
    typography: "{typography.caption}"
    stroke: "{strokes.outline}"
    rounded: "{rounded.sm}"

extraction:
  inputs:
    - id: shot-hud
      kind: screenshot
      describes: "Full HUD during a round, desktop 1920x1080, with codes panel and settings window open over a blurred world"
    - id: shot-settings-a
      kind: screenshot
      describes: "Settings window crop: studded slab, floating title tab, cross close, two toggle rows"
    - id: shot-settings-b
      kind: screenshot
      describes: "Second settings window capture (different source/scale), same anatomy"
    - id: crop-leftrail
      kind: screenshot
      describes: "Left-rail crop: currency pill, 2x2 launcher grid, settings + emote cluster with keybind badge"
    - id: crop-banner
      kind: screenshot
      describes: "Top-center status banner crop: snow-capped ice slab with icicles, round pill beneath, timed-offer chip right"
    - id: crop-codes
      kind: screenshot
      describes: "Codes panel crop: cyan input well + green redeem pill under a floating title"
    - id: crops-code-states
      kind: screenshot
      describes: "Three codes-panel feedback crops: success, invalid, expired messages replacing the input text"
    - id: shot-daily
      kind: screenshot
      describes: "Daily-reward window: ice frame, 3x2 day-card grid plus featured gold column, claimed/locked button states"
    - id: shot-quests
      kind: screenshot
      describes: "Quest window crop: two tabs, reward reset CTA, three quest rows with progress bars, reward pills, claimed/in-progress buttons, reset timer caption"
    - id: shot-shop
      kind: screenshot
      describes: "Cosmetics shop window crop: studded slab, header row with currency pill + title + cross, inset product rows with odds cards and dual price pills"
    - id: shot-event
      kind: screenshot
      describes: "Seasonal event shop window: retheme of the same window grammar (frame, timer well, offer cards, dual price pills, cross close)"
    - id: shot-bundle
      kind: screenshot
      describes: "Limited bundle purchase screen over the world: green buy card, gift button, three bundle banner cards, stock ribbon"
    - id: crops-vote
      kind: screenshot
      describes: "Two mode-vote buttons: glossy gradient pills with black strokes and purple keybind corner badges"
    - id: shot-wheel
      kind: screenshot
      describes: "Prize-wheel screen: diamond prize cards with odds, spin CTA, gold buy pills"
    - id: shot-emote
      kind: screenshot
      describes: "Radial emote wheel: translucent studded ring with speech-bubble slots"
    - id: shot-index
      kind: screenshot
      describes: "Collection index grid crop: square tiles, per-item fills, padlock overlays on locked entries, name captions"
    - id: shots-marketing
      kind: screenshot
      describes: "Store marketing thumbnails; used only to confirm the rounded single-weight lettering, no UI measured from them"
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
    Viewport calibration: shot-hud is 1920x1080, so its measurements are 1:1
    logical px and anchor everything else. UI-only crops were calibrated
    through shared elements (the settings window and currency pill appear in
    shot-hud and in the crops); px tokens sourced only from crops
    (progress-bar height, vote-pill proportions, quest-row metrics) carry a
    constant-factor caveat. No video input: motion block is the
    cartoon-chunky family preset, confidence low. dim is estimated — windows
    open over a heavily blurred world with only a light tint; no
    dimmed/undimmed pair existed. Typography sizes are medium confidence
    because several came from crops. Sourcing junk excluded: world/arena
    shots, item renders, one lobby screenshot from an unrelated game.
    Pressed/disabled states beyond "claimed" gray were not observed;
    bevel-on-press is inferred from the taste family, marked in prose.
---

# Frosted Baseplate

## Overview

Frosted Baseplate is the taste of casual round-based arena minigames: a toy
construction set left out in the snow. Every panel is a charcoal slab embossed
with a repeating brick-stud pattern — like the underside of a plastic
baseplate — and the festive chrome (status banners, reward windows) is carved
from ice, complete with a snow cap on the top edge and icicles dripping off
the bottom. Controls are saturated candy pills sitting on those slabs.

One concrete reference: **a plastic brick kit photographed in a freezer** —
matte dark gray plates, studs casting tiny shadows, and frost creeping over
the show pieces. The UI never pretends to be glass or paper; it is molded
plastic and ice.

Three rules of thumb:

1. **Chrome floats; it is never welded on.** Window titles hang outside the
   panel as sticker tabs, the close control is a free-floating cross glyph,
   keybind badges perch on button corners. Nothing important is embedded in a
   bar.
2. **Texture carries the surface, color carries the action.** Slabs and rings
   get the stud emboss and stay gray; anything tappable is a flat, saturated
   pill (green = go, red = no, cyan = money).
3. **Two materials, one grammar.** The dark slab (utility: settings, shop,
   codes) and the ice frame (celebration: rewards, quests, banners) share the
   same anatomy — floating title, corner cross, inset content — so retheming
   an event window means swapping material, not layout.

## Colors

Charcoal neutrals under saturated arcade accents, with an ice-cyan family
reserved for celebration and money.

- `{colors.primary}` (green) is the forward-action color: redeem, claim,
  spin, ON. One dominant green per panel.
- `{colors.secondary}` (cyan-blue) handles tabs, utility icons, and neutral
  mode choices. Never used for purchases — cyan money is lighter and pill-shaped.
- `{colors.danger}` (pink-red) is the close cross, OFF toggles, and
  locked/expired feedback. Players find "close" by the color of the cross.
- `{colors.surface}` / `{colors.surface-deep}` are the slab and its inset
  rows. Both are cool grays, never pure black — the stud emboss needs a
  midtone to read.
- `{colors.surface-ice}` is the celebration material: pale ice fills with
  `{strokes.outline-ice}` chrome, snow caps, icicles.
- `{colors.on-surface}` is white; body text is effectively always white with
  a dark outline. There is no dark-on-light body text anywhere in this taste.
- `{colors.currency-soft}` ice-cyan marks the earned currency (HUD pill,
  price pills); `{colors.currency-hard}` lime marks premium prices. The two
  price pills sit side by side on offers, so these hues must never be
  repurposed for decoration.
- `{colors.accent-rare}` gold flags featured rewards (the day-7 column, event
  headline names). A garnish — one gold element per screen.
- `{colors.dim}` is barely there: windows rely on a strong camera blur
  (BlurEffect) rather than a dark backdrop. Estimated value; see extraction
  notes.

## Typography

One rounded single-weight family everywhere: `FredokaOne`. Hierarchy comes
from size and outline weight only, which keeps the toy read intact.

- `{typography.display}` — banner headlines and window titles on ice frames,
  white with `{strokes.text-outline-display}` (a frosty blue outline, not the
  usual near-black).
- `{typography.heading}` — floating window title tabs, white with
  `{strokes.text-outline}`.
- `{typography.label}` — button and toggle text, row labels' louder sibling.
- `{typography.body}` — row labels, currency amounts.
- `{typography.caption}` — timers, odds percentages, keybind badges, card
  names.

Casing is Title Case ("Background Music", "Redeem"), not ALL CAPS; short mode
names may be acronyms. Every piece of text carries a text stroke — white
letters are never naked, whether on slab, ice, or world. TextScaled policy:
buttons, toggles, and titles use `TextScaled` with the token size as the
intended size at reference (bounded by `UITextSizeConstraint`); captions use
fixed `textSize`.

## Layout

Density is medium: the HUD keeps roughly nine persistent elements, windows
keep to one column of rows or a small grid.

- `{spacing.md}` (12px) between grid siblings (launcher grid, day cards);
  `{spacing.lg}` (24px) between window rows; `{spacing.xl}` (48px) as window
  inner padding via `UIPadding` — the slab shows a generous stud apron around
  content. `{spacing.xs}`/`{spacing.sm}` are for icon-to-label and
  pill-internal gaps.
- Repeating content is laid out by `UIListLayout`/`UIGridLayout` with spacing
  tokens as `Padding`/`CellPadding`; rows are full-width inside the padded
  slab.
- Sizes are Scale-first with `UIAspectRatioConstraint` (see component
  `aspectRatio`); offsets are reserved for strokes and spacing.
- Safe areas: HUD roots use `ScreenGui.ScreenInsets = DeviceSafeInsets`;
  query `GuiService:GetInsetArea()` rather than hardcoding the topbar.
- Tap targets 44px minimum; launchers (~100px) and the close cross (~70px)
  are far above it. The observed desktop layout parks settings/emote in the
  bottom-left — on touch devices move that cluster up the left rail, clear of
  the virtual joystick.

## Elevation & Depth

Depth is molded, not blurred — with one exception: the world itself blurs
behind windows.

1. **Emboss** — the stud pattern on slabs and rings is the primary depth
   texture (a tiled `ImageLabel` over the fill; subtle, ~10% contrast).
2. **Inset rows** — content wells use `{colors.surface-deep}` against
   `{colors.surface}`; darker = deeper. No strokes on rows.
3. **Selective strokes** — `{strokes.outline}` (near-black, 3px) belongs to
   arcade pills (mode votes, keybind badges) and the close cross;
   `{strokes.outline-ice}` (4px pale blue) frames ice cards. Slabs
   themselves have no outer stroke — their edge is a soft drop shadow
   (`drop(0px 6px)`).
4. **Backdrop** — opening any window applies a strong camera BlurEffect plus
   the faint `{colors.dim}` tint. The world stays visible and bright; black
   dims are foreign here.

Layering plan (ScreenGuis with `ZIndexBehavior = Sibling`): reserve
`DisplayOrder` bands — HUD 0–9, windows 10–19, floating chrome/toasts 20–29.
Within a window, the panel sits lowest, inset rows above it, and the floating
title tab and close cross above the panel edge (they overlap it by design).

## Shapes

Rounded rectangles with honest corners; full pills mark interaction.

- `{rounded.sm}` (8px) — inset rows, progress tracks, keybind badges.
- `{rounded.md}` (14px) — buttons, launcher squares, currency pill, cards.
- `{rounded.lg}` (20px) — window slabs, mode-vote pills, the emote ring's
  bubble slots.
- `{rounded.full}` — toggles and price pills only. A pill silhouette means
  "this is a switch or a price".

Silhouette rules: windows are landscape rounded slabs; the close control is a
four-armed cross silhouette (no containing circle); status banners are wide
ice slabs with irregular snow-cap tops and icicle drips breaking the bottom
edge — the only intentionally non-geometric silhouette in the taste. Prize
screens may rotate cards 45° into diamonds; interactive buttons never rotate.

## Motion

No video input existed: the values above are the cartoon-chunky family preset
(confidence low) and the patterns below are inferred from stills where noted.

- **Entrances** (`{motion.easings.pop}`, `{motion.durations.normal}`):
  windows scale 0.8 → 1.0 with Back-Out overshoot while the world blur ramps
  in over the same duration. Never fade-only.
- **Exits** (`{motion.easings.exit}`, `{motion.durations.fast}`): scale to
  0.9 + fade, blur releases. Exits faster than entrances.
- **Press feedback** (`{motion.durations.instant}`): pills squash to ~0.93
  scale on press and restore with `{motion.easings.settle}` (inferred —
  no pressed frame was captured).
- **Value changes** (`{motion.easings.settle}`): currency counts tween up;
  progress bars fill smoothly; countdown timers tick per second without
  tweening.
- **Rewards** (`{motion.easings.bounce}`, `{motion.durations.slow}`):
  reserved for reward reveals and wheel results.
- Reduced motion: swap pop/bounce for settle and keep the blur — the blur,
  not the scale, is what separates "window open" from "HUD".

## Components

- **window** — the anatomy that defines this taste. A charcoal
  stud-embossed slab (`{rounded.lg}`, soft drop shadow, no outer stroke)
  floats over the blurred world. There is **no header band**: the title is a
  floating tab — a small circular icon badge plus `{typography.heading}`
  white outlined text — hovering over the slab's top-left edge, half outside
  the panel. The close control is an oversized `{colors.danger}` cross glyph
  with a near-black stroke overlapping the top-right corner, floating free of
  the edge. Content is a single padded column of inset rows or a grid; there
  is **no footer** — CTAs live inline in their rows. Layer stack: blurred
  world → dim tint → slab (shadow) → inset rows → floating tab and cross.
  Celebration windows (rewards, quests, events) keep this exact grammar but
  swap the slab for a `{colors.surface-ice}` frame with a snow cap, icicles,
  and `{strokes.outline-ice}` card chrome; their close cross may sit on a
  small corner ribbon.
- **window-header** — the floating tab described above. Transparent
  background; icon badge left, title right. Never stretch it into a bar.
- **button-close** — the pink-red cross IS the button; no circle behind it.
  Oversized (~70px), always top-right, always overlapping the corner.
- **button-primary** — flat green rounded rect ("Redeem", "Claim", "Spin"),
  white outlined label. Disabled/claimed state goes flat gray `#A2A2A2` and
  keeps its label (observed on claimed reward cards).
- **button-secondary** — the glossy arcade pill (mode votes): vertical cyan
  gradient, 3px near-black stroke, wide (aspect ~4.1), with a `badge-slot`
  keybind square pinned to its top-left corner. Red and other hues re-skin
  the gradient for other options; the stroke and badge stay.
- **button-buy / button-buy-hard** — paired price pills on offer cards:
  ice-cyan for earned currency, lime for premium. Icon left, amount right,
  full-rounded. They appear side by side; never show one without a clear icon.
- **currency-bar** — top-left pill: oversized ice-cube icon overflowing the
  left edge, white outlined amount. Light cyan vertical gradient. One
  currency, one pill.
- **side-button** — ~100px rounded squares in a 2×2 launcher grid, each with
  its own saturated fill (observed: purple, red, green, orange — one hue per
  destination), a chunky 3D icon, and a white outlined caption inside the
  bottom edge. No stroke; the saturated fill carries it.
- **toggle-pill** — settings rows end in a full-rounded state pill: mint
  green ON / red OFF with the state word as its label. The pill swaps color
  and text together; there is no knob.
- **card-grid** — reward/day cards: vertical ice-blue gradient fills with
  pale 4px strokes, day label top, prize art center, state button bottom.
  Featured items expand into a gold-framed column spanning the grid's
  height (`{colors.accent-rare}` title). Collection-index tiles are the same
  card at square aspect with padlock overlays when locked.
- **progress-bar** — quest rows: light gray rounded track, green fill,
  centered white outlined fraction caption ("1/7"). Fills animate with
  `settle`.
- **badge-slot** — small purple square (`{rounded.sm}`, near-black stroke)
  showing a keybind number/letter, pinned overlapping a button's corner.
- **dim-overlay** — faint tint + camera BlurEffect; see Elevation & Depth.

Not observed, therefore not defined: tooltip, badge-notification counters,
hover variants. Implementing agents should fall back to taste defaults
knowingly.

## Screen Patterns

- **HUD (desktop observed)**: top-center status banner — an ice slab with
  snow cap announcing the phase — with a small round-counter pill directly
  beneath; top-right timed-offer chip (mascot render + green countdown
  caption); top-left engine chrome left untouched. Left rail: currency pill
  at the very top, 2×2 launcher grid under it. Bottom-left: settings gear on
  a small studded square + dark emote pill with an "F" keybind badge (move
  this cluster up on touch to clear the joystick). Bottom-center and
  bottom-right stay empty for gameplay. ~9 persistent elements.
- **Codes panel**: floats top-center below the banner — a floating title
  (bird icon + "Codes"), a bright cyan input well on a slim slab, and a green
  redeem pill flush right. Feedback replaces the input's text ("Invalid
  code", "Code Expired!") rather than spawning toasts.
- **Settings**: slab window, two to three full-width rows — label left,
  toggle-pill right. No tabs, no footer.
- **Shop / offers**: slab window with a header row (currency pill left,
  title center-right, cross close right), then full-width product rows: item
  art left, odds/variant card strip center, price pill(s) right. Limited
  bundles instead float directly over the world: a green buy card left, the
  3D item center, and a row of bundle banner cards along the bottom with
  stock ribbons.
- **Quests / rewards**: ice-frame window; quests add two rounded tabs
  (selected = saturated cyan, unselected = pale ice) hanging on the top edge
  and a reset timer caption below the frame; rows are progress bar +
  reward pill + state button. Daily rewards is a day-card grid plus the
  featured gold column, timer caption top-right.
- **Emote wheel**: a translucent studded gray ring with eight speech-bubble
  slots around it; center stays empty for the crosshair/character.
- **Prize wheel**: diamond-rotated prize cards with odds captions around a
  center grand-prize card, spin CTA pill bottom-center flanked by gold
  premium buy pills.

## Do's and Don'ts

**Do:**
- Keep window titles floating over the top-left edge and the cross floating
  over the top-right — chrome overlaps edges, always.
- Emboss every slab and ring with the stud texture; a flat gray panel reads
  as unfinished in this taste.
- Blur the world when any window opens; release the blur on close.
- Outline every piece of text, white fill, dark (or frosty-blue) stroke.
- Pair every premium price with its earned-currency sibling pill.

**Don't:**
- Never build an integrated title bar or footer button band inside a window.
- Never put a circle behind the close cross — the cross silhouette is the
  button.
- Never use a heavy black backdrop behind windows; the blur carries focus.
- Never give inset rows a stroke; depth inside slabs comes from darker fills.
- Never use `{colors.currency-soft}`/`{colors.currency-hard}` for anything
  that isn't money.
- Never rely on keybind badges alone for affordance — they are desktop
  garnish; touch users must be able to tap the pill itself.

## Agent Prompt Guide

Quick reference for implementing agents:

- Slabs: `Color3.fromHex("#545D61")`, `UICorner` 20px, stud-emboss tile
  image, drop shadow 6px, NO outer `UIStroke`. Rows: `#45494C`, 8px corners,
  no stroke, 24px list gaps, 48px `UIPadding` on the slab.
- Floating chrome: title tab (icon + `Font.fromName("FredokaOne")` 34px
  white, 2px `#26282B` contextual stroke) overlapping top-left; danger
  `#F8425A` cross ~70px overlapping top-right.
- Pills: green `#34CC33` = act, mint/red full-rounded = toggle state,
  ice-cyan/lime full-rounded = prices, cyan gradient + 3px black stroke +
  purple keybind badge = arcade choice.
- Motion (preset): open scale 0.8→1.0 Back-Out 0.25s with camera blur; close
  0.15s Quad-In; press squash 0.93 at 0.08s; Elastic only on rewards.
- Layout: UIListLayout/UIGridLayout only, Scale + aspect sizing,
  DeviceSafeInsets, 44px+ targets, joystick/jump zones clear.

Canned prompts:

1. *"Using DESIGN.roblox.md (Frosted Baseplate), build the HUD: top-center
   ice status banner with round pill, top-left currency pill over a 2×2
   launcher grid (purple/red/green/orange), settings + emote cluster on the
   left rail. react-lua, Scale-first, safe areas respected."*
2. *"Using DESIGN.roblox.md (Frosted Baseplate), build the Settings window:
   studded charcoal slab, floating gear+title tab top-left, floating cross
   close top-right, two rows with mint/red toggle pills, camera blur behind.
   Include entrance/exit motion per the Motion section."*
3. *"Review this screenshot of my implementation against DESIGN.roblox.md
   (Frosted Baseplate) and list every deviation from the Do's and Don'ts and
   Components sections, ordered by visual impact."*

---

*Independent analysis of publicly observable UI conventions in Knock Out!, provided as-is for inspiration. Not affiliated with or endorsed by its creators or any studio. Rights holders may request changes or removal at any time.*
