FROM bitnami/mariadb-galera:latest
MAINTAINER soroosh.mehmandoost@gmail.com

LABEL version="1.0"
LABEL description="MariaDB Server"

ENV MARIADB_ROOT_PASSWORD=qazwsx
ENV MARIADB_GALERA_MARIABACKUP_PASSWORD=backup-password
ENV MARIADB_USER=user1
ENV MARIADB_DATABASE=customdatabase
ENV MARIADB_ENABLE_LDAP=yes
ENV LDAP_URI=ldap://openldap:1389
ENV LDAP_BASE=dc=soroosh,dc=land
ENV LDAP_BIND_DN=cn=admin,dc=soroosh,dc=land
ENV LDAP_BIND_PASSWORD=admin

