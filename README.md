# databricks-claude-code-starter

Claude Code と Databricks を統合した開発環境のスターターテンプレート

GitHub Codespaces または Docker で動作する Dev Container 環境を提供します。

## 概要

このリポジトリは、以下のツールを統合した開発環境を提供します。

- Claude Code (VS Code 拡張による AI アシスタント)
- Databricks CLI (mise 経由でインストール)
- jupyter-databricks-kernel (Databricks 対応 Jupyter カーネル)
- MCP Databricks server (Claude Code から Databricks API を操作)

## 前提条件

- GitHub Codespaces または Docker がインストールされた環境
- Databricks workspace (Service Principal での認証を推奨)
- Anthropic API key

## セットアップ手順

### 1. Codespaces secrets の設定

GitHub Codespaces を使用する場合、以下の環境変数を設定します。

Settings → Codespaces → Secrets から設定してください。

| 変数名                  | 説明                      |
| ----------------------- | ------------------------- |
| `ANTHROPIC_API_KEY`     | Claude Code の API キー   |

### 2. ~/.databrickscfg の作成

Codespaces 起動後、ターミナルで以下のファイルを手動作成します。

```bash
cat > ~/.databrickscfg << 'EOF'
[prod]
host = https://your-workspace.cloud.databricks.com
client_id = your-client-id
client_secret = your-client-secret
warehouse_id = your-warehouse-id
cluster_id = your-cluster-id
EOF

chmod 600 ~/.databrickscfg
```

NOTE: Service Principal (OAuth M2M) 認証を使用する場合、`client_id` と `client_secret` を指定してください。

### 3. 環境変数の設定

DATABRICKS_CONFIG_PROFILE 環境変数で、使用する ~/.databrickscfg のプロファイルを指定します。

```bash
export DATABRICKS_CONFIG_PROFILE=prod
```

デフォルトは `prod` です。

NOTE: ローカルマシンで環境変数を設定することで、devcontainer 内のデフォルト値をオーバーライドできます。

```bash
# ローカルマシンで環境変数を設定してから Codespaces を起動
export DATABRICKS_CONFIG_PROFILE=dev
```

## 使用方法

### Claude Code の起動

```bash
claude
```

VS Code で Claude Code 拡張を使用することもできます (Ctrl+Shift+P → "Claude Code: New Chat")。

### Databricks CLI の使用

```bash
databricks --help
databricks current-user me
databricks auth env
```

### Jupyter Lab の起動

```bash
jupyter lab
```

Databricks カーネルが利用可能です。

```bash
jupyter kernelspec list | grep databricks
```

## 含まれるコンポーネント

| コンポーネント                | 説明                                |
| ----------------------------- | ----------------------------------- |
| Claude Code                   | VS Code 拡張による AI アシスタント |
| Databricks CLI                | mise 経由でインストール             |
| jupyter-databricks-kernel     | Databricks 対応 Jupyter カーネル   |
| MCP Databricks server         | Claude Code から Databricks 操作    |
| context7 MCP server           | ライブラリドキュメント取得          |
| AWS Documentation MCP server  | AWS ドキュメント検索                |

## トラブルシューティング

### Databricks 認証エラー

以下のコマンドで認証情報を確認してください。

```bash
databricks auth env
```

~/.databrickscfg のプロファイル名と DATABRICKS_CONFIG_PROFILE が一致していることを確認してください。

### Jupyter カーネルが見つからない

以下のコマンドでカーネルを再インストールしてください。

```bash
uv run python -m jupyter_databricks_kernel.install
jupyter kernelspec list
```

## ライセンス

MIT