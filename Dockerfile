FROM alpine:3.12 as builder
RUN apk add curl tar
ARG GMINER_VERSION=2.86
RUN echo https://github.com/develsoftware/GMinerRelease/releases/download/${GMINER_VERSION}/gminer_${GMINER_VERSION/./_}_linux64.tar.xz
RUN curl -L "https://github.com/develsoftware/GMinerRelease/releases/download/${GMINER_VERSION}/gminer_${GMINER_VERSION/./_}_linux64.tar.xz" > gminer.tar.gz
RUN mkdir /gminer && tar -xf gminer.tar.gz -C /gminer

FROM nvidia/cuda:11.2.2-runtime-ubuntu20.04
COPY --from=builder /gminer /gminer
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh
ENV MINING_ALGO="ethash" \
    MINING_POOL="gulf.moneroocean.stream:11024" \
    DMINING_ALGO="ton" \
    DMINING_POOL="wss://pplns.toncoinpool.io/stratum"

CMD "/entrypoint.sh"
