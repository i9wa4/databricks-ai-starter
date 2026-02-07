# databricks-ai-starter

Claude Code / Codex CLI / Databricks を統合した開発環境テンプレート

## 1. クイックスタート

1. GitHub Codespaces で開く、または VS Code の Dev Container で "Reopen in Container" で起動する
2. `.databrickscfg` を編集して認証情報を設定する
3. `.env` で `DATABRICKS_CONFIG_PROFILE` を設定する
4. ターミナルから `claude` または `codex` を起動する

## 2. 認証設定

### 2.1. databrickscfg

Service Principal の場合:

```ini
[databricks-workspace-1]
host = https://your-workspace.cloud.databricks.com
client_id = your-client-id
client_secret = your-client-secret
warehouse_id = your-warehouse-id
cluster_id = your-cluster-id
```

Personal Access Token の場合:

```ini
[databricks-workspace-1]
host = https://your-workspace.cloud.databricks.com
token = dapi-xxxxxxxxxxxxxxxx
warehouse_id = your-warehouse-id
cluster_id = your-cluster-id
```

### 2.2. env

```bash
export DATABRICKS_CONFIG_PROFILE=databricks-workspace-1
```

## 3. Jupyter Notebook

Jupyter Notebook ではカーネル "Databricks" を選択するとリモート実行できるようになります。

GitHub Codespaces での初回起動の場合は F5 リロード後にカーネル "Databricks" が出現します。
