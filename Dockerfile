FROM postgres:10.5

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

ENV PG_MAJOR 10

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

RUN apt-get update -y; \
    apt-get install -y apt-utils software-properties-common
# Install needed packages
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN add-apt-repository "deb http://ftp.debian.org/debian testing main contrib"; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends --force-yes git g++ pkg-config cmake postgresql-server-dev-${PG_MAJOR} libpq-dev make 
# Protobuf-c
RUN apt-get install -y libprotobuf-c-dev=1.2.* libprotobuf-c1=1.2.*
# PostGIS
RUN apt-get install -y libproj-dev liblwgeom-dev

RUN apt-get clean all

WORKDIR /

# Download Debezium Postgres Decoderbufs
RUN git clone https://github.com/debezium/postgres-decoderbufs.git
RUN cd postgres-decoderbufs; \
    make; \
    make install; \
    rm -rf postgres-decoderbufs

COPY docker-entrypoint.sh /
RUN chmod 765 /docker-entrypoint.sh

COPY pg_hba.conf /
COPY postgresql.conf /
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["postgres"]
