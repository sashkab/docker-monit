FROM alpine:3.12

LABEL maintainer="github@compuix.com" version="2021.01.01" description="Monit monitoring service."

COPY run_monit.sh /usr/bin/run_monit.sh
COPY letsencrypt.txt /usr/local/share/ca-certificates/letsencrypt.crt

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
