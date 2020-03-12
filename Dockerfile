FROM alpine:3.11

LABEL maintainer="github@compuix.com" version="2020.03.11" description="Monit monitoring service."

COPY run.sh /usr/bin/run.sh

RUN set -xe \
    && apk add --no-cache monit tzdata bash \
    && ln -sfn /usr/share/zoneinfo/America/New_York /etc/localtime \
    && mkdir -p /monit/run \
    && monit -t \
    && rm /etc/monitrc \
    && chmod +x /usr/bin/run.sh

VOLUME [ "/monit" ]

CMD ["/usr/bin/run.sh"]
