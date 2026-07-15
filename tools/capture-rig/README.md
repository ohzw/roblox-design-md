# MCP visual-QA loop — runbook

How to render, screenshot, and verify DESIGN.roblox.md stories in Roblox Studio
from Claude Code, using the built-in Studio MCP server (`.mcp.json` →
`Roblox_Studio`, the `StudioMCP` binary shipped inside the Studio app bundle).
Everything below was verified live on 2026-07-12 against the cartoon-chunky
preview place.

## The loop

```
list_roblox_studios → set_active_studio        # ALWAYS: >1 Studio may be open
start_stop_play(true)                          # play mode
execute_luau(mount-story.luau, Client)         # mount a story into PlayerGui
screen_capture                                 # viewport + PlayerGui image
(compare against DESIGN.roblox.md)             # agent judges the screenshot
execute_luau(assertions, Client)               # exact numeric checks
start_stop_play(false)                         # leave Studio clean
```

`mount-story.luau` (same directory) is the mount harness; change `STORY_NAME`
per story. Fixes go into the source files, not the harness.

## Verified know-how (with failure modes)

1. **`screen_capture` includes PlayerGui in play mode.** In edit mode it
   captures the 3D viewport only. Capture size = current viewport (retina
   ~2660×1034 on this machine); device emulation presets are untested (open
   item for multi-resolution QA).
2. **ScreenGui ZIndexBehavior trap.** `Instance.new("ScreenGui")` defaults to
   `Global`: any explicitly-ZIndexed overlay (dim at ZIndex 10) hides every
   default-ZIndex descendant. Symptom: elements exist in the tree with correct
   AbsoluteSize but are invisible in the capture. The harness sets `Sibling`;
   generated code must too (SPEC.md §5.2). UI-Labs sets it internally, which
   is why manual UI-Labs checks never surface this.
3. **Screenshot + Luau assertions beat screenshot alone.** The image proves
   look; `execute_luau` proves values (e.g. pressed button `Face.Size` =
   `{1,0},{1,0}` vs idle `{1,0},{1,-5}`). Use both per state.
4. **`user_mouse_input` drives real interaction.** `instance_path`
   (`LocalPlayer.PlayerGui...`) beats coordinates. Press-and-hold works ACROSS
   tool calls (mouseButtonDown in one call, screen_capture next, mouseButtonUp
   after) — but mouse *position* does NOT persist across calls: every call
   needs a `moveTo` step first, or it errors.
5. **Argon serve live-syncs file edits into the open document** (two-way sync
   plugin). No rebuild/reopen needed. But play mode runs a snapshot: **stop
   and restart play** to pick up edits made while playing. If Studio is NOT
   serving (opened a built .rbxl standalone), patch the open doc with
   `execute_luau` in Edit mode (`module.Source = src:gsub(...)`) or rebuild.
6. **Debugging invisible elements**: dump the mounted tree with
   `execute_luau` (walk `GetChildren`, print ClassName/Visible/AbsoluteSize).
   Existence + size ≠ visibility → suspect Z-order, transparency, or clipping.
7. **`get_console_output` returns nothing when clean** — absence of output is
   the pass signal for mount errors.
8. **Always leave Studio stopped** (edit mode) after a QA run, and never touch
   non-target Studio instances (check `list_roblox_studios` names).

## Findings log

| Date | Story | Finding | Resolution |
|---|---|---|---|
| 2026-07-12 | Window | Cards/Buy invisible under dim | ZIndexBehavior=Global trap → SPEC.md §5.2 rule |
| 2026-07-12 | Tokens | Color-name labels wrapped mid-word | Swatch cell 76→96px, label TextSize 13→12 |
| 2026-07-12 | Buttons | Pressed bevel collapse verified via mouse simulation + Face.Size assertion | — |
| 2026-07-12 | CurrencyBar | 12400→"12.4K", 999 unabbreviated — matches spec | — |
| 2026-07-12 | ProgressBar | 0 / 65% / MAX all correct; gradient subtle at 26px height | acceptable |
| 2026-07-12 | Window (blind calibration) | Drop-shadow frame was a CHILD of Panel → under Sibling it rendered above the panel, tinting cream to tan. Caught only by blind extraction (contaminated eyes read it as cream) | Shadow restructured as a sibling behind Panel; fix verified by re-capture |
| 2026-07-12 | all (blind calibration) | Captures are downscaled (viewport 2660 logical → ~1920 image): px measured on the image are 0.72× logical. Blind run #1 sizes skewed accordingly | extraction-procedure.md now mandates image→logical conversion via `workspace.CurrentCamera.ViewportSize` |
| 2026-07-15 | obsidian-gacha (all 9) | `osascript` AXRaise + `set frontmost` lets the AGENT raise the target Studio window itself → no user babysitting. With the taste's Studio on a display separate from the user's active work, captures don't disturb them | recipe raises frontmost before every shot; packaged as `capture-catalog-previews` skill |
| 2026-07-15 | obsidian-gacha (settings) | Focus race: one shot photographed the user's terminal + the OTHER Studio window (privacy). Contaminated frame was 627 KB vs ~20–110 KB for clean UI shots | caught by mandatory read-back of every PNG; deleted + re-shot with a double-raise. Size is a smell test, read-back is the gate |
| 2026-07-15 | obsidian-gacha (dead-ends) | Re-confirmed the non-persisting routes so future sessions don't re-explore: MCP `screen_capture` = bytes-only; `CaptureService` = in-memory `rbxtemp`; `screencapture -l<id>` = blank when Studio backgrounded (render pauses); Orca can't focus/enumerate the window | only working path is `osascript` raise → `screencapture -R` → `magick` crop |

## Persisting previews to disk (for `design-md/<slug>/previews/`)

> Packaged as the **`capture-catalog-previews`** skill
> (`skills/capture-catalog-previews/`) — invoke that for the full step-by-step
> workflow + the reusable `references/capture.sh` helper. This section is the
> canonical recipe + findings log it points back to.

MCP `screen_capture` images live only in the agent's context. File output
goes through macOS `screencapture` of the Studio window — verified recipe:

```sh
# 0. If System Events reports ZERO windows for RobloxStudio (but the process
#    runs): the window lives in another macOS Space / behind a fullscreen
#    app — System Events only sees the CURRENT Space. Fix:
#    `osascript -e 'tell application "RobloxStudio" to activate'` + sleep 2,
#    then re-probe. Never capture blind on 0-window enumeration.
# 1. Find the target window's bounds (System Events; two same-named
#    RobloxStudio processes may exist — match by window title):
osascript -e 'tell application "System Events"
  repeat with p in (every process whose name is "RobloxStudio")
    repeat with w in (every window of p)
      if name of w contains "CartoonChunkyPreview" then
        perform action "AXRaise" of w
        set frontmost of p to true
      end if
    end repeat
  end repeat
end tell'
sleep 1.5
# 2. Capture the window region (bounds from the same osascript). With Studio
#    DEVICE EMULATION at a fixed resolution (the preferred setup — ask the
#    user to enable it via Test tab > Device), the emulated screen renders
#    1:1 centered in the viewport; crop exactly that:
screencapture -x -R-734,-2130,3840,2130 raw.png            # window bounds (1x display)
magick raw.png -crop 1280x720+1276+591 +repage out.png      # 1280x720 emulation (re-measured 2026-07-13 after Studio restart; was +1280+626)
# (Without emulation, fall back to viewport crop + resize:
#  magick raw.png -crop 7564x3268+56+312 +repage -resize 1920x out.png)
# NOTE: offsets are NOT stable across Studio restarts/panel-layout changes —
# ALWAYS verify framing on the first shot of a batch and re-measure via
# boundary pixel probes (`magick raw.png -format "%[pixel:p{X,Y}]" info:`).
# Recommended: add a letterbox-pixel guard to the capture script that
# aborts+deletes when the expected chrome/story boundary colors don't match
# (proven to catch both misalignment and transient wrong-window frames).
```

HARD CONSTRAINTS (violations captured the user's unrelated windows twice):
1. **Raise + capture must be ATOMIC** — one shell invocation, re-raised
   immediately before EVERY shot. A capture without a fresh raise photographs
   whatever the user has in front. Set `frontmost` BEFORE and AFTER
   `AXRaise` and settle 2s — other processes can steal focus back between
   raise and capture (observed in batch runs); even so, expect occasional
   races: verify every frame, delete+retry on contamination.
2. **The machine must be otherwise idle on that display** — agree on a
   time window with the user before a batch; captures during active use
   photograph their other work (privacy incident, delete immediately).
3. **Verify every capture by Reading it** before keeping: it must show the
   mounted story, nothing else. A capture showing any non-Studio content is
   deleted on the spot, never committed.
4. Naming: `design-md/<slug>/previews/{hud,shop,dialog}.png` (+ taste-specific
   extras by story name, kebab-case).

## Open items

- Multi-resolution capture (phone/tablet aspect ratios): device emulator
  control via MCP is unverified.
- Motion verification (tween timing) once Phase 3 adds motion: candidate
  approach is `wait` steps in `user_mouse_input` + captures mid-animation.
