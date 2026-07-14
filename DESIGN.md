---
name: DESIGN.roblox.md Catalog
description: A white-wall gallery of game-UI tastes, fired in kiln crimson — playful blocks, exacting craft.
colors:
  kiln-crimson: "oklch(52% 0.165 31)"
  kiln-deep: "oklch(41% 0.135 31)"
  kiln-wash: "oklch(95.5% 0.021 31)"
  on-crimson: "oklch(98.5% 0.006 31)"
  on-crimson-soft: "oklch(94% 0.03 31)"
  gallery-white: "oklch(100% 0 0)"
  clay-surface: "oklch(96.5% 0.007 31)"
  hairline: "oklch(90% 0.013 31)"
  hairline-strong: "oklch(80% 0.02 31)"
  roast-ink: "oklch(24.5% 0.02 31)"
  muted-clay: "oklch(45% 0.022 31)"
  golden-sample: "oklch(86% 0.155 92)"
  golden-ink: "oklch(38% 0.08 80)"
  verified-green: "oklch(44% 0.115 152)"
  verified-wash: "oklch(95% 0.03 152)"
  code-slab: "oklch(23% 0.015 31)"
  code-ink: "oklch(92% 0.01 31)"
typography:
  display:
    fontFamily: "Bricolage Grotesque Variable, Avenir Next, Segoe UI, system-ui, sans-serif"
    fontSize: "clamp(2.6rem, 1.9rem + 3.4vw, 4.6rem)"
    fontWeight: 800
    lineHeight: 1.04
    letterSpacing: "-0.025em"
  headline:
    fontFamily: "Bricolage Grotesque Variable, system-ui, sans-serif"
    fontSize: "clamp(1.9rem, 1.5rem + 1.8vw, 2.8rem)"
    fontWeight: 700
    lineHeight: 1.12
    letterSpacing: "-0.02em"
  title:
    fontFamily: "Bricolage Grotesque Variable, system-ui, sans-serif"
    fontSize: "1.25rem"
    fontWeight: 700
    lineHeight: 1.2
    letterSpacing: "-0.01em"
  body:
    fontFamily: "Bricolage Grotesque Variable, system-ui, sans-serif"
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: 1.6
  label:
    fontFamily: "Martian Mono Variable, ui-monospace, SF Mono, Menlo, monospace"
    fontSize: "0.75rem"
    fontWeight: 700
    lineHeight: 1.4
rounded:
  sm: "10px"
  md: "14px"
  lg: "20px"
  xl: "28px"
  pill: "999px"
spacing:
  2xs: "0.25rem"
  xs: "0.5rem"
  sm: "0.75rem"
  md: "1rem"
  lg: "1.5rem"
  xl: "2rem"
  2xl: "3rem"
  3xl: "4rem"
  section: "clamp(4rem, 3rem + 4vw, 7rem)"
components:
  button-primary:
    backgroundColor: "{colors.kiln-crimson}"
    textColor: "{colors.on-crimson}"
    rounded: "{rounded.pill}"
    padding: "0.8125rem 1.5rem"
  button-primary-hover:
    backgroundColor: "{colors.kiln-deep}"
    textColor: "{colors.on-crimson}"
  button-ghost:
    backgroundColor: "{colors.gallery-white}"
    textColor: "{colors.roast-ink}"
    rounded: "{rounded.pill}"
    padding: "0.8125rem 1.5rem"
  chip:
    backgroundColor: "{colors.gallery-white}"
    textColor: "{colors.roast-ink}"
    rounded: "{rounded.pill}"
    padding: "0.375rem 0.875rem"
  chip-selected:
    backgroundColor: "{colors.kiln-crimson}"
    textColor: "{colors.on-crimson}"
  badge-verified:
    backgroundColor: "{colors.verified-wash}"
    textColor: "{colors.verified-green}"
    rounded: "{rounded.pill}"
    padding: "0.1875rem 0.625rem"
  badge-pending:
    backgroundColor: "{colors.golden-sample}"
    textColor: "{colors.golden-ink}"
    rounded: "{rounded.pill}"
    padding: "0.1875rem 0.625rem"
  card:
    backgroundColor: "{colors.gallery-white}"
    rounded: "{rounded.lg}"
  code-block:
    backgroundColor: "{colors.code-slab}"
    textColor: "{colors.code-ink}"
    rounded: "{rounded.md}"
    padding: "1rem 1.5rem"
---

# Design System: DESIGN.roblox.md Catalog

## 1. Overview

**Creative North Star: "The Blocky Diorama Shelf"**

The site is a shelf of blocky toy dioramas photographed by a careful hand:
real in-engine captures framed in white, floating above a warm terracotta
block-world, arranged on pure white gallery walls. The warmth lives entirely
in the brand color (Kiln Crimson) and the generated diorama imagery; the
walls themselves stay pure white so every taste's own palette reads true.
Playfulness sits on the surface — fanned prints, wavy underlines, gently
bobbing cards — while the structure underneath stays exact: verified badges,
lint-clean specs, honest captions.

This system explicitly rejects the sterile technical-document look (a bare
Markdown viewer has no authority to sell taste) and equally rejects
kid-site primary-color noise. The audience is adult engineers; the toys are
the subject, not the voice.

**Key Characteristics:**
- Pure white gallery ground; color arrives only as Kiln Crimson, entry
  screenshots, and the diorama world
- Real screenshots are the heroes — the design frames them, never competes
- Soft, diffuse, layered shadows on floating elements only
- Pill-shaped controls with confident weight; instant, honest feedback
- One golden accent (`golden-sample`) reserved for the exemplar entry

## 2. Colors

A committed two-pole palette: hot kiln against white wall, with tiny
semantic accents.

### Primary
- **Kiln Crimson** (oklch(52% 0.165 31)): the brand's voice. Carries the
  hero canvas, footer, primary buttons, selected filter chips, step
  numerals, and focus rings. On crimson fills, text is always
  `on-crimson` (never gray).
- **Kiln Deep** (oklch(41% 0.135 31)): hover state of primary actions and
  the footer ground. Gold survives on this darker pole (5.8:1); it fails on
  plain crimson — keep gold off `kiln-crimson`.
- **Kiln Wash** (oklch(95.5% 0.021 31)): callout backgrounds and document
  heading underlines. A whisper of the brand, never a body background.

### Secondary
- **Golden Sample** (oklch(86% 0.155 92)) with **Golden Ink**
  (oklch(38% 0.08 80)) text: reserved for "the golden sample" badge and
  preview-pending states. This is the catalog's single yellow; do not
  reuse it decoratively.
- **Verified Green** (oklch(44% 0.115 152)) on **Verified Wash**
  (oklch(95% 0.03 152)): the proof color. Appears only on
  "verified in-engine" badges and copy-success feedback.

### Neutral
- **Gallery White** (oklch(100% 0 0)): the body background. Pure white,
  chroma zero — no hidden warmth.
- **Clay Surface** (oklch(96.5% 0.007 31)): thumbnails' letterbox ground and
  inline-code chips. The only tinted neutral, hued toward the brand.
- **Roast Ink** (oklch(24.5% 0.02 31)): all body text on white (≈13:1).
- **Muted Clay** (oklch(45% 0.022 31)): secondary text (≈6.5:1). Never used
  on colored fills.
- **Hairline / Hairline Strong** (oklch(90% 0.013 31) / oklch(80% 0.02 31)):
  1px borders and dividers only.
- **Code Slab** (oklch(23% 0.015 31)) with **Code Ink** (oklch(92% 0.01 31)):
  code blocks are dark slabs on the white page — the one deliberate
  inversion outside the crimson poles.

### Named Rules
**The White Wall Rule.** The body background is exactly
`oklch(100% 0 0)`. Warmth is carried by Kiln Crimson, imagery, and type —
never by tinting the walls. A cream page is a broken build.

**The One Gold Rule.** Gold marks exactly two things: the golden sample and
a pending preview. Any third use dilutes both.

## 3. Typography

**Display & Body Font:** Bricolage Grotesque Variable (fallback Avenir
Next / Segoe UI / system-ui)
**Label/Mono Font:** Martian Mono Variable (fallback ui-monospace / Menlo)

**Character:** one characterful grotesque doing all the talking — weight
800 shouts the headline, weight 400 explains calmly. The wide mono appears
only where a real machine artifact exists. Playful in silhouette, exact in
setting.

### Hierarchy
- **Display** (800, clamp(2.6rem → 4.6rem), 1.04, -0.025em): hero headline
  only. `text-wrap: balance`.
- **Headline** (700, clamp(1.9rem → 2.8rem), 1.12, -0.02em): page and
  section titles ("Pick a taste", "Getting started").
- **Title** (700, 1.25rem, -0.01em): card names, step titles.
- **Body** (400, 1rem, 1.6): all prose; max measure 65–75ch (62–70ch in
  practice).
- **Label / Mono** (700, 0.75rem): filter group labels, figcaptions, token
  values, the wordmark. Mono is an artifact marker, not decoration.

### Named Rules
**The Honest Mono Rule.** Martian Mono appears only on real technical
artifacts: file names, token values, code, capture labels. Mono as "tech
vibes" costume is prohibited.

## 4. Elevation

Surfaces are flat; only things you could pick up float. Depth comes from
soft, diffuse, multi-layered shadows on floating elements — never from
tonal darkening, never from hard drop shadows.

### Shadow Vocabulary
- **shadow-sm** (`0 1px 2px oklch(24.5% 0.02 31 / 0.05), 0 3px 10px … /
  0.06`): resting cards and small badges.
- **shadow-md** (`0 2px 4px … / 0.05, 0 14px 36px -8px … / 0.14`): sidebar
  panels, floating chips, hovered buttons.
- **shadow-lg** (`0 4px 8px … / 0.05, 0 28px 72px -16px … / 0.22`): hovered
  cards, lifted states.
- **shadow-float** (`0 8px 20px -8px oklch(28% 0.1 31 / 0.3), 0 32px 64px
  -20px … / 0.45`): the hero's fanned prints only — photographs hovering
  above the diorama world.

### Named Rules
**The Lifted Print Rule.** Static surfaces stay flat. Only elements with a
physical metaphor — prints, cards, pills, the copy button — may float, and
they float on large soft diffusion, never a tight dark edge. If a shadow
looks like 2014 Material, it's too dark and too small.

## 5. Components

The shared feel: 押せそうで、仕事は確か — looks pressable like a toy,
behaves precisely like a tool.

### Buttons
- **Shape:** full pill (999px), weight 700, 0.8125rem × 1.5rem padding.
- **Primary:** Kiln Crimson fill with a subtle top-lit vertical gradient
  and inner top highlight; `on-crimson` text. Hover: deepens to Kiln Deep,
  lifts -1px, gains shadow-md. Active: scale(0.97).
- **Ghost:** 1.5px `hairline-strong` border on white, Roast Ink text;
  hover darkens the border and lifts.
- **Inverse:** for crimson grounds — translucent white border, `on-crimson`
  text, hover fills white at 8%.

### Chips (filters)
- **Style:** pill, 1.5px hairline-strong border, white fill, 600 weight.
- **State:** `aria-pressed="true"` flips to solid Kiln Crimson with
  `on-crimson` text. Hover previews with a crimson border. On narrow
  screens chip rows scroll sideways rather than stacking tall.

### Badges
- **verified in-engine:** Verified Green on Verified Wash, leading ✓.
- **preview pending / the golden sample:** Golden Ink on Golden Sample.
- Both pill-shaped, 0.75rem, weight 700.

### Cards / Containers
- **Corner Style:** 20px (`rounded.lg`); hero canvas and footer use 28px.
- **Background:** Gallery White with 1px hairline border and shadow-sm at
  rest.
- **Screenshot-first anatomy:** 16:9 capture on top (the card's face),
  then title + badge, two-line description, palette swatches, tag pills.
- **Hover:** -4px lift, shadow-lg, border warms toward crimson, image
  scales 1.03 over 420ms ease-out-expo.
- **Featured entry:** one wide horizontal card (image ≈60%), never a
  stretched grid cell.

### Inputs
No form inputs exist yet. When they arrive: white fill, hairline-strong
border, `rounded.md`, focus ring = 2px Kiln Crimson offset 2px (the global
focus treatment).

### Navigation
- Sticky header on white at 82% opacity with 12px blur; mono wordmark
  (`DESIGN.roblox.md` with `.roblox` in crimson); 600-weight links.
- Hover: wavy crimson underline (the system's one whimsical flourish).
  Current page: solid 2px crimson underline.
- Footer: inset rounded crimson-deep slab bookending the hero; gold accents
  live here safely.

### The Fanned Prints (signature)
Seven white-framed 16:9 captures fanned like prints on a table: symmetric
Z-rotations (±3°/±6.5°/±10°), even overlap, center print scaled 1.08 and
front-most, edges dipping 2rem. Each print bobs ±7px on an 8s ease-in-out
alternate loop with staggered negative delays; static under
prefers-reduced-motion. The "✓ verified in-engine" chip anchors to the
center print's top-right corner — a label on the photo, not a stray bubble.

## 6. Do's and Don'ts

### Do:
- **Do** keep the body background pure white (The White Wall Rule) and let
  screenshots carry the color.
- **Do** lead every entry surface with the real capture — proof before
  prose, per PRODUCT.md's belief ladder (見た目 → 動く → 安全).
- **Do** use white text on any crimson fill; secondary text on crimson is
  `on-crimson-soft`, never gray.
- **Do** keep motion soft and physical: ease-out-quart/expo, 120–420ms for
  UI, the 8s bob for prints; every animation has a reduced-motion fallback.
- **Do** write copy in the 遊び心×職人気質 voice — playful phrasing,
  exact facts ("rendered in-engine and photographed before it earns a
  spot").

### Don't:
- **Don't** ship the sterile technical-document look PRODUCT.md names as
  the anti-reference — no bare-Markdown-viewer pages, no unstyled spec
  dumps.
- **Don't** tint the page background warm "for coziness"; cream walls are
  prohibited.
- **Don't** put gold text or badges on plain Kiln Crimson (3.6:1 — fails);
  gold belongs on Kiln Deep or white.
- **Don't** use `border-left`/`border-right` stripes, gradient text, or
  glass cards; callouts use Kiln Wash with a full hairline border.
- **Don't** dress non-technical content in Martian Mono (The Honest Mono
  Rule).
- **Don't** give static surfaces shadows; if it can't be picked up, it
  doesn't float (The Lifted Print Rule).
- **Don't** crop or restyle in-engine captures beyond the white frame;
  the proof must stay honest.
