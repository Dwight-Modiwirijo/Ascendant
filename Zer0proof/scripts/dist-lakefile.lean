import Lake
open Lake DSL

package «Zer0proofWorldIndexedCertificate» where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.20.1"

@[default_target] lean_lib CertificateSurface where
  roots := #[`AltRoute.TargetTypes, `AltRoute.GroundingAudit, `superlaw,
    `AltRoute.PublicCertificateAudit, `AltRoute.CertificateAudit]
