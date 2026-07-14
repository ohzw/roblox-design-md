---
name: screenshot-to-designmd
description: Generate a spec-conformant DESIGN.roblox.md (Roblox design-system document for AI agents) from game UI screenshots, with optional short video for motion. Use when the user provides Roblox game screenshots and wants the UI taste captured as a reusable DESIGN.roblox.md.
---

# screenshot-to-designmd

You turn screenshots of a Roblox game's UI into a `DESIGN.roblox.md` — a
design-system document that lets any AI agent reproduce the game's *taste*.
The format spec is BUNDLED at `references/spec/SPEC.md` (machine-readable:
`references/spec/spec-config.yaml`) — read it before extracting. (When
working inside the catalog repository itself, the repo-root `SPEC.md` /
`spec/spec-config.yaml` are the canonical originals of those bundles, and
the handwritten exemplar `design-md/cartoon-chunky/DESIGN.roblox.md` is
available too. The exemplar shows STRUCTURE and prose register only — every
value in your output must come from your own inputs, never from the
exemplar. In blind calibration runs the exemplar is off-limits. Installed
standalone via `npx skills`, neither exists: the bundle is sufficient.)

## Workflow

### 1. Gate the inputs

Compare what the user provided against `references/input-checklist.md`.

- If **required** inputs are missing, do NOT silently proceed: tell the user
  exactly which screenshots to add and why, using the checklist's request
  script. Offer to continue anyway with defaults.
- If proceeding with gaps: every affected section gets `confidence: low` in
  the `extraction` block AND a note in the section body saying what was
  defaulted.
- Reject inputs you may not use: assets ripped from game files, other
  people's paid asset packs. Screenshots of publicly visible gameplay are the
  intended input.

### 2. Extract, layer by layer

Follow `references/extraction-procedure.md` precisely. Order matters —
later layers reference earlier tokens:

1. **Colors** → semantic roles (`primary`, `danger`, `currency-soft`...).
2. **Typography** → nearest Roblox family via `references/font-mapping.md`.
3. **Spacing / Shapes / Strokes** → px at the 1920×1080 reference resolution.
4. **Motion** → taste-family presets from `references/motion-presets.md`;
   only override when video input exists (bucket classification, never exact
   curve fitting).
5. **Components** → only staples actually visible in the shots; states only
   if observed (or mark inferred).
6. **Screen Patterns** → placement maps from the HUD/window shots.

Record evidence as you go: every token gets `which input, which element` in
the `extraction` block. No token without provenance.

### 3. Write the document

- Front matter tokens + prose body in the canonical section order (SPEC §4).
  **Prose carries the intent** — write what the taste *feels* like and one
  concrete real-world reference (SPEC §1: "Prose, not Tokens").
- Use the recommended token names from `spec-config.yaml`
  (`recommended_token_names`) whenever they fit; invent new names only for
  concepts the recommendations don't cover. This keeps extraction
  near-deterministic across runs.
- Naming and rights (SPEC §7, transparency policy): taste-named `name`/slug
  (never the source game's name), but credit the reference game openly in
  the `inspiration` front-matter field; no third-party assets or asset IDs;
  end with the independent-analysis disclaimer naming the reference game and
  noting that rights holders may request changes or removal.

### 4. Validate before delivering

Run the bundled linter (self-contained, no install needed — it ships with
this skill and auto-resolves the bundled spec):

```sh
node <this-skill-dir>/references/linter/lint.bundle.mjs <output>.md
```

(In the catalog repository, `node tools/linter/lint.mjs <output>.md` is the
same linter from source.) Zero errors is mandatory; resolve warnings or
state why they stay. Then self-review against the checklist at the end of
`references/extraction-procedure.md` (evidence coverage, section order,
banned vocabulary, banned fonts).

## Quality bar

- **Structure over palette**: the deliverable's core value is the window
  grammar, component anatomy, and motion signature — colors are the
  swappable parameter layer. A document that nails the palette but
  under-describes the anatomy has failed its purpose.

- A stranger agent reading only your output must be able to build a
  consistent UI (this is tested — see `calibration/`).
- Same inputs → same section structure and token names on re-runs.
- Never present a defaulted value as observed. Confidence honesty is a
  feature, not a weakness.
