# CLAUDE.md / AGENTS.md

## 1. 一般ルール

- 日本語で受け答えしてください。

## 2. 技術的なルール

### 2.1. Databricks MCP Server

- SQL の実行やテーブル情報の取得には **Databricks MCP Server を最優先** で使うこと。
- ノートブック作成や Bash 経由の実行よりも、常に MCP ツールを先に試すこと。

#### 2.1.1. 使い分け

| やりたいこと             | 使うツール                                           |
| ---                      | ---                                                  |
| SQL を実行する           | `execute_sql_query_in_databricks`                    |
| カタログ一覧を見る       | `list_uc_catalogs`                                   |
| カタログの中身を見る     | `describe_uc_catalog`                                |
| スキーマ一覧を見る       | `list_schemas_in_databricks` / `describe_uc_schema`  |
| テーブル一覧を見る       | `list_tables_in_databricks`                          |
| テーブル定義を見る       | `describe_uc_table` / `describe_table_in_databricks` |
| テーブルのリネージを見る | `describe_uc_table` (`include_lineage=true`)         |

#### 2.1.2. 原則

- `.sql` ファイルの実行を頼まれたら、ファイルを読み取って `execute_sql_query_in_databricks` で実行する。
- データの確認・探索は MCP Server 経由で行い、結果をそのまま表示する。

### 2.2. Jupyter Notebook の CLI 実行方法

```bash
# 特に指示がなければ --inplace オプションを使う
jupyter execute notebook.ipynb --kernel_name=databricks --inplace
```

| オプション          | 説明                                      |
| ---                 | ---                                       |
| `--inplace`         | 入力ファイルを上書き                      |
| `--output FILE`     | 出力ファイル名                            |
| `--timeout SEC`     | セル実行のタイムアウト (秒)               |
| `--startup_timeout` | カーネル起動のタイムアウト (デフォルト60) |
| `--allow-errors`    | セルエラー時も続行                        |

## 3. その他ルール

クエリ実行時に改善提案を積極的にユーザーに行い、かつ同じことを繰り返さないように以下にルールを書き加えること。
