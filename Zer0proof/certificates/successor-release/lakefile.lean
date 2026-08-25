import Lake
open Lake DSL

package successorRelease

@[default_target]
lean_lib SuccessorRelease where
  roots := #[
    `AscendantRoute.Release.Successor.SuccessorAPI,
    `AscendantRoute.Release.Successor.SuccessorModel,
    `AscendantRoute.Release.Successor.SuccessorCertificate,
  ]
