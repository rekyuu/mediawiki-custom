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

# Upgrade libsodium
RUN set -eux; \
    sed -i "s/so:libsodium.so.23/libsodium=1.0.22-r0/" /etc/apk/world; \
    apk fix;

# Install latest PHP and needed extensions
# https://www.mediawiki.org/wiki/Manual:Installation_requirements#PHP
RUN set -eux; \
    apk add --no-cache \
        php84 \
        php84-fpm \
        php84-calendar \
        php84-ctype \
        php84-dom \
        php84-fileinfo \
        php84-iconv \
        # php84-json \
        php84-openssl \
        php84-sodium \
        php84-xml \
        php84-xmlreader \
        php84-intl \
        php84-mbstring \
        php84-opcache \
        php84-pecl-apcu \
        php84-curl \
        php84-pgsql \
        php84-pdo_pgsql;

# Copy opcache config to the new config directory
RUN set -eux; \
    cp /usr/local/etc/php/conf.d/opcache-recommended.ini /etc/php84/conf.d;

# Install utility scripts
COPY ["scripts", "/scripts"]

# Run php-fpm and NGINX
CMD ["/scripts/bootstrap.sh"]