FROM mediawiki:1.36.2-fpm-alpine

# Add NGINX and PostgreSQL support
RUN set -eux; \
    \
    apk add --no-cache \
        nginx \
        postgresql-libs \
        postgresql-dev \
    ;

# Add NGINX outputs and configs
RUN ln -sf /dev/stdout /var/log/nginx/access.log;
RUN ln -sf /dev/stderr /var/log/nginx/error.log;

COPY ["nginx.conf", "/etc/nginx/nginx.conf"]

# Add PostgreSQL PHP extensions
RUN set -eux; \
    \
    docker-php-ext-install -j "$(nproc)" \
        pgsql \
        pdo_pgsql \
    ;

# Add MediaWiki extensions
RUN set -eux; \
    \
    git clone --depth 1 \
        https://github.com/octfx/wiki-seo \
        /var/www/html/extensions/WikiSEO \
    ;

RUN set -eux; \
    \
    git clone --depth 1 \
        https://github.com/jayktaylor/mw-discord \
        -b REL1_36 \
        /var/www/html/extensions/Discord \
    ;

# Run php-fpm and NGINX
COPY ["bootstrap.sh", "."]
CMD ["./bootstrap.sh"]