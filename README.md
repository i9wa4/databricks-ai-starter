# databricks-ai-starter

Claude Code / Codex CLI / Databricks を統合した開発環境テンプレート

## クイックスタート

1. GitHub Codespaces で開く、または VS Code の Dev Container で "Reopen in Container" で起動する
2. `.databrickscfg` を編集して認証情報を設定する
3. `.env` で `DATABRICKS_CONFIG_PROFILE` を設定する
4. ターミナルから `claude` または `codex` を起動する

## 認証設定

### .databrickscfg

```ini
[databricks-workspace-1]
host = https://your-workspace.cloud.databricks.com
client_id = your-client-id
client_secret = your-client-secret
cluster_id = your-cluster-id
warehouse_id = your-warehouse-id
```

### .env

```bash
export DATABRICKS_CONFIG_PROFILE=databricks-workspace-1
```

## Jupyter Notebook

Jupyter Notebook ではカーネル "Databricks" を選択するとリモート実行できるようになります。

GitHub Codespaces での初回起動の場合は F5 リロード後にカーネル "Databricks" が出現します。
