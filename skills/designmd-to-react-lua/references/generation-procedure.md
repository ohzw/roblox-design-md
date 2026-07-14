# Generation procedure (theme → components → screens → stories)

**Scope vocabulary.** A "core slice" = Theme + the taste's window component +
the components the requested stories genuinely need (helper components those
require, e.g. a close button or rarity chip, are prerequisites, not extra
scope). "Load-bearing" = anatomy-critical per the DESIGN.md's own prose, or
required by ≥2 Screen Patterns. Variants a DESIGN.md merely names in prose
(event re-skins, celebration frames) are OUT of a core slice unless
explicitly requested — but must be noted in delivery. When the caller
explicitly reduces scope (e.g. "two stories only"), the caller wins over this
file's checklist — note the resulting checklist deviations in delivery
instead of silently violating or ignoring the cap.

**Delivery forms.** Output is a plain `src/` tree. It becomes runnable
either as (a) a Rojo/Argon project (add default.project.json + wally.toml as
in `preview-place/`) or (b) injected into an open Studio document for review
(recipe in verification.md). E2E/review slices routinely ship as bare src/ —
that is intentional, not an omission.

Output layout (`src/` mapped into ReplicatedStorage):

```
src/
├── Theme.luau
├── <Name>.storybook.luau        # { name, storyRoots = { script.Parent.Stories } }
├── Components/
│   └── <ComponentName>.luau     # one per Components-section entry
├── Screens/
│   └── <ScreenName>.luau        # compositions per Screen Patterns
└── Stories/
    └── <Name>.story.luau        # one per component + one per screen
```

## 1. Theme.luau — mechanical front-matter translation

Translation table (front matter → Luau):

| Token | Luau |
|---|---|
| `colors.x: "#RRGGBB"` | `Color3.fromHex("#RRGGBB")` |
| `colors.x: "#RRGGBBAA"` | color `Color3.fromHex("#RRGGBB")` + separate `Theme.<x>Transparency = 1 - 0xAA/255` (rounded to 2dp) |
| `typography.x` | `{ font = Font.fromName(family, Enum.FontWeight.W, Enum.FontStyle.S), textSize = N, uppercase = bool }` — single-weight families (FredokaOne, LuckiestGuy, Bangers) use `Enum.FontWeight.Regular` |
| `spacing.x: Npx` | number `N` |
| `rounded.x: Npx` / `full` | `UDim.new(0, N)` / `UDim.new(1, 0)` |
| `strokes.x` | `{ thickness = N, color = <ref>, mode = Enum.ApplyStrokeMode.Border|Contextual, transparency = 1 - alpha }` — the `transparency` field exists only when the stroke color carries an `#RRGGBBAA` alpha (maps to `UIStroke.Transparency`) |
| `motion.durations.x: Ns` | number `N` (seconds) |
| `motion.easings.x` | `{ style = Enum.EasingStyle.X, direction = Enum.EasingDirection.Y }` |
| component `shadow: bevel(Npx #hex)` | bevel color constant + height N (see components) |

Resolve `{a.b}` references at generation time — Theme fields hold concrete
values, cross-referencing other Theme fields in Luau (e.g.
`color = Theme.colors.outline`) where the reference is within Theme.

Key naming: kebab-case tokens become camelCase fields (`currency-soft` →
`currencySoft`). Keep a comment mapping when renaming.

**Derived tokens**: when a required visual value has no front-matter token
(e.g. a bevel shade for a component the DESIGN.md doesn't define), derive it
consistently with the taste (same darkening ratio as sibling values) and add
it to Theme.luau with a comment marking it `-- Derived (...)`. Derived values
NEVER live as literals in component files — Theme is the single place a
reviewer audits. This includes: story backdrops (`Theme.derived.worldBackdrop`
— sky-like for bright tastes, moody for dark ones), pressed-state lifts, and
dim washes. Colors COMPUTED from tokens (`:Lerp`, brightness math) count as
derived — put the computation in Theme, not in components.
Derivation budget: derive a COMPLETE set when the document states or clearly
implies the rule (e.g. one bevel ratio → derive all rarity bevels at that
ratio); when the document gives no basis at all, leave the value a documented
gap for a human rather than inventing taste.
When a task-level ask structurally overrides a DESIGN.md component (per
SKILL.md precedence), record the conflict as a comment at the Theme/component
level and surface it in delivery — never edit the DESIGN.md itself to match
the task; the catalog document stays the taste's ground truth.

**Textures come from the same sourcing rules as icons** (see
asset-sourcing.md): a FREE Creator Store seamless texture is legitimate and
preferred for fidelity; a procedural instance tree (repeated
Frames/UIGradient) is the fallback when no rights-clean asset passes the
pixel check. What is BANNED is emitting an ImageLabel with a placeholder or
third-party-game asset ID (SPEC §7) — that is worse than either alternative.
Note the choice and tradeoff in delivery.

## 2. Components

For each entry in the Components section (skip states — they fold into their
base component):

1. Anatomy from the component's prose + tokens — **the anatomy is
   taste-specific, never assume one**. When the DESIGN.md's anatomy prose
   describes MULTIPLE window forms (popup vs full-screen hub), one component
   with a `variant` prop branching the anatomy beats two near-duplicate
   modules. Precedence inside one document: a component-level token beats a
   section-level rule of thumb when they disagree (e.g. `list-row: rounded.sm`
   wins over Shapes' "rows are square"). Two worked archetypes:
   - Beveled (chunky tastes): `root (bevel color, corner, stroke)` →
     `Face (fill, corner, height 1,-BEVEL)` → content. Pressed = Face
     stretches full (bevel collapses).
   - Flat/translucent (dark tastes): single frame, fill with
     `BackgroundTransparency` from the token, thin stroke. Pressed =
     brightness/stroke lift (see motion-implementation.md), never a fake
     bevel the DESIGN.md doesn't define.
2. States: `-pressed` via `useState` + mouse events (Down/Up/Leave — Leave
   must clear pressed), `-disabled` via prop (in beveled tastes disabled
   keeps its bevel — a missing bevel reads as pressed), `-selected` via prop.
   **Tap-target vs token conflict**: when a component's token height is
   below the 44px rubric (a 36px price pill), keep the visual at token size
   inside an invisible 44px+ touch root (the interactive instance) — taste
   and usability both win.
3. Bind every visual to Theme. Variant maps (`primary`/`secondary`) are a
   table at module top, not branches in render.
4. Standard prop passthroughs: `size`, `position`, `anchorPoint`,
   `layoutOrder`, `zIndex`, plus `onActivated` etc. Respect
   `aspectRatio` tokens with `UIAspectRatioConstraint` when size is
   scale-driven; offset default sizes are acceptable for fixed chrome.
5. Text: white-on-fill labels take the text-stroke token; uppercase when the
   typography tier says so (`string.upper` at render).

Worked examples to imitate: `preview-place/src/Components/ChunkyButton.luau`
(variants, states, bevel, squash), `Window.luau` (dim/shadow/panel layering,
entrance motion, children passthrough), `CurrencyBar.luau` (abbreviation
logic), `Card.luau` (selected state + rarity ribbon).

## 3. Screens

- A screen module composes components only; its own instances are limited to
  invisible containers, layout instances, padding, and **pattern-defined text
  content** (e.g. a settings-row label the Screen Patterns section
  describes). If a row/cell shape repeats with any styling of its own,
  promote it to a component instead of styling it inline.
- Follow the Screen Patterns section literally: region containers first
  (left rail, top-right stack, bottom-center slot), each with its own
  UIListLayout; keep reserved zones clear (layout-rules.md §5).
- Screens receive data via props (amounts, item lists, callbacks) — no
  hardcoded game data beyond story defaults.

## 4. Stories (one per component and per screen)

UI-Labs React format — a ModuleScript named `<Name>.story`:

```lua
return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = { Text = "CLAIM", Disabled = false },
	story = function(props)
		return e(Component, { text = props.controls.Text, disabled = props.controls.Disabled })
	end,
}
```

- Wrap stories in a world-like backdrop frame (sky color) so outline/stroke
  tokens read in context.
- Add controls for every prop a reviewer would want to poke (text, counts,
  disabled, progress).
- A `<Name>.storybook.luau` at src root returns
  `{ name = <taste name>, storyRoots = { script.Parent.Stories } }`.

## 5. Self-review checklist

- [ ] Every file passes `luau <file>` (parse) — check children-table commas
- [ ] No banned API (grep: `Roact`, `JSX`, `Suspense`, `Enum.Font.Gotham`,
      `onClick`)
- [ ] No literal hex outside Theme.luau (except DESIGN.md-inlined values)
- [ ] Every ScreenGui sets `ZIndexBehavior.Sibling`
- [ ] Repeating content uses UIListLayout/UIGridLayout
- [ ] States: pressed/disabled/selected implemented where DESIGN.md defines them
- [ ] Motion: press feedback + entrance/exit implemented where defined
- [ ] Every component/screen has a story
