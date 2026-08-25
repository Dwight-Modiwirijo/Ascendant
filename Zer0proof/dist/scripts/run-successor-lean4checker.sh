#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

checker_repository="https://github.com/leanprover/lean4checker.git"
checker_commit="ba94ec4b7f5fde6579858f33598eff3e64b9492d"
expected_toolchain="leanprover/lean4:v4.20.1"
lake_bin="${LAKE_BIN:-lake}"

for tool in git mkdir tr; do
  command -v "$tool" >/dev/null 2>&1 || {
    echo "[SUCCESSOR-CHECKER] ERROR: required tool missing: $tool" >&2
    exit 1
  }
done
command -v "$lake_bin" >/dev/null 2>&1 || {
  echo "[SUCCESSOR-CHECKER] ERROR: required tool missing: $lake_bin" >&2
  exit 1
}

project_toolchain="$(tr -d '\r\n' < lean-toolchain)"
if [[ "$project_toolchain" != "$expected_toolchain" ]]; then
  echo "[SUCCESSOR-CHECKER] ERROR: project toolchain mismatch: $project_toolchain" >&2
  exit 1
fi

search_root_arg="${1:?usage: run-successor-lean4checker.sh BUNDLE_ROOT}"
if [[ ! -d "$search_root_arg" ]]; then
  echo "[SUCCESSOR-CHECKER] ERROR: bundle root not found: $search_root_arg" >&2
  exit 1
fi
search_root="$(cd "$search_root_arg" && pwd)"

cache_parent="${LEAN4CHECKER_CACHE_ROOT:-${XDG_CACHE_HOME:-$HOME/.cache}/zer0proof}"
checker_root="$cache_parent/lean4checker-$checker_commit"
mkdir -p "$cache_parent"

if [[ ! -d "$checker_root/.git" ]]; then
  if [[ -e "$checker_root" ]]; then
    echo "[SUCCESSOR-CHECKER] ERROR: checker cache is not a Git checkout: $checker_root" >&2
    exit 1
  fi
  echo "[SUCCESSOR-CHECKER] cloning pinned lean4checker $checker_commit"
  git clone --filter=blob:none --no-checkout "$checker_repository" "$checker_root"
  git -C "$checker_root" checkout --detach "$checker_commit"
fi

actual_remote="$(git -C "$checker_root" remote get-url origin)"
if [[ "$actual_remote" != "$checker_repository" ]]; then
  echo "[SUCCESSOR-CHECKER] ERROR: checker repository mismatch: $actual_remote" >&2
  exit 1
fi
actual_commit="$(git -C "$checker_root" rev-parse HEAD)"
if [[ "$actual_commit" != "$checker_commit" ]]; then
  echo "[SUCCESSOR-CHECKER] ERROR: checker commit mismatch: $actual_commit" >&2
  exit 1
fi
checker_toolchain="$(tr -d '\r\n' < "$checker_root/lean-toolchain")"
if [[ "$checker_toolchain" != "$expected_toolchain" ]]; then
  echo "[SUCCESSOR-CHECKER] ERROR: checker toolchain mismatch: $checker_toolchain" >&2
  exit 1
fi

printf '[SUCCESSOR-CHECKER] repository: %s\n' "$checker_repository"
printf '[SUCCESSOR-CHECKER] pinned commit: %s\n' "$checker_commit"
printf '[SUCCESSOR-CHECKER] toolchain: %s\n' "$checker_toolchain"
(
  cd "$checker_root"
  "$lake_bin" build lean4checker
)

checker_bin="$checker_root/.lake/build/bin/lean4checker"
if [[ -x "$checker_bin.exe" ]]; then
  checker_bin="$checker_bin.exe"
fi
if [[ ! -x "$checker_bin" ]]; then
  echo "[SUCCESSOR-CHECKER] ERROR: built executable missing: $checker_bin" >&2
  exit 1
fi

modules=(
  "AscendantRoute.Release.Successor.SuccessorAPI"
  "AscendantRoute.Release.Successor.SuccessorModel"
  "AscendantRoute.Release.Successor.SuccessorCertificate"
)
for module in "${modules[@]}"; do
  echo "[SUCCESSOR-CHECKER] replaying plain mode: $module"
  module_rc=0
  set +e
  (
    cd "$checker_root"
    "$lake_bin" env env LEAN_PATH="$search_root" "$checker_bin" --verbose "$module"
  )
  module_rc=$?
  set -e
  echo "[SUCCESSOR-CHECKER] rc[$module]=$module_rc"
  if [[ "$module_rc" -ne 0 ]]; then
    echo "[SUCCESSOR-CHECKER] ERROR: replay failed: $module" >&2
    exit 1
  fi
done

echo "[SUCCESSOR-CHECKER] plain-mode kernel replay PASS: ${#modules[@]} modules"