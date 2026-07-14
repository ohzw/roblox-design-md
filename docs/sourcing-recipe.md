# Public UI-material sourcing recipe (proven on the candlelit-parlor entry)

How to gather rights-safe, publicly available UI screenshots for a Roblox
title, for use as extraction inputs. Everything below uses public APIs and
publicly hosted community documentation; downloaded files stay local (inputs
are never republished — only the derived taste tokens/prose are).

## 1. Roblox game-page media (official, but usually promo art)

```sh
# find the placeId: web-search "site:roblox.com <title>" and read the /games/<placeId>/ URL
UNIVERSE=$(curl -s "https://apis.roblox.com/universes/v1/places/<placeId>/universe" | python3 -c "import json,sys; print(json.load(sys.stdin)['universeId'])")
curl -s "https://games.roblox.com/v2/games/$UNIVERSE/media"   # -> imageIds
curl -s "https://thumbnails.roblox.com/v1/assets?assetIds=<ids,comma>&size=768x432&format=Png"  # -> CDN URLs
```

Warning: game-page media is mostly promotional art WITHOUT UI. Check every
image; keep only ones showing HUD/windows/buttons.

## 2. Fandom wiki (the reliable source for UI screenshots)

Wikis block plain page fetches (402) but the MediaWiki API works with a UA:

```sh
W="https://<subdomain>.fandom.com/api.php"
# find UI-documenting pages (try: "Lobby Menu", "Controls", "Inventory", "Shop",
# "Settings", "User Interface", "HUD", plus Category:Screenshots):
curl -s -A "Mozilla/5.0" "$W?action=query&list=categorymembers&cmtitle=Category:Screenshots&cmtype=file&cmlimit=200&format=json"
# list large landscape images on a page (icons are square/small — filter w>=500, w>h*0.8):
curl -s -A "Mozilla/5.0" "$W?action=query&generator=images&titles=<Page>&prop=imageinfo&iiprop=url%7Csize&gimlimit=60&format=json"
```

## 3. Download & convert

Fandom serves WebP regardless of extension; convert before viewing:

```sh
curl -s -A "Mozilla/5.0" -o x.webp "<url>"
sips -s format png x.webp --out x.png
```

## 4. Triage against the input checklist

Keep: HUD full views, windows/popups, button groups, inventories, progress
bars. Discard: 3D scenes without UI, single item icons, fan art. Record for
each kept image: what it shows + its role in the checklist. Missing
categories are DECLARED (confidence caps), never guessed.

## Rights reminders

- Inputs must be publicly visible gameplay/UI documentation. No ripped
  assets, no paid content, no files from game binaries.
- The produced DESIGN.roblox.md is taste-named and game-name-free; inputs
  are working material only and are not committed to the repo.
