# Formal Status

> Generated from current Lean/CI output. Do not edit by hand.

- Git commit: `ca0b4c26ffdbacc20a43907f62dbfe627ce1a753`
- Lean toolchain: `leanprover/lean4:v4.20.1`
- Audit date: `2026-08-25`
- Auditor verdict: **PENDING_INDEPENDENT_REVIEW**

## Public Theorems

| Declaration | Axiom footprint |
|---|---|
| `AscendantRoute.GroundingChain.C5_NE` | `propext, Classical.choice, Quot.sound` |
| `AscendantRoute.GroundingChain.C5_BoxUnique` | `propext, Classical.choice, Quot.sound` |
| `AscendantRoute.GroundingChain.C5_RigidWitness` | `propext, Classical.choice, Quot.sound` |

## HyperModal Core-Relative Audit

| Declaration | Axiom footprint |
|---|---|
| `HyperModal.logic_necessity` | `none` |
| `HyperModal.meta_logic` | `none` |
| `HyperModal.posT_box` | `propext, Classical.choice, Quot.sound` |
| `HyperModal.posT_iff_box` | `propext, Classical.choice, Quot.sound` |
| `HyperModal.triad_holds` | `none` |
| `HyperModal.posT_box_core` | `propext, Classical.choice, Quot.sound` |
| `HyperModal.posT_not_both` | `propext, Classical.choice, Quot.sound` |
| `HyperModal.Historical.perfect_positivity_refutation` | `none` |
| `HyperModal.Historical.consciousness_axiom_refutation` | `none` |
| `HyperModal.Historical.anti_regress_refutation` | `none` |
| `HyperModal.Historical.logic_material_trio_refutation` | `none` |
| `HyperModal.Model.setting_inhabited` | `none` |
| `HyperModal.Model.omega_possible` | `none` |
| `HyperModal.Model.grounding_nonempty` | `none` |
| `HyperModal.Model.frame_not_collapsed` | `none` |

## Successor Certificate

| Declaration | Axiom footprint |
|---|---|
| `AscendantRoute.Release.Successor.Machine` | `none` |
| `AscendantRoute.Release.Successor.Machine.State` | `none` |
| `AscendantRoute.Release.Successor.Machine.S` | `none` |
| `AscendantRoute.Release.Successor.Machine.meas` | `none` |
| `AscendantRoute.Release.Successor.Machine.dec` | `none` |
| `AscendantRoute.Release.Successor.Machine.terminal` | `none` |
| `AscendantRoute.Release.Successor.Machine.zeroUnique` | `none` |
| `AscendantRoute.Release.Successor.iterate` | `none` |
| `AscendantRoute.Release.Successor.terminates` | `none` |
| `AscendantRoute.Release.Successor.coverage` | `none` |
| `AscendantRoute.Release.Successor.Omega` | `none` |
| `AscendantRoute.Release.Successor.omega_iff` | `none` |
| `AscendantRoute.Release.Successor.omega_fixed` | `none` |
| `AscendantRoute.Release.Successor.existsUniqueOmegaReached` | `none` |
| `AscendantRoute.Release.Successor.existsUniqueOmega` | `none` |
| `AscendantRoute.Release.Successor.NatMachine` | `none` |
| `AscendantRoute.Release.Successor.natStart` | `none` |
| `AscendantRoute.Release.Successor.natMachine_terminates` | `none` |
| `AscendantRoute.Release.Successor.natMachine_coverage` | `none` |
| `AscendantRoute.Release.Successor.natMachine_omega_iff` | `none` |
| `AscendantRoute.Release.Successor.natMachine_omega_fixed` | `none` |
| `AscendantRoute.Release.Successor.natMachine_existsUniqueOmegaReached` | `none` |
| `AscendantRoute.Release.Successor.natMachine_existsUniqueOmega` | `none` |

## W12 Question-Begging Matrix

- Audited premises: `C1, GroundObtains, C3, C4a, datum_obtains`
- Audited targets: `actual_omega, possible_omega, necessary_omega, possible_necessary_omega`

| Premise | Target | Status |
|---|---|---|
| `C1` | `actual_omega` | PASS |
| `C1` | `possible_omega` | PASS |
| `C1` | `necessary_omega` | PASS |
| `C1` | `possible_necessary_omega` | PASS |
| `GroundObtains` | `actual_omega` | PASS |
| `GroundObtains` | `possible_omega` | PASS |
| `GroundObtains` | `necessary_omega` | PASS |
| `GroundObtains` | `possible_necessary_omega` | PASS |
| `C3` | `actual_omega` | PASS |
| `C3` | `possible_omega` | PASS |
| `C3` | `necessary_omega` | PASS |
| `C3` | `possible_necessary_omega` | PASS |
| `C4a` | `actual_omega` | PASS |
| `C4a` | `possible_omega` | PASS |
| `C4a` | `necessary_omega` | PASS |
| `C4a` | `possible_necessary_omega` | PASS |
| `datum_obtains` | `actual_omega` | PASS |
| `datum_obtains` | `possible_omega` | PASS |
| `datum_obtains` | `necessary_omega` | PASS |
| `datum_obtains` | `possible_necessary_omega` | PASS |

## Gates

- Gate 0: **PASS**
- Modal Non Collapse: **PASS**
- Question Begging Individual Premises: **PASS**
- W12 Premise Manifest Complete: **PASS**
- W12 Question Begging Matrix Complete: **PASS**
- Public Grounding Model: **PASS**
- Hypermodal Setting Model: **PASS**
- Hypermodal Legacy Guards: **PASS**
- Public Reproducibility: **PASS**
- Explicit Package Allow List: **PASS**
- Post Package Leak Scan: **PASS**

## Private Route

The private successor route is not distributed as source or theorem-bearing .olean; no public verdict about its current internal build is asserted.

## Public Assembly Hashes

| Assembly | SHA-256 |
|---|---|
| `AscendantRoute/Interface.olean` | `4bdf45cce915287f9acea5fb3a4af36daee98148da8073c230e06ea515b1d077` |
| `AscendantRoute/PublicTests.olean` | `8d03a65bf92bdb96d7d5c4c3d3e26800cd45610b4f05ddb9be460adac857d3f4` |
| `AscendantRoute/TargetTypes.olean` | `aa58421f1186336031d8ac37fcdd547006502d445ca10fc685414858aaaeba13` |
| `AscendantRoute/GroundingAudit.olean` | `b86bca7e94f18ff583e30d8fd5a3fddded678034e5e13f6137df2acec23ce1b3` |
| `AscendantRoute/GroundingChain.olean` | `c34dbcec21d880b2201c24089e3973d18fc5cf883d07b0b629b1150be85c4f59` |
| `AscendantRoute/GroundingChainAudit.olean` | `f8c5016550229f5819401177cc006a4dea9b73c918aa500385a1a7dc9c3ef92f` |
| `AscendantRoute/GroundingModel.olean` | `3cb8b95eee93ddead473e09f05edfa0f1dd1648f69eec640c93525627b02d3b6` |
| `AscendantRoute/PublicCertificateAudit.olean` | `96ae1bd2bdd0e8df2ca9c18a7422ae08d047fd3ac5b3ac18597b9f396b77aa4c` |
| `HyperModal.olean` | `fe838066bae6b4d7f60fd0fb75f69ac40a9e5b0694e3ccc02cddab29f1a4129c` |
