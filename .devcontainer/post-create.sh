#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

echo "Starting post-create setup..."

# mise install
echo "Installing mise..."
curl https://mise.run | sh

# mise activate & install
echo "Installing mise tools..."
eval "$(~/.local/bin/mise activate bash)"
~/.local/bin/mise trust --all
~/.local/bin/mise install

# zsh configuration
echo "Configuring zsh..."
cat >~/.zshrc <<'ZSHRC'
export PATH="$HOME/.local/share/mise/shims:$PATH"
eval "$(~/.local/bin/mise activate zsh)"
ZSHRC

# pre-commit hook to prevent .env commits
if [ -d /workspace/.git ]; then
  echo "Installing pre-commit hook..."
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
  echo "Pre-commit hook installed to prevent .env commits"
fi

# Python dependencies
echo "Installing Python dependencies..."
~/.local/bin/mise exec -- uv sync

# AI Code Assistants (optional tools)
echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash || echo "WARNING: Claude Code installation failed"

echo "Installing Codex CLI..."
npm install -g @openai/codex || echo "WARNING: Codex CLI installation failed"

# Databricks kernel install
echo "Installing Databricks Jupyter kernel..."
~/.local/bin/mise exec -- uv run python -m jupyter_databricks_kernel.install

# Verify Databricks authentication
if [ -n "${DATABRICKS_CONFIG_PROFILE:-}" ]; then
    echo "Verifying Databricks authentication with profile: $DATABRICKS_CONFIG_PROFILE"
    ~/.local/bin/mise exec -- databricks auth env || echo "WARNING: Databricks authentication not configured"
fi

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Create ~/.databrickscfg manually with your Databricks credentials"
echo "2. See README.md for instructions"
