#!/bin/bash

# Check if wp-config.php exists, and if it does, assume WordPress is already installed
# if [ -f "/var/www/html/wordpress/wp-config.php" ]; then
#     echo "WordPress is already installed in this directory."
#     exec "$@"
#     exit 0
# fi

# Install WP-CLI if it doesn't exist
if [ ! -f "/usr/local/bin/wp" ]; then
    cd /tmp
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Create the WordPress directory if it doesn't exist
if [ ! -d "/var/www/html/wordpress" ]; then
    mkdir -p /var/www/html/wordpress
fi

# Set permissions for WordPress directory
chmod -R 755 /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress

# Change directory to WordPress installation
cd /var/www/html/wordpress

# Remove existing files (if any)
rm -rf /var/www/html/wordpress/*

# Download WordPress core
wp core download --allow-root

# Generate wp-config.php with database connection details
wp config create --allow-root --dbname=${WP_DB_NAME} --dbuser=${WP_USER} --dbpass=${WP_PASSWD} --dbhost=mariadb
wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWD} --admin_email=${WP_ADMIN_EMAIL}

# Create additional users (if needed)
wp user create ${WP_ADMIN} ${WP_ADMIN_EMAIL} --role=administrator --user_pass=${WP_ADMIN_PASSWD} --path=/var/www/html/wordpress --allow-root
wp user create ${WP_USER} ${WP_USER_EMAIL} --role=editor --user_pass=${WP_PASSWD} --path=/var/www/html/wordpress --allow-root

# Execute additional commands (if needed)
exec "$@"
