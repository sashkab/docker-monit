FROM alpine:3.14

LABEL maintainer="github@compuix.com" version="2021.07.09" description="Monit monitoring service."

COPY run_monit.sh /usr/bin/run_monit.sh

# Certifacates are from https://letsencrypt.org/certificates/
COPY lets-encrypt-e1.pem \
     lets-encrypt-e2.pem \
     lets-encrypt-r3-cross-signed.pem \
     lets-encrypt-r4-cross-signed.pem  /usr/local/share/ca-certificates/

RUN set -xe \
    && apk add --no-cache monit tzdata bash ca-certificates \
    && ln -sfn /usr/share/zoneinfo/America/New_York /etc/localtime \
    && mkdir -p /monit/run \
    && monit -t \
    && rm /etc/monitrc \
    && chmod +x /usr/bin/run_monit.sh \
    && update-ca-certificates

VOLUME [ "/monit" ]

CMD [ "/usr/bin/run_monit.sh" ]
