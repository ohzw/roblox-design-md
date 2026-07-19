# Design-rule source index

調査日: 2026-07-19

Roblox公式資料を優先し、Xbox/WCAGは外部のproject-adoptable guidanceとして分離する。完全なscope、limitations、conflictsは `evidence/design/sources/*.json` に保存する。

## Typography

- **TypographyDesignResearch:SRC-001 — supported / design-recommendation**: Roblox's current API reference recommends that rendered text, and specifically UITextSizeConstraint.MinTextSize, not be lower than 9 because it may be unreadable or invisible to many users. The 9 value is an official Roblox readability recommendation in API-reference prose; it is not documented as a runtime/Studio warning, an enforced API minimum, or a universal platform rule.
  - [UITextSizeConstraint | Roblox Creator Hub](https://create.roblox.com/docs/reference/engine/classes/UITextSizeConstraint) (official-api)
  - [TextLabel | Roblox Creator Hub](https://create.roblox.com/docs/reference/engine/classes/TextLabel) (official-api)
- **TypographyDesignResearch:SRC-002 — supported / engine-fact**: TextLabel.TextSize controls the height of one rendered line in offsets, not typographic points. Roblox does not document a separate enforced minimum on the TextSize property.
- **TypographyDesignResearch:SRC-003 — supported / engine-fact**: UITextSizeConstraint constrains TextLabel, TextButton, or TextBox text between MinTextSize and MaxTextSize when parented to the text object; it is intended for use with TextScaled. MinTextSize defaults to 1, MaxTextSize defaults to 1000, and the minimum must not exceed the maximum.
- **TypographyDesignResearch:SRC-004 — supported / platform-guidance**: With TextScaled enabled, TextSize is ignored, TextWrapped is automatically enabled, and text scales to fill the label. For on-screen UI Roblox recommends constraining the possible range, but more generally recommends avoiding TextScaled in favor of AutomaticSize because unconstrained scaling can make text unreadably small; Roblox also recommends not combining AutomaticSize and TextScaled on the same TextLabel.
- **TypographyDesignResearch:SRC-005 — supported / engine-fact**: Roblox provides a player Preferred Text Size setting. TextScaled text is not scaled by PreferredTextSize; UITextSizeConstraint caps the setting's effect; AutomaticSize can grow or shrink element bounds with the resized text; and wrapped text can add lines within the element's absolute-size limits.
  - [Accessibility guidelines | Roblox Creator Hub](https://create.roblox.com/docs/production/publishing/accessibility) (official-doc)
- **TypographyDesignResearch:SRC-006 — supported / engine-fact**: FontFace accepts Roblox's Font datatype, whose Weight property uses Enum.FontWeight. Roblox exposes nine enum values from Thin (100) through Heavy (900), with Regular (400) as the default; Font constructors accept a requested weight.
  - [Font | Roblox Creator Hub](https://create.roblox.com/docs/reference/engine/datatypes/Font) (official-api)
  - [FontWeight | Roblox Creator Hub](https://create.roblox.com/docs/reference/engine/enums/FontWeight) (official-api)
- **TypographyDesignResearch:SRC-007 — supported / engine-fact**: Actual font-face availability should be established per family rather than inferred from Enum.FontWeight: TextService:GetFamilyInfoAsync returns a family's Faces, and Roblox's sample enumerates each face's Weight and Style.
  - [TextService | Roblox Creator Hub](https://create.roblox.com/docs/reference/engine/classes/TextService) (official-api)
- **TypographyDesignResearch:SRC-008 — supported / design-recommendation**: Roblox's published design guidance uses size and boldness for hierarchy: headers and titles should be larger and bolder than body text, and color or bolding can highlight important information. It also says to prioritize legibility when selecting a font.
  - [UI and UX design | Roblox Creator Hub](https://create.roblox.com/docs/production/game-design/ui-ux-design) (official-doc)
- **TypographyDesignResearch:SRC-009 — not-found / design-recommendation**: Roblox publishes a specific semantic mapping such as Regular for body, Medium for labels, SemiBold for controls, and Bold for headings.
- **TypographyDesignResearch:SRC-010 — not-found / design-recommendation**: No current Roblox-specific rule for sentence case, title case, or all-caps usage was found in the reviewed official typography, accessibility, and UI/UX sources.
- **TypographyDesignResearch:SRC-011 — supported / design-recommendation**: When Roblox is silent on casing, Microsoft Xbox Accessibility Guidelines recommend proper sentence case instead of full caps or full lowercase for lines of text; one- or two-word labels are exempt. For subtitles/captions, Microsoft recommends mixed case because it is easier to read than uniform case.
  - [Xbox Accessibility Guideline 101: Text display | Microsoft Learn](https://learn.microsoft.com/en-us/xbox/accessibility/xbox-accessibility-guidelines/101) (official-doc)
  - [Xbox Accessibility Guideline 104: Subtitles and captions | Microsoft Learn](https://learn.microsoft.com/en-us/xbox/accessibility/xbox-accessibility-guidelines/104) (official-doc)
- **TypographyDesignResearch:SRC-012 — supported / engine-fact**: Roblox TextLabel.LineHeight is an engine control expressed as a multiplier of the font em square. Its documented range is 1.0 to 3.0 and its default is 1.0. Roblox does not publish a separate readable line-height minimum in the reviewed design/accessibility guidance.
- **TypographyDesignResearch:SRC-013 — supported / design-recommendation**: For blocks longer than two lines, Xbox Accessibility Guideline 101 recommends configurability for line width and spacing; if configurability is absent, it suggests line spacing of at least 1.5, alongside limits/values for line width, paragraph spacing, letter spacing, and word spacing. WCAG 2.2's 1.5 line-height figure has a different scope: web content must survive a user override to that value without losing content or functionality; WCAG explicitly says authors are not required to use 1.5 as their default.
  - [Understanding WCAG 2.2 Success Criterion 1.4.12: Text Spacing | W3C](https://www.w3.org/WAI/WCAG22/Understanding/text-spacing.html) (official-doc)
- **TypographyDesignResearch:SRC-014 — supported / engine-fact**: Roblox exposes TextStrokeColor3 and TextStrokeTransparency for text outlines. The API recommends TextStrokeTransparency in the 0.75–1 range for a subtle effect and identifies UIStroke as a more powerful gradient-capable alternative; it does not claim that every text element should have an outline or that this range guarantees readability.
- **TypographyDesignResearch:SRC-015 — supported / design-recommendation**: For text over variable gameplay backgrounds, Xbox guidance treats borders/outlines and solid or opacity-adjustable text backgrounds as valid ways to improve contrast. It recommends measuring text against the lowest-contrast area of a non-solid background; subtitle guidance specifically recommends a configurable solid background and opacity.
  - [Xbox Accessibility Guideline 102: Contrast | Microsoft Learn](https://learn.microsoft.com/en-us/xbox/accessibility/xbox-accessibility-guidelines/102) (official-doc)
- **TypographyDesignResearch:SRC-016 — supported / platform-guidance**: Roblox's general accessibility guidance says small text can be difficult to read, increasing smaller labels makes them clearer to most players, and text/background colors should have sufficient contrast. That design page does not publish a numeric default text-size minimum or numeric contrast ratio.
- **TypographyDesignResearch:SRC-017 — supported / design-recommendation**: Microsoft Xbox Accessibility Guideline 101 supplies external game-specific numeric defaults when Roblox guidance is insufficient: at 1080p it recommends at least 26 measured body-height pixels on console and 18 on PC/VR; for mobile/game streaming it recommends 18 pixels at 100 DPI, scaling linearly with DPI. It also recommends allowing scaling to 200% of those default minima without loss of content, functionality, or meaning.
- **TypographyDesignResearch:SRC-018 — supported / design-recommendation**: High-authority external contrast guidance is numeric but not Roblox-specific: Xbox XAG 102 recommends 4.5:1 for standard important text and 3:1 for its defined large text; WCAG 2.2 SC 1.4.3 likewise requires 4.5:1 for ordinary web text and 3:1 for large-scale web text. WCAG 2.2 SC 1.4.4 requires web text to resize to 200% without loss of content or functionality.
  - [Understanding WCAG 2.2 Success Criterion 1.4.3: Contrast (Minimum) | W3C](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html) (official-doc)
  - [Understanding WCAG 2.2 Success Criterion 1.4.4: Resize Text | W3C](https://www.w3.org/WAI/WCAG22/Understanding/resize-text.html) (official-doc)

## Hierarchy

- **HierarchyDesignResearch:SRC-301 — supported / platform-guidance**: Roblox's official UI curriculum recommends identifying a primary interaction as the action a player is most likely to perform, then giving primary, secondary, and tertiary interactions different visual emphasis according to their likelihood and intended sequence.
  - [Choose an art style — Establish an interaction order](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/choose-an-art-style) (official-doc)
- **HierarchyDesignResearch:SRC-302 — supported / platform-guidance**: Official Roblox guidance supports using size, color, spatial placement, negative space, and proximity to direct attention and communicate relative importance, while using these tools in moderation.
  - [Wireframe your layouts — Plan a visual hierarchy](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/wireframe-your-layouts) (official-doc)
- **HierarchyDesignResearch:SRC-303 — supported / platform-guidance**: Roblox's curriculum recommends at least one visible feedback treatment when an interactable UI element is in focus, such as an outline or a change in size, color, or animation.
  - [Understanding WCAG 2.2 Success Criterion 2.4.7: Focus Visible](https://www.w3.org/WAI/WCAG22/Understanding/focus-visible.html) (official-doc)
  - [Understanding WCAG 2.2 Success Criterion 1.4.1: Use of Color](https://www.w3.org/WAI/WCAG22/Understanding/use-of-color.html) (official-doc)
- **HierarchyDesignResearch:SRC-304 — supported / platform-guidance**: Roblox officially recommends grouping UI elements that belong to the same information category or function, and using proximity to communicate their association.
- **HierarchyDesignResearch:SRC-305 — supported / platform-guidance**: Roblox guidance recommends reducing cognitive load by prioritizing contextually relevant information, limiting simultaneous categories and elements, and avoiding excessive visual emphasis or clutter.
- **HierarchyDesignResearch:SRC-306 — supported / platform-guidance**: Roblox official guidance recommends making interaction states perceptibly different and providing feedback for actions; color may participate in state differentiation but should not be the only cue when it carries meaning.
- **HierarchyDesignResearch:SRC-307 — partially-supported / design-recommendation**: A proposed Roblox rule that every screen must have exactly one primary action, or that multiple primary-looking actions are universally prohibited, is only partially supported: Roblox asks for a clear prioritized interaction order, but the exact one-primary-per-screen maximum comes from general design-system guidance rather than the Roblox curriculum.
  - [Button — New York State Design System](https://designsystem.ny.gov/components/button/) (official-doc)
- **HierarchyDesignResearch:SRC-308 — supported / platform-guidance**: Roblox officially recommends validating layouts and flows with players and experiments rather than treating hierarchy recommendations as self-proving outcomes.
- **HierarchyDesignResearch:SRC-309 — not-found / design-recommendation**: A claim that Roblox user testing has proven these hierarchy and interaction-order rules to increase retention, engagement, or conversion is not established by the reviewed sources.

## Color and contrast

- **ColorDesignResearch:SRC-001 — supported / platform-guidance**: Roblox officially recommends sufficient contrast between text and its background and specifically warns against light text on light backgrounds and dark text on dark backgrounds.
  - [Accessibility guidelines — Color contrast](https://create.roblox.com/docs/production/publishing/accessibility#color-contrast) (official-doc)
  - [Cross-platform development — Accessibility](https://create.roblox.com/docs/projects/cross-platform#accessibility) (official-doc)
- **ColorDesignResearch:SRC-002 — supported / platform-guidance**: The WCAG 2.2 Level AA thresholds are 4.5:1 for normal text and 3:1 for large-scale text; these are imported external web-accessibility thresholds, not Roblox engine requirements.
- **ColorDesignResearch:SRC-003 — supported / platform-guidance**: WCAG 2.2 Level AA uses a 3:1 threshold for visual information needed to identify active UI components and states, and for meaningful graphical objects; this is also an imported external threshold rather than a Roblox requirement.
  - [Understanding Success Criterion 1.4.11: Non-text Contrast](https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html) (official-doc)
- **ColorDesignResearch:SRC-004 — supported / platform-guidance**: Roblox officially advises creators not to rely on color alone to communicate information, actions, or outcomes for players with color-vision deficiencies, and recommends pairing color with non-color cues such as symbols, icons, shapes, or patterns.
  - [Accessibility guidelines — Color non-reliance](https://create.roblox.com/docs/production/publishing/accessibility#color-non-reliance) (official-doc)
  - [Choose an art style — Select a color theme](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/choose-an-art-style#select-a-color-theme) (official-doc)
- **ColorDesignResearch:SRC-005 — supported / platform-guidance**: The external WCAG rule likewise prohibits using color as the only visual means of conveying information or state; a hue-only status distinction is therefore insufficient under that web standard.
- **ColorDesignResearch:SRC-006 — supported / design-recommendation**: For on-screen text that may overlay a changing 3D scene, Roblox recommends placing text on a contrasting color or giving it a stroke so it does not blend into the background.
  - [Choose an art style — Determine a text system](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/choose-an-art-style#determine-a-text-system) (official-doc)
- **ColorDesignResearch:SRC-007 — supported / design-recommendation**: Roblox recommends a limited color theme whose colors maintain consistent, quickly learned associations with UI functions, but does not publish a universal semantic mapping such as red always meaning error or green always meaning success.
  - [Choose an art style — Identify your UI elements](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/choose-an-art-style#identify-your-ui-elements) (official-doc)
- **ColorDesignResearch:SRC-008 — supported / design-recommendation**: Roblox recommends that overlay UI colors remain readable over both light and dark elements in the 3D world.
- **ColorDesignResearch:SRC-009 — not-found / design-recommendation**: An official Roblox requirement that every in-experience UI provide separate dark and light surface themes was not found in the reviewed Creator Hub accessibility, cross-platform, UI-art-style, and styling sources.
- **ColorDesignResearch:SRC-010 — supported / platform-guidance**: Roblox officially recommends respecting the player's Preferred Transparency setting so UI backgrounds become more opaque when the player requests it, improving readability and contrast.
  - [Accessibility guidelines — Preferred transparency](https://create.roblox.com/docs/production/publishing/accessibility#preferred-transparency) (official-doc)
- **ColorDesignResearch:SRC-011 — supported / engine-fact**: Roblox provides an engine-level non-interactable GUI state that can be targeted by UI state styling: when GuiObject.Interactable is false, its GuiState is NonInteractable, and Roblox style state selectors correspond to GuiState values.
  - [GuiObject.Interactable and GuiObject.GuiState](https://create.roblox.com/docs/reference/engine/classes/GuiObject#Interactable) (official-api)
  - [GuiState enum](https://create.roblox.com/docs/reference/engine/enums/GuiState) (official-api)
  - [CSS Comparisons — Pseudo-classes](https://create.roblox.com/docs/ui/styling/css-comparisons#pseudo-classes) (official-doc)
- **ColorDesignResearch:SRC-012 — not-found / design-recommendation**: No official Roblox visual-design rule was found that disabled controls must use a fixed opacity, desaturation amount, grey palette, or reduced-contrast treatment.
  - [Choose an art style — Establish an interaction order](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/choose-an-art-style#establish-an-interaction-order) (official-doc)
- **ColorDesignResearch:SRC-013 — supported / platform-guidance**: WCAG 2.2 exempts inactive UI components from its minimum text and non-text contrast criteria; this external exception does not require or recommend making disabled Roblox controls low contrast.
  - [Understanding Success Criterion 1.4.3: Contrast (Minimum) — Inactive User Interface Components](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html#inactive-user-interface-components) (official-doc)

## HUD and composition

- **CompositionDesignResearch:SRC-001 — supported / platform-guidance**: During active gameplay, Roblox recommends showing only the information and controls that are vital in the current context, especially on mobile where screen space is limited.
  - [Position and size UI objects — Context-based UI](https://create.roblox.com/docs/ui/position-and-size#context-based-ui) (official-doc)
  - [UI and UX design — Prioritization](https://create.roblox.com/docs/production/game-design/ui-ux-design#prioritization) (official-doc)
- **CompositionDesignResearch:SRC-002 — supported / design-recommendation**: Roblox recommends grouping information and controls that belong to the same category, and using proximity to communicate relationships.
  - [Wireframe your layouts — Plan a visual hierarchy](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/wireframe-your-layouts#plan-a-visual-hierarchy) (official-doc)
  - [UI and UX design — Attention](https://create.roblox.com/docs/production/game-design/ui-ux-design#attention) (official-doc)
- **CompositionDesignResearch:SRC-003 — partially-supported / design-recommendation**: Keeping persistent status information near the top or sides so the central view can remain focused on 3D action is supported as a genre-dependent HUD composition pattern, not as a universal Roblox layout rule.
- **CompositionDesignResearch:SRC-004 — supported / design-recommendation**: Roblox recommends minimizing obstruction and distraction through contextual display, hierarchy, and moderation, rather than through a fixed screen-space budget.
- **CompositionDesignResearch:SRC-005 — supported / platform-guidance**: On touch devices, Roblox identifies the bottom-left and bottom-right corners as qualitative default-control zones and recommends keeping important information and custom virtual buttons out of those zones.
  - [Position and size UI objects — Reserved zones and thumb zones](https://create.roblox.com/docs/ui/position-and-size#cross-platform-factors) (official-doc)
  - [Wireframe your layouts — Block in UI elements](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/wireframe-your-layouts#block-in-ui-elements) (official-doc)
- **CompositionDesignResearch:SRC-006 — contradicted / engine-fact**: A universal fixed joystick rectangle or jump-button rectangle is not guaranteed by Roblox and must not be treated as a platform invariant.
  - [DevTouchMovementMode enum](https://create.roblox.com/docs/reference/engine/enums/DevTouchMovementMode) (official-api)
  - [StarterPlayer.DevTouchMovementMode](https://create.roblox.com/docs/reference/engine/classes/StarterPlayer#DevTouchMovementMode) (official-api)
  - [Position and size UI objects — Thumb zones](https://create.roblox.com/docs/ui/position-and-size#thumb-zones) (official-doc)
- **CompositionDesignResearch:SRC-007 — supported / engine-fact**: Core UI and device cutouts impose platform-level safe-area constraints, and Roblox exposes runtime inset data instead of requiring hard-coded HUD margins.
  - [ScreenGui API reference](https://create.roblox.com/docs/reference/engine/classes/ScreenGui) (official-api)
  - [GuiService API reference — TopbarInset, GetGuiInset, and GetInsetArea](https://create.roblox.com/docs/reference/engine/classes/GuiService) (official-api)
- **CompositionDesignResearch:SRC-008 — not-found / platform-guidance**: An official Roblox numeric maximum for HUD screen coverage, screen-space density, persistent element count, or required percentage of unobstructed gameplay view was found.
  - [Position and size UI objects](https://create.roblox.com/docs/ui/position-and-size) (official-doc)
- **CompositionDesignResearch:SRC-009 — not-found / engine-fact**: An official Roblox fixed numeric touch-control exclusion zone, including guaranteed joystick and jump-button pixel or percentage rectangles, was found.
- **CompositionDesignResearch:SRC-010 — supported / platform-guidance**: Roblox recommends composing and testing UI across multiple screen and input categories, using Studio emulation for fast coverage and real hardware for usability and behavior that emulation cannot reproduce.
  - [Studio testing modes — Device emulation](https://create.roblox.com/docs/studio/testing-modes#device-emulation) (official-doc)
  - [Test on hardware](https://create.roblox.com/docs/performance-optimization/test-on-hardware) (official-doc)
- **CompositionDesignResearch:SRC-011 — supported / engine-fact**: GuiButton.Modal is not a complete modal-dialog or focus-trapping mechanism; its documented Roblox engine effect is limited to mouse-lock behavior.
  - [GuiButton.Modal API reference](https://create.roblox.com/docs/reference/engine/classes/GuiButton#Modal) (official-api)
  - [GuiService.SelectedObject API reference](https://create.roblox.com/docs/reference/engine/classes/GuiService#SelectedObject) (official-api)
- **CompositionDesignResearch:SRC-012 — supported / design-recommendation**: For a truly modal interface, focus should enter and remain within the dialog, outside content should be inert and visually obscured, Escape should close it, and focus should normally return to the invoking control.
  - [W3C WAI-ARIA Authoring Practices — Dialog (Modal) Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/) (official-doc)
- **CompositionDesignResearch:SRC-013 — not-found / design-recommendation**: Roblox officially requires gameplay modals to preserve a specified amount of world visibility, use a specified dimming opacity, or pause world simulation.
