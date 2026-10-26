FROM ghcr.io/rekyuu/mediawiki-custom:1.36.2-2

# Upgrade Alpine
RUN set -eux; \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.24/main" > /etc/apk/repositories; \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.24/community" >> /etc/apk/repositories;

RUN set -eux; \
    apk update; \
    apk upgrade;

# Install latest php-fpm
RUN set -eux; \
    apk add --no-cache \
        php85-fpm;

# Install utility scripts
COPY ["scripts", "/scripts"]

# Run php-fpm and NGINX
CMD ["/scripts/bootstrap.sh"]