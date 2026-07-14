# Motion implementation (tokens → TweenService)

Motion tokens map to `TweenInfo.new(duration, easingStyle, easingDirection)`.
The implementation pattern is **UIScale + ref + TweenService** — it composes
with any layout (UIScale scales the rendered result without disturbing
UIListLayout positions of siblings' layout slots).

## Press squash (mandatory on every button when the DESIGN.md defines it)

```lua
local scaleRef = React.useRef(nil)

local SQUASH_IN = TweenInfo.new(Theme.motion.durations.instant,
	Theme.motion.easings.settle.style, Theme.motion.easings.settle.direction)
local SQUASH_OUT = TweenInfo.new(Theme.motion.durations.fast,
	Theme.motion.easings.settle.style, Theme.motion.easings.settle.direction)

local function squash(target, info)
	local uiScale = scaleRef.current
	if uiScale then
		TweenService:Create(uiScale, info, { Scale = target }):Play()
	end
end

-- in the root element:
[React.Event.MouseButton1Down] = function() squash(0.92, SQUASH_IN) end,
[React.Event.MouseButton1Up] = function() squash(1, SQUASH_OUT) end,
[React.Event.MouseLeave] = function() squash(1, SQUASH_OUT) end,
-- children: Scale = e("UIScale", { ref = scaleRef }),
```

Pair the squash with the structural press state (bevel collapse) — motion
and state are two halves of one affordance.

**Non-squash press feedback** (dark/flat tastes that ban squash): tween a
brightness lift instead — precompute the lifted color in Theme
(`Theme.derived.<x>Pressed`, e.g. `color:Lerp(Color3.new(1,1,1), 0.12)`) and
tween `BackgroundColor3` to it on Down, back on Up/Leave, same durations as
the squash pattern. "Stroke lift" variants tween `UIStroke.Transparency`
toward 0 or thickness by +1. Read the DESIGN.md's Motion prose to pick which.

## Entrance (windows/popups)

Scale from the DESIGN.md's entrance pattern (e.g. 0.8 → 1.0 pop):

```lua
React.useEffect(function()
	local uiScale = scaleRef.current
	if uiScale then
		uiScale.Scale = 0.8
		TweenService:Create(uiScale, TweenInfo.new(
			Theme.motion.durations.normal,
			Theme.motion.easings.pop.style,
			Theme.motion.easings.pop.direction
		), { Scale = 1 }):Play()
	end
end, {})
```

- Put the UIScale on a wrapper that contains BOTH the panel and its shadow
  (PanelGroup pattern) so they scale together.
- Exits: tween scale down (e.g. → 0.9) + transparency, `durations.fast`,
  exit easing, then unmount on completion (`Tween.Completed:Once(...)` →
  state change). Exits must be faster than entrances when the DESIGN.md says
  so (asymmetry is a common taste rule).

**Fade entrances** (tastes that ban scale pops): fading a panel WITH its
children requires a `CanvasGroup` — tween `GroupTransparency` 1 → 0
(optionally + a small positional slide). Caveats: CanvasGroup rasterizes its
subtree (slight blur on text at scale ≠ 1, memory cost), and
`GroupTransparency` MULTIPLIES with each child's own Background/Text
transparency — translucent-panel tokens keep their meaning, but verify the
settled state numerically (GroupTransparency == 0, panel transparency ==
token).
**CanvasGroup CLIPS to its own bounds.** If the taste's anatomy has chrome
floating OUTSIDE the panel rect (sticker tabs, corner-overlapping close
buttons), a CanvasGroup wrapper silently cuts them off. In that case use a
plain Frame wrapper and fade panel/children individually instead — never
trade the anatomy for a one-tween convenience.

**Color-only press lifts are always safe to tween directly.** The
frozen-initial-render precaution applies to properties that props/state ALSO
drive (positions, sizes). A `BackgroundColor3` that props never touch can be
tweened on the ref with no special handling — don't over-engineer it.

## Animating a property that props/state also drive (toggles, sliders)

When a tweened property (a knob's Position, a panel's offset) is ALSO
determined by props, naive code makes React snap it at the next commit and
kill the tween. Use the **frozen-initial-render** pattern: render the
animated property ONCE from the first-render value (`useRef(props.value)`),
and drive every subsequent change through a `useEffect` on the prop that
tweens via a ref. Because the rendered prop value never changes between
renders, React never rewrites the property, and TweenService stays the sole
owner. Worked example: `preview-place/src/Components/ChunkyToggle.luau`.
(Alternative for continuous values: `useBinding` and tween a NumberValue you
map into the binding.)

## Value changes (bars, counters)

- Progress fills: tween the fill's `Size` with `settle` easing — never snap.
- Count-ups: `useBinding` + a short-lived RunService connection stepping the
  displayed number toward the target (bindings avoid re-render storms).

## Rules

- Never `task.wait()` inside render or event handlers for animation timing —
  TweenService owns timing.
- Reserved easings (e.g. `bounce`/Elastic) are used ONLY where the DESIGN.md
  assigns them (rewards); do not sprinkle them on ordinary UI.
- Everything animatable derives from `Theme.motion.*` — a literal duration
  in a component is a review defect.
- If the game exposes a reduced-motion setting, swap pop/bounce for settle
  and keep durations (per the DESIGN.md's Motion prose).
