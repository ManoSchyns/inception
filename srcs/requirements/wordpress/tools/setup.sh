#!/bin/bash
set -e

WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
WP_ADMIN_USER=$WP_ADMIN_USER
WP_USER=$WP_USER

DB_NAME=$SQL_DATABASE
DB_USER=$(cat /run/secrets/sql_user_name)
DB_PASS=$(cat /run/secrets/sql_password)
DB_HOST="mariadb"
DOMAIN_NAME=$DOMAIN_NAME

until mysqladmin ping -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

cat > /var/www/html/wp-config.php << EOF
<?php

define('DB_NAME', '$DB_NAME');
define('DB_USER', '$DB_USER');
define('DB_PASSWORD', '$DB_PASS');
define('DB_HOST', '$DB_HOST');

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

\$table_prefix = 'wp_';

define('WP_DEBUG', false);
EOF

# INSTALL SAFE
if ! wp core is-installed --path=/var/www/html; then
    wp core install \
        --path=/var/www/html \
        --url="$DOMAIN_NAME" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="admin@inception.com" \
        --skip-email

    wp user create \
        "$WP_USER" \
        user@inception.com \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --path=/var/www/html || true
fi

exec php-fpm8.2 -F
