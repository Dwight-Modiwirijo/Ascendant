# Zer0proof — AltRoute (public interface + `.olean`)

**Build:** `lake update && lake build`  
**Check:** `./scripts/ci.sh` (grep-gate, blocklist, axioms whitelist, proof-term, no-export guard, packaging)

## Toolchain & deps
- Lean: zie `lean-toolchain`
- mathlib: gepind in `lakefile.lean`

## Public surface (zwak)
- `necPossible_of_Pos`: `Pos P → □◇∃x P x` (via S5 `ax_5` + zwakke brug `PosPossibility`)
- `SomePosNecPossible`: ∃P met bovenstaande eigenschap  
**Geen** publieke claim van `□∃x …`.

## Verifieerbaarheid
- `#print axioms` (publieke theorema’s) toont enkel `AltRoute.PosPossibility`.
- Proof-term laat aanroep van `Modal.ax_5` zien.
- No-export guard bewijst dat sterke symbolen (zoals `NecessaryExistence`/`□∃`) **niet** publiek zijn.

## Toolchain
 leanprover/lean4:v4.20.1 (binary reports Lean 4.20.0, commit b02228b0, per upstream packaging). CLI en lake env zijn identiek, zie CI.

## Disclosure
We leveren: `.olean` + `AltRoute/Interface.lean` + toolchain/lakefile.  
Bron van proofs is vertrouwelijk; onder NDA beschikbaar voor reviewers.

### How to verify (public)
```bash
# fresh env
lake update && lake build
# run axiom footprint report
lake env lean -R . scripts/AxiomsCheck.lean

