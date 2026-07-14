---
name: designmd-to-react-lua
description: Implement Roblox UI with react-lua from a DESIGN.roblox.md design-system document plus screen requirements. Use when the user has a DESIGN.roblox.md (or asks to build UI "in this taste") and wants components, screens, or UI-Labs stories generated for Roblox.
---

# designmd-to-react-lua

You turn a `DESIGN.roblox.md` (format spec bundled at
`references/spec/SPEC.md`) plus a screen requirement ("build the HUD and
shop") into working react-lua code. When working inside the catalog
repository, the canonical worked example is `preview-place/` (hand-built
from `design-md/cartoon-chunky/DESIGN.roblox.md`) — read a component or two
from it to absorb the register before generating. Installed standalone via
`npx skills`, the repo isn't present: the reference docs' inline patterns
(button/window/motion anatomies, worked code shapes) are the register —
they are sufficient on their own.

## Non-negotiables (read the references before writing any code)

1. `references/react-lua-rules.md` — the exact API surface and hard bans.
   react-lua is React 17 in Luau: NO JSX, NO Roact API, no Suspense.
2. `references/layout-rules.md` — Scale-first sizing, layout delegation
   (UIListLayout/UIGridLayout — never hand-computed positions for repeating
   content), safe areas, `ZIndexBehavior = Sibling` ALWAYS set explicitly.
3. Components before screens: generate the theme module and themed
   components first; screens may only compose those components. No free-form
   drawing inside screens — that is how quality is structurally guaranteed.
4. Precedence on conflicts: the DESIGN.roblox.md owns TASTE (colors, shapes,
   strokes, motion feel); the user's explicit requirement owns STRUCTURE and
   BEHAVIOR (which screens, which data, which interactions). When a
   requirement contradicts the DESIGN.md's taste rules, follow the explicit
   requirement only if it is unambiguous, and ALWAYS surface the conflict in
   your delivery notes so a human can arbitrate.

## Workflow

### 1. Read the DESIGN.roblox.md

Lint it first with the bundled linter
(`node <this-skill-dir>/references/linter/lint.bundle.mjs <file>` —
self-contained; in the catalog repo `node tools/linter/lint.mjs <file>` is
the same linter from source); refuse to build from a file with errors. Then
read the prose — the Overview, Do's and Don'ts, and Agent Prompt Guide
constrain every choice the tokens don't.

### 2. Generate in this order

Follow `references/generation-procedure.md`:

1. **`Theme.luau`** — mechanical translation of the front matter (colors →
   `Color3.fromHex`, typography → `Font.fromName`, rounded → `UDim`,
   strokes/spacing → tables, motion → duration numbers + easing enums).
2. **Components** — one module per Components-section entry, states included
   (pressed/disabled/selected), every visual property bound to Theme, never
   a literal hex in a component file (exception: values the DESIGN.md itself
   inlines, e.g. bevel shades).
3. **Motion** — per `references/motion-implementation.md`: press squash and
   entrance/exit are mandatory when the Motion section defines them.
4. **Screens** — compose components per the Screen Patterns section.
5. **Stories** — a UI-Labs story per component/screen (see
   `references/verification.md` for the exact story format), so every
   deliverable is visually inspectable. **For catalog/e2e slices, build the
   fixed set in `references/standard-showcase.md`** (same content through
   every taste's grammar — that is what makes tastes comparable).
6. **Assets** — icon/texture slots get REAL image assets per
   `references/asset-sourcing.md` (Creator Store free assets via the
   `search_asset` MCP tool, recorded in `Theme.assets`), not glyph
   placeholders.

### 3. Verify before delivering

Per `references/verification.md`: syntax-check every file (`luau <file>`,
grep for error markers), then — when a Studio MCP connection exists — run
the visual QA loop (play → mount story → screenshot → compare against the
DESIGN.roblox.md prose → numeric assertions for states/motion). Self-score
against the rubric: 3-second wayfinding, currency/CTA visibility, 44px+ tap
targets, contrast, and every Do's-and-Don'ts rule.

## Quality bar

- Zero Roact/JSX vocabulary in the output.
- Every color/font/radius/duration in generated code traces to a Theme token.
- Layout survives resolution changes: Scale + aspect constraints, no manual
  Position math for repeating content.
- States and motion are implemented, not stubbed, whenever the DESIGN.md
  defines them.
