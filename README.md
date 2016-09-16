# InfluxDB [![Build Status](https://travis-ci.org/mkubenka/docker-influxdb.svg?branch=master)](https://travis-ci.org/mkubenka/docker-influxdb)

Docker image for [InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/).

## Initializing a fresh instance
When a container is started for the first time, it will execute files with extensions `.sh` and `.influxql` that are found in `/docker-entrypoint-initdb.d`. Files will be executed in alphabetical order.

