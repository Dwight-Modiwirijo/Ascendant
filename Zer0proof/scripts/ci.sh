#!/usr/bin/env bash
set -euo pipefail

# 0) Version info (do not fail if Lean is missing from PATH)
lean --version || true

# 1) Build the default Lake target (must succeed)
lake build

# 2) Grep-gate (public surface hygiene)
#    Block obvious red flags from public files:
#    - unfinished proofs (sorry/admit)
#    - essentialism / Barcan / Löb / GL
#    - leaking typeclass instances for Positive
#    - non-deterministic choice
if grep -R -nE "sorry|admit|Ess|Barcan|Loeb|GL|instance .* Positive|choose" AltRoute/*.lean; then
  echo "[CI] grep-gate: forbidden pattern found on the public surface" >&2
  exit 1
fi

# 3) Blocklist: strong public claims must not appear
#    The public interface must not export □∃, ◇□, or patterns that imply them.
if grep -R -nE "NecessaryExistence|□∃|◇□|Box \(∃|Dia \(.*Box" AltRoute/*.lean; then
  echo "[CI] blocklist: strong public claim found" >&2
  exit 1
fi

# 4) AxiomsCheck: print axiom footprint + proof term for public theorems
#    Run inside Lake's environment so project modules resolve.
lake env lean -R . scripts/AxiomsCheck.lean > axioms.out

# 4a) Whitelist with awk (only inspect 'depends on axioms:' lines)
awk '
  /depends on axioms:/ && $0 !~ /\[AltRoute\.PosPossibility\]/ { bad=1 }
  END { exit bad }
' axioms.out || {
  echo "[CI] axiom whitelist violation: unexpected global axioms detected" >&2
  sed -n "1,200p" axioms.out
  exit 1
}

# 4b) Proof-term check: ensure S5 ax_5 is actually used in the derivation.
#     We grep the printed proof term of `necPossible_of_Pos` for `Modal.ax_5`.
if ! grep -q "Modal\.ax_5" axioms.out; then
  echo "[CI] proof-term check failed: expected reference to Modal.ax_5 not found" >&2
  echo "----- axioms.out (snippet) -----"
  sed -n '1,200p' axioms.out
  echo "--------------------------------"
  exit 1
fi

# 5) No-export guard: this target MUST FAIL (i.e., symbol must not exist publicly)
if lake build NoExport_NecessaryExistence 2>/dev/null; then
  echo "[CI] no-export-guard: unexpected success" >&2
  exit 1
else
  echo "[CI] no-export-guard: expected failure detected (OK)"
fi

# 6) Packaging & integrity (distribute only .olean + minimal text surface)
rm -rf dist && mkdir -p dist

# copy only non-test olean files from Lake output
find .lake/build/lib/lean/AltRoute -maxdepth 1 -type f -name '*.olean' \
  ! -name '*PublicTests*' -exec cp {} dist/ \;

# minimal text surface
cp AltRoute/Interface.lean README.md LICENSE lean-toolchain lakefile.lean dist/

# hashes
( cd dist && sha256sum * > SHA256SUMS && sha256sum -c SHA256SUMS )

