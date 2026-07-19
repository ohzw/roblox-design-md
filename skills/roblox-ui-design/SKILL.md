---
name: roblox-ui-design
description: Design or critique Roblox game UI using evidence-backed visual rules. Use when choosing typography sizes or weights, information and action hierarchy, color and state cues, spacing, silhouettes, depth, HUD or modal composition, focus states, or touch affordances for a Roblox screen. Accepts an optional DESIGN.roblox.md, screenshots, or existing implementation and produces screen-specific design decisions or an audit. Not for screenshot taste extraction or react-lua implementation.
---

# roblox-ui-design

You turn a Roblox screen purpose, content/actions, and optional taste evidence
into an evidence-bounded visual decision contract. You also audit existing UI
against the same contract. This skill works standalone: a `DESIGN.roblox.md`,
`screenshot-to-designmd`, and `designmd-to-react-lua` can improve the input or
consume the output, but none is required.

## Read the references progressively

- Always read `references/evidence-policy.md` before making design claims.
- Read the relevant sections of `references/design-rules.md` for the domains
  in the request. Do not load unrelated domains for a focused question.
- Read `references/decision-contract.md` when designing a screen or returning
  more than one decision.
- Read `references/review-checklist.md` when auditing an existing design,
  screenshot, story, or implementation.
- Read `references/design-registry.json` only when exact applicability,
  exceptions, evidence IDs, confidence, or remaining validation matters.
- `references/sources.md` is the portable source index. Use it to support
  provenance, not as a substitute for the rule's scope and limitations.

## Modes

Infer the narrowest useful mode from the request.

1. **Focused guidance** — answer one or a small set of tightly related design
   questions with only `recommendation`, `strength`, `provenance`, `reason`,
   `notClaimed`, `exceptions`, and `validation`. Do not emit screen metadata,
   empty content/action arrays, a full state model, or the screen-design
   contract.
   When several focused decisions are related, return a list and give each
   decision its own strength and provenance; never merge evidence classes
   across decisions.
2. **Screen design** — produce a complete visual decision contract for a new
   or revised screen.
3. **Design audit** — identify concrete hierarchy, typography, color/state,
   composition, or evidence defects and propose bounded corrections.

Use focused guidance unless the user asks to design/revise a whole screen or
the answer genuinely requires cross-domain composition.

## Input gate

The only required input is a screen purpose or a concrete design question.
Use repository context and supplied artifacts before asking the user.

For screen design, derive when available:

```yaml
screen:
  type: HUD | Shop | Dialog | Inventory | Settings | Other
  purpose: string
  gameplayActive: boolean
users:
  inputs: [mouse, touch, gamepad, keyboard]
  devices: [phone, tablet, desktop, console]
content:
  requiredInformation: []
  optionalInformation: []
  primaryActions: []
  secondaryActions: []
  destructiveActions: []
taste:
  designDocument: optional
  screenshots: optional
  confidence: high | medium | low | unspecified
```

If taste evidence is missing, do not invent a visual identity. Apply universal
and conditional rules, offer repository starting points where needed, and
mark taste-dependent choices unresolved. If device/input support is absent,
state the conservative coverage assumption rather than claiming verified
support.

## Precedence

Apply decisions in this order:

1. Explicit product requirement from the user.
2. The supplied `DESIGN.roblox.md` for taste-specific values and grammar.
3. Official-backed functional or accessibility outcome.
4. Explicitly adopted project convention.
5. Cross-taste corpus pattern.
6. Repository fallback.

A taste rule cannot silently override input reachability, visible focus, or a
required non-color cue. Surface the conflict and preserve the functional
outcome through taste-compatible treatment.

## Workflow

### 1. Establish semantics before styling

Record the current task, first-read information, current decision, commitment
action, reversible secondary actions, persistent status, and optional
metadata. Do not choose a heading size before deciding what is a heading.

### 2. Preserve the taste

Select hierarchy channels that fit the evidence:

- Chunky/outlined: size, outline, surface depth, component scale.
- Restrained/information-dense: size, spacing, value, optional weight.
- Single-weight playful: size, stroke, casing, color, placement.
- Narrative/action split: family role, size, placement, surface.

These are conditional clusters, not mandatory style families. Never normalize
every taste into one average font, radius ladder, spacing scale, or shadow.

### 3. Make quantitative decisions with provenance

For every numeric recommendation, label it as one of:

```text
official-engine-fact
official-design-recommendation
external-project-adoption
cross-taste-pattern
taste-specific
repository-starting-point
generator-convention
unresolved
```

Separate authored typography values from rendered bounds. When relevant,
record `authoredSizePx`, `renderedFloorPx`, `usesTextScaled`, and player text
size behavior independently.

### 4. Design the state model

Cover only supported states, but distinguish these whenever present:

- default
- hover (pointer supplement only)
- focus (current keyboard/gamepad location)
- pressed (transient activation feedback)
- selected (persistent choice)
- disabled (unavailable and behaviorally blocked)
- error/danger/outcome

Required information cannot depend on color, hover, or transient motion alone.

### 5. Compose for the current context

Define reading order, decision regions, local versus global action emphasis,
HUD persistence, world occlusion, modal behavior, and responsive substitution.
Treat repeated row-local actions separately from screen-global commitments.
Visual dimming does not establish modal focus or background inertness.

### 6. Falsify the decisions

Challenge the proposed design against the applicable cases:

- smallest supported landscape and tall/mobile viewport
- longest localized strings and non-Latin fallback faces
- player Preferred Text Size and transparency settings
- bright, dark, saturated, high-frequency, and moving world backgrounds
- keyboard/gamepad navigation, scroll reveal, modal containment, restoration
- touch target clipping, overlap, neighboring capture, and scroll gestures
- focus + selected, focus + disabled, and other combined states

Do not claim runtime support for a check that was not exercised.

### 7. Deliver at the requested depth

Focused guidance uses only the focused-answer shape from
`references/decision-contract.md`; it never emits the screen-design schema.
Screen design returns the complete contract. Audit findings are ordered by
functional severity, then visual hierarchy impact; each finding names the
broken outcome, evidence class, correction, and remaining validation.

## Non-negotiable claim boundaries

- The corpus's 14–18px authored minima are not a Roblox minimum.
- Roblox's recommendation not to go below 9 is not engine enforcement or an
  accessibility guarantee.
- 44 Roblox Offset pixels is a repository interaction-target convention, not
  an official Roblox or universal accessibility minimum.
- WCAG contrast ratios are project-adoptable external guidance, not Roblox
  engine requirements.
- Roblox does not define a Regular/Medium/SemiBold/Bold semantic role map.
- A specific Bold/Regular role assignment is taste-specific or a project
  decision. Official guidance supports perceptible hierarchy generally, not a
  semantic assignment of those weight names.
- A 1.15 typography ratio and 1.67–2.67 spacing ratios are descriptive corpus
  clusters, not pass/fail thresholds.
- A primary action belongs to a decision region; do not require exactly one
  primary-looking control per screen.
- Standard showcase recurrence is generator-policy evidence, not independent
  taste evidence.

## Quality bar

- Every recommendation names its provenance and strength.
- Every universal statement has official or functional support.
- Taste-specific decisions preserve source evidence rather than repository
  defaults.
- Numeric values include scope and are not promoted beyond their source.
- Focus, selected, pressed, hover, and disabled remain distinguishable where
  the supported interaction model requires them.
- The result names unresolved taste choices and unexecuted validation instead
  of fabricating certainty.
- A downstream designer or implementation agent can act without rediscovering
  the semantic hierarchy.
