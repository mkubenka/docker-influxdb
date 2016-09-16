FROM influxdb:1.0
MAINTAINER Michal Kubenka <mkubenka@gmail.com>

RUN mkdir /docker-entrypoint-initdb.d

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["influxd"]
