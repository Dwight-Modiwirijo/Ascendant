# W11 Grounding Route Audit Report

## Status

- W10 commit 35dedc0 was pushed before W11 work began and matched origin/main.
- W11 outcome: PROVABLE ONLY WITH A FORBIDDEN PREMISE.
- No Final_NE_Proof, Final_BoxUnique_Proof, Final_RigidWitness_Proof, or replacement StrongCertificates.olean was created.
- Paper.md was not modified.

## Runtime evidence

The local project toolchain reported:

    Lake version 5.0.0-b02228b (Lean version 4.20.0)
    Lean (version 4.20.0, x86_64-w64-windows-gnu, commit b02228b03f65, Release)

The historical image named by the prompt was no longer pullable on 2026-08-16:

    docker pull leanprover/lean4:v4.20.1
    pull access denied ... repository does not exist

The GHCR and historical community aliases were also unavailable. All results below were therefore produced by the repository's pinned local v4.20.1 toolchain, whose executable identifies commit b02228b03f65.

## Acceptance surface

AltRoute/TargetTypes.lean is a default Lake root and a direct CI input. All Target declarations report no axiom dependency, including GroundingPremises, all targets, all four Yields predicates, and all obligations.

Ground was retained exactly in the paper's extensional direction. StrictGround adds extensional inequality only where the paper requires strict descent: Terminus and anti_regress. This avoids the impossible anti-regress formulation induced by reflexive Ground without changing C1/A1.

## Per-field non-entailment

Each row is one compiled countermodel in which the named field is inhabited while the Omega domain is empty. RefutesAllYields is the conjunction of the negations of actual, possible, necessary, and possibly-necessary Omega existence.

| GroundingPremises field | Actual | Possible | Necessary | Possibly necessary | Footprint |
|---|---:|---:|---:|---:|---|
| datum_contingent | refuted | refuted | refuted | refuted | propext |
| hm_psr | refuted | refuted | refuted | refuted | none |
| anti_regress | refuted | refuted | refuted | refuted | none |
| coalescence | refuted | refuted | refuted | refuted | none |
| terminus_is_Omega | refuted | refuted | refuted | refuted | none |

The datum witness uses the universal Bool frame. The other four witnesses use the one-world frame; this is legitimate for semantic non-entailment of each individual field, not as a proof of a strong certificate.

## Mechanical finding

C1 and C2 are jointly inconsistent under the published Ground definition:

1. C2 supplies Cont F I.
2. C1 supplies q with Nec F q and Ground F q I.
3. Frame.ax_T applied to Nec F q supplies q at any world.
4. Ground F q I supplies I at every world.
5. Cont F I includes a reachable world with Not I.
6. Contradiction.

Lean reports no axiom dependency for premises_false. It also reports no axiom dependency for c1c2_yields_actual, c1c2_yields_possible, c1c2_yields_necessary, and c1c2_yields_possible_necessary. The combined C1/C2 core is therefore itself a forbidden premise bundle by explosion.

The NE, BoxUnique, BoxUnique reductio, and rigid-witness obligations compile only as explicitly named audit findings ending in from_inconsistent_bundle. They are not exported as strong certificates. Their footprints are empty because the contradiction is derived from explicit structure fields, not because the grounding route closes constructively.

## Positivity criterion

No positivity-derived constant occurs in the grounding obligation proofs. CI rejects AltRoute.PosPossibility, AltRoute.exists_of_positive, and AltRoute.necPossible_of_Pos if any later strong footprint contains them.

The actual Final_NE_Proof and Final_BoxUnique_Proof footprints remain unavailable because StrongCertificates.olean has not been rebuilt. W11 does not claim that those absent footprints were inspected.

## HyperModal footprints

superlaw.lean now imports AltRoute.Interface and defines necessarily and possibly directly as Frame.Box and Frame.Dia. The before/after footprints of all 19 existing theorems are identical:

| Theorem | Axiom footprint |
|---|---|
| consciousness_grounded | consciousness_axiom |
| anti_material_grounding | logic_is_necessary, material_is_contingent, no_necessary_grounded_in_contingent |
| reductio | consciousness_axiom |
| materialist_reductio | logic_is_necessary, material_is_contingent, no_necessary_grounded_in_contingent |
| perfect_positivity_reductio | perfect_positivity |
| hyper_minimal_PSR_reductio | hyper_minimal_PSR |
| perfect_being_exists_reductio | perfect_being_exists |
| logic_necessity_reductio | logic_necessity |
| anti_regress_reductio | anti_regress |
| meta_logic_reductio | meta_logic |
| consciousness_axiom_reductio | consciousness_axiom |
| logic_is_necessary_reductio | logic_is_necessary |
| material_is_contingent_reductio | material_is_contingent |
| no_necessary_grounded_in_contingent_reductio | no_necessary_grounded_in_contingent |
| veridical_support | consciousness_axiom |
| falsidical_strengthen | none |
| antinomy_support | none |
| semantic_strengthen | consciousness_axiom |
| paradox_strengthens_perfection | none |

## Negative guards

All nine tests failed as intended. The four tightened collapse sentinels matched these literal Lean lines:

    Reject_BoxCollapse.box_collapse: phi w cannot rewrite world-indexed phi
    Reject_DiaCollapse.dia_collapse: phi x is not phi w
    Reject_NoContingency.no_contingency_anywhere: witnesses have different world indices
    Reject_CertificateCollapse.certificate_equals_existence: phi x is not phi w

The remaining guards matched missing proper, missing symm, goal Not True, goal False, and unknown Final_NE_Proof. CI then stopped only at the intentionally absent source-free strong assembly:

    [CI] ERROR: missing source-free certificate assembly: certificates/AltRoute/StrongCertificates.olean
    CI_RC=2

## Deterministic assemblies

Two clean builds and a third build after LF normalization were byte-identical. Final SHA-256 values:

| Assembly | SHA-256 |
|---|---|
| AltRoute/Interface.olean | 06bff5fcb1a830b6e5445becd125bef35bd3889a2500d639d0028975b0fd136a |
| AltRoute/PublicTests.olean | d172dfc3522095e8c02928c9ec9b8deee81756eae4f4423e788e2894c3e2f00c |
| AltRoute/TargetTypes.olean | 1c8d94ca53b8cf35c40125567f03bcea6fde856171fedea0263ce900e0102ccf |
| AltRoute/GroundingAudit.olean | ebd25cff9710316254a661842eeb516418c14609794264ef3c5fbeefc3ba7fa2 |
| AltRoute/PublicCertificateAudit.olean | f8a7b9a845594d6f1ba06890ae78df2ca0d23e96cc4f444550582d053f315c47 |
| superlaw.olean | 2dbfc52936283f7ee892cf1d55e606fa68be73320c8c3953f381aec118632a68 |

## Unproved work

A non-explosive derivation of necessary existence, uniqueness, or a rigid witness from the stated bundle was not obtained. It cannot be assessed until C1/A1 or Ground is repaired so that C1 is compatible with the contingent datum. Adding an Omega-existence or positivity premise merely to force closure would violate the acceptance rules and was not done.