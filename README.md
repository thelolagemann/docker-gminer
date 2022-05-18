# docker-gminer

![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/thelolagemann/gminer?style=flat-square)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/thelolagemann/docker-gminer/Build%20and%20publish%20docker%20image?style=flat-square)
![Gminer version](https://img.shields.io/badge/gminer-v2.96-blue?style=flat-square)

A docker container for quickly getting up and running with gminer.

## Table of Contents
* [Requirements](#requirements)
  * [AMD](#amd)
  * [NVIDIA](#nvidia)
* [Quick Start](#quick-start)
* [Environment Variables](#environment-variables)
* [Docker Compose](#docker-compose)
* [Building](#building)

## Requirements

### AMD

AMD GPUs are currently unsupported. See issue [#1](https://github.com/thelolagemann/docker-gminer/issues/1)

### NVIDIA

* [nvidia-drivers](https://www.nvidia.com/en-us/drivers/unix/) >= 418.81.07
* [nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)

#### CUDA
  
Ensure you have the correct nvidia-drivers installed, and then run `nvidia-smi` in order to check your currently
supported CUDA version. For example, 11.4 => `thelolagemann/gminer:latest-cuda-11.4.3`. Currently, images are 
automatically generated on each new gminer release, for CUDA versions

- 9.2
- 10.2
- 11.2.2
- 11.3.1
- 11.4.3
- 11.5.1
- 11.6.0

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
  -e DWALLET_ADDRESS="EQDMgD4Gz-FEEgeQMEq24a3-2qE857yrlnvVngEP6obQJ8t3" \
  -e DMINING_ALGO="ton" \
  -e DMINING_POOL="wss://pplns.toncoinpool.io/stratum"
  --restart=always \
  thelolagemann/gminer:latest-cuda-11.6.0
```

| **Parameter** | **Description**                                                                                                                  |
|---------------|----------------------------------------------------------------------------------------------------------------------------------|
| `-d`          | Run the container in the background. If not set, the container runs in the foreground.                                           |
| `-e`          | Pass an environment variable to the container. See the [Environment Variables](#environment-variables) section for more details. |

## Environment variables

| **Variable**      | **Description**                            | **Default**                          |
|-------------------|--------------------------------------------|--------------------------------------|
| `RIG_NAME`        | Name used to identify the mining rig.      | Randomly generated                   |
| `WALLET_ADDRESS`  | The wallet to payout to.                   | (unset)                              |
| `MINING_ALGO`     | Mining algo to use.                        | `ethash`                             |
| `MINING_POOL`     | URL of the mining pool to connect to.      | `gulf.moneroocean.stream:11024`      |
| `DMINING_ALGO`    | Dual mining algo to use                    | `ton`                                |
| `DMINING_POOL`    | URL of the dual mining pool to connect to. | `wss://pplns.toncoinpool.io/stratum` | 
| `DWALLET_ADDRESS` | The wallet to payout to for dual mining.   | (unset)                              |

## Docker Compose

Here is an example of a `docker-compose.yml` file that can be used with [docker-compose](#https://docs.docker.com/compose).

**NOTE**: Make sure to adjust the configuration according to your needs.

```yaml
version: "3.9"
services:
  gminer:
    image: thelolagemann/gminer:latest-cuda-11.6.0
    environment:
      MINING_ALGO: "ethash"
      MINING_POOL: "gulf.moneroocean.stream:11024"
      DMINING_ALGO: "ton"
      DMINING_POOL: "wss://pplns.toncoinpool.io/stratum"
      DWALLET_ADDRESS: "EQDMgD4Gz-FEEgeQMEq24a3-2qE857yrlnvVngEP6obQJ8t3"
      RIG_NAME: "gpu~ethash"
      WALLET_ADDRESS: "88yUzYzB9wrR2r2o1TzXxDMENr6Kbadr3caqKTBUNFZ3dWVt6sJcpWBAwMwNRtEi7nHcBcqzmExNfdNK7ughaCeUFuXXpPp"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

## Building
In order to build the container run the command.

```shell
docker build .
```

When building docker containers, you can pass build arguments with the `--build-arg` flag. Listed below are the available
build arguments you can pass during build.

| Argument         | Description                                              | Default  |
|------------------|----------------------------------------------------------|----------|
| `GMINER_VERSION` | The version of gminer to build the container with.       | `2.96`   |
| `CUDA_BASE`      | The version of CUDA to build the container with.         | `11.6.0` |
| `UBUNTU_VERSION` | Ubuntu OS base container version.<sup>[1](#ubuntu)</sup> | `20.04`  |

<sup><a name="ubuntu">1</a>: Check NVIDIA's [dockerhub](https://hub.docker.com/r/nvidia/cuda/tags?page=1&name=-runtime-ubuntu)
to correctly match up the CUDA and Ubuntu versions.</sup>

For example, to build a container with cuda version 11.6.0 and gminer 2.96, run the command

```shell
docker build --build-arg GMINER_VERSION=2.96 --build-arg CUDA_BASE=11.6.0 .
```

## License

This project is licensed under the MIT license - see the [LICENSE](https://github.com/thelolagemann/docker-gminer/blob/main/LICENSE) file for details