#!/usr/bin/env bash
set -euo pipefail

# — Required environment variables
: "${ETHEREUM_HOSTS?Need to set ETHEREUM_HOSTS}"
: "${VALIDATOR_PRIVATE_KEY?Need to set VALIDATOR_PRIVATE_KEY}"
: "${COINBASE?Need to set COINBASE}"
: "${STAKING_ASSET_HANDLER?Need to set STAKING_ASSET_HANDLER (build arg)}"
: "${L1_CHAIN_ID?Need to set L1_CHAIN_ID (build arg)}"

echo "[INFO - entrypoint] Attempting to register as a validator..."
echo "[INFO - entrypoint] This may fail if today's validator quota has been reached. If so, try again later."

# Build flags as an array
FLAGS=(
  add-l1-validator
  --l1-rpc-urls "$ETHEREUM_HOSTS"
  --private-key "$VALIDATOR_PRIVATE_KEY"
  --attester "$COINBASE"
  --proposer-eoa "$COINBASE"
  --staking-asset-handler "$STAKING_ASSET_HANDLER"
  --l1-chain-id "$L1_CHAIN_ID"
)

# Log final command for visibility
echo "[INFO - entrypoint] Running: node /usr/src/yarn-project/aztec/dest/bin/index.js ${FLAGS[*]}"

# Retry logic
while true; do
  # Execute command safely
  if node --no-warnings /usr/src/yarn-project/aztec/dest/bin/index.js "${FLAGS[@]}"; then
    echo "[INFO - entrypoint] Validator registration successful."
    break
  else
    echo "[ERROR - entrypoint] Validator registration failed. Retrying in 24 hours..."
    sleep 24h
  fi
done
