ARG CUDA_BASE=12.6.3
ARG UBUNTU_VERSION=20.04

FROM alpine:latest as builder
RUN apk add curl tar xz
ARG GMINER_VERSION=3.44
RUN echo https://github.com/develsoftware/GMinerRelease/releases/download/${GMINER_VERSION}/gminer_${GMINER_VERSION/./_}_linux64.tar.xz
RUN curl -L "https://github.com/develsoftware/GMinerRelease/releases/download/${GMINER_VERSION}/gminer_${GMINER_VERSION/./_}_linux64.tar.xz" > gminer.tar.gz
RUN mkdir /gminer && tar -xf gminer.tar.gz -C /gminer

FROM nvidia/cuda:${CUDA_BASE}-base-ubuntu${UBUNTU_VERSION}
COPY --from=builder /gminer /gminer
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh
ENV MINING_ALGO="etchash" \
    MINING_POOL="gulf.moneroocean.stream:11024" 

CMD "/entrypoint.sh"
