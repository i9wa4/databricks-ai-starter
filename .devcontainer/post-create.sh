#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

echo "セットアップ開始..."

# mise install
echo "mise インストール中..."
curl https://mise.run | sh

# mise activate & install
echo "mise ツールインストール中..."
eval "$(~/.local/bin/mise activate bash)"
~/.local/bin/mise trust --all
~/.local/bin/mise install

# zsh configuration
echo "zsh 設定中..."
cat >~/.zshrc <<'ZSHRC'
export PATH="$HOME/.local/share/mise/shims:$PATH"
eval "$(~/.local/bin/mise activate zsh)"
ZSHRC

# pre-commit hook to prevent .env commits
if [ -d /workspace/.git ]; then
  echo "pre-commit フック設定中..."
  mkdir -p /workspace/.git/hooks
  cat > /workspace/.git/hooks/pre-commit <<'HOOK'
#!/usr/bin/env bash
if git diff --cached --name-only | grep -q "^\.env$"; then
  echo "ERROR: .env file should not be committed"
  echo "Remove .env from staging area with: git reset HEAD .env"
  exit 1
fi
HOOK
  chmod +x /workspace/.git/hooks/pre-commit
  echo "pre-commit フック設定完了（.env コミット防止）"
fi

# Python dependencies
echo "Python 依存関係インストール中..."
~/.local/bin/mise exec -- uv sync

# AI Code Assistants (optional tools)
echo "Claude Code インストール中..."
curl -fsSL https://claude.ai/install.sh | bash || echo "警告: Claude Code installation failed"

echo "Codex CLI インストール中..."
npm install -g @openai/codex || echo "警告: Codex CLI installation failed"

# Databricks kernel install
echo "Databricks Jupyter カーネルインストール中..."
~/.local/bin/mise exec -- uv run python -m jupyter_databricks_kernel.install

# Databricks config symlink
if [ -f /workspace/.databrickscfg ]; then
    echo "シンボリックリンク作成: ~/.databrickscfg -> /workspace/.databrickscfg"
    ln -sf /workspace/.databrickscfg ~/.databrickscfg
fi

# Verify Databricks authentication
if [ -n "${DATABRICKS_CONFIG_PROFILE:-}" ]; then
    echo "Databricks 認証確認中（プロファイル: $DATABRICKS_CONFIG_PROFILE）"
    ~/.local/bin/mise exec -- databricks auth env || echo "警告: Databricks authentication not configured"
fi

echo ""
echo "セットアップ完了"
echo ""
echo "次のステップ:"
echo "1. .databrickscfg を編集して認証情報を設定"
echo "2. 詳細は README.md を参照"
