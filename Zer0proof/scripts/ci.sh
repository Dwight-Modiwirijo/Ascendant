#!/usr/bin/env bash
set -euo pipefail

echo "[CI] Versions"
lean --version || true
lake --version || true

echo "[CI] Build"
lake build

echo "[CI] Package"
rm -rf dist && mkdir -p dist
# kopieer alleen publieke .olean (geen tests)
find .lake/build/lib/lean/AltRoute -maxdepth 1 -type f -name '*.olean' ! -name '*PublicTests*' -exec cp {} dist/ \;
# metadata
cp AltRoute/Interface.lean README.md LICENSE lean-toolchain lakefile.lean dist/
( cd dist && sha256sum * > SHA256SUMS && sha256sum -c SHA256SUMS )

echo "[CI] Done"
