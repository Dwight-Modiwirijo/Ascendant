#!/usr/bin/env bash
set -euo pipefail

for tool in grep find sha256sum sort diff mktemp; do
  command -v "$tool" >/dev/null 2>&1 || { echo "[CI] ERROR: required tool missing: $tool" >&2; exit 1; }
done

lake_bin="${LAKE_BIN:-lake}"
command -v "$lake_bin" >/dev/null 2>&1 || { echo "[CI] ERROR: required tool missing: $lake_bin" >&2; exit 1; }


root_arg="${1:?usage: check-public-dist.sh DIST_ROOT}"
root="$(cd "$root_arg" && pwd)"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
allowlist="$root/PUBLIC_ALLOWLIST.txt"

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

if find "$root" -type f | grep -E '/(AscendantRoute/Private|Private/Successor|StrongCertificates|AltRoute|TI_|Final_(NE|BoxUnique|RigidWitness)_Proof)' >/dev/null; then
  echo "[LEAK] forbidden private path in distribution" >&2
  exit 1
fi

# The markers of the private architecture. Verified absent from every shipped
# olean, so this guard is safe to keep wide; it exists to catch a future
# regression, not the present state. Note that `PosPossibility` and `sorryAx`
# deliberately do NOT appear here: both occur as documentation text inside
# shipped docstrings, and neither is a private symbol. Textual absence is the
# weaker claim anyway -- the binding check is the environment enumeration in
# the no-export test below, which asserts over declarations rather than bytes.
forbidden_olean_symbols='Final_(NE|BoxUnique|RigidWitness)_Proof|StrongCertificates|AscendantRoute\.Private|Private\.Successor|AltRoute|TI_|NE_Run|Swap|E_R|J_R|J_F|Jump|Bridge'

while IFS= read -r -d '' artifact; do
  if grep -a -E "$forbidden_olean_symbols" "$artifact" >/dev/null 2>&1; then
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