#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -o posix

# Create .databrickscfg template if not exists
if [ ! -f /workspaces/databricks-ai-starter/.databrickscfg ]; then
  cat >/workspaces/databricks-ai-starter/.databrickscfg <<'EOF'
[databricks-workspace-1]
host = https://your-workspace.cloud.databricks.com
client_id = your-client-id
client_secret = your-client-secret
warehouse_id = your-warehouse-id
cluster_id = your-cluster-id
EOF
  chmod 600 /workspaces/databricks-ai-starter/.databrickscfg
fi

# Create .env template if not exists
if [ ! -f /workspaces/databricks-ai-starter/.env ]; then
  cat >/workspaces/databricks-ai-starter/.env <<'EOF'
DATABRICKS_CONFIG_PROFILE=databricks-workspace-1
EOF
fi

# Databricks config symlink
ln -sf /workspaces/databricks-ai-starter/.databrickscfg /home/vscode/.databrickscfg

# Load .env in bash
cat >>~/.bashrc <<'BASHRC'

# mise
eval "$(mise activate bash)"

# Load .env if exists
[ -f /workspaces/databricks-ai-starter/.env ] && source /workspaces/databricks-ai-starter/.env
BASHRC

# Install tools via mise (see mise.toml)
mise install

# Python dependencies
uv sync --frozen

# Databricks kernel install
uv run python -m jupyter_databricks_kernel.install
