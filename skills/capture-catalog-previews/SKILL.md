---
name: capture-catalog-previews
description: Capture Roblox Studio UI-Labs story renders to PNG files on disk for a taste's design-md/<slug>/previews/, which flips a catalog entry from "preview pending" to verified/published. Use when the user wants to generate or regenerate catalog preview images for a taste, asks why an entry has no thumbnail, or says previews are missing.
---

# capture-catalog-previews

You turn the react-lua UI-Labs stories of a taste (in `preview-place/` or
`e2e/<slug>/`) into the committed preview PNGs at
`design-md/<slug>/previews/*.png`. The site catalog reads that folder: an entry
with previews is `published` (badge "✓ verified in-engine", HUD thumbnail); an
entry with none shows "preview pending" (`site/src/lib/catalog.mjs`,
`published: previews.length > 0`).

## The one hard fact about capturing (do not re-derive it)

**Rendered Studio pixels reach disk ONLY via macOS `screencapture` of the
Studio window while that window is frontmost AND actively rendering, then a
`magick` crop.** These were all investigated and rejected — do NOT waste a
session re-trying them:

- MCP `screen_capture` returns image bytes to the agent's context only; there
  is no disk file.
- `CaptureService:CaptureScreenshot` yields an in-memory `rbxtemp://` id; the
  raw pixels are inaccessible from Luau/disk.
- MCP `store_image`/`upload_image` push images INTO Studio/asset-server, they
  don't save renders out.
- `screencapture -l<windowId>` of a BACKGROUNDED Studio window returns a blank
  frame — **Studio pauses play-mode rendering when its window is not
  frontmost.** So there is no "capture it while it's behind" trick.
- Orca `computer-use` on this macOS provider cannot focus/raise windows and
  often enumerates only one of several Studio windows.

The one lever that removes the babysitting: **`osascript` (System Events) can
`AXRaise` + set a specific Studio window frontmost itself**, so the agent
raises Studio right before each shot instead of asking the user to hold it in
front. If the taste's Studio window is on a *different display* than the user's
active work, captures don't disturb them.

## Non-negotiables

1. **Verify EVERY captured frame by Reading the PNG before keeping it.** A
   focus race (another window steals front between raise and capture)
   photographs the user's other windows — a privacy incident. This happened;
   it was caught only by the read-back. Contaminated frames are usually much
   larger/noisier on disk (a clean UI shot is ~20–110 KB; a desktop-clutter
   shot was 600 KB+) — a useful smell test, but never a substitute for
   Reading each one. Delete any contaminated frame on the spot; never commit it.
2. **Raise + capture must be ATOMIC** — one shell invocation that re-raises
   immediately before every shot (`references/capture.sh` does this). A bare
   `screencapture` without a fresh raise shoots whatever is in front.
3. **Crop offsets drift** across Studio restarts / panel-layout changes —
   recalibrate on the first shot of every batch (see step 3). Never assume a
   remembered offset.
4. **The machine must be otherwise idle on that display** during a batch;
   agree a short window with the user (unless Studio is on a display they
   aren't using).

## Prerequisites (have the user confirm)

- Roblox Studio open with the taste's `src` synced (argon serve) and the
  UI-Labs storybook available; the Studio MCP connected (`Roblox_Studio`).
- **Device emulation set to 1280×720** (Studio Test tab → Device). The emulated
  screen renders 1:1 centered in the viewport; you crop exactly it → a clean
  1280×720 with no Studio chrome. This 1280×720 + the Roblox topbar visible is
  the catalog convention (match the existing `cartoon-chunky/previews/*`).

## Workflow

1. **Set the active Studio** (`list_roblox_studios` → `set_active_studio`; there
   may be several — pick the one running THIS taste) and `start_stop_play(true)`.
2. **Find the target window's bounds** (also the title substring to match):
   ```sh
   osascript -e 'tell application "System Events" to get {name, position, size} of every window of (every process whose name is "RobloxStudio")'
   ```
   Note the region `X,Y,W,H` of the taste's window (title contains the .rbxl
   name). Two same-named RobloxStudio processes can coexist — match by title.
3. **Calibrate the crop once.** Mount one story (step 4a), then raise+capture the
   whole window region to a RAW file, Read it downscaled, and find where the
   1280×720 emulated screen sits inside it (its dusk/backdrop rectangle vs. the
   near-black viewport). Probe edges with
   `magick raw.png -format "%[pixel:p{X,Y}]" info:` and settle a
   `CROP=1280x720+<offsetX>+<offsetY>`. (On a 1× display the emulated screen is
   1280×720 px directly; on a 2× retina display it is 2560×1440 px — crop that
   and `-resize 1280x720`.)
4. **Per story, loop:**
   a. **Mount it** via MCP `execute_luau` (datamodel `Client`) — destroy any
      prior `StoryPreview`, make a `ScreenGui` (`ZIndexBehavior = Sibling`,
      `IgnoreGuiInset = true`), `ReactRoblox.createRoot():render(story.story{ controls = story.controls })`,
      `task.wait(0.6)` (0.8–1.0 for window stories, which can render a frame
      late — a mistimed shot shows only the blurred world; recapture once).
   b. **Capture + crop** with the atomic helper:
      `references/capture.sh "<TITLE>" "<X,Y,W,H>" "<CROP>" design-md/<slug>/previews/<name>.png`
   c. **Read the PNG and verify** it shows only the mounted story. Re-shoot on
      contamination or mistiming.
5. **Standard filenames** (kebab-case by story; the site uses `hud.png` as the
   card thumbnail): `hud, window, shop, settings, buttons, currency-bar,
   progress-bar, tokens, dialog` (+ any taste-specific extras).
6. **Clean up**: destroy the mounted `StoryPreview`, `start_stop_play(false)`,
   delete raw/scratch capture files.
7. **Commit + push** `design-md/<slug>/previews/`. Confirm the loader now reports
   `published: true` (run `loadCatalog()` from `site/src/lib/catalog.mjs`). The
   `deploy-site.yml` workflow redeploys on the push.

## References

- `references/capture.sh` — the atomic raise + screencapture + crop helper.
- `tools/capture-rig/README.md` (repo root) — the canonical MCP visual-QA
  runbook and the "Persisting previews to disk" recipe + findings log; add new
  gotchas there as you learn them.
