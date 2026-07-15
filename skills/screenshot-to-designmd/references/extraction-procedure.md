# Extraction procedure (layer by layer)

Work in this order — later layers reference earlier tokens.

## Measuring: convert to LOGICAL pixels first

px tokens are offset pixels (SPEC §5.3: defined against the 1920×1080
reference). Roblox UI chrome (pills, strokes, radii, text) is typically
authored in offset px, which render at the same logical size on every
screen — so **the logical-pixel measurement IS the token**. The pipeline:

```
logical_px = image_px * (logical_viewport_width / image_width)
token      = logical_px          # for offset-authored elements (the norm)
```

- **Find the logical viewport width first.** Screenshots are usually
  downscaled (retina captures, MCP `screen_capture` output), so image px
  understate logical px. Sources: ask the user for their
  device/window size; for MCP captures query
  `workspace.CurrentCamera.ViewportSize` via `execute_luau` (the capture
  image itself comes out ~1920px wide regardless of viewport — confirm via
  aspect ratio). Record the viewport and the conversion factor in extraction
  notes. If truly unknowable, assume a 1920-wide viewport and SAY SO — a
  wrong assumption skews every px token by a constant factor (calibration
  measured a 0.72× systematic skew from exactly this mistake).
- **Canonical context for component sizes**: measure components where they
  live (HUD, windows), not in isolated lineups/galleries, which may render
  non-canonical sizes. When contexts disagree, prefer the in-situ value and
  record the range in the component's `size` prose.
- **Colors are literal hex, never `{references}`** (grammar). If two roles
  share a value (e.g. accent-rare equals secondary), duplicate the hex and
  note the coincidence in prose — roles may diverge in other games of the
  same taste.
- Elements sized by Scale rather than offsets (full-width panels, HUD-scaled
  containers) vary with the viewport; describe those with scale/aspect
  intent in component `size`, not px.
- **UI-only crops have no viewport at all.** Calibrate scale through shared
  elements across images instead: match stroke weights, known tap-target
  sizes, or identical components appearing in multiple shots, then record
  the calibration chain (which anchor, which factor) in extraction notes.
  All px tokens from crops carry a constant-factor caveat — say so.
- Round to friendly steps: spacing to 4px, radii to 2px, strokes to 1px.
  Rationale: sub-pixel precision is rendering noise, and clean scales make
  the document more deterministic across runs.
- If the screenshot is a phone capture with visible letterboxing/notch,
  measure inside the safe area only.
- **TextScaled undershoots the intended token.** Text rendered with
  TextScaled + padding is smaller than its designed textSize. When a text
  element visibly fills its container, treat the measurement as a lower
  bound and round UP toward the nearest hierarchy step.

## 0. What a taste actually is (read before extracting)

**Colors are the swappable layer; structure is the identity.** The point of a
DESIGN.roblox.md is to let someone reproduce the window grammar, component
anatomy, and motion signature of a taste — possibly with a completely
different palette. Extract colors faithfully, but write every other section
so a reader could recolor the whole document without touching it. The
`description` front-matter field must be a one-line STRUCTURAL summary
(window grammar + motion signature), not a list of colors.

**Classify every ornament as UI-primitive vs IMAGE-ASSET.** For each decorative
effect you see (a gradient, a glow, a glossy icon, a stylized name, a rarity
tile, a banner burst), decide and RECORD in the doc whether it is (a) reproducible
with Roblox UI primitives (`UIGradient`/`UIStroke`/`UICorner`/layered frames — a
fill, sheen, stroke, or single-color glow behind an icon/stroke), or (b) a
pre-rendered IMAGE ASSET (baked stylized typography, per-item bespoke design,
3D/faceted shading, or a light-burst). Mis-classifying is a load-bearing failure:
if the doc calls a baked-art effect a "gradient/glow," the implementer rebuilds
it out of UI primitives and produces a cheap, identity-less fake (verified: per-
item name wordmarks described as "UIGradient text + glow" came out uniform with
an elliptical-donut halo the real game never had). Heuristic: **if it differs per
item, or has baked type / 3D / a burst, it is an asset slot** — describe its
STYLE in prose and mark it an `ImageLabel` slot (no asset IDs — SPEC §7), never
a UI recipe. Flag the reverse too (a plain per-panel gradient is UI, not an
asset). This classification belongs in Colors/Typography/Components prose, not
just implied.

## 1. Colors

1. **Exclude the game world.** Terrain, sky, characters are not UI. Only
   sample fills, strokes, and text of GUI elements.
2. Sample from the CENTER of flat fills — never near edges (anti-aliasing)
   or on gradients (sample both ends, record as a gradient).
3. Cluster samples: if two observed colors are within ~ΔRGB 10 per channel,
   they are probably the same token rendered differently (shading,
   compression). Merge and note.
4. Assign semantic roles using behavior, not hue:
   - `primary` = the color of the most repeated forward-action button
     (buy/claim/hatch) — usually the most saturated recurring button color.
   - `danger` = close buttons / destructive actions.
   - `surface` / `surface-deep` = window panel fill / inset wells.
   - `on-surface` = default body text color on surface.
   - `currency-soft` / `currency-hard` = the two currency icon/pill accents.
   - `accent-rare` = rarity ribbons, "NEW!" flashes.
   - `outline` = the dominant stroke color (see §3).
   - `dim` = popup backdrop; estimate opacity by comparing dimmed vs undimmed
     areas of the same world region (record as #RRGGBBAA).
5. Note colors that are near-black or near-white: is the taste using pure
   black/white, or warm/tinted variants? This single observation strongly
   separates taste families — record it in the Colors prose.
6. **One-color-many-roles tastes** (a single ink serving CTA fill, strokes,
   text, and icons): assign `primary` to the color of the DOMINANT forward
   CTA (the biggest "start playing / buy now" button), even when smaller
   repeated buy-buttons use a different accent — those become their own
   semantic tokens. Duplicate the hex into every role it genuinely plays
   (`outline`, `on-surface`...) and state the coincidence in prose.

## 2. Typography

1. Identify the family per `font-mapping.md`. Check whether ONE family serves
   all tiers (common in simulators) or headers/body differ.
2. Build the size hierarchy from observed text, normalized to reference px,
   mapped onto the five tiers: `display` (rewards/titles), `heading`
   (window headers), `body`, `label` (buttons), `caption` (badges/counters).
   Skip tiers you never observed (do not invent sizes for them).
3. Record casing (are buttons/headers ALL CAPS?) and **text stroke usage**:
   which text carries an outline, how thick, what color. In Roblox game UI
   text strokes are a first-class taste feature.

## 3. Spacing, Shapes, Strokes

- **Strokes first**: measure outline thickness on 3+ different elements. If
  containers and windows differ (e.g. 3px vs 5px), that is a two-step stroke
  scale — record both. Determine the stroke color(s); a single universal
  outline color is a strong taste signature.
- **Corner radii**: measure on buttons, windows, small elements. Detect
  pills/circles (radius ≥ half height) → `full`. Map measurements onto
  sm/md/lg/full steps.
- **Spacing**: measure sibling gaps in lists/grids and window inner padding.
  Cluster into xs/sm/md/lg/xl (typical centers: 4/8/12/20/32).
- **Shadows/bevels**: look UNDER buttons — a darker strip of the fill color
  at the bottom edge is a `bevel(<h>px <color>)` (fake-3D, very common in
  cartoon tastes). Detached soft darkness behind windows is
  `drop(<x>px <y>px <color>)`. Absence of both is itself a taste fact.

## 4. Motion

Stills cannot prove motion. Choose the taste family in
`motion-presets.md`, copy its preset block, and write the Motion prose in
terms of the patterns you can INFER from stills (e.g. a mid-celebration
screenshot with oversized scaled elements hints at overshoot entrances) —
marked as inferred. Only a video input upgrades values: follow the bucket
procedure in motion-presets.md. Motion confidence without video: `low`
(preset) or `medium` (preset + strong still evidence).

## 5. Components

For each staple in `spec-config.yaml` `components.recommended_names`: if it
appears in the screenshots, define it — fill color, text color, typography
tier, rounded step, stroke, shadow/bevel, aspect ratio. States
(`-pressed`, `-disabled`, `-selected`) only when a screenshot shows them;
otherwise either omit or mark inferred in the extraction notes.

**Window anatomy is mandatory prose** whenever a window appears in the
inputs. Answer, explicitly: How is the header treated (band overlapping the
top edge? integrated bar? floating tab?)? Where is the close button and does
it overlap a corner? How do corners/edges resolve (radius step, stroke
weight, bevel/flat)? What is the layer stack (dim → shadow → panel → chrome)?
What is the footer/CTA convention? These answers ARE the taste — a reader
should be able to draw the window wireframe from your prose alone.

**Selected vs rarity disambiguation** (one emphasized card in a grid): if the
emphasis is a heavier/different-colored OUTLINE or a lighter FILL, read it as
`-selected`; if it is a ribbon, corner tag, or inner glow in an accent color,
read it as rarity styling. Both can coexist on one card. When still
ambiguous, record as `-selected` with the ambiguity noted.
Do NOT define components you never saw: absence is information for the
implementing agent (it will fall back to taste defaults knowingly).

## 6. Screen Patterns

From the HUD shot: draw the placement map in prose — what sits on each edge,
what is anchored to corners, what stays clear (virtual joystick bottom-left,
jump bottom-right, topbar strip). Count persistent HUD elements (information
density). From window shots: header treatment, close-button position, content
structure, footer CTA conventions. Only describe patterns for screens you saw.

## 7. Assemble and annotate

- Front matter first (tokens with recommended names), then body sections in
  canonical order, then the `extraction` block:

```yaml
extraction:
  inputs:
    - id: shot-1
      kind: screenshot
      describes: "HUD during gameplay, desktop 16:9"
  confidence:
    Colors: high        # per-section: high / medium / low
    Motion: low
  notes: "No inventory screen; card-grid omitted. Dim opacity estimated from shot-2."
```

- Every section body that used a default must SAY so inline.

## Self-review checklist (run before delivering)

- [ ] Linter: 0 errors (`node tools/linter/lint.mjs <file>`)
- [ ] Every token traceable to an input in `extraction.notes`/`inputs`
- [ ] No CSS vocabulary anywhere (margin/border/box-shadow/z-index...)
- [ ] No `Gotham*`/`Arial*` families
- [ ] No third-party game name in `name`; disclaimer footer present
- [ ] Prose: at least one concrete real-world reference in Overview;
      every section explains intent, not just values
- [ ] Sections in canonical order; unseen sections either omitted or
      explicitly marked as defaulted with `confidence: low`
