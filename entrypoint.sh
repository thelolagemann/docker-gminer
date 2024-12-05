#!/bin/sh
export RIG_NAME=${RIG_NAME:-$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8 ; echo '')'~'${MINING_ALGO}}
/gminer/miner --algo $MINING_ALGO --server "$MINING_POOL" --user "${WALLET_ADDRESS:-"88yUzYzB9wrR2r2o1TzXxDMENr6Kbadr3caqKTBUNFZ3dWVt6sJcpWBAwMwNRtEi7nHcBcqzmExNfdNK7ughaCeUFuXXpPp"}" \
  --pass "$RIG_NAME" --proto stratum