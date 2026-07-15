# DESIGN.roblox.md — Format Specification (alpha)

`DESIGN.roblox.md` is a plain-text design system document that lets an AI coding
agent reproduce a specific Roblox game-UI *taste* — without the agent (or its
user) knowing anything about design. It adapts the open-source
[Stitch DESIGN.md format](https://github.com/google-labs-code/design.md) to the
Roblox engine: same two-layer anatomy, same extensibility philosophy, but every
value and every convention is expressed in Roblox-native vocabulary.

The machine-readable source of truth for this spec is
[`spec/spec-config.yaml`](spec/spec-config.yaml); the linter in `tools/linter`
enforces it. When this document and spec-config disagree, spec-config wins.

**Status: alpha.** Expect changes as the format matures alongside the
extraction and implementation skills.

---

## 1. Design principles

1. **Prose, not tokens.** (Inherited from upstream, and it matters more here.)
   Token values are context, not rendering instructions. The quality of a
   generated UI is determined less by the precision of values than by how
   clearly the *intent* is described — "chunky toy-like buttons you want to
   press, everything outlined like a sticker" carries more than twenty hex
   codes. Every section pairs machine-readable tokens with prose explaining
   what the tokens are *for*.
2. **Roblox-native vocabulary only.** CSS vocabulary is banned. If a concept
   cannot be expressed with Roblox instances and datatypes (UDim2, UIStroke,
   UICorner, UIGradient, UIListLayout, UIPadding, UIAspectRatioConstraint,
   ZIndex, ClipsDescendants, TweenInfo...), it does not belong in this file.
   Rationale: the consuming agent writes Luau, not CSS; forcing translation at
   read-time is where hallucinations start.
3. **Upstream-compatible skeleton.** Sections shared with Stitch DESIGN.md keep
   upstream's canonical names and relative order. Roblox-specific concerns live
   in *extension sections* (Motion, Screen Patterns, Agent Prompt Guide), which
   upstream tooling must preserve per its own "unknown sections are preserved"
   rule. A DESIGN.roblox.md degrades gracefully in generic DESIGN.md tools.
4. **Evidence and confidence are first-class.** Files produced by extraction
   carry per-token provenance (which screenshot, which element) and per-section
   confidence, so a human can review cheaply and an agent knows which values
   are load-bearing versus defaulted.
5. **UI-vs-asset boundary is load-bearing.** Every ornament is either a UI
   primitive the implementer BUILDS (`UIGradient`, `UIStroke`, `UICorner`,
   layered frames, a single-color glow behind an icon/stroke) or a pre-rendered
   IMAGE ASSET they PLACE (baked stylized typography, per-item bespoke design,
   3D/faceted shading, a light-burst). The document must classify each one, in
   prose: describe an asset's STYLE and mark it an image slot (never an asset ID
   — §7), and give a UI recipe only for genuine UI. Mis-labeling baked art as a
   "gradient/glow" recipe is a high-severity failure — it makes implementers
   rebuild art out of primitives and ship identity-less fakes (a per-item
   wordmark faked as UIGradient text yields uniform names and a glowing
   elliptical halo the source never had). Heuristic: *if it differs per item, or
   has baked type / 3D / a burst, it is an asset.*

## 2. File anatomy

A file is **YAML front matter** (fenced by `---`) followed by a **Markdown
body**. An optional `#` H1 title is allowed but not parsed. All sections are
`##` H2 headings.

- Sections **may be omitted**, but those present **must appear in canonical
  order** (§4). A duplicate canonical section is an **error — reject the file**.
- Unknown sections and unknown front-matter keys are **preserved, never
  rejected** (extensibility). Typo-like keys (`colours:`) trigger a warning.
- Token references use `{path.to.token}` syntax, e.g. `{colors.primary}`,
  `{motion.durations.fast}`. References must resolve within the same file.
  Composite references (e.g. `typography: "{typography.label}"`) are allowed
  only inside `components`.

## 3. Front matter schema

Allowed top-level keys: `version`, `name`, `description`, `taste`, `genre`,
`extraction`, `colors`, `typography`, `spacing`, `rounded`, `strokes`,
`motion`, `components`. Custom keys are permitted.

### 3.1 Identity

```yaml
version: alpha
name: Cartoon Chunky            # taste name — never a third-party game name (§7)
description: >
  Bright, toy-like UI for pet-collecting simulators ...
taste: [cartoon-chunky, playful, juicy]
genre: [simulator, pet-collector]
```

### 3.2 Colors

Values are `"#RRGGBB"` (recommended) or `"#RRGGBBAA"` — alpha maps to
`1 - Transparency`. Implementations convert with `Color3.fromHex`.

```yaml
colors:
  primary: "#5FCB3F"        # main CTA green — the "yes, tap me" color
  danger: "#F24E4E"
  surface: "#FFF7E0"
  outline: "#4A2E14"        # the taste's universal sticker-outline brown
  currency-soft: "#FFD84D"
```

Recommended semantic names (extraction should prefer these; games rarely need
all of them): `primary`, `secondary`, `danger`, `surface`, `on-surface`,
`currency-soft`, `currency-hard`, `accent-rare`, `outline`, `dim`.
Rationale for the non-web names: Roblox game UI's recurring semantic slots are
currencies, rarity accents, and the outline color — not link/info/muted.

### 3.3 Typography

**FontFace-first.** `fontFamily` is a family name usable with
`Font.fromName()`, combined with `fontWeight` (`Enum.FontWeight` name or
100–900) and optional `fontStyle`. Do **not** use `Enum.Font` legacy values in
tokens. `Gotham*` and `Arial*` are banned: they were removed from the engine
and silently remap (to Montserrat / Arimo) — name the real family instead.

```yaml
typography:
  display:
    fontFamily: FredokaOne
    fontWeight: Regular      # FredokaOne ships one weight; boldness is baked in
    textSize: 42px
  label:
    fontFamily: FredokaOne
    fontWeight: Regular
    textSize: 24px
    uppercase: true
```

`textSize` is defined at the reference resolution (§5.3); component rules may
mandate `TextScaled` instead — the token then acts as the intended size at
reference, which also anchors `UITextSizeConstraint` bounds.

**Family mapping table.** Extraction maps observed lettering to the nearest
Roblox family. This table is normative for the extraction skill:

| Observed lettering | fontFamily |
|---|---|
| Rounded, chunky, cartoon bold (most simulators) | `FredokaOne` |
| Roblox-modern neutral (platform default look) | `BuilderSans` |
| Geometric sans, general-purpose bold | `Montserrat` |
| Humanist/neutral body text | `SourceSansPro` or `Nunito` |
| Blocky loud display / impact shouts | `LuckiestGuy` or `Bangers` |
| Condensed heavy grotesque (modern lobby CTAs) | `Oswald` |
| Hand-written / comic | `PatrickHand`, `Kalam`, `IndieFlower` |
| Horror drip | `Creepster` |
| Sci-fi / techno | `Michroma`, `Sarpanch` |
| Retro arcade / pixel | `PressStart2P` |
| Serif fantasy / classical | `Merriweather`, `Garamond` |
| Monospace / code | `RobotoMono` |

### 3.4 Spacing, rounded, strokes

Dimensions are `<number>px` = **pixel offset at the 1920×1080 reference
resolution** (§5.3). `rounded` additionally accepts `full` (pill,
`UDim.new(1, 0)`).

```yaml
spacing: { xs: 4px, sm: 8px, md: 12px, lg: 20px, xl: 32px }
rounded: { sm: 8px, md: 14px, lg: 22px, full: full }
strokes:
  outline:      { thickness: 3px, color: "{colors.outline}", mode: Border }
  text-outline: { thickness: 2px, color: "{colors.outline}", mode: Contextual }
```

`strokes` is a Roblox-specific token group (no upstream equivalent): outlined
UI is so central to Roblox game aesthetics that stroke weight/color *is* taste.
`mode` is `ApplyStrokeMode` — `Contextual` for text strokes, `Border` for
container outlines.

### 3.5 Motion

Static screenshots cannot capture motion, so motion tokens follow a two-stage
rule: **every taste ships defaults** (chosen by taste family), and **video
input, when provided, overrides** them (see the extraction skill). Durations
map to `TweenInfo` time; easings to `Enum.EasingStyle`/`EasingDirection`.

```yaml
motion:
  durations: { instant: 0.08s, fast: 0.15s, normal: 0.25s, slow: 0.4s }
  easings:
    pop:    { style: Back, direction: Out }
    settle: { style: Quad, direction: Out }
    exit:   { style: Quad, direction: In }
```

### 3.6 Components

`map<component, map<property, value-or-reference>>`. Allowed properties:
`backgroundColor`, `textColor`, `typography`, `rounded`, `stroke`,
`textStroke`, `padding`, `size`, `height`, `width`, `aspectRatio`, `gradient`,
`shadow`, `transparency`. Unknown properties are accepted with a warning.

**States are sibling keys** (upstream convention) with Roblox-appropriate
suffixes: `-pressed`, `-disabled`, `-selected`, and optionally `-hover`
(desktop-only; a design must never *require* hover to be usable — most Roblox
sessions are touch).

```yaml
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    stroke: "{strokes.outline}"
    textStroke: "{strokes.text-outline}"
    shadow: "bevel(4px #3E8A28)"
    aspectRatio: 3.2
  button-primary-pressed:
    shadow: none          # bevel collapses: the button visually depresses
```

Property value grammars beyond references:
- `gradient`: `vertical(<color>, <color>)` or `horizontal(...)` → `UIGradient`.
- `shadow`: `none` | `drop(<x>px <y>px <color>)` (image/9-slice drop shadow) |
  `bevel(<height>px <color>)` (the fake-3D bottom edge ubiquitous in cartoon
  UI — implemented as a stroke-bottom or layered frame, see implementation
  skill).
- `size`: prose-ish intent, e.g. `"scale 0.30 wide, aspect 3.2:1"` — sizes are
  Scale-first by layout rule (§5.3), so exact UDim2 values are an
  implementation concern.

### 3.7 Extraction provenance

```yaml
extraction:
  inputs:
    - id: shot-1
      kind: screenshot
      describes: "HUD during gameplay, phone landscape"
    - id: clip-1
      kind: video
      describes: "egg hatch + shop open, 6s"
  confidence:
    Colors: high
    Typography: high
    Motion: medium        # derived from clip-1, bucket-classified
    "Screen Patterns": low  # inventory screen was not provided
  notes: "No inventory screenshot; grid card tokens defaulted from taste family."
```

Handwritten files may omit `extraction` (lint: info only). Extracted files
must include it, and any section defaulted due to missing input must carry
`confidence: low` here **and** a note in the section body.

## 4. Sections (canonical order)

| # | Section | Ext. | Must cover |
|---|---|---|---|
| 1 | Overview | | Taste in prose; references ("feels like a toy vending machine"); target genre; 3–5 adjectives max, one concrete reference minimum |
| 2 | Colors | | Role of each semantic token; which colors never touch (e.g. danger vs currency); background treatment |
| 3 | Typography | | Hierarchy usage; text stroke conventions; TextScaled policy; casing |
| 4 | Layout | | Spacing scale usage; layout delegation rules; safe areas; tap targets; density |
| 5 | Elevation & Depth | | Stroke weights per element class; shadow/bevel treatment; dim overlay; ZIndex layering plan |
| 6 | Shapes | | Corner radius scale and where each step applies; silhouette rules (pill vs rounded-rect vs circle) |
| 7 | Motion | ✔ | Duration/easing usage; entrance/exit patterns per element class; feedback juice (press scale, reward bursts); reduced-motion stance |
| 8 | Components | | Each staple component: anatomy, states, token bindings, and a one-line "feel" sentence |
| 9 | Screen Patterns | ✔ | HUD placement map (thumb zones, reserved engine zones), shop/inventory/settings/reward-popup composition, information density |
| 10 | Do's and Don'ts | | Concrete anti-patterns, phrased as instructions ("Never use thin 1px strokes — this taste reads them as unfinished") |
| 11 | Agent Prompt Guide | ✔ | Quick-reference cheat sheet + 2–3 canned prompts for implementing agents |

Component staples to cover in §8 (define those that exist in the taste; this
list is the vocabulary, not a mandate): `button-primary`, `button-secondary`,
`button-icon`, `button-close`, `currency-bar`, `side-button`, `window`,
`window-header`, `dim-overlay`, `card-grid`, `progress-bar`,
`badge-notification`, `tooltip`.

## 5. Roblox normalization rules

### 5.1 Banned vocabulary → Roblox equivalent

| Banned (CSS/web) | Use instead |
|---|---|
| margin / gap | `UIListLayout.Padding`, `UIGridLayout.CellPadding` |
| padding (CSS) | `UIPadding` (px offsets) |
| border / border-radius | `UIStroke` / `UICorner` |
| box-shadow | shadow grammar (§3.6): 9-slice drop image or bevel |
| linear-gradient | `UIGradient` (rotation, `ColorSequence`) |
| z-index (CSS) | `ZIndex`, `DisplayOrder` (ScreenGui) |
| overflow: hidden | `ClipsDescendants` |
| font-family (web fonts) | Font family via `Font.fromName` (§3.3 table) |
| breakpoints / media queries | Scale-first sizing + `UIAspectRatioConstraint` + inset APIs (§5.3) |
| hover-dependent UX | pressed/selected states; hover as optional garnish |

### 5.2 Datatype conventions

- Colors: `Color3.fromHex("#RRGGBB")`.
- Fonts: `Font.fromName(family, Enum.FontWeight.X, Enum.FontStyle.Y)` →
  `TextLabel.FontFace`. Never emit `Enum.Font.Gotham*` / `Arial*`.
- Tweens: `TweenInfo.new(duration, Enum.EasingStyle.X, Enum.EasingDirection.Y)`.
- ScreenGuis: always set `ZIndexBehavior = Enum.ZIndexBehavior.Sibling`
  explicitly. `Instance.new("ScreenGui")` defaults to `Global`, under which any
  explicitly-ZIndexed overlay (e.g. a dim at ZIndex 10) silently hides every
  default-ZIndex descendant — verified empirically in this project's preview
  pipeline. DisplayOrder bands (see Elevation guidance) assume Sibling.

### 5.3 Responsive rules (replaces upstream's breakpoint thinking)

- **Reference resolution is 1920×1080.** All `px` tokens are offsets at
  reference. Rationale: Studio's device emulator and most design references
  use it; it gives `px` a single unambiguous meaning.
- **Scale-first sizing.** Element sizes use `UDim2` Scale plus
  `UIAspectRatioConstraint`; Offset is reserved for hairline details and
  spacing tokens. Manual `Position` arithmetic is delegated to
  `UIListLayout`/`UIGridLayout`/`UIPadding` (enforced by the implementation
  skill — the file only needs to *assume* it).
- **Safe areas.** HUD roots use `ScreenGui.ScreenInsets = DeviceSafeInsets` (or
  `TopbarSafeInsets` for top-anchored bars); current topbar ("unibar") inset is
  58px desktop / ~52px mobile and must never be hardcoded — query
  `GuiService:GetInsetArea()`. Note: inset can read `0,0` on the first frame;
  read after a Heartbeat.
- **Tap targets: 44px minimum** (logical px at reference) for anything
  touchable. Roblox publishes no official number; 44 is adopted from Apple HIG
  and is the community consensus. Mobile-first: the majority of Roblox
  sessions are touch.
- **Reserved engine zones** (HUD must avoid): bottom-left (virtual joystick),
  bottom-right (jump button), top strip (unibar/topbar).

## 6. Conformance and linting

`tools/linter` implements the rules in spec-config (`lint:` block):
errors `duplicate-section`, `broken-ref`, `invalid-value`; warnings
`section-order`, `unknown-key`, `unknown-component-property`,
`missing-primary`; info `missing-extraction-confidence`, `token-summary`.
A file **conforms** when it has zero errors. Extracted files additionally
should have zero warnings before catalog inclusion.

## 7. Naming and rights rules (transparency policy)

- Entries describe **tastes, not games**. `name` and the catalog slug are
  taste-descriptive (`cartoon-chunky`), never a third-party game or studio
  name — the taste is the reusable thing, not the game.
- **Reference games are credited openly** in the optional `inspiration`
  front-matter field (e.g. `inspiration: "DOORS (Horror, LSPLASH)"`).
  Truthfully naming what was analyzed is the honest form of attribution;
  hiding it implies something to hide. An entry must still never claim to
  *be* any game's design system.
- Files must not embed or link third-party assets (images, logos, sounds,
  decal IDs from other games). Tokens describe colors, shapes, and
  conventions — publicly observable style facts. Input screenshots are
  working material only and are never redistributed.
- Every published entry carries: "Independent analysis of publicly
  observable UI conventions, provided as-is for inspiration. Not affiliated
  with or endorsed by any game or studio." — naming the reference game where
  one exists.
- Takedown: rights holders can request changes or removal at any time via
  the repository's issue tracker; requests are honored promptly.

## 8. Versioning

`version: alpha`. Breaking changes to section order, token grammars, or
component property lists bump the version; the linter accepts the versions it
knows and warns on unknown ones. `spec/fixtures/` holds conformance fixtures
that double as linter tests.
