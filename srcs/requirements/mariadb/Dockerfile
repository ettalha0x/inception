FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client && \
    mkdir -p /run/mysqld && chmod 777 /run/mysqld && \
    sed -i "s|skip-networking|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db

EXPOSE 3306

COPY ./conf/config.sh /config.sh
RUN chmod +x /config.sh

ENTRYPOINT ["sh", "config.sh"]

CMD ["mysqld", "--user=mysql", "--bind-address=0.0.0.0"]