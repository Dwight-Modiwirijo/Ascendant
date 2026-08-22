FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

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
ENV PATH=/root/.elan/bin:/workspace/Zer0proof/.lake/build/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
  | sh -s -- -y --no-modify-path --default-toolchain none

WORKDIR /workspace/Zer0proof
COPY . .

RUN elan toolchain install "$(tr -d '\r\n' < lean-toolchain)" \
  && (lake exe cache get || true) \
  && lake build \
  && PYTHON_BIN=python3 bash scripts/ci.sh

CMD ["/bin/bash"]
