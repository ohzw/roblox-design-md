# Evidence and claim policy

Use this policy before applying any visual-design rule.

## Evidence classes

| Class | What it establishes | What it does not establish |
|---|---|---|
| `official-engine-fact` | Current Roblox API or engine behavior within the cited scope | Product-specific visual quality or universal taste |
| `official-design-recommendation` | Roblox-authored guidance creators should normally consider | Engine enforcement, conformance, or a complete accessibility guarantee |
| `external-project-adoption` | A defensible external standard the project explicitly chooses | A Roblox platform requirement |
| `cross-taste-pattern` | A recurring solution across inspected tastes after generator adjustment | A universal rule or safe numeric threshold |
| `taste-specific` | A coherent rule for the supplied visual language | A default for another taste |
| `repository-starting-point` | A practical fallback when source evidence is absent | Independent corpus agreement or official guidance |
| `generator-convention` | Shared fixture, schema, or generation policy behavior | Taste evidence |
| `unresolved` | A question requiring source or runtime evidence | Permission to invent a value silently |

## Strength

- **MUST** — protects a functional, input-reachability, or required-information outcome. Preserve the outcome; the visual treatment may remain taste-specific.
- **SHOULD** — normally follow within the stated scope. An exception needs a reason and validation.
- **MAY** — an optional taste or composition strategy.
- **AVOID** — commonly causes false evidence, hierarchy failure, or misleading state communication.

Frequency does not determine strength.

## Confidence axes

When confidence matters, report it separately:

```yaml
confidence:
  corpusIndependence: high | medium | low | none
  officialSupport: high | medium | low | none
  runtimeSupport: high | medium | low | none
  overall: high | medium | low
```

The eight e2e tastes share one DESIGN-to-react-lua pipeline. Recurrence may be generator contamination. Treat corpus independence conservatively unless the visual decision is traceable to each taste source.

## Numeric claim template

```yaml
value: 18
unit: Roblox Offset pixels
role: body
provenance: repository-starting-point
scope: creator-authored on-screen text when taste evidence is absent
notClaimed:
  - Roblox official minimum
  - rendered-size guarantee
  - accessibility conformance
validation:
  - actual rendered bounds
  - longest localized string
  - smallest supported viewport
```

Never omit the unit. Roblox Offset pixels, CSS pixels, physical millimeters, contrast ratios, scale fractions, and image-measured pixels are not interchangeable.

## Observation, inference, recommendation

Keep these separate:

```yaml
observed: Directly visible in a source, file, or executed runtime result.
inferred: A probable purpose or relationship not explicitly stated.
recommended: The bounded design decision proposed for the current screen.
```

Do not move an inference into `observed`. Do not describe unexecuted validation as runtime evidence.

## Required corrections to common claims

| Incorrect claim | Correct treatment |
|---|---|
| "14px is Roblox's minimum" | 14–18px is the inspected corpus's authored-minimum range |
| "9px is accessible" | Roblox recommends not going below 9; this is not sufficient accessibility proof |
| "44px is Roblox's touch minimum" | 44 Offset px is this repository's adopted convention |
| "WCAG 4.5:1 is required by Roblox" | A project may adopt WCAG ratios as external targets |
| "Bold means heading" | Weight is one optional hierarchy channel with no Roblox semantic role map |
| "One screen, one primary button" | Distinguish commitments within each decision region |
| "The eight tastes all use this" | First subtract shared extraction, schema, and showcase policy |

## Source hierarchy

Prefer, in order:

1. Roblox Creator Hub and API reference.
2. Roblox official samples and staff-authored guidance.
3. Explicit external standard adopted by the project.
4. Source-traceable taste evidence.
5. Generator-adjusted cross-taste pattern.
6. Repository fallback.

Use `sources.md` for links and `design-registry.json` for exact evidence IDs, limitations, confidence, and remaining validation.
