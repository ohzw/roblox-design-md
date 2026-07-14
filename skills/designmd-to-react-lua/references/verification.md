# Verification (syntax → visual → numeric → rubric)

Deliver nothing you haven't verified at every level available in the session.

## 1. Syntax (always available)

```sh
luau <file>   # parse check; runtime errors about `game` being nil are FINE —
              # only syntax/expected/unexpected messages are failures
```

Also grep the output set for banned API (`Roact`, `Suspense`,
`Enum.Font.Gotham`, `onClick=`) and literal hex colors outside Theme.luau.

## 2. Visual QA loop (when the Roblox Studio MCP is connected)

The full loop and its gotchas live in `tools/capture-rig/README.md` **at the
repository root** (not inside this skill directory). Summary:

```
list_roblox_studios → set_active_studio (NEVER touch unrelated instances)
start_stop_play(true)
execute_luau(Client): mount the story into PlayerGui
  (harness: tools/capture-rig/mount-story.luau — sets ZIndexBehavior=Sibling)
screen_capture → judge against the DESIGN.roblox.md prose
start_stop_play(false) when done
```

Judge the capture against the DESIGN.md like a design reviewer: token
colors, outline presence, corner steps, spacing rhythm, and every
Do's-and-Don'ts rule. **Check every non-ASCII glyph renders** (no tofu
boxes): Roblox font families cover little of the dingbat range — tested in
FredokaOne/Montserrat/Oswald: U+2726 ✦ / U+2715 ✕ tofu'd, while U+00D7 ×,
U+25C6 ◆, U+25A0 ■, U+25B2 ▲ and the Robux PUA `\u{E002}` rendered fine.
Other families may differ — re-verify in the capture whenever the taste uses
a family outside that tested set. Prefer geometric shapes + ASCII. Remember captures are downscaled — don't measure px
on the image without converting via `workspace.CurrentCamera.ViewportSize`.

If the user's Studio session opened a stale .rbxl (not argon-serve synced),
patch the open document via execute_luau `ModuleScript.Source = [=====[...]=====]`
in Edit mode, and rebuild the .rbxl on disk so reopens match.

**Injecting a multi-file component tree** into the open document (when your
output isn't file-synced at all): create the Folder/ModuleScript skeleton,
then **one execute_luau call per file**, embedding each file's content in a
long-bracket string. Do NOT attempt one giant multi-file injection script
(too large to verify or debug). **Generate each injection call
programmatically from the disk file** (script/template) — hand-retyping file
content into the call is itself an error vector. Verify each injection by
comparing `#module.Source` against the disk file's `wc -c` BEFORE moving to
the next file (this check has caught real transcription drift). Two traps:
- `\u{XXXX}` escapes inside content embedded as source text are the eight
  literal characters, not the codepoint — `gsub`/`find` against the
  interpreted character silently matches nothing.
- **Non-ASCII bytes get silently mangled in transit** (an em-dash became
  `--`). Scan sources for non-ASCII first; inject those files via ASCII
  placeholders + in-engine `string.char()` substitution. A ±1–3 byte drift
  in the byte-count check is a SIGNAL to diff the decoded content — causes
  include Unicode substitution AND your own wrapper template re-adding a
  trailing newline; confirm which before "fixing".
- **Asset-load checks**: `ContentProvider:PreloadAsync` is unreliable in
  this MCP session (returns Failure even for known-good ids). The reliable
  signal is `ImageLabel.IsLoaded` compared against a known-good sibling in
  the same render pass. Registry "verified" claims are point-in-time —
  assets get moderated/deleted; re-verify via IsLoaded when reusing.
- Reading `AbsoluteSize` right after re-mounting over a tearing-down story
  can return stale mid-layout values — settle with a `task.wait()` after
  destroying the old root before declaring a tap-target failure.
- `user_mouse_input` scroll actions reject ScreenGui instance paths; set
  `ScrollingFrame.CanvasPosition` via execute_luau for scroll-state captures.
- Run `luau` syntax checks from a directory with a rokit-pinned toolchain
  (e.g. `preview-place/`); a fresh output dir has no rokit.toml and the
  rokit shim errors confusingly.
- Dotted instance names break MCP path-based tools generally: `multi_edit`
  creates nested wrapper Folders per dot; `script_read`/`script_search`
  error on paths like `Stories.HUD.story`. For dotted names (every
  story/storybook), go through execute_luau + `FindFirstChild("HUD.story")`
  for both creation and reading.
- Luau long-bracket strings (`[=====[...]=====]`) silently DROP a leading
  newline immediately after the opening bracket — a ±1-byte drift source
  distinct from Unicode mangling. Start embedded content on the same line
  or account for the eaten byte.
- First diagnostic for any byte-count mismatch: compare per-line length
  arrays between Studio Source and disk — it localizes real drift in one
  call and exposes false positives (wrapper-added trailing newline,
  reconstruction artifacts) without further probing.

## 3. Numeric assertions (states & motion)

Screenshots prove looks; `execute_luau` proves values. Assert at least:

- Pressed state: simulate with `user_mouse_input`
  (`moveTo instance_path` → `mouseButtonDown` → wait ≥ tween duration), then
  read `UIScale.Scale` (≈ squash target) and the structural change (e.g.
  `Face.Size` = full height). Release and assert restore. Note: mouse
  position does NOT persist across tool calls — every call starts with
  `moveTo`; press state DOES persist across calls.
- Entrance: read the UIScale right after mount (below 1) and after the
  duration (== 1). **Timing-sensitive reads must live inside ONE
  execute_luau call** (mount → `task.wait(t)` → read): tween PROGRESS is
  unobservable across separate tool calls (each call has its own latency),
  unlike press STATE, which persists between calls.
- Layout: dump `AbsoluteSize`/`AbsolutePosition` of key elements and check
  tap-target minimums and reserved-zone clearance. Two tree-reading gotchas:
  `React.Fragment` children never materialize as a named Instance — read the
  parent's `GetChildren()` directly, don't look up a "Children" node. And
  with `IgnoreGuiInset = true`, full-bleed elements read `AbsolutePosition.Y`
  offset by the gui inset (−58px-ish) while `AbsoluteSize` stays
  inset-reduced — account for it before asserting positions.

## 4. Rubric self-score (before delivering)

Score honestly, fix what fails, and report the scorecard:

| Check | Pass condition |
|---|---|
| 3-second wayfinding | Primary action identifiable in the capture at a glance |
| Currency/CTA visibility | Always-visible elements present and unobstructed |
| Tap targets | Every interactive element ≥ 44px logical (chunky tastes: ≥ 56px) |
| Contrast | Label text readable over its fill; text over world has its stroke |
| Do's and Don'ts | Zero violations of the DESIGN.md's own rules |
| Token fidelity | Spot-check 5 rendered colors/radii against tokens |
| Multi-resolution (when emulation is available) | No overlap/clipping at phone landscape and desktop |
