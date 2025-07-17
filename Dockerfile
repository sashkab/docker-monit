FROM alpine:3.22.1

LABEL \
    maintainer="github@compuix.com"\
    version="2025.07.16" \
    description="Monit monitoring service."

COPY run_monit.sh /usr/bin/run_monit.sh

RUN set -xe \
    && apk add --no-cache monit tzdata bash ca-certificates fping \
    && ln -sfn /usr/share/zoneinfo/America/New_York /etc/localtime \
    && mkdir -p /monit/run \
    && monit -t \
    && rm /etc/monitrc \
    && chmod +x /usr/bin/run_monit.sh \
    && wget -q -P /usr/local/share/ca-certificates/ \
    https://letsencrypt.org/certs/2024/e5.pem \
    https://letsencrypt.org/certs/2024/e5-cross.pem \
    https://letsencrypt.org/certs/2024/e6.pem \
    https://letsencrypt.org/certs/2024/e6-cross.pem \
    https://letsencrypt.org/certs/2024/r10.pem \
    https://letsencrypt.org/certs/2024/r11.pem \
    && update-ca-certificates
VOLUME [ "/monit" ]

CMD [ "/usr/bin/run_monit.sh" ]

# Let's Encrypt Certiciates - https://letsencrypt.org/certificates/
