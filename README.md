# databricks-ai-starter

An integrated development environment template combining Claude Code / Codex CLI / Databricks

## 1. What Makes This Template Powerful

This template provides a seamless AI-assisted development experience with Databricks by integrating two powerful libraries:

**jupyter-databricks-kernel** - Execute your entire notebook workload on Databricks clusters without any code changes. Simply select the "Databricks" kernel in VS Code or JupyterLab, and your Python code runs with the full power of Spark and Databricks infrastructure. Works perfectly with CLI automation via `jupyter execute`.

**mcp-databricks-server** - Enable AI assistants (Claude Code, Codex CLI) to directly query your Databricks data and explore Unity Catalog metadata. AI can execute SQL, inspect table schemas, view lineage, and answer questions about your data - all through natural language. Built-in safety mechanisms prevent destructive operations.

Together, these components create a development environment where AI assistants can understand your data warehouse structure, execute queries, and help you write data transformation code that runs on production-grade infrastructure.

## 2. Quick Start

1. Open in GitHub Codespaces, or start with "Reopen in Container" in VS Code Dev Container
2. Edit `.databrickscfg` to configure authentication credentials
3. Set `DATABRICKS_CONFIG_PROFILE` in `.env`
4. Launch `claude` or `codex` from the terminal

## 3. Authentication Configuration

### 3.1. `.databrickscfg`

For Service Principal:

```ini
[databricks-workspace-1]
host = https://your-workspace.cloud.databricks.com
client_id = your-client-id
client_secret = your-client-secret
warehouse_id = your-warehouse-id
cluster_id = your-cluster-id
```

For Personal Access Token:

```ini
[databricks-workspace-1]
host = https://your-workspace.cloud.databricks.com
token = dapi-xxxxxxxxxxxxxxxx
warehouse_id = your-warehouse-id
cluster_id = your-cluster-id
```

### 3.2. `.env`

```bash
export DATABRICKS_CONFIG_PROFILE=databricks-workspace-1
```

## 4. Jupyter Notebook

In Jupyter Notebook, selecting the "Databricks" kernel enables remote execution.

For the first launch in GitHub Codespaces, the "Databricks" kernel will appear after an F5 reload.

## 5. Components

This template includes the following components:

### 5.1. jupyter-databricks-kernel

A Jupyter kernel for complete remote execution on Databricks clusters.

- Execute Python code entirely on Databricks clusters
- Works with VS Code, JupyterLab, and other Jupyter frontends
- CLI execution support with `jupyter execute`

Repository: <https://github.com/i9wa4/jupyter-databricks-kernel>

### 5.2. mcp-databricks-server

MCP server for executing SQL queries on Databricks.

- Execute SQL queries on Databricks
- Unity Catalog metadata exploration (catalogs, schemas, tables)
- Table lineage information (upstream/downstream tables, notebooks)
- Block dangerous SQL commands for safety (DROP, DELETE, etc.)

Repository: <https://github.com/i9wa4/mcp-databricks-server>
