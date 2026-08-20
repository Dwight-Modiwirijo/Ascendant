#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

lake_bin="${LAKE_BIN:-lake}"
if command -v python3 >/dev/null 2>&1; then
  python_bin=python3
elif command -v python >/dev/null 2>&1; then
  python_bin=python
else
  echo "[CI] ERROR: python interpreter not found" >&2
  exit 1
fi

expected_toolchain="$(tr -d '\r\n' < lean-toolchain)"
export ELAN_TOOLCHAIN="${ELAN_TOOLCHAIN:-$expected_toolchain}"

public_modules=(
  Interface PublicTests TargetTypes GroundingAudit GroundingChain
  GroundingChainAudit GroundingModel PublicCertificateAudit
)

run_negative_test() {
  local file="$1"
  local expected="$2"
  local output
  if output=$("$lake_bin" -R env lean "$file" 2>&1); then
    printf '[CI] ERROR: negative test compiled: %s\n' "$file" >&2
    return 1
  fi
  printf '%s\n' "$output"
  if ! grep -Fq "$expected" <<<"$output"; then
    printf '[CI] ERROR: negative test failed for an unexpected reason: %s\n' "$file" >&2
    return 1
  fi
}

snapshot_public_assemblies() {
  local output="$1"
  : > "$output"
  for module in "${public_modules[@]}"; do
    sha256sum ".lake/build/lib/lean/AltRoute/$module.olean" >> "$output"
  done
  sha256sum ".lake/build/lib/lean/superlaw.olean" >> "$output"
  sort -o "$output" "$output"
}

echo "[CI] Versions"
"$lake_bin" --version
"$lake_bin" env lean --version

hash_a="$(mktemp)"
hash_b="$(mktemp)"
staging=""
cleanup() {
  rm -f "$hash_a" "$hash_b"
  [[ -z "$staging" ]] || rm -rf "$staging"
}
trap cleanup EXIT

echo "[CI] Clean public build A"
"$lake_bin" clean
"$lake_bin" build
snapshot_public_assemblies "$hash_a"

public_audit_output=$("$lake_bin" -R env lean AltRoute/PublicCertificateAudit.lean 2>&1)
printf '%s\n' "$public_audit_output"
if grep -Fq 'sorryAx' <<<"$public_audit_output"; then
  echo "[CI] ERROR: public audit contains sorryAx" >&2
  exit 1
fi
"$lake_bin" -R env lean AltRoute/PublicTests.lean
"$lake_bin" -R env lean AltRoute/TargetTypes.lean
"$lake_bin" -R env lean AltRoute/GroundingAudit.lean
"$lake_bin" -R env lean AltRoute/GroundingChain.lean
"$lake_bin" -R env lean AltRoute/GroundingChainAudit.lean
"$lake_bin" -R env lean AltRoute/GroundingModel.lean
"$lake_bin" -R env lean superlaw.lean

echo "[CI] Negative guards"
run_negative_test tests/Reject_HostilePositiveEmpty.lean "fields missing: 'proper'"
run_negative_test tests/Reject_HostileModal.lean "fields missing: 'symm'"
run_negative_test tests/Reject_ForcedPositiveEmpty.lean "⊢ ¬True"
run_negative_test tests/Reject_ForcedHostileModal.lean "⊢ False"
run_negative_test tests/Reject_BoxCollapse.lean "Reject_BoxCollapse.box_collapse: phi w cannot rewrite world-indexed phi"
run_negative_test tests/Reject_DiaCollapse.lean "Reject_DiaCollapse.dia_collapse: phi x is not phi w"
run_negative_test tests/Reject_NoContingency.lean "Reject_NoContingency.no_contingency_anywhere: witnesses have different world indices"
run_negative_test tests/Reject_CertificateCollapse.lean "Reject_CertificateCollapse.certificate_equals_existence: phi x is not phi w"
run_negative_test tests/NoExport_NecessaryExistence.lean "unknown identifier 'Final_NE_Proof'"

echo "[CI] Clean public build B"
"$lake_bin" clean
"$lake_bin" build
snapshot_public_assemblies "$hash_b"
if ! diff -u "$hash_a" "$hash_b"; then
  echo "[CI] ERROR: public assemblies are not reproducible" >&2
  exit 1
fi
echo "[CI] Public assembly reproducibility PASS"

echo "[CI] Stage explicit public allow-list"
staging="$(mktemp -d "${TMPDIR:-/tmp}/zer0proof-dist.XXXXXX")"
mkdir -p "$staging/AltRoute" "$staging/tests" "$staging/scripts"

public_sources=(
  AltRoute/Interface.lean
  AltRoute/PublicTests.lean
  AltRoute/TargetTypes.lean
  AltRoute/GroundingAudit.lean
  AltRoute/GroundingChain.lean
  AltRoute/GroundingChainAudit.lean
  AltRoute/GroundingModel.lean
  AltRoute/PublicCertificateAudit.lean
  tests/NoExport_NecessaryExistence.lean
  tests/Reject_HostilePositiveEmpty.lean
  tests/Reject_HostileModal.lean
  tests/Reject_ForcedPositiveEmpty.lean
  tests/Reject_ForcedHostileModal.lean
  tests/Reject_BoxCollapse.lean
  tests/Reject_DiaCollapse.lean
  tests/Reject_NoContingency.lean
  tests/Reject_CertificateCollapse.lean
  scripts/FormalStatusAudit.lean
  scripts/generate-formal-status.py
  scripts/check-document-sync.py
  scripts/check-public-dist.sh
)
for src in "${public_sources[@]}"; do
  cp "$src" "$staging/$src"
done
cp superlaw.lean Paper.md README.md PUBLIC_SAFETY_CERTIFICATE.md LICENSE \
  lean-toolchain lake-manifest.json "$staging/"
cp scripts/dist-lakefile.lean "$staging/lakefile.lean"

for module in "${public_modules[@]}"; do
  cp ".lake/build/lib/lean/AltRoute/$module.olean" "$staging/AltRoute/"
done
cp ".lake/build/lib/lean/superlaw.olean" "$staging/"

LAKE_BIN="${lake_bin}" ${python_bin} scripts/generate-formal-status.py --reproducible \
  --output-json "$staging/formal-status.json" \
  --output-md "$staging/FORMAL_STATUS.md"
${python_bin} scripts/check-document-sync.py "$staging/formal-status.json"

cat > "$staging/SCOPE.txt" <<SCOPE
Zer0proof public distribution

toolchain: $expected_toolchain
commit:    $(git rev-parse HEAD 2>/dev/null || echo unknown)

Covered: the world-indexed public interface, compatibility API, public C5
strong theorem route, individual-premise question-begging audit, non-collapsed
GroundingModel, public tests, HyperModal layer, generated formal status, and
document-sync checks. Every shipped path is explicit in PUBLIC_ALLOWLIST.txt
and every shipped file is covered by SHA256SUMS.

Private successor source and theorem-bearing private .olean: NOT DISTRIBUTED.
No public verdict about the current internal private build is asserted.
SCOPE

(
  cd "$staging"
  { find . -type f -printf '%P\n'; printf '%s\n' PUBLIC_ALLOWLIST.txt SHA256SUMS; } \
    | sort -u > PUBLIC_ALLOWLIST.txt
  find . -type f ! -name SHA256SUMS -print0 | sort -z | xargs -0 sha256sum > SHA256SUMS
  sha256sum -c SHA256SUMS
)

rm -rf dist
mv "$staging" dist
staging=""

echo "[CI] Post-package leak scan"
LAKE_BIN="$lake_bin" bash scripts/check-public-dist.sh dist
( cd dist && sha256sum -c SHA256SUMS )

echo "[CI] Done"


