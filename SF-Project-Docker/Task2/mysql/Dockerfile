FROM mysql:8.0.32
MAINTAINER soroosh.mehmandoost@gmail.com

ENV MYSQL_ROOT_PASSWORD=qazwsx
ENV MYSQL_USER=twitter_user
ENV MYSQL_PASSWORD=qazwsx
ENV MYSQL_DATABASE=twitter


ADD ./tables.sql ./procedures.sql /docker-entrypoint-initdb.d



EXPOSE 3306
