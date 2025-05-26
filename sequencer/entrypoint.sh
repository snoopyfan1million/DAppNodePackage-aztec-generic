#!/usr/bin/env bash
set -euo pipefail

# — Required environment variables
: "${ETHEREUM_HOSTS?Need to set ETHEREUM_HOSTS}"
: "${L1_CONSENSUS_HOST_URLS?Need to set L1_CONSENSUS_HOST_URLS}"
: "${VALIDATOR_PRIVATE_KEY?Need to set VALIDATOR_PRIVATE_KEY}"
: "${COINBASE?Need to set COINBASE}"
: "${_DAPPNODE_GLOBAL_PUBLIC_IP?Need to set _DAPPNODE_GLOBAL_PUBLIC_IP (your public IP)}"
: "${NETWORK?Need to set NETWORK (build arg)}"

# — Build the command array
FLAGS=(
  start
  --network "$NETWORK"
  --l1-rpc-urls "$ETHEREUM_HOSTS"
  --l1-consensus-host-urls "$L1_CONSENSUS_HOST_URLS"
  --sequencer.validatorPrivateKey "$VALIDATOR_PRIVATE_KEY"
  --sequencer.coinbase "$COINBASE"
  --p2p.p2pIp "$_DAPPNODE_GLOBAL_PUBLIC_IP"
)

# — Add optional flags if set
if [[ -n "${BLOB_SINK_URL:-}" ]]; then
  FLAGS+=(--blob-sink "$BLOB_SINK_URL")
fi

if [[ -n "${SEQ_MIN_TX_BLOCK:-}" ]]; then
  FLAGS+=(--seqMinTxBlock "$SEQ_MIN_TX_BLOCK")
fi

if [[ -n "${SEQ_MAX_TX_BLOCK:-}" ]]; then
  FLAGS+=(--seqMaxTxBlock "$SEQ_MAX_TX_BLOCK")
fi

# — Append fixed mode flags
FLAGS+=(--archiver --node --sequencer)

# — Print for debugging
echo "[INFO - entrypoint] Starting sequencer with flags:"
printf '  %q\n' "${FLAGS[@]}"

# — Execute the command
exec node --no-warnings /usr/src/yarn-project/aztec/dest/bin/index.js "${FLAGS[@]}"
