#!/bin/bash
set -e

WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
DB_PASSWORD=$(cat /run/secrets/sql_password)

WP_ADMIN_USER="$WP_ADMIN_USER"
WP_USER="$WP_USER"

DB_NAME="$SQL_DATABASE"
DB_USER="$SQL_USER"
DB_HOST="mariadb"
DOMAIN_NAME="$DOMAIN_NAME"

# Wait MariaDB
until mysqladmin ping -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Install WordPress core if needed
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --path=/var/www/html --allow-root
fi

# Create wp-config.php PROPERLY (IMPORTANT FIX)
cat > /var/www/html/wp-config.php << EOF
<?php

define('DB_NAME', '${DB_NAME}');
define('DB_USER', '${DB_USER}');
define('DB_PASSWORD', '${DB_PASSWORD}');
define('DB_HOST', '${DB_HOST}');

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('WP_HOME', 'https://${DOMAIN_NAME}');
define('WP_SITEURL', 'https://${DOMAIN_NAME}');

\$table_prefix = 'wp_';

define('WP_DEBUG', false);

/* Stop editing here */

if ( ! defined('ABSPATH') ) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
EOF

# Install WordPress only if not installed
if ! wp core is-installed --path=/var/www/html --allow-root; then
    wp core install \
        --path=/var/www/html \
        --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="admin@inception.com" \
        --skip-email

    wp user create \
        "$WP_USER" \
        user@inception.com \
        --allow-root \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --path=/var/www/html || true
fi

echo "listen = 9000" >> /etc/php/8.2/fpm/pool.d/www.conf

exec php-fpm8.2 -F
