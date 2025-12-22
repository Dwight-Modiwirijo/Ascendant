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
    `AltRoute.Private.Successor.Chain,
    `AltRoute.Private.Omega.Def,
    `AltRoute.Private.Omega.FromSuccessor,
    `AltRoute.Private.BridgeOmegaNE,
    `AltRoute.Private.Bridge_NecPossible,
    `AltRoute.Private.SwapOmega,
    `AltRoute.S5.Brouwer,
    `AltRoute.Private.Omega.Swap,
    `AltRoute.Private.Omega.Swap_Wire,
    `AltRoute.Private.Omega.Rigidity,
    `AltRoute.Private.Omega.ExistPlain,
    `AltRoute.Private.Omega.Rigidity_Wire,
    `AltRoute.Private.Omega.NE_Final,
    `AltRoute.Private.Omega.NE_Run,
    `AltRoute.Private.Omega.Swap_Instantiate,
    `AltRoute.Private.Omega.NE_Assemble,
    `AltRoute.Private.Omega.EOmega,
    `AltRoute.Private.Omega.Uniqueness,
    `AltRoute.Private.Omega.Uniqueness_Axiom,
    `AltRoute.Private.Omega.Uniq0_AssumeOrProve,
    `AltRoute.Private.Omega.Uniq0_FromFix,
    `AltRoute.Private.Omega.Exports,
    `AltRoute.Private.Omega.ZeroFix,
    `AltRoute.Private.Omega.ZeroCoalesce,
    `AltRoute.Private.Omega.Rigidity_FromChain,
    `AltRoute.Private.Omega.Uniqueness_Final,
    `AltRoute.Private.Omega.Uniqueness_Axiom,
    `AltRoute.Final.Assemble,
    `AltRoute.S5.Helpers
  ]
