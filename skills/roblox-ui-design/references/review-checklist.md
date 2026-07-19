# Roblox UI design review checklist

Use only the sections relevant to the supplied screen and supported interaction model. A check is `pass`, `fail`, or `unverified`; absence of runtime evidence is never `pass`.

## Intent and hierarchy

- Can a first-time viewer identify the current task and first-read information within the intended composition?
- Is each primary-looking action primary within a named decision region?
- Are repeated row/card actions distinguished from a screen-global commitment?
- Are secondary, tertiary, destructive, and cancel actions visibly differentiated where they coexist?
- Are semantic peers allowed to remain equal rather than being forced into false hierarchy?
- Does intended rank remain perceptible through some combination of size, weight, family, casing, value, stroke, placement, spacing, or container salience?
- Is no numeric size ratio used as the sole pass/fail criterion?

## Typography

- Is every font family assigned to a named functional, linguistic, numeric, system, or taste role?
- Is every weight change meaningful, available in the selected family, and not based on a fabricated Roblox semantic weight map?
- Are prose and long localized strings protected from forced uppercase?
- Are authored `TextSize`, actual rendered bounds, and any project floor recorded separately?
- When `TextScaled` is used, is the scaling range constrained and is the rendered result still unverified until measured?
- Are longest strings, non-Latin fallbacks, wrapping, clipping, captions, badges, prices, and HUD microcopy covered?
- Is player Preferred Text Size behavior considered, including the fact that TextScaled does not receive that adjustment?

## Color and legibility

- Is text evaluated against its actual composited surface or world background?
- Does noisy or changing world content receive an appropriate backing or contextual stroke?
- Are Roblox qualitative contrast guidance and any project-adopted WCAG ratios labeled separately?
- Does every required color-coded meaning also have persistent text, symbol, pattern, shape, position, or geometry?
- Are blocked behavior and transient motion excluded as the sole non-color cue?
- Are accent colors assigned to stable named roles rather than arbitrary novelty?

## Spacing and grouping

- Can viewers identify which information and controls belong together?
- Are local relationships and semantic separations perceptibly distinct, whether through spacing or another grouping channel?
- Are spacing ratios treated as taste/corpus observations rather than universal thresholds?
- Is the repository 4/8/12/20/32 ladder used only as a fallback when source evidence is absent?
- Does localization preserve grouping without clipping or orphaned labels?

## Shape, material, and depth

- Does each radius, pill, circle, or hard corner map to a named silhouette role?
- Does each shadow, bevel, gloss, stroke, inset, or glow map to material, elevation, state, or salience?
- Is the depth grammar coherent within the taste or component family?
- Are generic full-radius and shadow tokens excluded when the source taste does not actually use them?
- Is a quiet taste protected from imported chunky bevels, and vice versa?

## HUD and composition

- Is persistent HUD content vital to the current gameplay or workflow?
- Is it grouped by function rather than accumulated by availability?
- Are world occlusion, safe-area fit, and platform control collisions unverified until exercised?
- Are top/side placement and a clear center treated as genre-dependent rather than universal?
- Are fixed HUD coverage, item-count, and control-zone numbers absent unless sourced?
- Does responsive behavior specify substitution, reflow, collapse, overlay, or scroll rather than only scale?

## Modal composition

- Are backdrop tint, opacity, transparency, blur, and world visibility taste/workflow decisions rather than corpus averages?
- Is visual dimming separated from actual background input behavior?
- Does focus enter the modal, remain within it where required, and return to the invoking control?
- Is outside content inert when the product calls the interface modal?
- Are Escape/back and dismissal behavior defined?
- Is `GuiButton.Modal` not mistaken for a complete modal-dialog mechanism?

## States and input

- Are focus, selected, pressed, hover, and disabled distinguishable in all supported combined states?
- Is hover supplemental rather than the only carrier of required information?
- Does keyboard/gamepad focus have a persistent current-location cue?
- Are navigation order, scroll reveal, activation, modal containment, and focus restoration covered?
- Are disabled actions behaviorally blocked as well as visually differentiated?
- If the project adopts 44 Offset px, is it labeled a repository convention rather than a Roblox minimum?
- Are touch bounds, spacing, clipping, overlap, neighboring capture, and scrolling gestures unverified until exercised on target devices?

## Evidence integrity

- Does every recommendation declare official, external, corpus, taste, project, generator, or unresolved provenance?
- Are observed facts separated from inferred intent and recommendations?
- Are generator fixture recurrence and taste evidence counted separately?
- Are corpus values prevented from becoming official or accessibility thresholds?
- Does every unexecuted check remain in `validation` or `unresolved`?

## Delivery gate

A complete review states:

1. What passes from supplied evidence.
2. What concretely fails and which outcome it breaks.
3. What remains unverified.
4. The smallest correction preserving the taste.
5. The runtime or visual scenario needed to close each material uncertainty.
