# Private certificate policy

The public distribution does not accept or ship private theorem-bearing Lean
assemblies. In particular, no private successor implementation, private proof
source, or compiled private proof tree belongs in this directory.

The public strong Omega results are rebuilt from source through
`AltRoute.GroundingChain`; `AltRoute.GroundingModel` supplies the public
satisfiability witness. Any private successor route uses a separate internal CI
and may publish only non-proof-bearing high-level metadata.

`scripts/ci.sh` packages an explicit public allow-list. The resulting `dist/`
is then checked by `scripts/check-public-dist.sh`, including a binary symbol
scan and the no-export test in the actually shipped Lean environment.