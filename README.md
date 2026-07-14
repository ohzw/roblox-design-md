# roblox-design-md

Design systems that AI agents can read — for Roblox game UI.

`DESIGN.roblox.md` adapts the open-source [Stitch DESIGN.md
format](https://github.com/google-labs-code/design.md) to Roblox: a plain-text
document that captures a game-UI *taste* (colors, typography, strokes, shapes,
motion, components, screen patterns) in Roblox-native vocabulary, so that an
engineer with no design background can hand it to an AI agent and get a
coherent react-lua UI.

**Status: pre-release, local development.** Not published yet.

## Layout

| Path | What |
|---|---|
| [`SPEC.md`](SPEC.md) | The format specification (human-readable) |
| [`spec/spec-config.yaml`](spec/spec-config.yaml) | Machine-readable single source of truth (sections, grammars, lint rules) |
| [`spec/fixtures/`](spec/fixtures/) | Conformance fixtures (double as linter tests) |
| [`design-md/`](design-md/) | The catalog — one directory per taste (`design-md/<slug>/DESIGN.roblox.md` + `previews/`) |
| [`tools/linter/`](tools/linter/) | Node linter: `node lint.mjs <file>` (`npm test` runs fixture tests) |
| `skills/` | Agent Skills: `screenshot-to-designmd`, `designmd-to-react-lua` (Phase 2–3) |
| `preview-place/` | Rojo project rendering every token/component for real-device screenshots (Phase 3) |
| `tools/capture-rig/` | Studio-driven screenshot automation (Phase 3) |
| `site/` | Static catalog site (Phase 5) |
| [`docs/phase0-report.md`](docs/phase0-report.md) | Research findings and the plan behind all of the above |

## Quick start

```sh
# install the skills into your own project (any Agent Skills-compatible agent)
npx skills add ohzw/roblox-design-md --skill designmd-to-react-lua
npx skills add ohzw/roblox-design-md --skill screenshot-to-designmd

# lint an entry (in this repo)
cd tools/linter && npm install
node lint.mjs ../../design-md/cartoon-chunky/DESIGN.roblox.md

# browse the catalog locally
cd site && npm install && npm run dev   # http://localhost:4321
```

The two skills under `skills/` are self-contained (each bundles the format
spec at `references/spec/`, regenerated via `node tools/sync-skill-bundles.mjs`)
— they are the only skills this repository publishes.

The first taste, [`cartoon-chunky`](design-md/cartoon-chunky/DESIGN.roblox.md),
is the handwritten golden sample that calibrates the extraction and
implementation skills.

## Toolchain assumptions

- UI framework: react-lua (React 17 API). Default Wally packages:
  `roblox/react@17.3.9` + `roblox/react-roblox@17.3.9` (jsdotlua scope
  supported as an option).
- Fonts: `FontFace` / `Font.fromName()` first; `Enum.Font.Gotham*`/`Arial*`
  are banned (removed from the engine).
- Rojo + Wally + Rokit for the preview place; Roblox Studio for capture.

## Rights

Catalog entries describe tastes, not games: taste-named slugs, no third-party
assets, tokens limited to publicly observable style conventions. Each entry
carries an independent-analysis disclaimer. See SPEC.md §7.
