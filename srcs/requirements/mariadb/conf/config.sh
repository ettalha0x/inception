# #!bin/sh

# if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then

#         cat << EOF > /tmp/init_db.sql
# USE mysql;
# FLUSH PRIVILEGES;
# DELETE FROM mysql.user WHERE User='';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWD}';
# CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
# CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASSWD}';
# GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
# FLUSH PRIVILEGES;
# EOF
#         mariadbd --user=mysql --bootstrap < /tmp/init_db.sql
#         rm -f /tmp/init_db.sql
# else
#         echo "Database already exists"
# fi

# exec "$@"


#!bin/sh

# if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then

#         cat << EOF > /tmp/init_db.sql
echo "
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE  IF NOT EXISTS  ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER  IF NOT EXISTS  '${MYSQL_USER}'@'%' IDENTIFIED by '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;" > init_db.sql
ERROR: 1064  You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'wp_db CHARACTER SET utf8 COLLATE utf8_general_ci;' at line 1
# EOF
        mariadbd --user=mysql --bootstrap < /init_db.sql
        # rm -f /init_db.sql
# else
#         echo "Database already exists"
# fi

exec "$@"