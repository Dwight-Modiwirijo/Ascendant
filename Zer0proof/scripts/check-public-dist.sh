#!/usr/bin/env bash
set -euo pipefail

root_arg="${1:?usage: check-public-dist.sh DIST_ROOT}"
root="$(cd "$root_arg" && pwd)"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
allowlist="$root/PUBLIC_ALLOWLIST.txt"
lake_bin="${LAKE_BIN:-lake}"

[[ -f "$allowlist" ]] || { echo "[LEAK] missing PUBLIC_ALLOWLIST.txt" >&2; exit 1; }

actual="$(mktemp)"
expected="$(mktemp)"
cleanup() { rm -f "$actual" "$expected"; }
trap cleanup EXIT

( cd "$root" && find . -type f -printf '%P\n' | sort ) > "$actual"
sort -u "$allowlist" > "$expected"
if ! diff -u "$expected" "$actual"; then
  echo "[LEAK] distribution differs from the explicit allow-list" >&2
  exit 1
fi

if find "$root" -type f | grep -E '/(AltRoute/Private|Private/Successor|StrongCertificates|Final_(NE|BoxUnique|RigidWitness)_Proof)' >/dev/null; then
  echo "[LEAK] forbidden private path in distribution" >&2
  exit 1
fi

while IFS= read -r -d '' artifact; do
  if strings "$artifact" | grep -E 'Final_(NE|BoxUnique|RigidWitness)_Proof|StrongCertificates|AltRoute\.Private|Private\.Successor' >/dev/null; then
    echo "[LEAK] forbidden private symbol in public assembly: $artifact" >&2
    exit 1
  fi
done < <(find "$root" -type f -name '*.olean' -print0)

lean_import_root="$root"
lean_test="$root/tests/NoExport_NecessaryExistence.lean"
if [[ "$lake_bin" == *.exe ]] && command -v wslpath >/dev/null 2>&1; then
  lean_import_root="$(wslpath -w "$root")"
  lean_test="$(wslpath -w "$lean_test")"
fi

output=""
if output=$(cd "$repo_root" && LEAN_PATH="$lean_import_root" "$lake_bin" -R env lean "$lean_test" 2>&1); then
  echo "[LEAK] no-export test unexpectedly compiled in shipped environment" >&2
  exit 1
fi
if ! grep -Fq "unknown identifier 'Final_NE_Proof'" <<<"$output"; then
  printf '%s\n' "$output" >&2
  echo "[LEAK] shipped-environment no-export test failed unexpectedly" >&2
  exit 1
fi

printf '[LEAK] explicit allow-list and shipped-environment scan PASS\n'