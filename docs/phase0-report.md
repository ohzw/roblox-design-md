# Phase 0 報告書 — 調査結果と実装計画の提案

作成日: 2026-07-12
ステータス: **レビュー待ち**（本報告の承認後にPhase 1へ進む）

---

## 0. エグゼクティブサマリ

- **フォーマット面**: Google公式仕様（google-labs-code/design.md, Apache-2.0, version alpha）は「YAML front matter（トークン）+ 本文prose」の二層構造で、8章の正規順序を持つ。**カスタム章の追加は公式に許容されている**ため、Roblox版はこの正規順序を骨格として Motion / Screen Patterns / Agent Prompt Guide を拡張章として挿入する形で、Stitchエコシステムとの互換性を保ったまま設計できる。
- **配布面**: getdesign.md は「GitHubリポジトリ=正典データ、サイト=ビュー+ビジネス層」構成。エントリのメタデータはfront matterが兼ね、別マニフェスト不要。新規エントリのPRは受けず運営が生成する品質管理モデル。権利面は「公開情報の独立分析」免責+ブランド名変形+Not affiliated表記の三段構え。**MVPは静的サイトで十分**。
- **実装面**: react-luaはReact 17のAPIで安定。ただし**jsdotlua版は2024年12月から休眠状態で、2026年現在はRoblox公式の `roblox/react@17.3.9`（Wally配布・活発に保守中）が存在する**。API表面は同一なので、生成コードは共通APIを対象にし、パッケージスコープは設定項目にすることを提案する（→質問1）。
- **最大リスク（実機プレビュー自動撮影）**: 完全ヘッドレスでのRoblox UI描画+画像出力は**現状不可能**（Open Cloud Luau実行はレンダリングなし、CaptureServiceはピクセル持ち出し不可）。現実解は**ローカル撮影リグ**（Studioプラグイン+ローカルサーバー+macOS `screencapture`、Roblox公式のStudio内蔵MCPサーバーで自動操縦）。実績あるパターンの現代化で工数2〜4日規模。CIではOpen Cloud Luau実行を「描画なしのレイアウト検証」に使う役割分担。
- **スパイク実施済み**: このMac上で `jsdotlua/react@17.2.1` のWally取得と、react-lua入りプレビュープレイスのRojoビルド（preview.rbxl生成）まで検証完了。ツールチェーンはStudio手前まで動作確認済み。

---

## 1. 調査結果ハイライト

### 1.1 Google DESIGN.md 仕様（google-labs-code/design.md）

- 構造: 省略可能なYAML front matter + Markdown本文。本文は `##` 見出しの8章を**この正規順序**で持つ（省略可・順序厳守・重複はエラー・未知の章は保持）:
  `Overview → Colors → Typography → Layout → Elevation & Depth → Shapes → Components → Do's and Don'ts`
- トークン: front matterに `colors:`（CSS色、hex推奨）、`typography:`（fontFamily/fontSize/fontWeight/lineHeight）、`rounded:`、`spacing:`、`components:`。トークン参照は `{colors.primary}` 形式（W3C Design Token仕様由来）。
- コンポーネント: プロパティは8種のみ（backgroundColor/textColor/typography/rounded/padding/size/height/width）。**状態バリアントは `button-primary-hover` のような姉妹キー**で表現する。
- 設計哲学（PHILOSOPHY.md）: **「Prose, not Tokens」** — トークン値はレンダリング指示ではなく文脈であり、意図を語るproseと具体的な参照（「1970年代の大学院講義プリント」のような）が品質を決める。**「any key, any section, any structure」**とカスタム拡張を明示的に許容（`## Motion` 章の例が公式に言及されている）。
- ツール: 公式CLI `@google/design.md`（lint 9ルール / diff / export / spec）。仕様の単一真実は `spec-config.yaml` にあり、docs/spec.mdはそこから生成される。**この「機械可読な仕様設定 → lint → docs生成」の構造はRoblox版でそのまま踏襲すべき**。
- **preview.htmlは公式仕様に存在しない**。VoltAgent発のコミュニティ慣習であり、Roblox版のプレビュー（実機スクショ方式）は独自設計してよい。
- ライセンス: Apache-2.0。フォーマットは `version: alpha` で変更されうる。
- 参考: google-labs-code/stitch-skills に抽出系スキル2種（Stitchプロジェクトから / 既存コードから）が存在し、抽出スキルの設計の直接の参考になる。

### 1.2 awesome-design-md / getdesign.md（配布モデル）

- リポジトリは完全フラット構造 `design-md/<slug>/DESIGN.md`（73エントリ、10万スター）。カテゴリ分類はREADMEとサイトのみ。エントリ本文はStitch仕様準拠+拡張章（Responsive Behavior、Agent Prompt Guide）。
- preview.htmlは**リポジトリから撤去されサイトホスティングに移行済み**（トークンからライト/ダーク2種のHTMLを生成）。
- CONTRIBUTING: 「品質維持のため新規DESIGN.mdのPRは受け付けない」。新規はIssueフォーム（+有償優先枠）でリクエストし運営が生成。コミュニティは修正PRと報告のみ。
- 権利面の三段構え: (a) 「公開されているCSS値の独立分析であり、いかなるサイトの視覚的アイデンティティの所有権も主張しない」免責、(b) ファイル内ブランド名の変形（Stripe→"Stripi-Inspired design analysis"）、(c) 詳細ページ毎の「Not affiliated / 商標は各権利者に帰属」表記。
- 機械可読配布: raw .md直配信、`llms.txt`、`/.well-known/agent-skills/index.json`（sha256付きマニフェスト）、CLI `npx getdesign add <slug>`。
- サイトはTanStack Start製のフルアプリだが、認証・カウンタ・課金を除けば**静的生成で全機能を代替可能**。

### 1.3 react-lua 現行状況（2026年7月）

- **jsdotlua/react-lua**: v17.2.1（2024年12月）で停止。安定・普及済みだが休眠。
- **Roblox/react-luau（公式）**: 2026年6〜7月もコミットが続く活発な保守状態。**Wallyに公式パッケージ `roblox/react@17.3.9` / `roblox/react-roblox@17.3.9` を公開**（2026年の新展開）。API表面はjsdotlua版と同一のReact 17。
- 正確な構文の要点（実装スキルに焼き込む）:
  - `React.createElement("Frame", props, { ChildName = element })` — 文字列キーがReactキー兼Instance名
  - `ReactRoblox.createRoot(container)` + `root:render(element)` — **PlayerGui直接ではなく専用コンテナ**（rootはコンテナの所有権を取る）
  - イベント: `[React.Event.Activated] = function(rbx, ...)`（第1引数はInstance）、変更監視: `[React.Change.AbsoluteSize]`
  - ref: `ref = someRef`（プレーンキー。`[Roact.Ref]` は不可）
  - `React.useBinding` — 再レンダリングなしでプロパティ更新（アニメーション用のイディオム）
  - 禁止事項: JSX、`Roact.mount`、`Roact.Portal`、Suspense/エラーバウンダリ（17.xでは実質使用不可）
- **フォント**: `Enum.Font` は形式的には非推奨でないが凍結状態。**Gotham/Arialは削除済み**（Montserrat/Arimoへ強制マップ）。現行推奨は `FontFace` + `Font.fromName("Montserrat", Enum.FontWeight.Bold)` 形式。既定UIフォントはBuilderSans族。→ 原設計の「Enum.Fontへの最近傍マッピング表」は**FontFace（family+weight）ベースに変更すべき**（例外的にFredokaOne等の enum専用フォントは残存利用可）。
- エコシステム: pretty-react-hooks（ユーティリティ）、ripple/roact-spring（アニメーション）、flipbook / ui-labs（**ストーリーブック系Studioプラグイン** — プレビューストーリー画面の先行事例）。

### 1.4 技術リスク検証

| リスク | 結論 | 確度 |
|---|---|---|
| 実機スクショ自動撮影 | 完全ヘッドレスは不可能。ローカル撮影リグ（Studio+MCP自動操縦+`screencapture`）が現実解。CIはOpen Cloud Luau実行でレイアウト検証のみ | 高（不可能性は複数の公式情報源で裏付け） |
| 動画からのMotion抽出 | 厳密なイージング曲線復元は非現実的。**テイスト別プリセット+動画はバケット分類（duration帯×easing族）による選択器**として設計（原設計の二段構え案を裏付け） | 中〜高 |
| SafeArea/解像度 | トップバー(unibar)はデスクトップ58px・モバイル約52px。`ScreenGui.ScreenInsets`/`GuiService:GetInsetArea()` が現行API。公式のタップ最小サイズ・解像度マトリクスは**存在しない**（不在を確認）→ 44px相当を独自トークンとして定義する方針が正当化された | 高 |

撮影リグの構成（推奨案）:

```
lune/Rojoでストーリープレイスをビルド
  → Studio起動（公式Studio内蔵MCPサーバー or run-in-robloxで自動操縦）
  → Studioプラグインが各ストーリーを固定エミュレーション解像度で順次表示、
    HttpServiceでローカルサーバーに「表示完了」を通知
  → ローカルサーバーが macOS `screencapture -R<x,y,w,h>` で撮影・クロップ・命名
  → design-md/<slug>/previews/ へ配置
```

未検証（要ローカルスパイク、各1時間規模。Studioへのログインが必要なため実施タイミングは要相談 →質問6）:
1. run-in-roblox（2020年から更新なし）が2026年のmacOS版Studioで動くか
2. Studio内蔵MCPサーバーにスクリーンショットツールが含まれるか（プレイテスト自動化・入力シミュレーションは公式発表済み、スクショは未確認）
3. コミュニティMCP（Chrrxs/robloxstudio-mcp、`capture_screenshot` あり）のmacOS動作

### 1.5 実施済みスパイク（このMac上で検証完了）

- `wally install` で `jsdotlua/react@17.2.1` + `react-roblox@17.2.1` の取得成功（依存17パッケージ、リンカー生成確認）
- Rojo 7.5.1 で react-lua + プレビュー用クライアントスクリプト入りの `preview.rbxl`（580KB）のビルド成功
- 環境: Roblox Studio / Rojo / Wally / Rokit / Node.js インストール済み。lune / run-in-roblox は未導入（必要時に導入）

---

## 2. 原設計への異論・改善提案

1. **フォントマッピングはEnum.FontではなくFontFaceを一次形式に**（根拠: 1.3。Gotham/Arial削除済み、新フォントはFontFaceのみ）。トークンは `family + weight + style` で持ち、視覚的特徴→familyの最近傍マッピング表を仕様に含める。FredokaOne等はfamily名として引き続き使用可能。
2. **章立てはStitch正規順序を骨格に、拡張章を挿入する**。独自の5層モデルで章順をゼロから発明するのではなく、`Overview → Colors → Typography → Layout → Elevation & Depth(=UIStroke/影) → Shapes → Motion※ → Components → Screen Patterns※ → Do's and Don'ts → Agent Prompt Guide※`（※がRoblox拡張章）とする。理由: (a) Stitch公式lintの「順序厳守・未知章保持」ルールとの互換、(b) 「カスタム章追加」は公式哲学が明示的に許容、(c) 既存エコシステム（awesome-design-mdはAgent Prompt Guide章を既に持つ）との整合。5層モデルは章の**分類軸**として仕様書の説明に残す。
3. **機械可読仕様 `spec-config.yaml` を最初から作る**（根拠: 1.1。Google公式は仕様書もlintもこのYAMLから駆動）。Roblox版も「spec-config → linter → SPEC.md生成」の構造にすれば、抽出スキルの出力検証・品質基準の「決定性」担保・仕様改訂が全て1ファイルの変更で済む。**Linter（最小版）をPhase 1に前倒し**することを提案（ゴールデンサンプル自体の検証に使うため）。
4. **プレビューは「トークン由来HTML（即時・安価）+ 実機スクショ（信頼の核）」の二段**。preview.htmlが公式仕様でなくコミュニティ慣習と判明した以上、実機スクショを正とする原設計は正しい。ただしカタログの網羅性のため、front matterから機械生成できるHTMLスウォッチ（色・タイポ・角丸の一覧）を補助として持つと、実機撮影パイプラインが詰まってもサイト側の見栄えが確保できる。**公開基準は原設計どおり「実機プレビューなしは公開しない」を維持**。
5. **CI検証にOpen Cloud Luau実行を追加**（根拠: 1.4）。画像は撮れないが、「ストーリーのマウントがエラーなく完了するか」「各要素のAbsoluteSize/Positionが複数解像度で期待範囲か」をヘッドレスで検証できる。品質基準の「複数解像度でレイアウト崩れしない」を、スクショ目視より先に数値でゲートできる。
6. **パッケージスコープの再考**（根拠: 1.3）。原設計は「jsdotlua版」を指定しているが、2026年現在の活発な保守はRoblox公式Wallyパッケージ側にある。API同一なので生成コードは変わらず、`wally.toml` のスコープだけの問題。デフォルトを `roblox/react` とし `jsdotlua` を選択肢として残すことを推奨（→質問1）。
7. **権利ポリシーにgetdesign.md方式の「名称変形」を追加検討**。原設計の「アセット転載禁止・トークン記述限定」に加え、エントリ名を「〜Inspired design analysis」と明示し、対象ゲーム名の直接使用を避ける（または「Not affiliated」表記を必須化する）ことを推奨（→質問5）。

## 3. 実装計画

### 3.1 リポジトリ構成（モノレポ、awesome-design-md方式+生産設備同居）

```
roblox-design-md/
├── SPEC.md                        # フォーマット仕様書（spec-config.yamlから生成）
├── spec/
│   ├── spec-config.yaml           # 章順・トークン型・lintルールの単一真実
│   └── fixtures/                  # lintテスト用の正常系/異常系サンプル
├── design-md/                     # カタログ正典データ（完全フラット）
│   └── <slug>/                    # 例: cartoon-chunky-petsim
│       ├── DESIGN.roblox.md       # front matter（メタデータ兼トークン）+ 本文
│       └── previews/              # 実機スクショ（story-tokens.png, hud.png, shop.png）
├── skills/                        # Agent Skills（agentskills.io標準、Claude Code互換）
│   ├── screenshot-to-designmd/
│   │   ├── SKILL.md
│   │   ├── references/            # 入力チェックリスト、抽出手順、SPEC参照
│   │   └── examples/              # ゴールデンサンプル（入力スクショ→出力対）
│   └── designmd-to-react-lua/
│       ├── SKILL.md
│       ├── references/            # react-lua規約・レイアウト規約・禁止事項
│       └── examples/              # テーマ付きコンポーネント実装例
├── tools/
│   ├── linter/                    # Node製CLI（lint/diff、Google CLIの構造を踏襲）
│   └── capture-rig/               # Studioプラグイン+ローカル撮影サーバー
├── preview-place/                 # ストーリープレイスのRojoプロジェクト
│   ├── default.project.json
│   ├── wally.toml
│   └── src/
├── site/                          # カタログサイト（静的生成、design-md/を読む）
└── docs/
    └── phase0-report.md           # 本書
```

- リポジトリ=正典データ、サイト=ビューという getdesign.md の役割分担を踏襲。front matterがサイトのメタデータ源を兼ねるため別マニフェスト不要。
- サイトの規模が大きくなったら `site/` を別リポジトリに分離可能な構造にしておく。

### 3.2 スキルのインターフェース

**screenshot-to-designmd**
- 入力: スクリーンショット群（+任意で短い動画、ゲーム名/ジャンルのメタ情報）
- 手順: (1) 入力チェックリスト照合 → 不足があれば「どの画面のスクショを追加すべきか」を具体的に要求 (2) レイヤー別抽出（各トークンに抽出根拠と確信度を付記） (3) Motionは動画があればバケット分類で上書き、なければテイスト別プリセット (4) linterで検証してから出力
- 出力: 仕様準拠の `DESIGN.roblox.md`（不足章は `confidence: low` 明記+デフォルト補完）

**designmd-to-react-lua**
- 入力: `DESIGN.roblox.md` + 画面要件（「HUDとショップ」等）
- 手順: (1) front matterから `theme.luau`（トークンモジュール）を生成 (2) Components章からテーマ付きコンポーネントを生成 (3) 画面はコンポーネントの組み立てに限定（自由描画禁止） (4) ストーリー更新 → 撮影 → ルーブリック自己採点
- 出力: `theme.luau` + `components/` + `screens/` + `stories/`
- 規約: 手動Position原則禁止（UIListLayout/UIGridLayout+UIPadding委譲）、Scale+UIAspectRatioConstraint基準、`[React.Event.*]` 構文、専用コンテナへのcreateRoot、FontFace使用、Suspense等の禁止事項リスト

### 3.3 検証基盤

- **ストーリープレイス**: 全トークン・全コンポーネント・代表画面を1プレイスに描画。flipbook / ui-labs（既存のreact-luaストーリーブックプラグイン）の採用または簡易自作をPhase 3冒頭で判断。
- **撮影リグ**: 1.4の構成。固定エミュレーション解像度（デスクトップ1920×1080、スマホ縦横、タブレット）で撮影。
- **ヘッドレス検証（CI）**: Open Cloud Luau実行でマウント検証+レイアウト数値ダンプ。
- **QAルーブリック**: 3秒で主要導線 / 通貨・CTA常時視認 / タップ領域44px / コントラスト。

### 3.4 カタログサイト

- 技術: **静的生成（Astro推奨）+ GitHub Pages or Cloudflare Pages**。ビルド時に `design-md/` を走査し、front matter→一覧（ジャンル×テイストの二軸フィルタ）、本文→詳細ページ（コピー/ダウンロードボタン、実機プレビュー画像ギャラリー、利用手順）。
- 機械可読配布: raw .md直リンク、`llms.txt`、agent-skillsマニフェスト（getdesign.md方式）。認証・カウンタ等のバックエンド機能はMVPでは持たない。
- コミュニティ導線: **（2026-07-12改訂）エンドユーザーが自作の DESIGN.roblox.md をシェアできるUGC型を採用する**。getdesign.mdの「運営のみ生成」モデルは踏襲しない。品質は人手の選別ではなく機械的なゲート（linter 0 error + 実機プレビュー画像の添付必須 + E2Eパイプライン通過）で担保する。初期エントリ（cartoon-chunky等）は投稿の手本となるシード用Example。

## 4. フェーズ計画の修正案

依存関係「仕様書とゴールデンサンプル先行→後続スキル較正」は維持。変更点は太字。

| フェーズ | 内容 | 変更点 |
|---|---|---|
| Phase 0 | 調査と戦略提案 | 完了（本書）。**残件: Studio撮影スパイク3件（要ユーザー同席、計半日）をPhase 1と並行実施** |
| Phase 1 | `spec-config.yaml` + `SPEC.md` + ゴールデンサンプル手書き1本 | **最小linterを前倒しで含める**（ゴールデンサンプル自体をlintで検証するため） |
| Phase 2 | 抽出スキル、ゴールデンサンプルで較正 | 変更なし |
| Phase 3 | 実装スキル + ストーリープレイス + **撮影リグ本実装** | 撮影リグをここに正式配置（スパイク結果を反映） |
| Phase 4 | 別ジャンルでE2E通し、仕様へフィードバック | 変更なし |
| Phase 5 | サイトMVP + 初期10エントリ量産 | 変更なし |

## 5. 質問リスト（Phase 1着手前に確認したい事項）

1. **reactパッケージのスコープ**: デフォルトを公式 `roblox/react@17.3.9`（活発に保守中）にしてよいか。それとも指定どおり `jsdotlua@17.2.1`（休眠だが普及済み）を維持するか。生成コードは同一で、wally.tomlの1行の差。→ 推奨: roblox/reactをデフォルト、jsdotluaをオプション。
2. **DESIGN.roblox.mdの記述言語**: AI消費と国際公開を考えると本文は英語を推奨（サイトUIは日英併記可）。日本語にするか英語にするか。
3. **ゴールデンサンプルの題材**: 原案どおり「Pet Simulator系 Cartoon Chunky」でよいか。参照スクショは誰が用意するか（権利面では自前プレイでの撮影が望ましい）。
4. **スキルの配布形式**: Claude Code互換のAgent Skills（SKILL.md、agentskills.io標準）を前提としてよいか（Stitch公式スキルと同形式）。
5. **権利ポリシーの強度**: getdesign.md方式の「ゲーム名変形（〜Inspired）」まで踏み込むか、ゲーム名明記+「Not affiliated」免責に留めるか。
6. **Studio撮影スパイクの実施タイミング**: Studioの起動とログインが必要（このMacにStudioはインストール済み）。同席可能なタイミングで実施したい。
7. **公開先**: GitHubのorg/リポジトリ名、サイトのホスティング先（GitHub Pages / Cloudflare Pages）とドメインの希望はあるか。

## 6. 主要ソース

- https://github.com/google-labs-code/design.md（仕様・PHILOSOPHY.md・spec-config.yaml・examples）/ https://github.com/google-labs-code/stitch-skills
- https://github.com/VoltAgent/awesome-design-md / https://getdesign.md
- https://github.com/jsdotlua/react-lua / https://github.com/Roblox/react-luau（公式Wally: roblox/react@17.3.9）
- Roblox Creator Docs: CaptureService / EditableImage / GuiService / ScreenGui.ScreenInsets / Font datatype / Open Cloud Luau Execution
- DevForum: Studio内蔵MCPサーバー+プレイテスト自動化発表（2026-03） / トップバーinset寸法 / Enum.Font新フォント非対応
- https://github.com/Corecii/roblox-screenshot(撮影リグの参考アーキテクチャ) / flipbook-labs/flipbook / PepeElToro41/ui-labs（ストーリーブック先行事例）
