# **postgres**
___

### Description

This image runs [*PostgreSQL*](https://www.postgresql.org/) on a Debian Jessie Linux distribution.

The image extends the official [*PostgreSQL*](https://hub.docker.com/_/postgres/) one, adding the support for the [*Bottled Water*](https://github.com/confluentinc/bottledwater-pg)  extension.

The *latest* tag of this image is build with the [latest stable](https://www.postgresql.org/) release of PostgreSQL.

You can pull it with:

    docker pull mcapitanio/postgres


You can also find other images based on different PostgreSQL releases, using a different tag in the following form:

    docker pull mcapitanio/postgres:[postgres-release]


For example, if you want PostgreSQL release 9.4 you can pull the image with:

    docker pull mcapitanio/postgres:9.4

Run with Docker Compose:

    docker-compose -p docker up

Setting the project name to *docker* with the **-p** option is useful to share the named data volumes created with the containers coming from other docker-compose.yml configurations of mine (for example the one of the [*Apache Hive Docker image*](https://hub.docker.com/r/mcapitanio/hive/) or [Apache Hue Docker image](https://hub.docker.com/r/mcapitanio/hue/).

The PostgreSQL port on the host is remapped to **15432** so you can connect to PostgreSQL using:

    hostname: localhost
    port: 15432
    username: postgres
    password: postgres

There is one named volumes defined:

- **postgres_data** wich points to PGDATA


### Available tags:

- PostgreSQL 9.5 ([9.5](https://github.com/mcapitanio/docker-postgres/blob/9.5/Dockerfile), [latest](https://github.com/mcapitanio/docker-postgres/blob/latest/Dockerfile))
