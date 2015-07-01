#!/bin/bash

cp /tmp/odbcinst.ini /etc/
cp /tmp/odbc.ini /root/.odbc.ini
cp /tmp/dbaccess.ini /opt/totvs/dbaccess/multi/

ln -s /usr/pgsql-9.3/lib/psqlodbcw.so /usr/lib64/libpsqlodbc.so

echo "/opt/totvs/dbaccess/multi/" > /etc/ld.so.conf.d/dbaccess64-libs.conf
/sbin/ldconfig

rm -f /tmp/*
