#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

echo "セットアップ開始..."
# Databricks config symlink
ln -sf /workspaces/databricks-ai-starter/.databrickscfg /home/vscode/.databrickscfg

# bash configuration
echo "bash 設定中..."
cat >~/.bashrc <<'BASHRC'
export PATH="$HOME/.local/bin:$PATH"
# Load .env if exists
[ -f /workspaces/databricks-ai-starter/.env ] && source /workspaces/databricks-ai-starter/.env
BASHRC

# uv install
echo "uv インストール中..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Python dependencies
echo "Python 依存関係インストール中..."
"${HOME}"/.local/bin/uv sync --frozen

# Databricks kernel install
echo "jupyter-databricks-kernel インストール中..."
"${HOME}"/.local/bin/uv run python -m jupyter_databricks_kernel.install

# AI Code Assistants (optional tools)
echo "Claude Code インストール中..."
curl -fsSL https://claude.ai/install.sh | bash

echo "Codex CLI インストール中..."
npm install -g @openai/codex

echo ""
echo "セットアップ完了"
echo ""
echo "次のステップ:"
echo "1. .databrickscfg を編集して認証情報を設定"
echo "2. 詳細は README.md を参照"
