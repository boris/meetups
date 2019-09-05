FROM vault:1.1.2

EXPOSE 8200

COPY config/local-config.hcl /vault/config/config.hcl

CMD vault server -config=/vault/config/config.hcl
