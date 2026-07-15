#!/bin/bash
# Atomic raise + screencapture + crop of a Roblox Studio window's device-emulated
# screen. macOS only. Part of the capture-catalog-previews skill.
#
# Usage:
#   capture.sh <window-title-substring> <region:X,Y,W,H> <crop:WxH+X+Y> <out.png> [resize:WxH]
#
# Example (1x display, emulated screen already 1280x720):
#   capture.sh CartoonChunkyPreview -734,-2130,3840,2130 1280x720+1276+591 \
#     design-md/obsidian-gacha/previews/hud.png
#
# Example (2x retina display, emulated screen is 2560x1440 -> downscale):
#   capture.sh MyPlace 0,0,3600,2338 2560x1440+520+300 out/hud.png 1280x720
#
# NOTES (see the skill's SKILL.md for the full rules):
#   - <region> and <crop offset> are session/layout-specific: RE-CALIBRATE on the
#     first shot of a batch (offsets drift across Studio restarts).
#   - The window must be RENDERING: Studio pauses render when backgrounded, so
#     this raises it frontmost right before capture. Keep the machine idle on
#     that display during a batch.
#   - AFTER running this, the AGENT MUST Read the output PNG to confirm it shows
#     ONLY the mounted story (a focus race can photograph other windows — a
#     privacy incident). Delete + re-shoot anything contaminated.
set -euo pipefail

TITLE="${1:?window title substring}"
REGION="${2:?region X,Y,W,H}"
CROP="${3:?crop WxH+X+Y}"
OUT="${4:?output path}"
RESIZE="${5:-}"

mkdir -p "$(dirname "$OUT")"
TMP="$(mktemp -t rbxcap).png"

# Raise the target window frontmost (System Events / Accessibility permission).
# frontmost BEFORE and AFTER AXRaise — other processes can steal focus back.
osascript >/dev/null 2>&1 <<OSA
tell application "System Events"
  repeat with p in (every process whose name is "RobloxStudio")
    repeat with w in (every window of p)
      if name of w contains "$TITLE" then
        set frontmost of p to true
        perform action "AXRaise" of w
        set frontmost of p to true
      end if
    end repeat
  end repeat
end tell
OSA

sleep 1.6
screencapture -x -R"$REGION" "$TMP"

if [ -n "$RESIZE" ]; then
  magick "$TMP" -crop "$CROP" +repage -resize "$RESIZE" "$OUT"
else
  magick "$TMP" -crop "$CROP" +repage "$OUT"
fi
rm -f "$TMP"

echo "wrote $OUT ($(magick identify -format '%wx%h (%B bytes)' "$OUT"))"
echo "REMINDER: Read $OUT to verify it shows only the story (privacy)."
