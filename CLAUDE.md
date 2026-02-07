# CLAUDE.md / AGENTS.md

## 1. 最低限の約束

- 日本語で受け答えしてください。
- Python は uv 経由で利用してください。

## 2. jupyter-databricks-kernel CLI 実行

通常は --inplace オプションを使ってノートブックを上書きしてください。

```bash
uv run jupyter execute notebook.ipynb --kernel_name=databricks [OPTIONS]
```

| Option              | Description                         |
| ------------------- | ----------------------------------- |
| `--output FILE`     | Output file name                    |
| `--inplace`         | Overwrite input file                |
| `--timeout SEC`     | Cell execution timeout              |
| `--startup_timeout` | Kernel startup timeout (default 60) |
| `--allow-errors`    | Continue on cell error              |
