# Standard Showcase (the fixed sample set every taste implements)

Catalog implementations exist to COMPARE tastes. That only works if every
taste renders the SAME content through its own grammar — the taste decides
HOW things look and behave; this document decides WHAT gets built. Unless
the caller explicitly requests different screens, a catalog/e2e slice is
exactly this set.

## Components (minimum standard set)

| Slot | Notes |
|---|---|
| window | The taste's window anatomy (variants per its own prose) |
| button-primary | The taste's dominant CTA voice |
| button-close | Per taste anatomy (band-docked, corner-overlapping, bare glyph...) |
| currency-display | Pill/counter/ledger — whatever the taste defines |
| launcher/side-button | HUD entry buttons |
| item-card-or-row | Grid card OR list row per the taste's shop grammar, incl. ONE emphasized variant (rarity/limited/selected — whichever the taste defines) |
| buy-control | Price pill/in-row button/footer CTA per taste; reuse button-primary only if the taste genuinely has no distinct buy voice. If the taste's buy component belongs to a DIFFERENT purchase path than the showcase's soft-currency items (e.g. a premium-only expanded row), follow the taste's soft-currency grammar for the six items (whole-row tap, inline price...) and note why the buy component sat out |

Missing from the DESIGN.md? Two different cases: if the document is merely
SILENT about a slot, fill it with the taste's defaults per the derived-token
rules and note it. If the document explicitly DECLARES the slot absent
("no hard currency was observed"), omit it and say so — content parity
breaks there by design, never by silence.

## Stories (exactly these three, with these names)

### `HUD.story`
- Currency display showing **12,400** soft currency (+ **99** hard currency
  if the taste has one)
- Three launcher buttons labeled **SHOP / ITEMS / SETTINGS** (casing per the
  taste's typography rules), with a notification badge showing **3** on one
  of them if the taste defines badges
- One contextual primary action labeled **PLAY** (or the taste's equivalent
  verb if PLAY contradicts its prose — note the substitution). SILENCE is
  not contradiction: when the taste's HUD prose simply never mentions such
  an action, still include it (reuse the taste's dominant CTA anatomy,
  placed bottom-center unless a reserved zone or the taste's own placement
  rules forbid it) and note the inferred placement. Omit it only when the
  prose actively rules it out.
- The badge goes wherever the taste itself attaches badges; if its badge
  component is documented for a different host (hotbar slots, cards), attach
  it to a launcher anyway for comparability and note the transplant.
- Reserved zones respected — including the TOP strip: with the mount
  harness's full-bleed ScreenGui (IgnoreGuiInset=true), y=0 sits UNDER the
  Roblox topbar. Top-docked HUD containers (currency, badges, launcher rows)
  must clear it: offset their top by `game:GetService("GuiService"):GetGuiInset().Y`
  (query at render, never hardcode 58). Same rule for window headers that
  reach the top edge in Shop stories. (Verified failure mode: five tastes'
  badges/currency collided with the topbar in 720p captures.)

### `Shop.story`
- The taste's window, titled with the taste's own shop word (SHOP / STORE /
  MARKET...). If the DESIGN.md never uses any such word, title it with the
  taste's own name or its closest Screen-Patterns label, and note the
  substitution.
- The taste's ANATOMY may split the item set across regions (list + detail
  panel, paged rows...) if its Screen Patterns mandate it — the requirement
  is that all six items are present and purchasable, not that they share one
  column.
- Exactly **six items**, always these, in this order, with these tiers:
  Acorn (common), Feather (common), Crystal (rare), Lantern (rare),
  Compass (epic), **Crown (legendary + the taste's emphasized/limited
  treatment)**
- **Tier names map onto the taste's OWN rarity ladder** — if its ladder has
  no "epic" rung, use the nearest rung below its top (a taste-native name
  like "divine" is correct; a nil-crash on an unknown key is a verified real
  bug). Crown always takes the taste's top/exclusive rung. Rarity components
  must fail soft on unknown keys (fallback to common).
- Each item purchasable via the taste's buy grammar (in-row price, footer
  CTA, price pill...) with visible prices (25 / 40 / 120 / 150 / 600 / 2500)
- Grid density belongs to the taste: use ITS column count / row density even
  if six items leaves an orphan row (real shops have them). Flex the count
  only when the taste states none.
- The per-item buy control lives INSIDE the item-card/row component (a
  `price`/`onBuy` prop), not as story-level composition — stories compose
  components, components own their anatomy.
- **Retrofits must not change pixels in stories the caller said to keep** —
  when extending a shared component, scope new behavior behind new
  props/keys so legacy call sites render byte-identically.
- Item visuals come from real image assets — **check asset-sourcing.md's
  arbitrated canonical table FIRST**; every standard slot already has a
  pre-verified id, so fresh searches are the exception

### `Dialog.story`
- A small confirm popup over the taste's backdrop treatment (dim/blur/none):
  title **CONFIRM**, one body line ("Buy Crown for 2,500?"), a primary
  confirm and the taste's dismiss affordance (close button, cancel button,
  or dim-tap — per its prose)
- Tastes rarely define a bespoke "dialog" anatomy: reuse the closest
  existing window variant at a smaller size — that IS the expected answer,
  not a workaround.

## Rules

- Identical content, different grammar: if two tastes' Shop stories differ
  in ITEMS or COUNTS, that's a bug; if they differ in layout/anatomy/motion,
  that's the point.
- Tastes may ADD a fourth story showcasing something unique (a signature
  pattern the standard set can't express), clearly named after it.
- The storybook module is named after the taste; stories keep the standard
  names above so reviewers can flip between tastes story-by-story.
