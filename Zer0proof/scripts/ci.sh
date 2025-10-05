#!/usr/bin/env bash
set -euo pipefail

echo "[CI] Versions"
lean --version || true
lake --version || true

echo "[CI] Build"
lake build

echo "[CI] Grep-gate"
if grep -R -nE "sorry|admit|Ess|Barcan|Loeb|GL|instance .* Positive|choose" AltRoute/*.lean; then
  echo "[CI] grep-gate: forbidden pattern found" >&2; exit 1
fi

echo "[CI] Blocklist (public)"
if grep -R -nE "NecessaryExistence|□∃|◇□|Box \(∃|Dia \(.*Box" AltRoute/*.lean; then
  echo "[CI] blocklist: strong public claim found" >&2; exit 1
fi

echo "[CI] AxiomsCheck"
lake env lean -R . scripts/AxiomsCheck.lean > axioms.out

# Whitelist: alleen PosPossibility voor de twee hoofdstellingen
if grep -q "'AltRoute\.necPossible_of_Pos'.*depends on axioms: \[AltRoute\.PosPossibility\]" axioms.out \
   && grep -q "'AltRoute\.somePosNecPossible_of_exists'.*depends on axioms: \[AltRoute\.PosPossibility\]" axioms.out
then
  echo "[CI] axioms whitelist OK"
else
  echo "[CI] axiom whitelist violation: unexpected global axioms detected"
  echo "----- axioms.out -----"; cat axioms.out; echo "----------------------"
  exit 1
fi

echo "[CI] No-export guard"
set +e
lake build tests.NoExport_NecessaryExistence >/dev/null 2>&1
RES=$?
set -e
if [ $RES -ne 0 ]; then
  echo "[CI] no-export-guard: expected failure detected (OK)"
else
  echo "[CI] no-export-guard: unexpected success" >&2; exit 1
fi

echo "[CI] Package"
rm -rf dist && mkdir -p dist
# kopieer alleen publieke .olean (geen tests)
find .lake/build/lib/lean/AltRoute -maxdepth 1 -type f -name '*.olean' ! -name '*PublicTests*' -exec cp {} dist/ \;
# metadata
cp AltRoute/Interface.lean README.md LICENSE lean-toolchain lakefile.lean dist/
( cd dist && sha256sum * > SHA256SUMS && sha256sum -c SHA256SUMS )

echo "[CI] Done"
