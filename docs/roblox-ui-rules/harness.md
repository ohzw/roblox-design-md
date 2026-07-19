# Roblox UI rules evidence harness

このハーネスは、`e2e/` の反復をそのまま普遍ルールとみなさず、観測・生成ポリシー・外部根拠・反証・判定を分離する。

## ゴール

複数テイストへ再利用できるRobloxゲームUIルールを、適用条件、例外、証拠、反例、確信度付きで定義する。観測事実、意図の推定、推奨判断は別フィールドに保存する。

## エージェント

プロジェクトスコープの定義は `.omp/agents/` に置く。

| Agent | 責務 | 編集 |
|---|---|---|
| `roblox-ui-corpus-observer` | 1テイストの実装とDESIGN文書から独立観測を抽出 | 不可 |
| `roblox-ui-policy-auditor` | 生成スキルが反復へ与えた影響を監査 | 不可 |
| `roblox-ui-pattern-aggregator` | 観測を正規化して候補ルールを作る | 不可 |
| `roblox-ui-source-researcher` | Roblox公式資料を優先して候補クレームを検証 | 不可 |
| `roblox-ui-rule-falsifier` | 反例、境界条件、過剰一般化を探す | 不可 |
| `roblox-ui-rule-adjudicator` | 証拠だけから分類、強度、確信度を決定 | 不可 |
| `roblox-ui-runtime-verifier` | Studio/UI-Labsまたは利用可能な再現方法で失敗モードを検証 | ソース編集不可 |

## 証拠クラス

- `corpus`: `e2e/` または対応する `DESIGN.roblox.md` から直接確認した事実。
- `generator-policy`: screenshot/DESIGN/react-luaパイプラインが指定する規則。
- `official-source`: Roblox Creator Hub、API Reference、公式サンプル、Robloxスタッフ投稿。
- `runtime`: ビューポート、入力、状態、内容を固定した実行結果。
- `counterexample`: 候補の適用範囲を否定または狭める事例。

同じ生成ポリシーに由来する8件の反復は、8件の独立証拠として数えない。

## DAG

1. **Independent observation**: 8 tastesを別々のcorpus observerへ割り当てる。同じwaveでは他tasteの結果を見せない。
2. **Policy audit**: generator instructionsと既存検証レポートを観測と並列に監査する。
3. **Aggregation**: observation IDとpolicy IDを保持したまま候補ルールへ正規化する。
4. **Source verification**: 候補の外部クレームだけをカテゴリ別に検証する。
5. **Falsification**: corpus反例、入力方式、解像度、長文、overflow、clipping、animation interruptionを候補ごとに確認する。
6. **Adjudication**: universal、conditional、implementation、taste、generator、insufficient、rejectedへ分類する。
7. **Runtime verification**: MUST/AVOIDと未解決の境界条件を優先して実行する。失敗時は候補へ戻す。

## 状態

```text
observed
  -> candidate
  -> externally-verified | externally-unresolved
  -> falsified | narrowed | survives
  -> accepted | conditional | generator | taste | insufficient | rejected
  -> runtime-verified | runtime-gap
```

## 昇格条件

- `MUST`: エンジン、機能、入力到達性、または再現済み失敗モードがある。
- `SHOULD`: 明確な便益と例外があり、独立証拠または外部/実行根拠がある。
- `MAY`: 文脈依存で有効な選択肢。
- `AVOID`: 実証されたリスクとより安全な代替がある。

頻度だけでは `MUST` へ昇格しない。公式APIが機能を提供する事実だけでも、その機能を常用する `MUST` にはしない。

## 最低検証境界

候補に関係する軸だけを選ぶ。

- viewport: 667×375、1280×720、1920×1080、tall/mobile相当
- input: mouse、touch、gamepad focus
- content: 通常文、長いlocalized text、空、overflow
- state: default、hover/focus、pressed、disabled、modal open、scroll end
- rendering: clipping、shadow、overlay、ZIndex
- motion: enter/exit、interrupt、restore

静的コード確認をruntime passとして記録してはならない。利用できない検証は `unavailable` として残す。

## 成果物契約

ルールは一意なID、分類、強度、テスト可能な文、適用条件、例外、evidence ID、反証結果、確信度、未実施検証を持つ。確信度は `corpusIndependence`、`officialSupport`、`runtimeSupport`、`overall` を別々に記録する。
