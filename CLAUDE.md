# CLAUDE.md

roblox-design-md — AIエージェントが読めるRoblox向けデザインシステム記述フォーマット（DESIGN.roblox.md）の仕様・カタログ・ツール群。レイアウトは [README.md](README.md) を参照。

## Design Context

デザイン作業の戦略コンテキストは [PRODUCT.md](PRODUCT.md) にある。UI（特にカタログサイト site/）に触れる前に必ず読むこと。要点:

- **Register: brand / Platform: web** — 主対象はAstro製カタログサイト（site/）。トップは見せ場、詳細ページは道具。
- **利用者**: デザイン素養のないRoblox開発者。テイストを眺めて選び、DESIGN.roblox.md をコピーして自分のAIエージェントに渡す。
- **ポジショニング**: 「AIが読めるRobloxデザインシステム」— ファイル一つで一貫したRoblox UIになる、AIネイティブなカタログはここだけ。
- **人格**: 遊び心×職人気質（参照: ゲームUIギャラリー系）。アンチ参照: 無機質な技術ドキュメント風。
- **原則**: 見せて信じさせる / サイト自体が目利きの証明 / 眺めるのが主・持ち帰りは摩擦ゼロ / 遊び心は表面・職人気質は構造 / 信頼の階段（見た目→動く→安全）を順に。
- **a11y**: WCAG AA相当（コントラスト4.5:1、キーボード操作、reduced-motion）。

現在の site/ の見た目はプロトタイプ扱い。本デザインは今後 impeccable で新規に設計する（既存のダークテーマ・黄アクセントは維持対象ではない）。DESIGN.md は本デザイン確定後に `/impeccable document` で起こす。
