#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

lake_bin="${LAKE_BIN:-lake}"
command -v "$lake_bin" >/dev/null 2>&1 || {
  echo "[VERIFY] ERROR: required tool missing: $lake_bin" >&2
  exit 1
}

python_bin="${PYTHON_BIN:-}"
if [[ -z "$python_bin" ]]; then
  while IFS= read -r candidate; do
    if [[ -n "$candidate" ]] && "$candidate" -c 'import sys' >/dev/null 2>&1; then
      python_bin="$candidate"
      break
    fi
  done < <(type -aP python3 2>/dev/null; type -aP python 2>/dev/null)
fi
if [[ -z "$python_bin" ]] || ! "$python_bin" -c 'import sys' >/dev/null 2>&1; then
  echo "[VERIFY] ERROR: functional Python interpreter is required" >&2
  exit 1
fi

export LAKE_BIN="$lake_bin"
export LEAN_BIN="${LEAN_BIN:-lean}"
exec "$lake_bin" -R env "$python_bin" scripts/verify-published.py "$@"
