# cartoon-chunky preview place

UI-Labs stories that render the [`cartoon-chunky`](../design-md/cartoon-chunky/DESIGN.roblox.md)
golden sample with react-lua, for visual verification in Roblox Studio.

## Prerequisites

- Roblox Studio with the **UI Labs** plugin (Creator Store, free) and the
  **Argon** plugin (for live sync).
- CLI tools are pinned in `rokit.toml` (argon, luau) and `wally.toml`
  (jsdotlua react-lua 17.2.1 — the official `roblox/react@17.3.9` is currently
  broken on the public Wally index, see wally.toml comment).

## Run

```sh
cd preview-place
wally install          # first time only
argon serve            # then connect from the Argon plugin in Studio
# or, without sync:
argon build default.project.json -o CartoonChunkyPreview.rbxl && open CartoonChunkyPreview.rbxl
```

In Studio: Plugins → UI Labs → the **Cartoon Chunky** storybook lists the
stories (Tokens, Buttons, CurrencyBar, ProgressBar, Window, Settings, HUD,
Shop, Dialog).

## What to check (maps to DESIGN.roblox.md sections)

| Story | Verifies |
|---|---|
| Tokens | Colors / Typography / Shapes tokens at a glance |
| Buttons | button-primary/secondary/close/side; press them — the bevel must collapse; Disabled control keeps the bevel |
| CurrencyBar | pill anatomy, soft/hard icon assets, 5-digit abbreviation (controls) |
| ProgressBar | gradient fill, empty/full edge cases |
| Window | dim overlay, header band proud of the top edge, close button on the corner, card grid + rarity ribbons + selected state |
| Settings | Screen Patterns "Settings": single-column rows, label left, chunky toggle right |
| HUD | **Standard showcase** (`references/standard-showcase.md`): 12,400 soft + 99 hard currency, SHOP/ITEMS/SETTINGS launchers (badge 3 on Shop), bottom-center PLAY |
| Shop | **Standard showcase**: SHOP window, six items (Acorn..Crown) at 25/40/120/150/600/2500, Crown in the legendary/emphasized rung |
| Dialog | **Standard showcase**: CONFIRM popup over the dim overlay, reusing Window at a smaller size |

Tokens/Buttons/CurrencyBar/ProgressBar/Window/Settings are this exemplar's
taste-specific extras beyond the standard set (kept for full-taste coverage
this hand-built reference is meant to demonstrate); HUD/Shop/Dialog are the
fixed standard-showcase.md set shared across every taste in the catalog for
side-by-side comparison.

Real image assets (launcher/currency icons, the six shop item renders) are
recorded in `Theme.assets` with Creator Store provenance comments — see
`Theme.luau`.

Known simplifications: drop shadow is a plain offset frame instead of a
9-slice image; the Shop story omits the DESIGN.md's left category rail
(button-icon column) as out-of-core-slice per `references/generation-procedure.md`'s
scope vocabulary; some story sizes are Offset-based for story legibility
instead of the Scale-first rule.
