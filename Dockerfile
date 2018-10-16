FROM postgres:10.5-alpine as donar
ENV POSTGRES_PASSWORD='test123'
ENV POSTGRES_USER='postgres'
ENV POSTGRES_DB='foo'
RUN cat /etc/passwd
RUN su - ${POSTGRES_USER};
RUN whoami
RUN postgres psql -h postgres -U ${POSTGRES_USER}


FROM debian:stretch-slim as build_tools
ENV FLWAY_VERSION='5.2.0'
RUN set -ex; \
	if ! command -v gpg > /dev/null; then \
		apt-get update; \
		apt-get install -y --no-install-recommends \
			gnupg \
			dirmngr \
			wget \
		; \
		rm -rf /var/lib/apt/lists/*; \
	fi
VOLUME flyway/sql
RUN wget --no-check-certificate https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/5.2.0/flyway-commandline-5.2.0-linux-x64.tar.gz -O - | tar -xz
#RUN -url=jdbc:postgresql://localhost:5432/optins -user='admin' -password='naic1234' -schemas='premtax' migrate
RUN pwd; \
    ls-l; \
    cd flyway-5.2.0; \
    pwd; \
    ls -l; \
    sh ./flyway -url=jdbc:postgresql://donar:5432/optins -user='postgres' -password='test123' -schemas='bar' migrate; \






