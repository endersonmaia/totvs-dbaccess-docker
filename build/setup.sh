#!/usr/bin/env bash

cp /build/docker-entrypoint.sh /
cp /build/odbcinst.ini /etc/
cp /build/odbc.ini /root/.odbc.ini
cp /build/dbaccess.ini /opt/totvs/dbaccess/multi/

ln -s /usr/pgsql-9.3/lib/psqlodbcw.so /usr/lib64/libpsqlodbc.so

echo "/opt/totvs/dbaccess/multi/" > /etc/ld.so.conf.d/dbaccess64-libs.conf
/sbin/ldconfig

rm -rf /build
