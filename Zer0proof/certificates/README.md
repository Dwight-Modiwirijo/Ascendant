# Strong certificate bundle

This directory is the source-free input boundary for the strong Lean
certificate surface.

The bundle must contain:

```text
certificates/AltRoute/StrongCertificates.olean
```

and every transitive project `.olean` dependency required when Lean imports
that module. Directory paths must match the compiled Lean module names.

No private `.lean` implementation belongs in this directory.

`scripts/ci.sh` copies this bundle into Lean's build search path, executes
`AltRoute/CertificateAudit.lean`, rejects any reported `sorryAx`, and packages
the same assemblies into `dist/`. The ordinary `AltRoute.Interface` does not
import this bundle.

## Provenance manifest

A real bundle must include `certificates/SHA256SUMS`. Generate it from the
certificate root, never by copying expected values from documentation:

```bash
cd certificates
find . -type f -name '*.olean' -print0 | sort -z | xargs -0 sha256sum > SHA256SUMS
sha256sum -c SHA256SUMS
```

Every `.olean` in the bundle must have an exact entry. CI verifies the manifest
and rejects unlisted, missing, or substituted assemblies before placing any of
them on Lean's search path. No manifest is published while the real bundle is
absent.