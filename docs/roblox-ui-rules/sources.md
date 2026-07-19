# 外部根拠インデックス

調査日: 2026-07-19

Roblox Creator Hub/API Referenceを優先し、各主張の完全なscope・limitations・conflictsは `evidence/sources/*.json` に保存する。

## レスポンシブとsafe area

- **ResponsiveResearch:SRC-001 — supported / design-recommendation**: Scale-relative sizing is preferable to fixed Offset sizing for UI intended to respond across multiple screen resolutions.
  - [Create HUD meters — Position the frame / Resize the frame](https://create.roblox.com/docs/tutorials/use-case-tutorials/ui/create-hud-meters) (official-doc)
  - [Create score bars — Test the design](https://create.roblox.com/docs/tutorials/use-case-tutorials/ui/create-a-score-bar) (official-doc)
- **ResponsiveResearch:SRC-002 — supported / engine-fact**: Size constraints can bound responsive UI elements.
  - [UISizeConstraint API reference](https://create.roblox.com/docs/reference/engine/classes/UISizeConstraint) (official-api)
- **ResponsiveResearch:SRC-003 — partially-supported / platform-guidance**: Safe-area/inset handling is required so interactive UI is not obscured by device cutouts or Roblox system UI.
  - [ScreenGui API reference — ScreenInsets, ClipToDeviceSafeArea, SafeAreaCompatibility, IgnoreGuiInset](https://create.roblox.com/docs/reference/engine/classes/ScreenGui) (official-api)
  - [GuiService API reference — GetGuiInset and TopbarInset](https://create.roblox.com/docs/reference/engine/classes/GuiService) (official-api)
- **ResponsiveResearch:SRC-004 — not-found / platform-guidance**: 667×375 is an official Roblox responsive-UI validation target.
  - [Studio testing modes — Device emulation](https://create.roblox.com/docs/studio/testing-modes#device-emulation) (official-doc)

## 入力とtouch target

- **InputResearch:SRC-001 — partially-supported / design-recommendation**: Hover cannot be the only carrier of essential GUI state or information for a Roblox experience intended to support mouse, touch, and gamepad input.
  - [GuiObject API reference — MouseEnter, MouseLeave, SelectionGained, and SelectionLost](https://create.roblox.com/docs/reference/engine/classes/GuiObject) (official-api)
  - [Mobile input](https://create.roblox.com/docs/input/mobile) (official-doc)
  - [Choose an art style — Establish an interaction order](https://create.roblox.com/docs/tutorials/curriculums/user-interface-design/choose-an-art-style#establish-an-interaction-order) (official-doc)
- **InputResearch:SRC-002 — partially-supported / design-recommendation**: Touch targets have an official Roblox minimum size, specifically 44 px.
  - [Mobile Accessibility: How WCAG 2.0 and Other W3C/WAI Guidelines Apply to Mobile — Touch Target Size and Spacing](https://w3c.github.io/Mobile-A11y-TF-Note/#targetSize) (official-doc)
  - [Understanding WCAG 2.1 Success Criterion 2.5.5: Target Size (Enhanced)](https://www.w3.org/WAI/WCAG21/Understanding/target-size.html) (official-doc)
- **InputResearch:SRC-003 — supported / design-recommendation**: Gamepad GUI selection requires explicit reachability and navigation consideration.
  - [Gamepad input](https://create.roblox.com/docs/input/gamepad) (official-doc)
- **InputResearch:SRC-004 — supported / platform-guidance**: GuiButton.Activated is the appropriate event for a standard primary GUI action across mouse, touch, and gamepad.
  - [GuiButton API reference — Activated](https://create.roblox.com/docs/reference/engine/classes/GuiButton#Activated) (official-api)
  - [Text & image buttons — Script buttons](https://create.roblox.com/docs/ui/buttons#script-buttons) (official-doc)
  - [GuiObject API reference — Active](https://create.roblox.com/docs/reference/engine/classes/GuiObject#Active) (official-api)

## layoutとscroll

- **LayoutResearch:SRC-001 — supported / engine-fact**: ScrollingFrame.AutomaticCanvasSize provides live, descendant-driven canvas sizing at edit time and run time; when it is X, Y, or XY, the corresponding canvas axes may adjust as child content changes.
  - [ScrollingFrame API reference](https://create.roblox.com/docs/reference/engine/classes/ScrollingFrame) (official-api)
  - [AutomaticSize enum reference](https://create.roblox.com/docs/reference/engine/enums/AutomaticSize) (official-api)
  - [Size modifiers and constraints](https://create.roblox.com/docs/ui/size-modifiers) (official-doc)
- **LayoutResearch:SRC-002 — supported / engine-fact**: With AutomaticCanvasSize enabled, a manually assigned CanvasSize remains a lower bound on the effective scrollable area: AbsoluteCanvasSize is the maximum of CanvasSize and the size required by children.
- **LayoutResearch:SRC-003 — supported / engine-fact**: UIListLayout and UIGridLayout expose inherited AbsoluteContentSize as a live measurement of occupied layout space; reading it makes the value current immediately, while its Changed event is deferred until the next render step after that read.
  - [UIGridStyleLayout API reference](https://create.roblox.com/docs/reference/engine/classes/UIGridStyleLayout) (official-api)
  - [UIListLayout API reference](https://create.roblox.com/docs/reference/engine/classes/UIListLayout) (official-api)
  - [UIGridLayout API reference](https://create.roblox.com/docs/reference/engine/classes/UIGridLayout) (official-api)
- **LayoutResearch:SRC-004 — supported / engine-fact**: UIListLayout owns sibling positioning: each sibling's Position and Rotation are ignored or overridden by the layout, so manual writes to those properties do not provide reliable per-item placement while the sibling remains under that layout.
  - [List and flex layouts](https://create.roblox.com/docs/ui/list-flex-layouts) (official-doc)
- **LayoutResearch:SRC-005 — supported / engine-fact**: A non-flex UIListLayout normally preserves each sibling's defined Size, but flex settings can influence or override size; UI size constraints can also override layout-controlled size.
- **LayoutResearch:SRC-006 — supported / engine-fact**: UIGridLayout owns both Position and Size of sibling GuiObjects; its CellSize defines the uniform cell size, so manually assigning child Position or Size conflicts with the grid and does not have the normal effect.
  - [Grid and table layouts](https://create.roblox.com/docs/ui/grid-table-layouts) (official-doc)
- **LayoutResearch:SRC-007 — supported / platform-guidance**: UIListLayout.Padding and UIGridLayout.CellPadding are inter-item spacing, not outer container insets; UIPadding is the official mechanism for top, bottom, left, and right padding around a parent's contents.
  - [UIPadding API reference](https://create.roblox.com/docs/reference/engine/classes/UIPadding) (official-api)
- **LayoutResearch:SRC-008 — partially-supported / engine-fact**: AbsoluteContentSize includes padding created by the layout itself, but the stronger claim that it always includes every outer UIPadding contribution in all ScrollingFrame configurations is not established by the official references.
- **LayoutResearch:SRC-009 — supported / engine-fact**: Wrapping, clipping, and scrolling are separate behaviors: UIListLayout.Wraps controls whether oversized list items continue on another line, UIGridLayout starts another row or column when a cell does not fit, and GuiObject.ClipsDescendants controls whether portions outside a rectangular parent are rendered.
- **LayoutResearch:SRC-010 — contradicted / design-recommendation**: “Always script CanvasSize from layout.AbsoluteContentSize” is not a universal Roblox requirement; it is an implementation option, while AutomaticCanvasSize is the documented adaptive alternative for descendant-driven scrolling content.
- **LayoutResearch:SRC-011 — supported / engine-fact**: List/grid layouts automatically recompute sibling placement when children are added or removed and when relevant ordering properties change, so callers ordinarily do not need to force ApplyLayout for live layout updates.

## layeringとclipping

- **LayeringResearch:SRC-001 — supported / engine-fact**: With LayerCollector.ZIndexBehavior set to Sibling (the default), children always render above their parents, and GuiObject.ZIndex orders children of the same UI object relative to one another; ZIndex is not a global ordering key across the entire descendant tree in this mode.
  - [LayerCollector API reference — ZIndexBehavior](https://create.roblox.com/docs/reference/engine/classes/LayerCollector) (official-api)
  - [Position and size UI objects — ZIndex](https://create.roblox.com/docs/ui/position-and-size#zindex) (official-doc)
- **LayeringResearch:SRC-002 — supported / engine-fact**: With LayerCollector.ZIndexBehavior set to Global, all descendants are sorted by GuiObject.ZIndex and ties are broken by hierarchy order; a descendant whose ZIndex is below its parent's can render underneath that parent.
  - [ZIndexBehavior enum reference](https://create.roblox.com/docs/reference/engine/enums/ZIndexBehavior) (official-api)
- **LayeringResearch:SRC-003 — supported / engine-fact**: GuiObject.ZIndex controls overlap within a UI container, while ScreenGui.DisplayOrder controls which of multiple ScreenGui containers is drawn above another; a higher DisplayOrder ScreenGui is drawn on top of a lower one.
- **LayeringResearch:SRC-004 — supported / engine-fact**: When GuiObject.ClipsDescendants is effective and true, any portion of descendant GUI elements outside the clipping GuiObject's rectangular bounds is made invisible. Raising a descendant's ZIndex changes draw order but does not provide an escape from that clipping boundary.
  - [GuiObject API reference — ClipsDescendants](https://create.roblox.com/docs/reference/engine/classes/GuiObject#ClipsDescendants) (official-api)
- **LayeringResearch:SRC-005 — supported / engine-fact**: Current clipping behavior for rotated descendants is conditional: when StarterGui.ClipsDescendantsSupportsRotation is enabled, rotated descendants can be clipped correctly; clipping by a rotated parent shape and clipping by rounded UICorner geometry remain unsupported. When the rollout is not enabled, a non-zero Rotation on the clipping GuiObject or any ancestor causes ClipsDescendants to be ignored.
  - [StarterGui API reference — ClipsDescendantsSupportsRotation](https://create.roblox.com/docs/reference/engine/classes/StarterGui#ClipsDescendantsSupportsRotation) (official-api)
- **LayeringResearch:SRC-006 — supported / design-recommendation**: A shadow implemented as an ordinary child GuiObject sometimes needs to be moved to a sibling or other non-descendant layer for two independent reasons: under default Sibling ZIndexBehavior a child always renders above its parent, so it cannot sit behind the parent's fill; and, if the shadow overflows a clipping parent, ClipsDescendants hides the overflow. A sibling shadow can be ordered behind the card and is not clipped by that card, although it can still be clipped by another shared ancestor.
- **LayeringResearch:SRC-007 — contradicted / design-recommendation**: A sibling shadow pattern is not universally mandatory. Current Roblox provides UIShadow, a UIComponent parented directly to a UI instance that renders a drop shadow below that parent. Other conditional alternatives include using Global ZIndexBehavior with a lower-ZIndex child when clipping is not needed, disabling ClipsDescendants when overflow is acceptable, using an unclipped outer wrapper with a separately clipped content frame, or rendering the effect in a dedicated overlay ScreenGui ordered by DisplayOrder.
  - [UIShadow API reference](https://create.roblox.com/docs/reference/engine/classes/UIShadow) (official-api)
  - [UI appearance modifiers — Shadow](https://create.roblox.com/docs/ui/appearance-modifiers#shadow) (official-doc)
- **LayeringResearch:SRC-008 — supported / design-recommendation**: For overlays that must cross unrelated UI branches, robust options are to place the overlay at an appropriate common ancestor as a sibling, switch the LayerCollector to Global and assign unambiguous ZIndex values, or use a separate ScreenGui with higher DisplayOrder. Merely assigning a very large ZIndex to a deeply nested object is not a universal cross-branch or cross-ScreenGui guarantee under Sibling behavior.

## motionとreduced motion

- **MotionResearch:SRC-001 — supported / engine-fact**: TweenService motion is parameterized by a numeric duration and by easing style/direction through TweenInfo.
  - [TweenInfo datatype reference](https://create.roblox.com/docs/reference/engine/datatypes/TweenInfo) (official-api)
  - [UI animation/tweens](https://create.roblox.com/docs/ui/animation) (official-doc)
- **MotionResearch:SRC-002 — supported / engine-fact**: When two tweens on the same object attempt to animate the same property, playing the newer tween automatically cancels and overwrites the earlier tween; tweens on different properties may run simultaneously.
  - [TweenBase class reference — Play and Completed](https://create.roblox.com/docs/reference/engine/classes/TweenBase) (official-api)
- **MotionResearch:SRC-003 — partially-supported / design-recommendation**: Overlapping UI motion may warrant explicit cancellation and per-motion ownership so interruption behavior is deterministic.
- **MotionResearch:SRC-004 — partially-supported / design-recommendation**: Pressed and entrance motion states can be specified numerically through TweenInfo values and target UI property values, but treating those numbers as acceptance checks is an implementation/verification guideline rather than official Roblox design guidance.
  - [Add 2D audio — UI interaction](https://create.roblox.com/docs/tutorials/use-case-tutorials/audio/add-2D-audio) (official-doc)
- **MotionResearch:SRC-005 — supported / platform-guidance**: Official Roblox guidance says important UI interactions should provide instant feedback, and recommends multiple sensory forms of feedback when a visual change or animation alone may not be accessible.
  - [Accessibility guidelines — sound non-reliance](https://create.roblox.com/docs/production/publishing/accessibility) (official-doc)
- **MotionResearch:SRC-006 — supported / engine-fact**: GuiService.ReducedMotionEnabled is an official boolean player-preference signal that maps to Roblox's Reduce Motion setting and indicates that motion effects and animations should be reduced or completely removed.
- **MotionResearch:SRC-007 — supported / platform-guidance**: Roblox officially recommends reducing or removing UI tween motion when ReducedMotionEnabled is true; documented implementation options include setting TweenInfo.Time to 0 so the UI snaps to its target, or replacing positional motion with a fade.

## textとlocalization

- **TextResearch:SRC-201 — partially-supported / platform-guidance**: Long localized strings should be exercised in Studio: Player Emulator can emulate a Locale and can Elongate translated strings specifically to reveal UI that cannot accommodate text longer than the default translated text.
  - [Studio testing modes — Player emulation](https://create.roblox.com/docs/studio/testing-modes#player-emulation) (official-doc)
  - [Size modifiers and constraints — Automatic sizing](https://create.roblox.com/docs/ui/size-modifiers#automatic-sizing) (official-doc)
- **TextResearch:SRC-202 — supported / engine-fact**: AutomaticSize has specific, falsifiable layout interactions: it sizes a GuiObject from descendant content on the selected X, Y, or XY axes; AnchorPoint determines the point from which it expands; the object's Size is a minimum on automatically sized axes; and TextWrapped combined with AutomaticSize Y or XY expands a text object vertically as lines wrap.
  - [GuiObject.AutomaticSize](https://create.roblox.com/docs/reference/engine/classes/GuiObject#AutomaticSize) (official-api)
- **TextResearch:SRC-203 — supported / engine-fact**: UI constraints can take precedence over layout: when a GuiObject is controlled by both a UIListLayout-like layout structure and a UISizeConstraint, the UISizeConstraint overrides the layout and controls object size; UIAspectRatioConstraint has the same documented precedence. UITextSizeConstraint separately bounds font size for text objects and is respected by TextScaled.
  - [Size modifiers and constraints — Constraints](https://create.roblox.com/docs/ui/size-modifiers#constraints) (official-doc)
- **TextResearch:SRC-204 — supported / design-recommendation**: TextScaled and AutomaticSize solve opposite sizing problems, and Roblox recommends not applying both to the same TextLabel: TextScaled changes text to fit the container, ignores TextSize, and automatically enables TextWrapped, whereas AutomaticSize changes the UI to fit content while preserving a consistent font size.
  - [TextLabel.TextScaled](https://create.roblox.com/docs/reference/engine/classes/TextLabel#TextScaled) (official-api)
  - [Size modifiers and constraints — Text size](https://create.roblox.com/docs/ui/size-modifiers#text-size) (official-doc)
- **TextResearch:SRC-205 — partially-supported / design-recommendation**: A fixed-size text container needs an explicit overflow decision if content must remain intentionally represented: TextFits reports whether the text fits; TextBounds reports the minimum rendered-text dimensions; TextWrapped breaks long text into lines but omits any further line whose height would exceed the container; TextTruncate.AtEnd or SplitWord replaces non-fitting graphemes with "..." using different word-boundary behavior.
  - [TextLabel text measurement and overflow properties](https://create.roblox.com/docs/reference/engine/classes/TextLabel#TextFits) (official-api)
  - [TextTruncate enum](https://create.roblox.com/docs/reference/engine/enums/TextTruncate) (official-api)
