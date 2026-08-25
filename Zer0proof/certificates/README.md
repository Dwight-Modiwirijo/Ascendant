# Public certificate policy

`successor-release/` is the disclosure-bounded, clean-room certificate bundle
for the abstract S-Machine contract. It contains exactly three source/`.olean`
pairs, a minimal consumer `lakefile.lean`, the pinned toolchain, structured provenance, and an internal manifest.
`successor-release.SHA256SUMS` is the repository-controlled external trust
anchor.

Everything in this bundle is intentionally public-equivalent. A `.olean` is a
packaging format, not an IP boundary. The concrete Jump implementation, the
internal Ascendant Route, TI, private proof sources, and their assemblies are
not distributed.

Run the complete fail-closed consumer with:

```bash
bash scripts/check-successor-release.sh
```

The consumer checks the exact ten-file allow-list, both manifests, pinned
toolchain and provenance, `.olean` import compatibility, plain-mode kernel
replay, byte-identical source rebuilds, 23 axiom footprints, and forbidden
private symbols.