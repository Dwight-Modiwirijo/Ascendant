# Public certificate policy

`successor-release/` and `ti-release/` are disclosure-bounded,
clean-room certificate bundles. Successor contains three source/`.olean`
pairs; TI contains four, including full induction. Each bundle also contains a
minimal consumer `lakefile.lean`, the pinned toolchain, structured provenance,
and an internal manifest. The sibling `.SHA256SUMS` files are
repository-controlled external trust anchors.

Everything in these bundles is intentionally public-equivalent. A `.olean`
is a packaging format, not an IP boundary. The concrete Jump and the internal
Successor and TI implementations, proof architectures, bridges, and assemblies
are not distributed.

Run the complete fail-closed consumer from the Zer0proof root:

```bash
bash scripts/verify-published.sh
```

The consumer dynamically verifies the exact bundle inventories, both manifests,
pinned toolchain and provenance, plain-mode kernel replay, byte-identical source
rebuilds, exact axiom-footprint surfaces, and forbidden internal symbols.
The public `dist/` embeds byte-identical copies of both bundles and records their
exact TAR producer commits and manifest hashes in `TAR_PROVENANCE.json`.
