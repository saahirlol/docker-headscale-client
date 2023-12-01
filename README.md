
# Dockerized Headscale Client

This setup provides a Dockerized client for connecting to a Headscale server, an open-source implementation of the Tailscale control server. The client is configured to connect to a specified Headscale server and supports authentication using a Tailscale auth key.

## Prerequisites

- Docker installed on your host machine.
- Docker Compose (optional, for using the Docker Compose example).
- (Optional) A Tailscale auth key for automatic authentication.

## Configuration

Configuration is managed through environment variables, allowing you to specify the Headscale server URL and an optional Tailscale auth key.

- `HEADSCALE_SERVER_URL`: The URL of your Headscale server (default is `https://controlplane.tailscale.com:443`).
- `LOGIN_KEY`: Your Tailscale auth key for automatic authentication (MANDATORY).
- `NOMBRE`: The hostname of your container (default is `docker-headscale-client`).
## Files

- `Dockerfile`: Builds the Headscale client Docker image.
- `start-tailscale.sh`: Script to initialize the Headscale client with the provided environment variables.
- `docker-compose.yml`: Docker Compose file for easy deployment (example provided below).

## Building the Docker Image

To build the Docker image, run:

```bash
docker build -t ghcr.io/saahirlol/docker-headscale-client:main .
```

## Running the Container

### Using Docker

Run the container with:

```bash
docker run -d \
    --name=my-headscale-client \
    --network=host \
    --privileged \
    --volume=./state/tailscale:/var/lib/tailscale \
    -e HEADSCALE_SERVER_URL=https://your-headscale-server-url \
    -e LOGIN_KEY=your-auth-key \
    -e NOMBRE=docker-headscale-client \
    ghcr.io/saahirlol/docker-headscale-client:main
```

Replace `https://your-headscale-server-url` with your Headscale server URL and `your-auth-key` with your Tailscale auth key.

### Using Docker Compose

Here's an example `docker-compose.yml`:

```yaml
version: '3.8'
services:
  headscale-client:
    image: ghcr.io/saahirlol/docker-headscale-client:main
    container_name: my-headscale-client
    network_mode: host
    privileged: true
    volumes:
      - ./state/tailscale:/var/lib/tailscale
    environment:
      - HEADSCALE_SERVER_URL=https://your-headscale-server-url
      - LOGIN_KEY=your-auth-key
      - NOMBRE=docker-headscale-client
```

Run with:

```bash
docker-compose up -d
```

## Security Considerations

- Running containers in privileged mode and with host networking can have security implications. Ensure this setup aligns with your security policies.
- Keep your auth key secure, especially if this configuration is part of a code repository.

## Persistence

The mounted volume (`/var/lib/tailscale`) is used to persist the client's state across container restarts.

