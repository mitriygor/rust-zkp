# Zero-Knowledge Proof (ZKP) in Rust with gRPC

## Overview

This project implements a Zero-Knowledge Proof (ZKP) authentication system using gRPC in Rust. The system allows clients to register and authenticate securely without revealing their secret information. The server and client applications are containerized using Docker for easy deployment and isolation.

## Components

- `lib.rs`: Contains the implementation of the ZKP algorithm in Rust.
- `server.rs`: Implements the gRPC server that handles registration, challenge creation, and verification of the ZKP.
- `client.rs`: A gRPC client that interacts with the server for registration and authentication.
- `zkp_auth.proto`: Protocol Buffers file defining the gRPC service and messages.
- `Dockerfile`: Instructions for building the Docker image for the server and client.
- `docker-compose.yaml`: Configuration for deploying the server using Docker Compose.

## Prerequisites

- Docker
- Docker Compose

## Building and Running

### Server

1. **Build the Docker Image**:
   ```bash
   docker-compose build
   ```

2. **Run the Server**:
   ```bash
   docker-compose up
   ```

   This will start the ZKP server on `127.0.0.1:50051`.

### Client

After starting the server, you can run the client to interact with the server:

1. **Enter the Docker Container**:
   ```bash
   docker exec -it zkpserver /bin/bash
   ```

2. **Run the Client**:
   ```bash
   cargo run --bin client
   ```

   Follow the on-screen prompts to register and authenticate.

## How It Works

### Registration

- The client sends `y1 = alpha^x mod p` and `y2 = beta^x mod p` to the server.
- The server stores this information associated with the user.

### Authentication

1. **Challenge Request**: The client asks for a challenge, sending `r1 = alpha^k mod p` and `r2 = beta^k mod p`.
2. **Challenge Response**: The server responds with a challenge `c`.
3. **Solution Submission**: The client computes and sends the solution `s = k - c * x mod q`.
4. **Verification**: The server verifies the solution and, if correct, responds with a session ID.

## Testing

Unit tests for the ZKP implementation are included in `lib.rs`. Run these tests to ensure the correctness of the ZKP algorithm:

```bash
cargo test
```

## Notes

- Ensure Docker is properly installed and configured on your system.
- The `docker-compose.yaml` file can be modified to change configuration settings like port numbers.
- For production deployment, consider securing the gRPC communication using SSL/TLS.