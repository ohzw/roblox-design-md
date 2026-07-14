# Input checklist

Each input unlocks specific sections. Confidence for a section is capped by
whether its inputs exist.

## Required (extraction refuses to claim medium+ confidence without these)

| Input | Unlocks | Why |
|---|---|---|
| HUD full view, during gameplay | Screen Patterns (HUD), currency-bar, side-button, Colors (semantic roles), safe-area habits | The HUD is where a game's taste is most codified |
| At least one window/popup screen (shop, settings...) | window, window-header, button-close, dim-overlay, Elevation & Depth, Layout density | Windows reveal stroke/shadow/header conventions |
| A screen with 2+ distinct buttons | button-primary vs -secondary distinction, Typography (label), Shapes | Single-button shots can't separate primary from secondary |

## Recommended

| Input | Unlocks |
|---|---|
| Inventory / grid screen | card-grid (+ selected state), rarity color system, grid density |
| Popup over gameplay + the SAME area undimmed (pair) | dim color/opacity (unsolvable from a single dimmed shot), layering order |
| Reward / celebration moment | display typography, accent colors, Motion hints (even from a still) |
| Any screen with a progress bar / gauge | progress-bar component (unextractable otherwise — confirmed by calibration) |
| Same screen on phone AND desktop | Layout responsiveness observations |

## Optional

| Input | Unlocks |
|---|---|
| Short video (3–10s) of open/close/press/reward | Motion section overrides (duration buckets, easing family) — see motion-presets.md |
| Multiple states of one button (idle/pressed/disabled) | Component state tokens observed instead of inferred |

## Request script (when required inputs are missing)

> To extract a reliable DESIGN.roblox.md I still need: **[list]**.
> Specifically: [for each: what screen to capture and what it unlocks].
> I can proceed without them, but [sections] will be marked
> `confidence: low` and filled with taste-family defaults instead of
> observed values. Add screenshots, or reply "proceed" to continue.

## Input hygiene notes

- Prefer uncompressed/lightly-compressed screenshots; JPEG artifacts distort
  sampled colors near strokes.
- Note each screenshot's device class (phone/tablet/desktop) if known — it
  changes how px measurements normalize (extraction-procedure.md §Measuring).
- Screenshots must be of publicly visible gameplay. Refuse ripped assets,
  files from the game's binaries, or other paid content.
