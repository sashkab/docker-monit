FROM alpine:3.18.5

LABEL \
    maintainer="github@compuix.com"\
    version="2023.11.30" \
    description="Monit monitoring service."

COPY run_monit.sh /usr/bin/run_monit.sh

RUN set -xe \
    && apk add --no-cache monit tzdata bash ca-certificates \
    && ln -sfn /usr/share/zoneinfo/America/New_York /etc/localtime \
    && mkdir -p /monit/run \
    && monit -t \
    && rm /etc/monitrc \
    && chmod +x /usr/bin/run_monit.sh \
    && wget -q -P /usr/local/share/ca-certificates/ \
        https://letsencrypt.org/certs/lets-encrypt-r3.pem \
        https://letsencrypt.org/certs/lets-encrypt-r3-cross-signed.pem \
        https://letsencrypt.org/certs/lets-encrypt-e1.pem \
        https://letsencrypt.org/certs/lets-encrypt-r4.pem \
        https://letsencrypt.org/certs/lets-encrypt-r4-cross-signed.pem \
        https://letsencrypt.org/certs/lets-encrypt-e2.pem  \
    && update-ca-certificates
VOLUME [ "/monit" ]

CMD [ "/usr/bin/run_monit.sh" ]
