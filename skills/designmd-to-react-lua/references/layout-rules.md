# Layout rules (the anti-breakage core)

These rules exist because Roblox UI breaks through accumulated manual
coordinate math. They are constraints on generation, not suggestions.

## 1. Delegate repetition — never hand-position repeating content

- Lists/columns/rows: `UIListLayout` with `Padding = UDim.new(0, spacingToken)`,
  `SortOrder = Enum.SortOrder.LayoutOrder`, alignment via
  `HorizontalAlignment`/`VerticalAlignment`. Give every child a `LayoutOrder`.
- Grids: `UIGridLayout` with `CellSize`/`CellPadding` from tokens.
- Inner padding: `UIPadding` with spacing tokens — never fake padding by
  shrinking child sizes.
- Manual `Position` is allowed ONLY for singleton anchored elements (a close
  button on a window corner, a header band, HUD region containers) and must
  use `AnchorPoint` + edge-relative `UDim2` (e.g. anchor `(1, 0)` +
  `Position = UDim2.new(1, -pad, 0, pad)` for top-right).

## 2. Scale-first sizing

- Containers and screens: `UDim2.fromScale` + `UIAspectRatioConstraint` to
  lock shapes. Offsets are reserved for: spacing tokens, stroke thicknesses,
  chrome heights that must be finger-sized (a 44px+ button height), and
  hairline details.
- Text: `TextScaled = true` + `UITextSizeConstraint{ MaxTextSize = token }`
  for buttons/headers; fixed `TextSize = token` for body/caption.
- Never compute a child's pixel position from a parent's pixel size — that
  is the error-propagation pattern this whole system exists to kill.

## 3. ScreenGui settings (every generated ScreenGui)

```lua
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling  -- default is Global; Global hides
                                                        -- default-ZIndex children under overlays
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = false                        -- HUD roots: use ScreenInsets instead
screenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
```

- Never hardcode the topbar height (58px desktop / ~52px mobile today, and
  it changes) — query `GuiService:GetInsetArea()` if an exact inset is
  needed, and only after a Heartbeat (it can read 0,0 on the first frame).

## 4. Z-layering plan

With Sibling behavior, ZIndex orders SIBLINGS only; children always draw
above their parent. Two consequences:

- Reserve `DisplayOrder` bands per ScreenGui: HUD 0–9, windows 10–19,
  popups/toasts 20–29, tooltips 30+. Inside a single ScreenGui (stories, a
  window component that owns its dim), reproduce the same bands with sibling
  ZIndex on the top-level children instead.
- **A shadow/glow can never be a child of the element it sits behind** — it
  would render on top. Make it a lower-ZIndex SIBLING inside a shared
  wrapper (see the PanelGroup pattern in `preview-place/src/Components/Window.luau`;
  this exact bug shipped once and was caught by calibration).

## 4.5 Recurring shape mechanics (named patterns)

- **Partial corner rounding** (integrated header/footer band flush inside a
  rounded panel): a single UICorner rounds all four corners, so a band whose
  top must follow the panel radius but whose bottom must stay square needs
  either (a) the band's own UICorner + a masking rectangle covering its
  bottom edge, or (b) `ClipsDescendants` on the panel with an oversized band.
  Pick one and comment it — this shape recurs in most band-headed tastes.
- **Edge-pinned child vs UIPadding**: UIPadding insets ALL children, so a
  meta-strip that must sit flush with the outer edge (progress strip on a
  card bottom, verdict band) cannot share a padded parent with the content.
  Split into two siblings: a padded content wrapper + an unpadded edge strip.
- **UIGridLayout vs child aspect constraints**: a grid-managed child with its
  own UIAspectRatioConstraint fights the grid's CellSize unless CellSize is
  pre-matched to that ratio. Choose ONE owner of the shape: either set
  CellSize to the ratio and drop the child constraint, or use the constraint
  and let the grid size only one axis.
- **Scale fractions + UIListLayout gaps overflow**: children whose Scale
  widths sum to 1.0 PLUS list-layout Padding gaps overflow the parent (the
  gaps aren't part of the fractions). Give each child a negative offset
  carrying its share of the total gap: `Size = UDim2.new(frac, -GAP_TOTAL *
  frac, ...)` — verified failure mode: a leaderboard column pushed off the
  viewport edge.
- **Grid children can't share a cell**: two siblings with the same
  LayoutOrder still get SEPARATE sequential cells — an emphasis/selection
  overlay must live INSIDE the card component (the `-selected` prop path),
  never as a grid sibling.

- **Responsive window pattern** (mandatory for any window with content):
  the panel sizes Scale-first — `Size = UDim2.fromScale(~0.85, ~0.85)` (of
  the full-bleed root) with a `UISizeConstraint.MaxSize` at the taste's
  intended desktop dimensions — so it can NEVER exceed the viewport. Header
  and close live INSIDE the panel rect (or clamp on-screen if the taste
  floats them); the content region is a `ScrollingFrame` whenever its
  natural height can exceed the panel (a 6-item list always can). Verified
  failure mode: every fixed-offset shop window (560×560, 700×520...) pushed
  its header/close off-screen or made items unreachable at 667×375.
- **ScrollingFrame CanvasSize binds live to the layout**: set
  `CanvasSize` from the UIGridLayout/UIListLayout's `AbsoluteContentSize`
  (via `[React.Change.AbsoluteContentSize]` updating a binding) — static
  row-count math silently goes stale when a grid re-wraps its column count
  at smaller viewports (verified failure mode). Grids MAY re-wrap columns
  responsively when cells no longer fit; preserving the cell shape
  (near-square etc.) outranks the taste's stated desktop column count.
- **Smallest supported viewport**: 667×375 landscape (phone; portrait is
  out of scope by project decision). HUD stories must be collision-free and
  windows fully operable there — verify at BOTH the desktop emulation and
  667×375 before delivering.

## 5. Reserved zones & tap targets

- HUD must keep clear: bottom-left (virtual joystick), bottom-right (jump
  button), top strip (topbar/unibar).
- Interactive elements: 44px minimum at reference resolution; when the
  DESIGN.md taste is chunky, prefer 56px+.
- Hover is garnish, never load-bearing: any hover-only affordance needs a
  touch-visible equivalent.

## 6. Component structure conventions

- One module per component, named after its DESIGN.md entry (PascalCase file,
  kebab-case token names inside).
- Props: `size`, `position`, `anchorPoint`, `layoutOrder`, `zIndex`
  passthroughs + component-specific props (`text`, `variant`, `disabled`,
  `onActivated`...). Components must be placeable by BOTH layouts
  (LayoutOrder path) and anchors (position path).
- All visual constants come from the Theme module; a literal color/size in a
  component body is a review defect unless the DESIGN.md itself inlines it
  (e.g. bevel shades in `shadow: bevel(...)` values).
