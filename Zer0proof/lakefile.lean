import Lake
open Lake DSL

package «Zer0proof» where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.20.1" -- match toolchain


@[default_target] lean_lib AltRoute where
  roots := #[`AltRoute.Interface, `AltRoute.PublicTests, `AltRoute.CertificateAudit]

-- negative guard: this build MUST fail in CI
lean_lib NoExport_NecessaryExistence where
  roots := #[`tests.NoExport_NecessaryExistence]

-- Private library (no default_target; not built in public CI)
lean_lib AltRoutePrivate where
  roots := #[
    `AltRoute.Private.AltRoutePrivate,
    `AltRoute.Private.Successor.Types,
    `AltRoute.Private.Successor.Bridge,
    `AltRoute.Private.Successor.Chain
  ]
