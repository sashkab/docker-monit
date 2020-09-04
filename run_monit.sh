#!/bin/bash
set -e

rm -f /monit/run/monit.pid

if [[ "${ENABLE_MONIT}" == "true" ]]; then
    cp /etc/monitrc.new /etc/monitrc
    chmod 0600 /etc/monitrc
    chown root:wheel /etc/monitrc
    /usr/bin/monit -B -I
else
    echo "monit is disabled; exiting."
    while true; do sleep 1d; done
fi
