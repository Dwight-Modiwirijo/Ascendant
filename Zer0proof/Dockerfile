FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG ASCENDANT_COMMIT=unknown

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    coreutils \
    curl \
    findutils \
    g++ \
    gcc \
    git \
    libc6-dev \
    make \
    python3 \
    python3-venv \
    unzip \
    xz-utils \
    zstd \
  && rm -rf /var/lib/apt/lists/*

ENV ELAN_HOME=/root/.elan
ENV FORMAL_STATUS_GIT_COMMIT=${ASCENDANT_COMMIT}
ENV PATH=/root/.elan/bin:/workspace/Zer0proof/.lake/build/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
  | sh -s -- -y --no-modify-path --default-toolchain none

WORKDIR /workspace/Zer0proof
COPY . .

# Keep the shipped distribution aside before the pipeline regenerates it, then
# byte-compare. Without this the image would only prove that the sources build
# on Linux; with it, the image proves that the .olean files published in the
# repository are exactly what those sources produce. That is the claim a
# stranger actually needs to check, and it fails the build if it ever stops
# holding.
RUN elan toolchain install "$(tr -d '\r\n' < lean-toolchain)" \
  && (lake exe cache get || true) \
  && cp -a dist /published-dist \
  && PYTHON_BIN=python3 bash scripts/verify-published.sh \
  && lake build \
  && PYTHON_BIN=python3 bash scripts/ci.sh \
  && diff -r /published-dist dist \
  && echo "[VERIFY] published distribution reproduced byte-for-byte on this platform"

CMD ["/bin/bash"]
