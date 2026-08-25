import Lake
open Lake DSL

package tiRelease

@[default_target]
lean_lib TIRelease where
  roots := #[
    `AscendantRoute.Release.TI.TIAPI,
    `AscendantRoute.Release.TI.TIModel,
    `AscendantRoute.Release.TI.TICertificate,
  ]
