FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    python3 \
    python3-pip \
    libgmp-dev \
    libmpfr-dev \
    libmpc-dev \
    texinfo \
    libisl-dev \
    libz-dev \
    ninja-build \
    wget \
    ca-certificates \
    pkg-config \
    bison \
    flex \
    gawk \ 
    && rm -rf /var/lib/apt/lists/*

# Build RISC-V GNU Toolchain (bare-metal)
RUN git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git /opt/riscv-gnu-toolchain && \
    cd /opt/riscv-gnu-toolchain && \
    ./configure --prefix=/opt/riscv --with-arch=rv64gc --with-abi=lp64 --enable-multilib && \
    make -j2 newlib

ENV PATH="/opt/riscv/bin:$PATH"
WORKDIR /work/tests
