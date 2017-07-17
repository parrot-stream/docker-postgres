# **postgres**
___

### Description

This image runs [*PostgreSQL*](https://www.postgresql.org/) on a Debian Jessie Linux distribution.

The image extends the official [*PostgreSQL*](https://hub.docker.com/_/postgres/) one, adding the support for:

 * the [*Debezium Postgres Decoderbufs*](https://github.com/debezium/postgres-decoderbufs.git) plugin

The *latest* tag of this image is build with the [latest stable](https://www.postgresql.org/) release of PostgreSQL.

You can pull it with:

    docker pull mcapitanio/postgres


You can also find other images based on different PostgreSQL releases, using a different tag in the following form:

    docker pull mcapitanio/postgres:[postgres-release]


For example, if you want the latest PostgreSQL major release 9.5 (actually 9.5.7) you can pull the image with:

    docker pull mcapitanio/postgres:9.5

Run with Docker Compose:

    docker-compose up

You can access PostgreSql using:

    hostname: localhost
    port:     5432
    username: postgres
    password: postgres

### Available tags:

- PostgreSQL 9.6 ([9.6](https://github.com/mcapitanio/docker-postgres/blob/9.6/Dockerfile), [latest](https://github.com/mcapitanio/docker-postgres/blob/latest/Dockerfile))
- PostgreSQL 9.5 ([9.5](https://github.com/mcapitanio/docker-postgres/blob/9.5/Dockerfile))
