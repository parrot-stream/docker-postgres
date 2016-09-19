FROM postgres

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ARG httpProxyHost
ARG httpProxyPort
ARG httpProxyUrl
ARG httpsProxyUrl

ENV http_proxy $httpProxyUrl
ENV https_proxy $httpsProxyUrl
ENV no_proxy ${no_proxy}
ENV httpProxyHost $httpProxyHost
ENV httpProxyPort $httpProxyPort

ENV AVRO_VER 1.8.1
ENV RDKAFKA_VER 0.9.1

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

# Install needed packages
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -y; \
    apt-get install -y apt-utils; \
    apt-get install -y --no-install-recommends --force-yes  postgresql-server-dev-9.5 libpq-dev libsnappy-dev liblzma-dev cmake libjansson-dev libcurl4-openssl-dev git-core g++ pkg-config build-essential ca-certificates libpq5=${PG_MAJOR}\* libpq-dev=${PG_MAJOR}\*  postgresql-server-dev-${PG_MAJOR}=${PG_MAJOR}\* 



WORKDIR /opt/docker

# Download source, build and install librdkafka
RUN git clone -b $RDKAFKA_VER https://github.com/edenhill/librdkafka.git
RUN cd librdkafka; \
    ./configure; \
    make; \
    make install

# Download source, build and install Avro C
RUN git clone -b release-$AVRO_VER https://github.com/apache/avro.git
RUN cd avro/lang/c; \
    mkdir build; \
    cd build; \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=RelWithDebInfo; \
    make; \
    make install

# Download source, build and install Bottled Water
RUN git clone https://github.com/confluentinc/bottledwater-pg.git
COPY libsnappy.pc /usr/local/lib/pkgconfig/libsnappy.pc
RUN cd bottledwater-pg; \
    make; \
    make install

COPY docker-entrypoint.sh /opt/docker
RUN chmod 765 /opt/docker/docker-entrypoint.sh

COPY pg_hba.conf /opt/docker
COPY postgresql.conf /opt/docker

ENTRYPOINT ["/opt/docker/docker-entrypoint.sh"]

CMD ["postgres"]
