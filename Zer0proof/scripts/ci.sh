#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

lake_bin="${LAKE_BIN:-lake}"
expected_toolchain="$(tr -d '\r\n' < lean-toolchain)"
export ELAN_TOOLCHAIN="${ELAN_TOOLCHAIN:-$expected_toolchain}"
certificate_root="${CERTIFICATE_ROOT:-certificates}"
strong_certificate="$certificate_root/AltRoute/StrongCertificates.olean"
certificate_manifest="$certificate_root/SHA256SUMS"

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

echo "[CI] Versions"
"$lake_bin" --version
"$lake_bin" env lean --version

echo "[CI] Clean public build"
"$lake_bin" clean
"$lake_bin" build
"$lake_bin" -R env lean AltRoute/PublicCertificateAudit.lean
"$lake_bin" -R env lean AltRoute/PublicTests.lean
"$lake_bin" -R env lean AltRoute/TargetTypes.lean
grounding_output=$("$lake_bin" -R env lean AltRoute/GroundingAudit.lean 2>&1)
printf '%s\n' "$grounding_output"
if grep -Fq 'AltRoute.PosPossibility' <<<"$grounding_output"; then
  echo "[CI] ERROR: grounding obligation footprint contains AltRoute.PosPossibility" >&2
  exit 1
fi
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

if [[ ! -f "$strong_certificate" ]]; then
  printf '[CI] ERROR: missing source-free certificate assembly: %s\n' "$strong_certificate" >&2
  exit 2
fi

if [[ ! -f "$certificate_manifest" ]]; then
  printf '[CI] ERROR: missing certificate provenance manifest: %s\n' "$certificate_manifest" >&2
  exit 2
fi

echo "[CI] Verify certificate provenance"
while IFS= read -r -d '' artifact; do
  relative="${artifact#"$certificate_root"/}"
  if ! awk -v path="$relative" '$2 == path { found = 1 } END { exit !found }' \
      "$certificate_manifest"; then
    printf '[CI] ERROR: unpinned certificate assembly: %s\n' "$relative" >&2
    exit 1
  fi
done < <(find "$certificate_root" -type f -name '*.olean' -print0)
(
  cd "$certificate_root"
  sha256sum -c SHA256SUMS
)

echo "[CI] Install source-free certificate bundle"
while IFS= read -r -d '' artifact; do
  relative="${artifact#"$certificate_root"/}"
  destination=".lake/build/lib/lean/$relative"
  mkdir -p "$(dirname "$destination")"
  cp "$artifact" "$destination"
done < <(find "$certificate_root" -type f -name '*.olean' -print0)

echo "[CI] Strong certificate audit"
audit_output=$("$lake_bin" -R env lean AltRoute/CertificateAudit.lean 2>&1)
printf '%s\n' "$audit_output"
if grep -Fq 'sorryAx' <<<"$audit_output"; then
  echo "[CI] ERROR: strong certificate footprint contains sorryAx" >&2
  exit 1
fi
for forbidden in \
  'AltRoute.PosPossibility' \
  'AltRoute.exists_of_positive' \
  'AltRoute.necPossible_of_Pos' \
  'HyperModal.perfect_being_exists' \
  'HyperModal.consciousness_axiom'; do
  if grep -Fq "$forbidden" <<<"$audit_output"; then
    printf '[CI] ERROR: forbidden strong certificate dependency: %s\n' "$forbidden" >&2
    exit 1
  fi
done

echo "[CI] Canonical package"
staging="$(mktemp -d "${TMPDIR:-/tmp}/zer0proof-dist.XXXXXX")"
cleanup() {
  rm -rf "$staging"
}
trap cleanup EXIT

mkdir -p "$staging/AltRoute" "$staging/tests"
cp AltRoute/Interface.lean "$staging/AltRoute/"
cp AltRoute/PublicTests.lean "$staging/AltRoute/"
cp AltRoute/TargetTypes.lean "$staging/AltRoute/"
cp AltRoute/GroundingAudit.lean "$staging/AltRoute/"
cp superlaw.lean "$staging/"
cp AltRoute/PublicCertificateAudit.lean "$staging/AltRoute/"
cp AltRoute/CertificateAudit.lean "$staging/AltRoute/"
cp tests/NoExport_NecessaryExistence.lean "$staging/tests/"
cp tests/Reject_HostilePositiveEmpty.lean "$staging/tests/"
cp tests/Reject_HostileModal.lean "$staging/tests/"
cp tests/Reject_ForcedPositiveEmpty.lean "$staging/tests/"
cp tests/Reject_ForcedHostileModal.lean "$staging/tests/"
cp tests/Reject_BoxCollapse.lean "$staging/tests/"
cp tests/Reject_DiaCollapse.lean "$staging/tests/"
cp tests/Reject_NoContingency.lean "$staging/tests/"
cp tests/Reject_CertificateCollapse.lean "$staging/tests/"
cp README.md LICENSE lean-toolchain lake-manifest.json "$staging/"
cp scripts/dist-lakefile.lean "$staging/lakefile.lean"
cp "$certificate_manifest" "$staging/CERTIFICATE_SHA256SUMS"

for module in Interface PublicTests TargetTypes GroundingAudit PublicCertificateAudit; do
  cp ".lake/build/lib/lean/AltRoute/$module.olean" "$staging/AltRoute/"
done
cp ".lake/build/lib/lean/superlaw.olean" "$staging/"


while IFS= read -r -d '' artifact; do
  relative="${artifact#"$certificate_root"/}"
  destination="$staging/$relative"
  mkdir -p "$(dirname "$destination")"
  cp "$artifact" "$destination"
done < <(find "$certificate_root" -type f -name '*.olean' -print0)

(
  cd "$staging"
  find . -type f ! -name SHA256SUMS -print0 \
    | sort -z \
    | xargs -0 sha256sum > SHA256SUMS
  sha256sum -c SHA256SUMS
)

rm -rf dist
mv "$staging" dist
trap - EXIT

echo "[CI] Verify packaged hashes"
(cd dist && sha256sum -c SHA256SUMS)

echo "[CI] Done"
