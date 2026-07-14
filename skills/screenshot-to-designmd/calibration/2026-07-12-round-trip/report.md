# Calibration report — 2026-07-12 (round-trip + 2 blind runs)

**Method**: The cartoon-chunky golden sample was rendered in Roblox Studio
(react-lua preview place) and captured via the Studio MCP `screen_capture`
tool. Three captures (HUD, shop window, button lineup) were fed through the
extraction skill and the output compared against the handwritten ground truth
`design-md/cartoon-chunky/DESIGN.roblox.md`. Three runs:

| Run | Extractor | Contamination | Output |
|---|---|---|---|
| Round-trip | Same session that wrote the golden | High (knew the answers) | `2026-07-12-round-trip/` |
| Blind #1 | Fresh agent, answer files forbidden | None (named its taste "Sticker Pop") | `2026-07-12-blind/` |
| Blind #2 | Fresh agent, after pipeline fixes | None (named its taste "Sticker Toybox") | `2026-07-12-blind2/` |

## Headline results

| Metric | Round-trip | Blind #1 | Blind #2 (final) |
|---|---|---|---|
| Lint | 0/0 | 0/0 | 0/0 (first pass) |
| Sections, canonical order | 11/11 | 11/11 | 11/11 |
| Semantic color roles correct | 11/11 | 13/14 (surface pair reversed) | 14/14 |
| Color fidelity (Δ/channel vs truth) | ≤3 (contaminated — not meaningful) | ≤13 except surface pair Δ~50 | **≤16, hue-faithful; surface Δ≤10** |
| Geometry (strokes/radii/sizes) | exact (contaminated) | 0.72× systematic skew | **Δ≤4px / ±1-2px steps** |
| Typography sizes | exact (contaminated) | skewed + undershot | Δ2 systematic undershoot, flagged as lower bounds |
| Honesty (gaps declared, nothing invented) | ✓ | ✓ | ✓ |

## What the blind runs caught that the round-trip could not

1. **A real rendering bug**: the Window drop-shadow was a child of the panel;
   under `ZIndexBehavior.Sibling` children render above parents, so the
   semi-transparent shadow tinted the whole cream panel tan. Blind #1
   faithfully reported tan (#CDC5AB) and reversed the surface/surface-deep
   hierarchy; the contaminated round-trip "read" cream because it knew the
   answer. Fix: shadow restructured as a sibling behind the panel
   (`preview-place/src/Components/Window.luau`), verified by re-capture.
2. **A wrong measurement rule**: guidance added after the round-trip claimed
   MCP captures could be measured at scale = 1.0. The real viewport was
   2660×1034 downscaled to ~1920-wide images → Blind #1's px tokens came out
   0.72× truth. Fix: extraction-procedure now mandates image→logical
   conversion via `workspace.CurrentCamera.ViewportSize`; Blind #2 applied
   ×1.385 and landed within Δ4px.
3. **TextScaled undershoot**: rendered text measures below its designed
   textSize; now documented as a lower-bound rule (Blind #2 correctly
   flagged its sizes as lower bounds; residual Δ2).

## Determinism observations (three runs)

- Section structure, token naming (spec-config recommended names), component
  anatomy, and the honesty pattern (omitting display tier / progress-bar /
  tooltip as unobserved) were **identical across all three runs** — the
  vocabulary-constrained design achieves its determinism goal.
- Genuine judgment variance concentrated in: rarity accents (1 token vs 3
  `accent-<tier>` tokens — spec now blesses the tiered form), the
  selected-card interpretation (caught in #1, missed in #2 — heuristic added
  to the procedure but evidently still ambiguous at ~110px card sizes), and
  faint-shadow detection (the 0.75-transparency window shadow was read as
  `none` in #2).

## Skill/spec improvements driven by this calibration

1. `progress-bar` screen added to the recommended inputs checklist.
2. Image→logical viewport conversion procedure (+ capture-width note).
3. TextScaled lower-bound rule.
4. Canonical-context rule for component sizes (in-situ beats lineup shots).
5. Colors-are-literal-hex rule (no `{references}` in the colors block).
6. Selected-vs-rarity disambiguation heuristic.
7. Blind-mode note in SKILL.md (exemplar = structure/register only).
8. New linter rule `css-vocabulary` (banned-word prose scan) — immediately
   caught "margin" in the golden sample itself.
9. spec-config vocabulary additions: `surface-dark`, `accent-<tier>` naming.

## Accepted tolerances (to publish in SPEC or skill docs later)

- Honest color extraction from lossy captures: **Δ ≤ ~16/channel**,
  hue-faithful. Implementations re-rendered from an extracted file will be
  the same taste but not pixel-identical.
- Geometry: ±1px strokes, ±2px radii, ±4px sizes.
- Typography: sizes are lower bounds under TextScaled.

## Remaining for Phase 2 sign-off

- **Real-game extraction** (user-provided screenshots): compression, art
  noise, gradients — the honest test of the checklist and color clustering.
- Motion video override path is untested end-to-end.
