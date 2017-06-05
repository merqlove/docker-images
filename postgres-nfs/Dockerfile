FROM postgres:latest
MAINTAINER Alexander Merkulov <merkulov@cnsa.ru>

ADD scripts /docker-entrypoint-initdb.d/

ENV POSTGRES_INITDB_ARGS "--data-checksums"
