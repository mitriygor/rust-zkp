FROM rust:1.71.1

WORKDIR /zkp-server

COPY . .

RUN apt update
RUN apt install -y protobuf-compiler

RUN cargo build --release --bin server --bin client