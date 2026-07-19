# RobloxゲームUIルール

調査日: 2026-07-19
対象: `e2e/` 8テイスト、280観測、生成ポリシー監査、Roblox公式資料39クレーム

この文書は実装・engineルールの人間向け要約である。適用条件、例外、evidence ID、確信度、未実施検証を含む正本は [`registry.json`](./registry.json)、typography・階層・色・spacing・shape・compositionのルールは [`design-rules.md`](./design-rules.md)、外部URLは [`sources.md`](./sources.md) と [`design-sources.md`](./design-sources.md)、方法論は [`harness.md`](./harness.md) を参照する。

## 読み方

- **MUST**: 違反すると機能、入力到達性、ライフサイクル、またはエンジン挙動上の失敗を起こす。
- **SHOULD**: 原則として従う。例外には適用条件と検証結果が必要。
- **MAY**: 文脈、ゲーム、テイストに依存する選択肢。
- **AVOID**: 誤った推論または既知の失敗を起こしやすい。

`e2e/` はすべて同じ生成パイプラインを通っている。8/8の反復でも、生成ポリシーに由来する場合は独立した8票として扱わない。

## 最重要ルール

### RUI-005 — Dialog containment — MUST

製品が対応すると宣言した最小viewportとsafe areaの内側に、dialogのtitle、body、action、dismissalを収め、すべて操作可能にする。親が固定Offsetサイズより小さくなり得る場合、固定Offsetと `UISizeConstraint.MaxSize` だけに依存してはならない。Scale、reflow、scroll、または明示した最小対応viewportで解決する。

### RUI-013 — Cross-input activation — MUST

通常の `TextButton` / `ImageButton` の主要actionは `Activated` から一度だけdispatchする。対応すると宣言したmouse、touch、gamepadごとに、到達、focus、activation、cancel、visible feedbackを検証する。mouse down/up/leaveはpointer向けの補助的なheld表現であり、cross-input契約の代わりにはならない。

### RUI-019 — Disabled behavior — MUST

無効と表示されたactionはsemantic callbackをdispatchせず、有効時のpress feedbackを再生しない。表示を残す場合は読める無効表現と意図したfocus behaviorを持たせる。非表示にする設計も許容する。

### RUI-020 — Close lifecycle — MUST

production windowのclose glyph、cancel、back、許可されたbackdrop dismissalは、1つのowner-controlledなclose lifecycleへ集約する。exit終了後はrender、focus、hit testingから除去し、競合するclose/reopen/unmountでもcallbackと最終状態を一意にする。見えるが反応しないcloseや、透明なままinputを遮るwindowを残してはならない。

### RUI-022 — Layout ownership — MUST

`UIListLayout` の直接のsiblingsでは `Position` と `Rotation`、`UIGridLayout` の直接のsiblingsでは `Position` と `Size` をlayout所有として扱う。所有された値をitem内部で独立制御したい場合は、layout対象のwrapperの内側へ対象を置くか、そのitemをlayout所有から外す。flex、`AutomaticSize`、`UISizeConstraint`、`UIAspectRatioConstraint` はsize ownershipを変え得るため組み合わせを検証する。

### RUI-024 — Clipping boundary — MUST

`ClipsDescendants = true` が有効な場合、親の矩形境界を絶対的なdescendant描画境界として扱う。高い `ZIndex` でclipを越えられると仮定せず、`UICorner` が丸いmaskを作るとも仮定しない。rotationは `StarterGui.ClipsDescendantsSupportsRotation` の状態と、rotated parent shapeが非対応である点を区別する。

## Responsive、safe area、scroll

### RUI-004 — Responsive content window — SHOULD

複数viewportを対象にするcontent windowは、Scaleだけを強制するのではなく、相対sizeと意図したpixel boundsを組み合わせる。contentが領域を越え得る場合はscrollまたはreflowを提供し、headerとdismissalを対応safe area内へ置く。`667×375` はこのリポジトリの回帰baselineであり、Roblox公式の最小解像度ではない。Phone、Tablet、Desktop、Consoleなど製品が対応するdevice categoryを実際に検証する。

### RUI-006 — Manual top inset — MAY

full-bleed story harnessでは、hostの `ScreenInsets` / `IgnoreGuiInset` が既にclearanceを適用していないことを確認したうえで `GuiService:GetGuiInset().Y` を使ってよい。Y値だけを4辺のsafe-area対応とみなさず、defaultの `CoreUISafeInsets` と二重適用しない。

### RUI-008 — Overflow reachability — SHOULD

content count、wrapping、localization、text setting、viewportによってbounded regionを越え得る場合、最終item/actionまで到達できるscrollまたはreflowを用意する。header/footerを固定するかはsemantic名称ではなく、fitとinteraction roleで決める。

### RUI-009 — Live canvas sizing — SHOULD

変化する `ScrollingFrame` は `AutomaticCanvasSize`、またはcleanupを伴う `AbsoluteContentSize` bindingのどちらかでeffective contentと同期する。固定算術はitem数、item metrics、wrapping、paddingが不変な場合だけ使う。`AutomaticCanvasSize` 使用時はmanual `CanvasSize` がeffective canvasの下限として残る点に注意する。外側 `UIPadding` の包含は明示検証する。

### RUI-014 — Touch target — SHOULD

interactive targetをtouchしやすく、遮られず、隣接actionと十分に分離する。このリポジトリでは44 Roblox Offset pxをbaseline、chunky tasteでは56 pxを目安にするが、Roblox公式のpixel最小値とは呼ばない。Roblox公式教材が参照する値はmobile上の約9×9 mmであり、44×44は別のWCAG CSS-pixel基準である。小さいvisual pillは大きい透明hit rootへ入れてよい。

### RUI-023 — Localization and text overflow — SHOULD

Roblox localizationを通るtextはStudioのLocale emulationとElongateで長文化を確認し、container expansion、十分な高さを持つwrapping、意図的truncationのいずれかを明示して検証する。`AutomaticSize` と `TextScaled` は対立するstrategyとして扱い、同じ `TextLabel` での併用を避ける。`TextWrapped` は固定heightからはみ出す行を表示しないため、全内容表示を保証しない。

## Layering、modal、shadow

### RUI-010 — Dim backdrop — MAY

modalとtasteがfocus separationを必要とする場合にdim backdropを使う。raw-on-world、self-dimming、world awarenessが重要なsurfaceでは省略してよい。backdropの見た目と、backdrop clickでdismissできるかは別々に設定する。

### RUI-011 — Local 10/11 bands — MAY

modal dimの `ZIndex = 10`、panelの `ZIndex = 11` は現在のgenerator conventionである。hostのlayering planに合う場合だけ使い、taste ruleやRoblox普遍値として扱わない。

### RUI-012 — Host layering contract — SHOULD

host全体で `ZIndexBehavior`、hierarchy、`DisplayOrder`、clippingの契約を定義して検証する。現行defaultは **Sibling** でありGlobalではない。複数 `ScreenGui` を跨ぐ順序は `DisplayOrder` で決める。custom shadowをsiblingにするのは、Sibling modeで親の背面へ置く必要がある場合や、親のclip branchを出る必要がある場合に限る。現行Robloxにはdirect-parentの `UIShadow` もあるため、sibling shadowを普遍ルールにしない。

## Input、state、lifecycle

### RUI-003 — Confirmation shell reuse — SHOULD

既存window shellがlocalized content、focus order、dismissal semantics、必要actionを保持できる場合はconfirmationにも再利用する。破壊的decision、長文、stacked modal、固有anatomyではconfirmation専用shellを選ぶ。

### RUI-018 — Catalog association and focus order — SHOULD

self-containedな購入row/cardでは、item identity/art、supporting metadata、対応するprice/actionを同一unit内に明確に関連付け、予測可能なvisual/focus orderを持たせる。master-detailやfeatured offerには別の検証済み順序を定義する。

## Motion

### RUI-015 — Material-aware press feedback — MAY

press feedbackはcomponentごとのmaterialとmotion registerに合わせる。bevel collapse、squash、color/stroke lift、変形なしはいずれも選択肢であり、taste family全体の固定ルールにしない。全inputとreduced-motion pathでstuck stateがないことを確認する。

### RUI-016 — Unobserved motion defaults — MAY

source動画がない場合、Back-Out pop、settle、fade、blur、instantなどfamily-level presetを使ってよいが、必ずgenerator defaultと明記し、source fidelityとは呼ばない。採用したmotionはduration、trajectory、endpoint、interrupt、cleanupを検証する。

### RUI-017 — Reduced motion — SHOULD

`GuiService.ReducedMotionEnabled` を読み、custom UIの大きなscale、translation、bounce、blurを削減または除去する。visible state change、lifecycle completion、effect cleanupは維持する。0 durationでtargetへsnapする方法や、位置移動をfadeへ置換する方法は公式に示された選択肢である。

### RUI-025 — Tween interruption ownership — SHOULD

上書きされ得るstateful transitionはownerとreplacement behaviorを定義し、final property、visibility、input state、callbackを決定的にする。同じobject・同じpropertyの新しいtweenは古いtweenを自動cancelし、cancelされた側の `Completed` も `PlaybackState.Cancelled` で発火する。異なるpropertyのtweenは共存できるため、すべてを明示cancelする普遍ルールは作らない。

## Repository conventions and evidence hygiene

### RUI-001 — Theme centralization — SHOULD

このリポジトリでは共有semantic color、typography、motion値を既存 `Theme` conventionへ置き、必要なtaste固有roleを追加する。共通のtoken名や5段階typographyはgenerator由来であり、8 tasteが独立に同じ概念体系を発見した証拠ではない。

### RUI-002 — Standard Showcase inference — AVOID

固定されたHUD/Shop/Dialog、story名、item順、price、badge、dialog copy、canonical assetsをtaste固有またはRoblox platform ruleへ昇格させない。比較fixtureとしてのみ利用する。

### RUI-021 — Reproducible verification — SHOULD

story、controls、comment、provenance noteだけをruntime proofとみなさない。変更したriskに応じてactual hostへのmount、supported input、device category、orientation、safe area、localization、motion endpoint/cancellation、layer/clipping、asset loadingを再現可能なcaptureまたはmachine-readable assertionで残す。`667×375` とStandard Showcase matrixはrepository baselineであり、公式Roblox minimumではない。

## Taste-specific options

### RUI-007 — Bottom-center HUD action — MAY

bottom-centerにdominant contextual actionを置くのは、gameplay view、hotbar、caption、platform controls、safe area、taste-native HUDとのcollision budgetが確認できた場合だけにする。Robloxのtouch control位置を固定矩形として仮定しない。

## 証拠の確信度

- **公式根拠high**: RUI-004、005、006、008、009、011–013、017、019、022–025。RUI-014はmedium。
- **corpus独立性medium**: RUI-005、008、010、018、020。それ以外の頻出はgenerator影響が大きい。
- **runtime未検証**: ほぼ全ルール。これは隠さず `registry.json.requiredValidation` に残した。ルールの正当性を公式仕様・観測・反証で確立したことと、各e2e surfaceがすでに全境界を通過したことは別である。

## 明示的に否定した主張

- `667×375` はRoblox公式の最小validation targetではない。
- 44 Roblox pxはRoblox公式のtouch minimumではない。
- `ZIndexBehavior` の現行defaultはGlobalではなくSibling。
- dynamic scroll canvasは常にmanual `AbsoluteContentSize` bindingでなければならない、は誤り。`AutomaticCanvasSize` がある。
- shadowは常にsiblingでなければならない、は誤り。`UIShadow` や条件付きのGlobal/outer-wrapper案がある。
- `ZIndex` を上げれば `ClipsDescendants` を越えられる、は誤り。
- source動画のないfamily motion presetをtaste固有の観測事実として扱ってはならない。
