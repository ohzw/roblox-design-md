# Visual decision contract

Use this contract for screen-design requests. Omit empty optional fields, but do not omit unresolved decisions or validation.

```yaml
screen:
  name: string
  type: HUD | Shop | Dialog | Inventory | Settings | Other
  purpose: string
  gameplayActive: boolean

context:
  supportedDevices: []
  supportedInputs: []
  smallestViewport: unresolved | string
  tasteSource: none | path | description
  tasteConfidence: high | medium | low | unspecified

intent:
  currentTask: string
  firstRead: string
  currentDecision: string
  commitment: string | none
  persistentStatus: []
  optionalMetadata: []

readingOrder:
  - string

decisionRegions:
  - id: string
    purpose: string
    primary: []
    secondary: []
    tertiary: []
    repeatedLocalActions: []

typography:
  model: restrained | chunky | single-weight | family-split | taste-specific | unresolved
  roles:
    - name: body | caption | label | heading | display | taste-specific
      purpose: string
      familyRole: string | unresolved
      authoredSizePx: number | range | unresolved
      weightRole: string | optional | unresolved
      casing: string | source-dependent
      renderedFloorPx: number | project-dependent | unresolved
      usesTextScaled: boolean | unresolved
      provenance: string
  notes: []

colorAndMaterial:
  structuralSurfaceFamily: string | unresolved
  accentRoles: []
  requiredNonColorCues: []
  silhouetteRoles: []
  depthRoles: []
  worldBackgroundStrategy: string | unresolved

spacingAndGrouping:
  groupingModel: string
  spacingSource: taste-specific | repository-starting-point | unresolved
  valuesPx: []
  exceptions: []

states:
  - subject: string
    default: string
    hover: string | unsupported | unresolved
    focus: string | unsupported | unresolved
    pressed: string | unsupported | unresolved
    selected: string | unsupported | unresolved
    disabled: string | unsupported | unresolved
    errorOrOutcome: string | unsupported | unresolved

composition:
  persistentRegions: []
  responsiveSubstitutions: []
  worldOcclusionStrategy: string | not-applicable | unresolved
  modalBehavior:
    visualBackdrop: string | not-applicable | unresolved
    backgroundInert: boolean | not-applicable | unresolved
    focusEntry: string | not-applicable | unresolved
    focusContainment: string | not-applicable | unresolved
    focusRestoration: string | not-applicable | unresolved

rules:
  - id: RUD-NNN | local-decision-id
    statement: string
    strength: MUST | SHOULD | MAY | AVOID
    provenance: string
    appliesWhen: []
    exceptions: []
    validation: []

conflicts:
  - sources: []
    decision: string
    reason: string

unresolved:
  - question: string
    consequence: string
    evidenceNeeded: string

validation:
  static: []
  runtime: []
  visual: []
```

## Focused answer shape

For one design question, use the smaller form:

```yaml
recommendation: string
strength: MUST | SHOULD | MAY | AVOID
provenance: string
reason: []
notClaimed: []
exceptions: []
validation: []
```

For several tightly related questions, return `decisions: []` with exactly one
entry per question. Each recommendation contains one design claim and its own
strength and provenance. Never combine numeric, official, corpus, taste, or
project provenance into one entry. For example, body size and heading weight
are two entries: the size may be a repository starting point, while the
specific weight role is taste-specific or a project decision even when
general hierarchy guidance is official-backed.

## Audit finding shape

```yaml
severity: blocking | major | moderate | minor
subject: string
problem: string
brokenOutcome: string
ruleId: RUD-NNN | none
provenance: string
correction: string
remainingValidation: []
```

Order audit findings by functional failure first, then information/action hierarchy, state ambiguity, typography/legibility, composition, and taste consistency. Do not report a stylistic preference as a defect unless it violates the supplied taste or intended hierarchy.

## Starting-point policy

When no taste evidence exists, the skill may offer these authoring starts:

```yaml
typography:
  captionPx: 14-16
  bodyPx: 18
  labelPx: 20-24
  headingPx: 28-32
  displayPx: approximately 40
spacingPx: [4, 8, 12, 20, 32]
```

Every such value must say:

```yaml
provenance: repository-starting-point
notUniversal: true
replaceWhenTasteEvidenceExists: true
```

The starting point is not a finished design. The contract must still define hierarchy channels, state differentiation, composition, and validation.
