# SSL/TLS is supported by Redis starting with version 6 as an optional feature that needs to be enabled at compile time
# Current version 7 is already have this feature enabled and can be verified at https://github.com/docker-library/redis/blob/5c0bbb5dfce3d4999649cbc3ba8bf7c123bcadff/7.0/Dockerfile#L80
FROM redis:7

# Generated SSL certificates will be placed inside $CERTS_ROOT/certs
ENV CERTS_ROOT /etc/redis

RUN apt-get update && apt-get -y upgrade \
	&& apt-get install -y --no-install-recommends curl python3 openssl \
	&& rm -rf /var/lib/apt/lists/*

ADD ./createCerts.sh ${CERTS_ROOT}/
ADD ./docker-entrypoint-custom.sh /

ENTRYPOINT [ "/docker-entrypoint-custom.sh" ]