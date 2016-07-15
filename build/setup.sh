#!/usr/bin/env bash

cp /build/docker-entrypoint.sh /
cp /build/odbc.ini /root/.odbc.ini
cp /build/dbaccess.ini /opt/totvs/dbaccess/multi/

ln -s /usr/lib64/psqlodbcw.so /usr/lib64/libpsqlodbc.so

echo "/opt/totvs/dbaccess/multi/" > /etc/ld.so.conf.d/dbaccess64-libs.conf
/sbin/ldconfig

rm -rf /build
