# CLAUDE.md / AGENTS.md

## General Rules

- Please respond in English.

## Technical Rules

### Databricks MCP Server

- **Prioritize Databricks MCP Server** for SQL execution and table information retrieval.
- Always try MCP tools first before notebook creation or Bash execution.

#### Tool Selection

| Task                          | Tool to Use                                          |
| ---                           | ---                                                  |
| Execute SQL                   | `execute_sql_query_in_databricks`                    |
| List catalogs                 | `list_uc_catalogs`                                   |
| Describe catalog contents     | `describe_uc_catalog`                                |
| List schemas                  | `list_schemas_in_databricks` / `describe_uc_schema`  |
| List tables                   | `list_tables_in_databricks`                          |
| Describe table definition     | `describe_uc_table` / `describe_table_in_databricks` |
| View table lineage            | `describe_uc_table` (`include_lineage=true`)         |

#### Principles

- When asked to execute a `.sql` file, read the file and run it with `execute_sql_query_in_databricks`.
- Perform data verification and exploration via MCP Server and display results directly.

### Jupyter Notebook CLI Execution

```bash
# Use --inplace option unless otherwise specified
jupyter execute notebook.ipynb --kernel_name=databricks --inplace
```

| Option              | Description                               |
| ---                 | ---                                       |
| `--inplace`         | Overwrite input file                      |
| `--output FILE`     | Output file name                          |
| `--timeout SEC`     | Cell execution timeout (seconds)          |
| `--startup_timeout` | Kernel startup timeout (default 60)       |
| `--allow-errors`    | Continue on cell errors                   |

### Using Japanese in matplotlib

- If you use Japanese, import japanize-matplotlib
- Add the following to the first cell of the notebook

```python
%pip install japanize-matplotlib
```

- Add `import japanize_matplotlib` to import statements
- Manual font settings like `plt.rcParams['font.family'] = 'IPAexGothic'` are not necessary

## Other Rules

Proactively provide improvement suggestions to users during query execution, and add rules below to avoid repeating the same things.
