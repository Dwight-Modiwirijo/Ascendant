### Zer0proof — AltRoute (Public Verification Package)

**Scope**

This package exposes the *public* verification surface of the AltRoute proof as compiled `.olean` files, plus a thin Lean interface.  
It is designed so that third parties can:

- Rebuild the environment,
- Inspect the public theorems and axiom footprint,
- Confirm that no strong existence claims (e.g. `□∃x …`) are exported.

---

#### Threat model: 8 attack vectors and how they are neutralized

This repo treats the public Lean artifacts as a **verifiable certificate**: anyone can rebuild and check that the exported surface is non-trivial, non-explosive, and does not “smuggle” strong claims through a pretty interface.

| Attack vector | What it would break | Where it is checked / prevented |
| --- | --- | --- |
| 1) **`sorry` / placeholders** | “Proofs” compile without real justification | CI script + `grep`/Lean build rejects `sorry` in public modules; public tests compile from source. |
| 2) **Explosion (`ex falso quodlibet`) leakage** | From one contradiction, *everything* becomes provable | `PublicTests.lean` explicitly contains an `exFalsoQuodlibet` lemma and keeps `False` *unprovable* (no accidental `example : False`). |
| 3) **Triviality (`verum ex quodlibet` / always-true model)** | The interface “accepts” everything by collapsing the logic | `PublicTests.lean` includes a concrete **TrivialModel** (Box/Dia = identity) as a *consistency witness* and then adds *negative guards* so the public API cannot silently become “always true”. |
| 4) **Circular grounding / cycles** | Self-grounding loops masquerade as foundations | Public layer forbids exporting circular grounding witnesses; cycle-detection is expected in the runtime graph layer (Neo4j / GraphML), and the Lean surface avoids granting “grounded” status purely from cycles. |
| 5) **Infinite regress (non-well-founded chains)** | Proof search never bottoms out; “grounding” never terminates | The private route proves anti-regress / well-foundedness; the public package exposes only the safe interface + tests, not the regress machinery. |
| 6) **Accidentally exporting strong existence claims** | Leaking `□∃!Ω` (or equivalents) in the public API | The negative guard library (`tests.NoExport_NecessaryExistence`) is meant to **fail the build** if such claims become reachable; CI must run it as a canary. |
| 7) **Namespace / symbol shadowing** | A malicious redefinition makes a theorem “look” like the intended one | Public modules keep a small exported surface (`AltRoute.Interface`, `AltRoute.PublicTests`) and the build is pinned to an exact toolchain + mathlib revision. |
| 8) **Artifact tampering** | A swapped `.olean` could fake a verified proof | Rebuild-from-source + reproducible CI is the primary defense. Distributing hashes / signatures for `.olean` artifacts hardens this further. |

**Notes**
- Items (4)–(5) are *architectural* threats that are enforced across the full stack (Lean + graph runtime). The public package is intentionally minimal and does not reveal private internals, but it remains rebuildable and inspectable.
- The canary build that “must fail” is only useful if CI runs it in a dedicated job (expected failure). If CI ignores it, it does nothing.


#### Build

```bash
lake update
lake build
./scripts/ci.sh
