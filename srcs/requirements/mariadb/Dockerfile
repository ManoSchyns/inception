FROM debian:bookworm

RUN apt update && \
    apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setup.sh /tools/setup.sh

RUN chmod +x /tools/setup.sh

RUN mkdir -p /run/mysqld && \
chown -R mysql:mysql /run/mysqld

CMD ["/tools/setup.sh"]
