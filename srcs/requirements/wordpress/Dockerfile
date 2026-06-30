FROM debian:bookworm

RUN apt update && apt install -y \
    php-fpm \
    php-mysql \
    wget \
    curl \
    tar \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

ENV WP_VERSION=6.5.3

RUN wget https://wordpress.org/wordpress-${WP_VERSION}.tar.gz && \
    tar -xzf wordpress-${WP_VERSION}.tar.gz && \
    mkdir -p /var/www/html && \
    mv wordpress/* /var/www/html && \
    rm -rf wordpress wordpress-${WP_VERSION}.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

CMD ["/setup.sh"]
