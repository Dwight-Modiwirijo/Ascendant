import Lake
open Lake DSL

package «Zer0proof» where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.20.1" -- match toolchain


@[default_target] lean_lib AltRoute where
  roots := #[`AltRoute.Interface,
  `AltRoute.PublicTests,
  `AltRoute.PublicCertificateAudit
  ]

lean_lib VacuousCanaries where
  roots := #[`scripts.VacuousTruth, `scripts.VacuousIAm]

lean_lib StrongCertificateAudit where
  roots := #[`AltRoute.CertificateAudit]

-- negative guard: this build MUST fail in CI
lean_lib NoExport_NecessaryExistence where
  roots := #[`tests.NoExport_NecessaryExistence]

-- negative guard: the historical hostile Positive Empty instance MUST fail
lean_lib Reject_HostilePositiveEmpty where
  roots := #[`tests.Reject_HostilePositiveEmpty]

-- negative guard: a modal structure with `Dia := False` MUST fail
lean_lib Reject_HostileModal where
  roots := #[`tests.Reject_HostileModal]

-- negative guard: even a fully supplied hostile Positive instance is impossible
lean_lib Reject_ForcedPositiveEmpty where
  roots := #[`tests.Reject_ForcedPositiveEmpty]

-- negative guard: `Dia := False` cannot satisfy Box/Dia duality
lean_lib Reject_ForcedHostileModal where
  roots := #[`tests.Reject_ForcedHostileModal]

-- Private library (no default_target; not built in public CI)
lean_lib AltRoutePrivate where
  roots := #[
    `AltRoute.Private.AltRoutePrivate,
    `AltRoute.Private.Successor.Types,
    `AltRoute.Private.Successor.Bridge,
    `AltRoute.Private.Successor.Chain
  ]
