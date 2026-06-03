# databricks-ai-starter

An integrated development environment template combining Claude Code and Databricks.

## 1. What Makes This Template Powerful

This template provides a seamless AI-assisted development experience with
Databricks by integrating two powerful libraries:

**jupyter-databricks-kernel** - Execute your entire notebook workload on
Databricks clusters without any code changes. Simply select the "Databricks"
kernel in VS Code or JupyterLab, and your Python code runs with the full power
of Spark and Databricks infrastructure. Works perfectly with CLI automation via
`jupyter execute`.

**mcp-databricks-server** - Enable Claude Code to directly query your Databricks
data and explore Unity Catalog metadata. Claude can execute SQL, inspect table
schemas, view lineage, and answer questions about your data - all through
natural language. Built-in safety mechanisms prevent destructive operations.

Together, these components create a development environment where AI assistants
can understand your data warehouse structure, execute queries, and help you
write data transformation code that runs on production-grade infrastructure.

## 2. Reference Alignment Scope

This starter follows the reusable engineering shape of
<https://github.com/genda-tech/databricks-ai-starter> for development-container
structure, dependency management, bootstrap guardrails, and concise maintainer
workflow. That repository is an engineering reference, not a content source for
this public template.

The public starter targets Claude Code plus Databricks. Codex is not a
supported target for this alignment track. Tool packaging should be owned by Dev
Container Features where practical, including the Python and `uv` tooling used
by the development container. Claude Code is installed during post-create using
its native installer so this starter follows the current reference behavior.

Private or domain-specific analytics knowledge is excluded by default. If
examples are added, they must be synthetic or sanitized and must not copy
private catalogs, reports, notebooks, credentials, paths, or business rules from
the reference repository.

## 3. Quick Start

1. Open in GitHub Codespaces, or start with "Reopen in Container" in VS Code
   Dev Container
2. Edit `.databrickscfg` to configure authentication credentials
3. Set `DATABRICKS_CONFIG_PROFILE` in `.env`
4. Launch `claude` from the terminal

## 4. Authentication Configuration

### 4.1. `.databrickscfg`

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

### 4.2. `.env`

```bash
export DATABRICKS_CONFIG_PROFILE=databricks-workspace-1
```

## 5. Jupyter Notebook

In Jupyter Notebook, selecting the "Databricks" kernel enables remote
execution.

For the first launch in GitHub Codespaces, the "Databricks" kernel will appear
after an F5 reload.

## 6. Components

This template includes the following components:

### 6.1. jupyter-databricks-kernel

A Jupyter kernel for complete remote execution on Databricks clusters.

- Execute Python code entirely on Databricks clusters
- Works with VS Code, JupyterLab, and other Jupyter frontends
- CLI execution support with `jupyter execute`

Repository: <https://github.com/i9wa4/jupyter-databricks-kernel>

### 6.2. mcp-databricks-server

MCP server for executing SQL queries on Databricks.

- Execute SQL queries on Databricks
- Unity Catalog metadata exploration (catalogs, schemas, tables)
- Table lineage information (upstream/downstream tables, notebooks)
- Block dangerous SQL commands for safety (DROP, DELETE, etc.)

Repository: <https://github.com/i9wa4/mcp-databricks-server>
