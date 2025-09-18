ARG UPSTREAM_VERSION

FROM aztecprotocol/aztec:2.0.2

ENV NETWORK=testnet
ENV DATA_DIRECTORY=/data

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# NO necessitem lz4 ni wget
# RUN apt-get update && apt-get install -y lz4 wget

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
