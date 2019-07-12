FROM alpine:3.10.1

LABEL \
    maintainer="github@compuix.com" \
    version="2019.05.10" \
    description="Monit monitoring service."

COPY monitrc /etc/monitrc.new
RUN set -xe \
    && apk add --nocache monit tzdata \
    && ln -sfn /usr/share/zoneinfo/America/New_York /etc/localtime \
    && mkdir -p /monit/run \
    && mv /etc/monitrc.new /etc/monitrc \
    && chmod 0600 /etc/monitrc \
    && monit -t

VOLUME [ "/monit" ]

CMD ["/usr/bin/monit", "-I", "-B"]
