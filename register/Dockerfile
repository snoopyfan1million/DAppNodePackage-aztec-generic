ARG UPSTREAM_VERSION
FROM aztecprotocol/aztec:${UPSTREAM_VERSION}

# Re-declare build-time args after FROM
ARG STAKING_ASSET_HANDLER
ARG L1_CHAIN_ID
ARG ETHEREUM_HOSTS
ARG VALIDATOR_PRIVATE_KEY
ARG COINBASE

# Promote them to runtime environment variables
ENV STAKING_ASSET_HANDLER=${STAKING_ASSET_HANDLER} \
    L1_CHAIN_ID=${L1_CHAIN_ID} \
    ETHEREUM_HOSTS=${ETHEREUM_HOSTS} \
    VALIDATOR_PRIVATE_KEY=${VALIDATOR_PRIVATE_KEY} \
    COINBASE=${COINBASE}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
