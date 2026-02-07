# databricks-ai-starter

Claude Code、Codex CLI と Databricks を統合した開発環境テンプレート

## クイックスタート

1. GitHub Codespaces で開く、または VS Code の "Reopen in Container" で起動
2. `.databrickscfg` を編集して認証情報を設定
3. `.env` で `DATABRICKS_CONFIG_PROFILE` を設定
4. `claude` または `codex` を起動

## 認証設定

### .databrickscfg

```ini
[databricks-workspace-1]
host = https://your-workspace.cloud.databricks.com
client_id = your-client-id
client_secret = your-client-secret
cluster_id = your-cluster-id
```

### .env

```bash
DATABRICKS_CONFIG_PROFILE=databricks-workspace-1
```

## AI アシスタント

| ツール      | ログイン                |
| ----------- | ----------------------- |
| Claude Code | `claude login`          |
| Codex CLI   | `codex` (初回起動時)    |

## Jupyter

```bash
uv run jupyter-lab
```

カーネル "Databricks" を選択
