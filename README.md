# Ascendant

[![Lean CI](https://github.com/Dwight-Modiwirijo/Ascendant/actions/workflows/ci.yml/badge.svg)](https://github.com/Dwight-Modiwirijo/Ascendant/actions/workflows/ci.yml)

Public paper and reproducible Lean 4 audit for the **Ascendant Route**.

The accompanying paper presents the philosophical argument. The `Zer0proof`
project provides the public Lean definitions, theorem statements, proof
sources, model checks, negative controls, audit tooling, and the disclosure-bounded Successor source/`.olean` certificate bundle.

## Start Here

- [Paper](Zer0proof/Paper.md)
- [Lean audit and Docker instructions](Zer0proof/README.md)
- [Public safety certificate](Zer0proof/PUBLIC_SAFETY_CERTIFICATE.md)
- [AscendantRoute Lean modules](Zer0proof/AscendantRoute/)
- [Public Successor certificate bundle](Zer0proof/certificates/successor-release/)

`AscendantRoute` is the Lean namespace and public formalization of the
Ascendant Route described in the paper.

## Verify with Docker

```bash
docker pull dmodiwirijo/ascendant:latest
docker run --rm dmodiwirijo/ascendant:latest bash scripts/ci.sh
```

A successful audit ends with:

```text
[CI] Done
[CI] CI_RC=0
```

For the immutable audited snapshot:

```bash
docker pull dmodiwirijo/ascendant:4ed8dc9
docker run --rm dmodiwirijo/ascendant:4ed8dc9 bash scripts/ci.sh
```

## Verify from Source

```bash
cd Zer0proof
lake build
bash scripts/ci.sh
bash scripts/check-successor-release.sh
```

## Verification Scope

Lean verifies the published proof terms at their printed theorem types,
relative to their explicit hypotheses and reported axiom footprints.

The formal audit establishes derivation, explicit context, model and
non-collapse checks, and premise-isolation results. It does not establish that
the philosophical premises are true of reality; their defense belongs to the
paper.

## Repository Layout

- `Zer0proof/Paper.md`: accompanying paper
- `Zer0proof/AscendantRoute/`: public Lean formalization
- `Zer0proof/tests/`: negative and no-export tests
- `Zer0proof/scripts/ci.sh`: complete public audit
- `Zer0proof/certificates/successor-release/`: public clean-room Successor sources and `.olean` assemblies
- `Zer0proof/certificates/successor-release.SHA256SUMS`: external repository trust anchor
- `Zer0proof/Dockerfile`: reproducible audit environment
