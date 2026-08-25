#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

bundle_arg="${SUCCESSOR_RELEASE_ROOT:-$repo_root/certificates/successor-release}"
if [[ ! -e "$bundle_arg" ]]; then
  echo "[SUCCESSOR] optional certificate bundle absent; skipping"
  exit 0
fi
if [[ ! -d "$bundle_arg" ]]; then
  echo "[SUCCESSOR] ERROR: bundle path is not a directory: $bundle_arg" >&2
  exit 1
fi
bundle_root="$(cd "$bundle_arg" && pwd)"

pins_arg="${SUCCESSOR_RELEASE_PINS:-$repo_root/certificates/successor-release.SHA256SUMS}"
if [[ ! -f "$pins_arg" ]]; then
  echo "[SUCCESSOR] ERROR: external SHA pins missing: $pins_arg" >&2
  exit 1
fi
pins_root="$(cd "$(dirname "$pins_arg")" && pwd)"
pins_file="$pins_root/$(basename "$pins_arg")"

lake_bin="${LAKE_BIN:-lake}"
python_bin="${PYTHON_BIN:-}"
if [[ -z "$python_bin" ]]; then
  for candidate in python3 python; do
    if command -v "$candidate" >/dev/null 2>&1 &&
        "$candidate" -c 'import sys' >/dev/null 2>&1; then
      python_bin="$candidate"
      break
    fi
  done
fi

for tool in bash basename cmp dirname find grep mktemp mkdir rm sha256sum sort tr; do
  command -v "$tool" >/dev/null 2>&1 || {
    echo "[SUCCESSOR] ERROR: required tool missing: $tool" >&2
    exit 1
  }
done
command -v "$lake_bin" >/dev/null 2>&1 || {
  echo "[SUCCESSOR] ERROR: required tool missing: $lake_bin" >&2
  exit 1
}
if [[ -z "$python_bin" ]] || ! "$python_bin" -c 'import sys' >/dev/null 2>&1; then
  echo "[SUCCESSOR] ERROR: functional Python interpreter is required" >&2
  exit 1
fi

expected_files=(
  "AscendantRoute/Release/Successor/SuccessorAPI.lean"
  "AscendantRoute/Release/Successor/SuccessorAPI.olean"
  "AscendantRoute/Release/Successor/SuccessorCertificate.lean"
  "AscendantRoute/Release/Successor/SuccessorCertificate.olean"
  "AscendantRoute/Release/Successor/SuccessorModel.lean"
  "AscendantRoute/Release/Successor/SuccessorModel.olean"
  "SHA256SUMS"
  "lakefile.lean"
  "lean-toolchain"
  "provenance.json"
)
actual_output=""
actual_rc=0
set +e
actual_output="$(find "$bundle_root" -type f -printf '%P\n' 2>&1 | LC_ALL=C sort)"
actual_rc=$?
set -e
if [[ "$actual_rc" -ne 0 ]]; then
  printf '%s\n' "$actual_output" >&2
  echo "[SUCCESSOR] ERROR: inventory scan failed" >&2
  exit 1
fi
mapfile -t actual_files <<<"$actual_output"
if [[ "${#actual_files[@]}" -ne "${#expected_files[@]}" ]]; then
  echo "[SUCCESSOR] ERROR: payload count mismatch" >&2
  printf '[SUCCESSOR] actual: %s\n' "${actual_files[@]}" >&2
  exit 1
fi
for index in "${!expected_files[@]}"; do
  if [[ "${actual_files[$index]}" != "${expected_files[$index]}" ]]; then
    echo "[SUCCESSOR] ERROR: payload differs from exact allow-list" >&2
    printf '[SUCCESSOR] expected: %s\n' "${expected_files[@]}" >&2
    printf '[SUCCESSOR] actual: %s\n' "${actual_files[@]}" >&2
    exit 1
  fi
done
if [[ -n "$(find "$bundle_root" -type l -print)" ]]; then
  echo "[SUCCESSOR] ERROR: symlink in certificate bundle" >&2
  exit 1
fi
echo "[SUCCESSOR] exact payload allow-list PASS: ${#actual_files[@]} files"

(
  cd "$bundle_root"
  sha256sum -c "$pins_file"
  sha256sum -c SHA256SUMS
)
echo "[SUCCESSOR] external and internal SHA verification PASS"

expected_toolchain="$(tr -d '\r\n' < lean-toolchain)"
bundle_toolchain="$(tr -d '\r\n' < "$bundle_root/lean-toolchain")"
if [[ "$bundle_toolchain" != "$expected_toolchain" ]]; then
  echo "[SUCCESSOR] ERROR: bundle toolchain mismatch: $bundle_toolchain" >&2
  exit 1
fi
"$python_bin" - "$bundle_root/provenance.json" "$expected_toolchain" <<'PY_PROVENANCE'
import json
from pathlib import Path
import sys

path = Path(sys.argv[1])
expected_toolchain = sys.argv[2]
data = json.loads(path.read_text(encoding="ascii"))
modules = [
    "AscendantRoute.Release.Successor.SuccessorAPI",
    "AscendantRoute.Release.Successor.SuccessorModel",
    "AscendantRoute.Release.Successor.SuccessorCertificate",
]
errors = []
if data.get("producer") != "TAR":
    errors.append("producer must be TAR")
if data.get("producerDirty") is not False:
    errors.append("producerDirty must be false")
if data.get("toolchain") != expected_toolchain:
    errors.append("provenance toolchain mismatch")
if data.get("modules") != modules:
    errors.append("module list mismatch")
if data.get("projectLocalClosure") != modules:
    errors.append("project-local closure mismatch")
if data.get("freshReplay") != "blocked upstream on v4.20.1, see diagnostic":
    errors.append("freshReplay note mismatch")
checker = data.get("lean4checker", {})
if checker.get("repository") != "https://github.com/leanprover/lean4checker.git":
    errors.append("checker repository mismatch")
if checker.get("commit") != "ba94ec4b7f5fde6579858f33598eff3e64b9492d":
    errors.append("checker commit mismatch")
if checker.get("mode") != "plain":
    errors.append("checker mode must be plain")
if errors:
    for error in errors:
        print(f"[SUCCESSOR] ERROR: {error}", file=sys.stderr)
    raise SystemExit(1)
print("[SUCCESSOR] structured provenance validation PASS")
PY_PROVENANCE

scratch="$(mktemp -d "${TMPDIR:-/tmp}/successor-consumer.XXXXXX")"
cleanup() {
  rm -rf "$scratch"
}
trap cleanup EXIT

probe="$scratch/HeaderProbe.lean"
cat > "$probe" <<'EOF_HEADER'
import AscendantRoute.Release.Successor.SuccessorAPI
import AscendantRoute.Release.Successor.SuccessorModel
import AscendantRoute.Release.Successor.SuccessorCertificate
EOF_HEADER
header_output=""
header_rc=0
set +e
header_output="$("$lake_bin" -R env env LEAN_PATH="$bundle_root" lean "$probe" 2>&1)"
header_rc=$?
set -e
printf '%s\n' "$header_output"
if [[ "$header_rc" -ne 0 ]]; then
  echo "[SUCCESSOR] ERROR: olean header/toolchain compatibility check failed" >&2
  exit 1
fi
echo "[SUCCESSOR] olean header/toolchain compatibility PASS"

LAKE_BIN="$lake_bin" bash scripts/run-successor-lean4checker.sh "$bundle_root"

rebuild_root="$scratch/rebuild"
rebuild_work="$scratch/bundle"
mkdir -p "$rebuild_root" "$rebuild_work"
cp -a "$bundle_root/." "$rebuild_work/"
for module_file in SuccessorAPI SuccessorModel SuccessorCertificate; do
  relative="AscendantRoute/Release/Successor/$module_file"
  rebuilt="$rebuild_root/$relative.olean"
  mkdir -p "$(dirname "$rebuilt")"
  rebuild_output=""
  rebuild_rc=0
  set +e
  rebuild_output="$(
    cd "$rebuild_work"
    "$lake_bin" -R env env LEAN_PATH="$rebuild_root" lean -o "$rebuilt" "$relative.lean" 2>&1
  )"
  rebuild_rc=$?
  set -e
  printf '%s\n' "$rebuild_output"
  echo "[SUCCESSOR-REBUILD] rc[$relative.lean]=$rebuild_rc"
  if [[ "$rebuild_rc" -ne 0 ]]; then
    echo "[SUCCESSOR-REBUILD] ERROR: source rebuild failed: $relative.lean" >&2
    exit 1
  fi
  expected_line="$(grep -F "  $relative.olean" "$bundle_root/SHA256SUMS")"
  if [[ -z "$expected_line" ]]; then
    echo "[SUCCESSOR-REBUILD] ERROR: missing SHA entry: $relative.olean" >&2
    exit 1
  fi
  expected_hash="${expected_line%% *}"
  actual_line="$(sha256sum "$rebuilt")"
  actual_hash="${actual_line%% *}"
  echo "[SUCCESSOR-REBUILD] sha256[$relative.olean]=$actual_hash"
  if [[ "$actual_hash" != "$expected_hash" ]]; then
    echo "[SUCCESSOR-REBUILD] ERROR: rebuilt hash mismatch: $relative.olean" >&2
    exit 1
  fi
  cmp "$rebuilt" "$bundle_root/$relative.olean"
  echo "[SUCCESSOR-REBUILD] byte-identical: $relative.olean"
done
echo "[SUCCESSOR-REBUILD] source rebuild comparison PASS: 3 modules"

certificate_source="$bundle_root/AscendantRoute/Release/Successor/SuccessorCertificate.lean"
audit_output=""
audit_rc=0
set +e
audit_output="$("$lake_bin" -R env env LEAN_PATH="$bundle_root" lean "$certificate_source" 2>&1)"
audit_rc=$?
set -e
printf '%s\n' "$audit_output"
if [[ "$audit_rc" -ne 0 ]]; then
  echo "[SUCCESSOR] ERROR: certificate elaboration failed" >&2
  exit 1
fi
if grep -Fq 'depends on axioms:' <<<"$audit_output"; then
  echo "[SUCCESSOR] ERROR: nonempty axiom footprint" >&2
  exit 1
fi
axiom_free_count="$(grep -Fc 'does not depend on any axioms' <<<"$audit_output")"
if [[ "$axiom_free_count" -ne 23 ]]; then
  echo "[SUCCESSOR] ERROR: expected 23 axiom-free declarations, got $axiom_free_count" >&2
  exit 1
fi

forbidden_symbols=(
  "PosPossibility" "ConstantDomain" "sorryAx"
  "Final_NE_Proof" "Final_BoxUnique_Proof" "Final_RigidWitness_Proof"
  "TI_" "NE_Run" "Bridge" "Swap" "E_R" "J_R" "J_F"
)
for symbol in "${forbidden_symbols[@]}"; do
  if grep -Fq -- "$symbol" <<<"$audit_output"; then
    echo "[SUCCESSOR] ERROR: forbidden symbol in certificate output: $symbol" >&2
    exit 1
  fi
done

olean_files=(
  "$bundle_root/AscendantRoute/Release/Successor/SuccessorAPI.olean"
  "$bundle_root/AscendantRoute/Release/Successor/SuccessorModel.olean"
  "$bundle_root/AscendantRoute/Release/Successor/SuccessorCertificate.olean"
)
for artifact in "${olean_files[@]}"; do
  for symbol in "${forbidden_symbols[@]}"; do
    match_rc=0
    set +e
    grep -aFq -- "$symbol" "$artifact"
    match_rc=$?
    set -e
    case "$match_rc" in
      0)
        echo "[LEAK] forbidden private symbol '$symbol': $artifact" >&2
        exit 1
        ;;
      1) ;;
      *)
        echo "[SUCCESSOR] ERROR: leak scan failed: $artifact" >&2
        exit 1
        ;;
    esac
  done
done
for artifact in "${actual_files[@]}"; do
  for symbol in "PosPossibility" "TI_"; do
    match_rc=0
    set +e
    grep -aFq -- "$symbol" "$bundle_root/$artifact"
    match_rc=$?
    set -e
    case "$match_rc" in
      0)
        echo "[LEAK] forbidden private symbol '$symbol': $bundle_root/$artifact" >&2
        exit 1
        ;;
      1) ;;
      *)
        echo "[SUCCESSOR] ERROR: all-file zero-check failed: $artifact" >&2
        exit 1
        ;;
    esac
  done
done

echo "[SUCCESSOR] certificate audit PASS: 23 axiom-free declarations"
echo "[SUCCESSOR] leak scan PASS: 3 assemblies"
echo "[SUCCESSOR] all-file zero-check PASS: PosPossibility, TI_"
echo "[SUCCESSOR] optional certificate verification PASS"