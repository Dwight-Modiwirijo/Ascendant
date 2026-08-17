import Lake
open Lake DSL

package «Zer0proof» where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.20.1" -- match toolchain


@[default_target] lean_lib AltRoute where
  roots := #[`AltRoute.Interface,
  `AltRoute.PublicTests,
  `AltRoute.TargetTypes,
  `AltRoute.GroundingAudit,
  `AltRoute.GroundingChain,
  `AltRoute.GroundingChainAudit,
  `AltRoute.GroundingModel,
  `superlaw,
  `AltRoute.PublicCertificateAudit
  ]

lean_lib VacuousCanaries where
  roots := #[`scripts.VacuousTruth, `scripts.VacuousIAm]


-- negative guard: this build MUST fail in CI
lean_lib NoExport_NecessaryExistence where
  roots := #[`tests.NoExport_NecessaryExistence]

-- negative guard: the historical hostile Positive Empty instance MUST fail
lean_lib Reject_HostilePositiveEmpty where
  roots := #[`tests.Reject_HostilePositiveEmpty]

-- negative guard: a reflexive/transitive frame without symmetry MUST fail
lean_lib Reject_HostileModal where
  roots := #[`tests.Reject_HostileModal]

-- negative guard: even a fully supplied hostile Positive instance is impossible
lean_lib Reject_ForcedPositiveEmpty where
  roots := #[`tests.Reject_ForcedPositiveEmpty]

-- negative guard: the hostile preorder cannot satisfy symmetry
lean_lib Reject_ForcedHostileModal where
  roots := #[`tests.Reject_ForcedHostileModal]

-- modal-collapse regressions: these historical theorem shapes MUST fail
lean_lib Reject_BoxCollapse where
  roots := #[`tests.Reject_BoxCollapse]

lean_lib Reject_DiaCollapse where
  roots := #[`tests.Reject_DiaCollapse]

lean_lib Reject_NoContingency where
  roots := #[`tests.Reject_NoContingency]

lean_lib Reject_CertificateCollapse where
  roots := #[`tests.Reject_CertificateCollapse]
