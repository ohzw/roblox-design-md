<!-- GENERATED BUNDLE — do not edit. Canonical source: repository root.
     Regenerate with: node tools/sync-skill-bundles.mjs -->

# RobloxゲームUI・ビジュアルデザインルール

調査日: 2026-07-19
対象: `e2e/` 8テイスト、43 typography roles、visual hierarchy / color / spacing / shape / composition / states

この文書は「どう実装するか」ではなく、「何をどう見せ分けるか」を扱う。機械可読な正本は [`design-registry.json`](./design-registry.json)、外部根拠は [`design-sources.md`](./sources.md)。

## 調査から得たtypography分布

| Role | Corpus range | 読み方 |
|---|---:|---|
| Caption / microcopy | 14–18px | corpus上のauthored range。安全minimumではない |
| Body | 16–26px | restrained UIは16–18、chunky UIは22–26 |
| Label / utility | 18–28px | bodyと同sizeでもweight、stroke、surfaceで差を作る例がある |
| Primary CTA | 36px observed | 1 tasteのrole。cross-taste rangeやminimumではない |
| Heading | 24–40px | panel titleとlarge displayを混同しない |
| Display | 40–52px | screen内の最上位。毎画面に必要とは限らない |

43 roles全体では14–52px、中央値24px。各tasteの最小authored roleは14–18pxだった。ただし多くの `TextScaled` 実装には `MinTextSize` がなく、**authored tokenはrendered minimumを保証していなかった**。

### Corpus内の代表的なscale clusters

- **Restrained / information-dense**: caption 14、body 17–18、label 18–26、heading 24–30、display 40。
- **Chunky / outlined**: caption 16–18、body 22–26、label 26–28、heading 34–40、display 44–52。
- **Narrative + action split**: body 16のserif、label 24のbold sans、CTA 36のcondensed sans、heading/display 40。

これらは選択可能なtaste clusterであり、全UIを平均値へ寄せるためのscaleではない。

## Typography

### RUD-001 — Minimum rendered text — SHOULD

- Roblox API referenceは、on-screen textと `UITextSizeConstraint.MinTextSize` を **9未満にしないことを推奨**している。
- 9はengine-enforced minimumでも、accessibility-safeを保証する値でもない。API defaultは1であり、9未満も設定できる。
- このcorpusの14–18pxはauthored roleのrangeであり、Roblox公式minimumではない。
- `TextScaled` を使う場合は明示的な `MinTextSize` を設定し、viewport、最長文字列、locale、player text-size settingごとの実rendered sizeを測る。
- projectが14pxなどのより高いfloorを採用するのはよいが、**project convention**と明記する。

`TextScaled` はauthored `TextSize`を無視し、playerのPreferred Text Sizeによる拡大も受けない。小さなcaption、badge、price、HUD microcopyをtoken値だけで合格にしない。

### RUD-002 — Perceptible role hierarchy — SHOULD

同じreading/decision regionにあり、rankが異なるroleは、最終compositionで順序を知覚できるようにする。使えるchannel:

- size
- weight
- family
- casing
- value / color
- text stroke
- placement
- spacing
- container salience

corpusのadjacent size ratioは1.0–1.67だったが、1.15などをpass/fail thresholdにしない。equal-sizeでもweightやsurfaceで階層化でき、semantic peerならequal-sizeのままでよい。

### RUD-003 — Font weight is optional — MAY

Font weightはhierarchyの1 channelであり、必須ではない。

- FredokaOneのようなbaked-bold single-weight faceでは、size、stroke、case、color、component scaleで階層を作る。
- BuilderSans系のmulti-weight systemでは、body、label、headingなどnamed roleへweightを割り当てる。
- RobloxはThin 100〜Heavy 900をAPIとして提供するが、`Regular=body / Medium=label / SemiBold=control / Bold=heading` のような公式semantic mappingは提供していない。
- familyが実際にそのweight faceを持つかを確認し、存在しないweight名をenum availabilityから推測しない。

Weightを「見た目に変化を足すため」だけに増やさず、roleの意味を説明できる場合に使う。

### RUD-004 — Functional font-family assignment — SHOULD

追加するfont familyにはnamed functionを与える。

Corpusで成立した分担:

- narrative textとaction text
- UI chromeとmono timer/status
- playful displayとsystem utility
- localized bodyとnumeric readout

1 familyでも3 familyでもよい。family数の上限をcorpusから作らない。機能を説明できない「変化を付けるための2書体目」は追加しない。

### RUD-005 — Avoid global uppercase — AVOID

prose、caption、subtitle、長いlocalized textを強制all-capsにしない。sentence/Title Caseを基本とし、uppercaseは次へ限定する。

- 短いaction label
- acronym / identifier
- rarity / status metadata
- eyebrow
- wordmark
- uppercase-led tasteの短いrole

Xbox guidanceはline textにproper sentence caseを推奨しているが、Roblox固有のcasing規則は確認できなかった。locale固有のcaseを保持する。

### RUD-006 — Text contrast is composited — SHOULD

textのlegibilityはtoken単体ではなく、実際に合成されるink、surface、world background、strokeで判定する。

- noisyまたは変化する3D world上では、contrasting backingまたはstrokeを使う。
- restrained chromeは0px strokeでもよい。
- outlined tasteは1–4pxのcontextual strokeを使えるが、corpus平均を作らない。
- global strokeを全glyphへ機械的に適用しない。role、family、backgroundに結び付ける。

Roblox公式は「sufficient contrast」を推奨するが数値を定めていない。projectがWCAG AAを採用する場合、normal text 4.5:1、qualifying large text 3:1を**project target**として測る。Roblox engine requirementとは呼ばない。

## Interaction hierarchy

### RUD-007 — Primary / secondary / tertiary emphasis — SHOULD

現在のdecisionまたはworkflow region内で、primary、secondary、tertiary interactionに異なるvisual emphasisを与える。

- global commitmentが複数同格に見える状態を避ける。
- repeated row-local purchase actionは、screen-global primaryとは別contextとして扱う。
- peer choice controlsは複数が同格でもよい。
- Cancel/Noはprimary actionと共存できるが、color、geometry、placement、repetitionなどでroleを区別する。

「1 screenにつきprimary buttonは厳密に1個」という規則ではない。Roblox公式もinteraction orderを推奨するが、exactly oneを要求していない。

### RUD-008 — Relational spacing and grouping — SHOULD

spacingがgroupingを伝える場合、local relationshipとsemantic group separationを知覚可能に分ける。

Corpusではmajor/local gap比が約1.67–2.67のclusterだったが、normative thresholdにはしない。次がgroupingを十分に伝えるならequal gapも許容する。

- container
- alignment
- header band
- divider
- shared surface

数値より、視線上で何が同じgroupかを誤認しないことを検証する。

### RUD-009 — Repository spacing fallback — MAY

`4 / 8 / 12 / 20 / 32` はsource evidenceが弱い場合のrepository fallbackとして使ってよい。ただし5 tasteでの反復はgenerator policyの影響が大きい。

確認されたalternative:

- 4 / 8 / 16 / 28
- 4 / 8 / 12 / 24 / 48
- 4 / 8 / 12 / 20

source measurementとcomponent needがある場合はfallbackより優先する。

## Color and state semantics

### RUD-010 — Named accent roles — SHOULD

saturated colorをUI chrome、action、state、persistent indicatorへ使う場合はstable named roleを与える。structural surfaceはtasteのbase material/value family内でまとめる。

- rarity spectrum
- item artwork
- promotional skin
- content-generated accent

これらはUI chrome paletteと別管理してよい。corpus paletteは10–17 colorsだったが、accent count上限にはしない。

### RUD-011 — Required meaning needs a non-color cue — MUST

colorがrequired information、available action、state、outcomeを伝える場合、persistentなnon-color cueを併用する。

有効なcue:

- text
- symbol
- pattern
- shape
- position
- geometry
- knob movement
- persistent outline

blocked behaviorや一瞬のanimationだけを代替cueとして数えない。Roblox公式もcolorだけに依存しないことを推奨している。

Disabled controlの固定opacity、gray palette、desaturation量はRobloxから指定されていない。disabledであることと、actionが発火しないことを別々に検証する。

## Shape and material

### RUD-012 — Named silhouette vocabulary — SHOULD

各tasteでradius、pill、circle、hard cornerをnamed roleへ割り当てる。

例:

- hard structural slab
- compact rounded chip
- medium panel
- full pill
- circular icon button

Corpusには2〜3段程度のfinite radius ladderが多かったが、段数や8–20px rangeを普遍化しない。使われないgeneric full-radius tokenをtaste evidenceとして数えない。

### RUD-013 — Named depth/material roles — SHOULD

shadow、bevel、gloss、stroke、inset、glowを次のいずれかへ割り当てる。

- material
- elevation
- interaction state
- salience

1 taste内で同じroleは同じdepth grammarを使う。複数mechanismを併用してよいが、1つのcoherent modelとして説明できなければならない。静かなtasteへchunky bevelを移植したり、すべてのcardを同じshadowで浮かせたりしない。

## HUD and modal composition

### RUD-014 — Contextual HUD density — SHOULD

active gameplayでは、その時点のtaskに必要な情報とcontrolだけをpersistent表示する。

- functionごとにgroupingする。
- world occlusionを確認する。
- safe areaとplatform control collisionを確認する。
- top/side statusとclear centerはgenre-dependent patternとして扱う。
- fixed HUD coverage%、element count、center-clearance値を作らない。

Roblox公式はmobileで「most vital information」を優先し、bottom-left/rightをdefault controlのqualitative zoneとして避けるよう案内している。ただしfixed joystick/jump rectangleは保証していない。

### RUD-015 — Modal appearance and modality are separate — SHOULD

backdrop tint、opacity、panel transparency、blur、world visibilityはtasteとworkflowに合わせ、実world scene上で検証する。corpusの0–0.8 opacity rangeを平均しない。

visual dimmingとtrue modalityを分ける:

- background inputをinertにする
- focusをdialog内へ移す
- focusをdialog内に保持する
- close後にinvokerへ戻す
- Escape/back behaviorを定義する

`GuiButton.Modal` は完全なdialog focus trapではない。

## Evidence and focus states

### RUD-016 — Standard Showcase is not design evidence — AVOID

3-story showcase、launcher数、catalog item数、global CTA、CONFIRM copyの反復をtasteの独立証拠として数えない。normalized addition/substitutionを明記し、source-observed anatomy、casing、HUD zonesと衝突する場合はsourceを優先する。

### RUD-017 — Visible focus is a distinct state — MUST

keyboard/gamepadで到達可能なcontrolは、persistentで現在位置が分かるfocus indicatorを持つ。

focusを次と区別する:

- selected
- pressed
- hover
- disabled

navigation order、scroll reveal、activation、modal containment、focus restorationを検証する。pointer press feedbackをfocusの代わりにしない。

### RUD-018 — 44px is a repository convention — SHOULD

44 Roblox Offset pxをこのrepositoryのinteraction-target conventionとして使ってよいが、Roblox公式minimumや普遍accessibility ruleとは呼ばない。

Touch-supported controlではactual activated regionについて次を実機確認する。

- physical size
- spacing
- clipping
- overlap
- adjacent-control capture
- target edgeでの誤activation


## まず採用するデフォルト

source evidenceが弱い新規tasteで、仮のstarting pointが必要な場合:

1. Body 18px、caption 14–16px、label 20–24px、heading 28–32px、display 40px前後から始める。
2. これはcorpus中央付近のauthoring startであり、安全minimumではない。
3. `TextScaled` には原則として明示的な `MinTextSize` を入れ、Roblox推奨の9以上かつproject floor以上で検証する。
4. Weightはbody Regular、heading/label Boldのように自動割当せず、family availabilityとrole contrastを見て決める。
5. 1 regionのcommitment hierarchyを明確にし、色だけでstateを伝えない。
6. 実world background、small viewport、Preferred Text Size、long localization、gamepad focusで再評価する。

このdefaultをtaste ruleとして保存してはならない。sourceから別scaleやsingle-weight systemが得られた時点で置き換える。
