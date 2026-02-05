# databricks-ai-starter

Claude Code、Codex CLI と Databricks を統合した AI アシスト開発環境のスターターテンプレート

GitHub Codespaces または Docker で動作する Dev Container 環境を提供します。

## 概要

このリポジトリは、以下のツールを統合した開発環境を提供します。

- Claude Code (VS Code 拡張による AI アシスタント)
- Codex CLI (OpenAI の AI アシスタント CLI)
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

| 変数名                       | 説明                                  | 必須 |
| ---------------------------- | ------------------------------------- | ---- |
| `ANTHROPIC_API_KEY`          | Claude Code の API キー               | Yes  |
| `DATABRICKS_HOST`            | Workspace URL (例: https://xxx.cloud.databricks.com) | No   |
| `DATABRICKS_CLIENT_ID`       | Service Principal の Client ID        | No   |
| `DATABRICKS_CLIENT_SECRET`   | Service Principal の Client Secret    | No   |

NOTE: Databricks 認証情報は Codespaces Secrets で設定するか、手動で ~/.databrickscfg を作成することができます。

#### Secrets の設定手順

1. GitHub リポジトリ → Settings → Secrets and variables → Codespaces
2. "New repository secret" をクリック
3. 各シークレットを追加
4. Codespaces を起動または再起動

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

## セキュリティベストプラクティス

### ~/.databrickscfg の保護

- `chmod 600 ~/.databrickscfg` でパーミッションを設定
- 絶対にコミットしない (.gitignore で除外済み)
- 誤ってコミットした場合は直ちにシークレットをローテーション

### マルチプロファイル設定

~/.databrickscfg で複数のプロファイルを定義できます。

```ini
[prod]
host = https://workspace-prod.cloud.databricks.com
client_id = xxx
client_secret = xxx
warehouse_id = xxx
cluster_id = xxx

[dev]
host = https://workspace-dev.cloud.databricks.com
client_id = yyy
client_secret = yyy
warehouse_id = yyy
cluster_id = yyy
```

環境変数で切り替え:

```bash
export DATABRICKS_CONFIG_PROFILE=dev
```

### iptables ファイアウォール (オプション)

**WARNING: Advanced users only. May affect Codespaces networking.**

コンテナのネットワークセキュリティを強化する場合、オプションで iptables ファイアウォールを有効化できます。

#### 有効化手順

1. `.devcontainer/devcontainer.json` の `postCreateCommand` を編集:

```json
"postCreateCommand": ".devcontainer/post-create.sh && .devcontainer/init-firewall.sh"
```

2. Codespaces を再構築

#### 注意事項

- Codespaces のポートフォワーディングに影響する可能性があります
- カスタムポートを使用する場合は、`.devcontainer/init-firewall.sh` を編集してポートを追加してください
- 問題が発生した場合は、`postCreateCommand` から `init-firewall.sh` を削除して無効化できます

## 使用方法

### Claude Code の起動

```bash
claude
```

VS Code で Claude Code 拡張を使用することもできます (Ctrl+Shift+P → "Claude Code: New Chat")。

### Codex CLI の起動

```bash
codex
```

OpenAI の AI アシスタント CLI として、コード生成やリファクタリングをサポートします。

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
| Codex CLI                     | OpenAI の AI アシスタント CLI       |
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