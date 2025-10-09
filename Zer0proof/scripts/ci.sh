#!/usr/bin/env bash
set -euo pipefail

echo "[CI] Versions"
lean --version || true
lake --version || true

echo "[CI] Clean build"
rm -rf .lake _lake dist
lake update
lake build

echo "[CI] Package"
mkdir -p dist
# kopieer alleen publieke .olean (géén tests)
find .lake/build/lib/lean/AltRoute -maxdepth 1 -type f -name '*.olean' ! -name '*PublicTests*' -exec cp {} dist/ \;

# metadata die je wilt meeleveren
cp AltRoute/Interface.lean README.md LICENSE lean-toolchain lakefile.lean dist/

( cd dist && sha256sum * > SHA256SUMS && sha256sum -c SHA256SUMS >/dev/null )

echo "[CI] Done ✅"
