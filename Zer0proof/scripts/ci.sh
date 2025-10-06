#!/usr/bin/env bash
set -Eeuo pipefail

echo "[CI] Versions"
lean --version || true
lake --version || true

echo "[CI] Build"
lake build

echo "[CI] Grep-gate"
if grep -R -nE 'sorry|admit|Ess|Barcan|Loeb|GL|instance .* Positive|choose' AltRoute/*.lean; then
  echo "[CI] grep-gate: forbidden pattern found" >&2; exit 1; fi

echo "[CI] Blocklist (public)"
if grep -R -nE 'NecessaryExistence|□∃|◇□|Box \(∃|Dia \(.*Box' AltRoute/*.lean; then
  echo "[CI] blocklist: strong public claim found" >&2; exit 1; fi

echo "[CI] AxiomsCheck (running)"
set +e
lake env lean -R . scripts/AxiomsCheck.lean > axioms.out 2>&1
ax=$?
set -e
if [[ $ax -ne 0 ]]; then
  echo "[CI] AxiomsCheck FAILED (exit $ax). Dumping axioms.out:"
  sed -n '1,200p' axioms.out
  exit $ax
fi

echo "[CI] AxiomsCheck (parsing)"
np_line=$(grep -E "^'AltRoute\.necPossible_of_Pos'" axioms.out || true)
se_line=$(grep -E "^'AltRoute\.somePosNecPossible_of_exists'" axioms.out || true)
sp_ok=$(grep -E "^'AltRoute\.SomePosNecPossible' does not depend on any axioms" axioms.out || true)
if [[ -z "$np_line" || -z "$se_line" || -z "$sp_ok" ]]; then
  echo "[CI] Unexpected axioms.out format:"; sed -n '1,200p' axioms.out; exit 1; fi

np_deps=$(echo "$np_line" | sed -E "s/.*depends on axioms: \[(.*)\].*/\1/" | tr -d '[:space:]')
se_deps=$(echo "$se_line" | sed -E "s/.*depends on axioms: \[(.*)\].*/\1/" | tr -d '[:space:]')

if [[ "$np_deps" != "AltRoute.PosPossibility" || "$se_deps" != "AltRoute.PosPossibility" ]]; then
  echo "[CI] axiom whitelist violation: expected only AltRoute.PosPossibility"
  sed -n '1,200p' axioms.out; exit 1; fi
echo "[CI] axioms whitelist OK"

echo "[CI] No-export guard"
set +e
lake build tests.NoExport_NecessaryExistence >/dev/null 2>&1
guard=$?
set -e
if [[ $guard -eq 0 ]]; then
  echo "[CI] no-export-guard: unexpected success" >&2; exit 1
else
  echo "[CI] no-export-guard: expected failure detected (OK)"
fi

echo "[CI] Package"
rm -rf dist && mkdir -p dist
find .lake/build/lib/lean/AltRoute -maxdepth 1 -type f -name '*.olean' ! -name '*PublicTests*' -exec cp {} dist/ \;
cp AltRoute/Interface.lean README.md LICENSE lean-toolchain lakefile.lean dist/
( cd dist && sha256sum * > SHA256SUMS && sha256sum -c SHA256SUMS )

echo "[CI] Done"
