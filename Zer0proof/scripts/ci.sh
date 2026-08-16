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
"$lake_bin" -R env lean AltRoute/GroundingChain.lean
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

# ---------------------------------------------------------------------------
# Public distribution.
#
# Built unconditionally, so a third party can reproduce and verify it without
# the strong certificate assembly. The strong phase below extends the same
# distribution when the bundle is present, and fails closed when it is not.
# ---------------------------------------------------------------------------

echo "[CI] Stage public distribution"
staging="$(mktemp -d "${TMPDIR:-/tmp}/zer0proof-dist.XXXXXX")"
cleanup() { rm -rf "$staging"; }
trap cleanup EXIT

mkdir -p "$staging/AltRoute" "$staging/tests"

public_sources=(
  AltRoute/Interface.lean
  AltRoute/PublicTests.lean
  AltRoute/TargetTypes.lean
  AltRoute/GroundingAudit.lean
  AltRoute/GroundingChain.lean
  AltRoute/GroundingModel.lean
  AltRoute/PublicCertificateAudit.lean
  AltRoute/CertificateAudit.lean
  tests/NoExport_NecessaryExistence.lean
  tests/Reject_HostilePositiveEmpty.lean
  tests/Reject_HostileModal.lean
  tests/Reject_ForcedPositiveEmpty.lean
  tests/Reject_ForcedHostileModal.lean
  tests/Reject_BoxCollapse.lean
  tests/Reject_DiaCollapse.lean
  tests/Reject_NoContingency.lean
  tests/Reject_CertificateCollapse.lean
)
for src in "${public_sources[@]}"; do
  cp "$src" "$staging/$src"
done
cp superlaw.lean README.md PUBLIC_SAFETY_CERTIFICATE.md LICENSE lean-toolchain lake-manifest.json "$staging/"
cp scripts/dist-lakefile.lean "$staging/lakefile.lean"

public_modules=(
  Interface PublicTests TargetTypes GroundingAudit
  GroundingChain GroundingModel PublicCertificateAudit
)
for module in "${public_modules[@]}"; do
  cp ".lake/build/lib/lean/AltRoute/$module.olean" "$staging/AltRoute/"
done
cp ".lake/build/lib/lean/superlaw.olean" "$staging/"

strong_included=no

if [[ -f "$strong_certificate" ]]; then
  if [[ ! -f "$certificate_manifest" ]]; then
    printf '[CI] ERROR: missing certificate provenance manifest: %s\n' "$certificate_manifest" >&2
    exit 1
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
  ( cd "$certificate_root" && sha256sum -c SHA256SUMS )

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

  while IFS= read -r -d '' artifact; do
    relative="${artifact#"$certificate_root"/}"
    mkdir -p "$(dirname "$staging/$relative")"
    cp "$artifact" "$staging/$relative"
  done < <(find "$certificate_root" -type f -name '*.olean' -print0)
  cp "$certificate_manifest" "$staging/CERTIFICATE_SHA256SUMS"
  strong_included=yes
fi

# In-band statement of what this distribution does and does not cover.
{
  echo "Zer0proof public distribution"
  echo
  echo "toolchain: $expected_toolchain"
  echo "commit:    $(git rev-parse HEAD 2>/dev/null || echo unknown)"
  echo
  echo "Covered: the public interface, public tests, target types, the grounding"
  echo "audit, the grounding chain (C5_NE, C5_BoxUnique, C5_RigidWitness), its"
  echo "satisfiability model, and the HyperModal development, as sources and as"
  echo "compiled assemblies. Every file listed in SHA256SUMS is covered by it."
  echo
  if [[ "$strong_included" == yes ]]; then
    echo "Strong certificate assembly: INCLUDED. See CERTIFICATE_SHA256SUMS."
  else
    echo "Strong certificate assembly: NOT INCLUDED. This distribution makes no"
    echo "claim about Final_NE_Proof, Final_BoxUnique_Proof or"
    echo "Final_RigidWitness_Proof. Those remain pending a rebuilt bundle."
  fi
} > "$staging/SCOPE.txt"

echo "[CI] Generate and verify manifest"
(
  cd "$staging"
  find . -type f ! -name SHA256SUMS -print0 | sort -z | xargs -0 sha256sum > SHA256SUMS
  sha256sum -c SHA256SUMS
)

rm -rf dist
mv "$staging" dist
trap - EXIT

echo "[CI] Verify packaged hashes"
( cd dist && sha256sum -c SHA256SUMS )

if [[ "$strong_included" == no ]]; then
  printf '[CI] Public distribution complete.\n'
  printf '[CI] ERROR: missing source-free certificate assembly: %s\n' "$strong_certificate" >&2
  exit 2
fi

echo "[CI] Done"
