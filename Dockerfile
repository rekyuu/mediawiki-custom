FROM ghcr.io/rekyuu/mediawiki-custom:1.36.2-2

# Upgrade Alpine
RUN set -eux; \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.24/main" > /etc/apk/repositories; \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.24/community" >> /etc/apk/repositories;

RUN set -eux; \
    apk update; \
    apk upgrade;

# Remove old MediaWiki dependencies
RUN set -eux; \
    apk del .mediawiki-phpext-rundeps;

# Install latest PHP and needed extensions
RUN set -eux; \
    apk add --no-cache \
        php85 \
        php85-fpm \
        php85-mbstring \
        php85-xml \
        php85-ctype \
        php85-iconv \
        php85-fileinfo \
        php85-intl \
        php85-pgsql \
        php85-pdo_pgsql;

# Install utility scripts
COPY ["scripts", "/scripts"]

# Run php-fpm and NGINX
CMD ["/scripts/bootstrap.sh"]