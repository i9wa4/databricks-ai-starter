#!/usr/bin/env bash
set -euo pipefail

if [ "${POST_CREATE_DEBUG:-}" = "1" ]; then
  set -x
fi

USER_HOME=${DEVCONTAINER_USER_HOME:-$HOME}

install_claude() {
  local installer
  local status=0

  installer=$(mktemp)
  curl -fsSL https://claude.ai/install.sh -o "$installer" || status=$?
  if [ "$status" -eq 0 ]; then
    bash "$installer" || status=$?
  fi
  rm -f "$installer"
  return "$status"
}

export PATH="$USER_HOME/.local/bin:$PATH"
export CLAUDE_CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$USER_HOME/.claude}"

# Create .databrickscfg template if not exists
if [ ! -f /workspaces/databricks-ai-starter/.databrickscfg ]; then
  cat >/workspaces/databricks-ai-starter/.databrickscfg <<'EOF'
# Service Principal
# [databricks-workspace-1]
# host = https://your-workspace.cloud.databricks.com
# client_id = your-client-id
# client_secret = your-client-secret
# warehouse_id = your-warehouse-id
# cluster_id = your-cluster-id

# Personal Access Token
# [databricks-workspace-1]
# host = https://your-workspace.cloud.databricks.com
# token = dapi-xxxxxxxxxxxxxxxx
# warehouse_id = your-warehouse-id
# cluster_id = your-cluster-id
EOF
  chmod 600 /workspaces/databricks-ai-starter/.databrickscfg
fi

# Create .env template if not exists
if [ ! -f /workspaces/databricks-ai-starter/.env ]; then
  cat >/workspaces/databricks-ai-starter/.env <<'EOF'
export DATABRICKS_CONFIG_PROFILE=databricks-workspace-1
EOF
fi

# Symlinks
ln -sf /workspaces/databricks-ai-starter/.databrickscfg "$USER_HOME/.databrickscfg"
ln -sf /workspaces/databricks-ai-starter/CLAUDE.md /workspaces/databricks-ai-starter/AGENTS.md

# Load .env in bash
cat >>"$USER_HOME/.bashrc" <<'BASHRC'

# Load .env if exists
[ -f /workspaces/databricks-ai-starter/.env ] && source /workspaces/databricks-ai-starter/.env
BASHRC

# Python dependencies
pip install .

# Claude Code native install
command -v claude >/dev/null 2>&1 || install_claude

# Databricks kernel install
python -m jupyter_databricks_kernel.install
