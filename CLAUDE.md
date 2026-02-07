# CLAUDE.md / AGENTS.md

## 1. 最低限の約束

- 日本語で受け答えしてください。

## 2. Databricks MCP Server （優先）

SQL の実行やテーブル情報の取得には **Databricks MCP Server を最優先** で使うこと。
ノートブック作成や Bash 経由の実行よりも、常に MCP ツールを先に試すこと。

### 使い分け

| やりたいこと | 使うツール |
|---|---|
| SQL を実行する | `execute_sql_query_in_databricks` |
| カタログ一覧を見る | `list_uc_catalogs` |
| カタログの中身を見る | `describe_uc_catalog` |
| スキーマ一覧を見る | `list_schemas_in_databricks` / `describe_uc_schema` |
| テーブル一覧を見る | `list_tables_in_databricks` |
| テーブル定義を見る | `describe_uc_table` / `describe_table_in_databricks` |
| テーブルのリネージを見る | `describe_uc_table`（`include_lineage=true`） |

### 原則

- `.sql` ファイルの実行を頼まれたら、ファイルを読み取って `execute_sql_query_in_databricks` で実行する。
- データの確認・探索は MCP Server 経由で行い、結果をそのまま表示する。

## 3. Jupyter Notebook の CLI 実行

ノートブック (`.ipynb`) の実行が必要な場合のみ使用する。
通常は --inplace オプションを使ってノートブックを上書きすること。

```bash
jupyter execute notebook.ipynb --kernel_name=databricks [OPTIONS]
```

| Option              | Description                         |
| ------------------- | ----------------------------------- |
| `--output FILE`     | Output file name                    |
| `--inplace`         | Overwrite input file                |
| `--timeout SEC`     | Cell execution timeout              |
| `--startup_timeout` | Kernel startup timeout (default 60) |
| `--allow-errors`    | Continue on cell error              |
