### Zer0proof — AltRoute (Public Verification Package)

**Scope**

This package exposes the *public* verification surface of the AltRoute proof as compiled `.olean` files, plus a thin Lean interface.  
It is designed so that third parties can:

- Rebuild the environment,
- Inspect the public theorems and axiom footprint,
- Confirm that no strong existence claims (e.g. `□∃x …`) are exported.

---

#### Build

```bash
lake update
lake build
./scripts/ci.sh
