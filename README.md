# docker-gminer

![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/thelolagemann/gminer?style=flat-square)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/thelolagemann/docker-gminer/Build%20and%20publish%20docker%20image?style=flat-square)
![Gminer version](https://img.shields.io/badge/gminer-v2.75-blue?style=flat-square)

A docker container for quickly getting up and running with gminer.

## Table of Contents
* [Quick Start](#quick-start)
* [Environment Variables](#environment-variables)
* [Docker Compose](#docker-compose)
* [Building](#building)

## Quick start

**NOTE**: The command provided is an example and should be adjusted for your needs.

Launch the miner with the following command:

```bash
docker run -d \
  --name="gminer" \
  --gpus=all \
  -e WALLET_ADDRESS="88yUzYzB9wrR2r2o1TzXxDMENr6Kbadr3caqKTBUNFZ3dWVt6sJcpWBAwMwNRtEi7nHcBcqzmExNfdNK7ughaCeUFuXXpPp" \
  -e MINING_ALGO="ethash" \
  -e MINING_POOL="gulf.moneroocean.stream:11024" \
  --restart=always \
  thelolagemann/gminer:latest
```

| **Parameter** |  **Description** |
| --- | --- |
| `-d` | Run the container in the background. If not set, the container runs in the foreground. |
| `-e` | Pass an environment variable to the container. See the [Environment Variables](#env) section for more details. |
| `-v` | Set a volume mapping (allows to share a folder between the host and the container). See the [Data Volumes](#volumes) section for more details |
| `-p` | Set a network port mapping (exposes an internal container port to the host). See the [Ports](#ports) section for more details |

## Environment variables

| **Variable** | **Description** | **Default** |
| --- | --- | --- |
| `RIG_NAME` | Name used to identify the mining rig. | Randomly generated |
| `WALLET_ADDRESS` | The wallet to payout to. | (unset) |
| `MINING_ALGO` | Mining algo to use. | `ethash` |
| `MINING_POOL` | URL of the mining pool to connect to. | `gulf.moneroocean.stream:11024` |
| `PROTO` | Mining protocol to use. | `stratum` |

## Docker Compose

Here is an example of a `docker-compose.yml` file that can be used with [docker-compose](#https://docs.docker.com/compose).

**NOTE**: Make sure to adjust the configuration according to your needs.

```yaml
version: "3.9"
services:
  xmrig-mo:
    image: thelolagemann/gminer
    environment:
      - MINING_ALGO: "ethash"
      - MINING_POOL: "gulf.moneroocean.stream:11024"
      - RIG_NAME: "gpu~ethash"
      - WALLET_ADDRESS: "88yUzYzB9wrR2r2o1TzXxDMENr6Kbadr3caqKTBUNFZ3dWVt6sJcpWBAwMwNRtEi7nHcBcqzmExNfdNK7ughaCeUFuXXpPp"
    deploy:
      resources:
        reservations:
          devices:
            - capabilities: [gpu]
```

## Building
In order to build the container run the command.

```bash
docker build -f Dockerfile .
```

When building docker containers, you can pass build arguments with the `--build-arg` flag. Listed below are the available
build arguments you can pass during build.

| Argument | Description | Default |
| --- | --- | --- |
| `GMINER_VERSION` | The version of gminer to build the container with. | `2.75` |

## License

This project is licensed under the MIT license - see the [LICENSE](https://github.com/thelolagemann/docker-gminer/blob/main/LICENSE) file for details