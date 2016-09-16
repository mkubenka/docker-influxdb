#!/bin/bash
set -eo pipefail

if [ "${1:0:1}" = '-' ]; then
  set -- influxd "$@"
fi

# https://github.com/docker-library/mysql/blob/master/5.7/docker-entrypoint.sh

if [ "$1" = 'influxd' ]; then
  DATADIR="/var/lib/influxdb/data"

  if [ ! -d "$DATADIR" ]; then
    echo 'Initializing'

    "$@" &
    pid="$!"

    for i in {30..0}; do
      if influx -execute 'SHOW DATABASES' &> /dev/null; then
        break
      fi
      echo 'InfluxDB init process in progress...'
      sleep 1
    done

    echo
    for f in /docker-entrypoint-initdb.d/*; do
      case "$f" in
        *.sh)         echo "$0: running $f"; . "$f" ;;
        *.influxql)   echo "$0: running $f"; influx -import -path="$f"; echo ;;
        *)            echo "$0: ignoring $f" ;;
      esac
      echo
    done

    if ! kill -s TERM "$pid"; then
      echo >&2 'InfluxDB init process failed.'
      exit 1
    fi

    echo
    echo 'InfluxDB init process done. Ready for start up.'
    echo
  fi
fi

exec "$@"
