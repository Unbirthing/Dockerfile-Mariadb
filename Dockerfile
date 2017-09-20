FROM debian:latest

ENV MYSQL_ROOT_PASSWORD jpl615141

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server-10.1
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/

VOLUME ["/etc/mysql","/var/lib.mysql"]

RUN echo "DROP USER IF EXISTS 'ldapadmin'@'localhost'"
RUN service mysql start && echo "CREATE USER 'ldapadmin'@'localhost'" | mysql -u root
RUN echo "CREATE DATABASE own_db;"
RUN echo "GRANT ALL ON own_db.* TO 'ldapadmin'@'localhost'"
RUN echo "FLUSH PRIVILEGES;"

ENTRYPOINT ["/bin/bash"]
CMD ["service", "mysql", "start"]
