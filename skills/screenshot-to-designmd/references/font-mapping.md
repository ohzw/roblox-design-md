# Font mapping (observed lettering → Roblox family)

Canonical source: SPEC.md §3.3 — keep in sync. `fontFamily` values must work
with `Font.fromName()`. NEVER emit `Gotham*` or `Arial*` (removed from the
engine; they silently remap to Montserrat / Arimo — name the real family).

| Observed lettering | fontFamily |
|---|---|
| Rounded, chunky, cartoon bold (most simulators) | `FredokaOne` |
| Roblox-modern neutral (platform default look) | `BuilderSans` |
| Geometric sans, general-purpose bold | `Montserrat` |
| Humanist/neutral body text | `SourceSansPro` or `Nunito` |
| Blocky loud display / impact shouts | `LuckiestGuy` or `Bangers` |
| Condensed heavy grotesque (modern lobby CTAs, "HOST GAME" style) | `Oswald` (heavier: `Anton`-like → still `Oswald` + Bold) |
| Hand-written / comic | `PatrickHand`, `Kalam`, `IndieFlower` |
| Horror drip | `Creepster` |
| Sci-fi / techno | `Michroma`, `Sarpanch` |
| Retro arcade / pixel | `PressStart2P` |
| Serif fantasy / classical | `Merriweather`, `Garamond` |
| Monospace / code | `RobotoMono` |

## Identification cues

- **Terminal shape**: fully rounded terminals + uniform thick weight →
  FredokaOne. Squared-off + geometric → Montserrat/LuckiestGuy.
- **Single-weight taste**: if all text looks like one family at different
  sizes (very common in simulators), say so in the Typography prose — it is
  a taste feature, not laziness.
- **Weight**: FredokaOne/LuckiestGuy/Bangers are single-weight (use
  `Regular`; boldness is baked in). BuilderSans/Montserrat need an explicit
  `fontWeight`.
- When torn between two families, choose the one available cross-platform in
  the engine list and note the runner-up in the extraction notes.
