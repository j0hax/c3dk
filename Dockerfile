FROM debian:bookworm AS build

RUN apt-get -y update && apt-get -y install autoconf automake autotools-dev curl python-is-python3 python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev

RUN git clone https://github.com/riscv/riscv-gnu-toolchain

WORKDIR riscv-gnu-toolchain

RUN ./configure --prefix=/opt/riscv --with-multilib-generator="rv32imc_zicsr-ilp32--" && make -j$(nproc)

FROM debian:bookworm

RUN apt-get -y update && apt-get -y install libmpc3

COPY --from=build /opt/riscv /opt/riscv

ENV PATH="$PATH:/opt/riscv/bin"
