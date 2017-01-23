#!/bin/bash

cp /build/odbc.ini /etc/odbc.ini
cp /build/dbaccess.ini /totvs11/dbaccess64/multi/
cp /build/docker-entrypoint.sh /

odbcinst -i -s -l -f /etc/odbc.ini

echo "/totvs11/dbaccess64/multi/" > /etc/ld.so.conf.d/dbaccess64-libs.conf
/sbin/ldconfig

chmod +x /totvs11/dbaccess64/dbmonitor
chown -R root:root /totvs11

rm -rf /build
