#!/bin/bash
set -e

export DB_HOST=${DB_HOST:-${POSTGRES_PORT_5432_TCP_ADDR}}
export DB_PORT=${DB_PORT:-${POSTGRES_PORT_5432_TCP_PORT}}
export DB_USER=${DB_USER:-${POSTGRES_ENV_POSTGRES_USER}:-postgres}
export DB_PASS=${DB_PASS:-${POSTGRES_ENV_POSTGRES_PASSWORD}}
export DB_NAME=${DB_NAME:-${POSTGRES_ENV_POSTGRES_USER}}

/bin/sed 's/{{DB_HOST}}/'"${DB_HOST}"'/' -i /etc/odbc.ini
/bin/sed 's/{{DB_PORT}}/'"${DB_PORT}"'/' -i /etc/odbc.ini
/bin/sed 's/{{DB_USER}}/'"${DB_USER}"'/' -i /etc/odbc.ini
/bin/sed 's/{{DB_PASS}}/'"${DB_PASS}"'/' -i /etc/odbc.ini
/bin/sed 's/{{DB_NAME}}/'"${DB_NAME}"'/' -i /etc/odbc.ini

export LICENSE_SERVER=${LICENSE_SERVER:-127.0.0.1}
export LICENSE_SERVER_PORT=${LICENSE_SERVER_PORT:-5555}

/bin/sed 's/{{LICENSE_SERVER}}/'"${LICENSE_SERVER}"'/' -i /totvs11/dbaccess64/multi/dbaccess.ini
/bin/sed 's/{{LICENSE_SERVER_PORT}}/'"${LICENSE_SERVER_PORT}"'/' -i /totvs11/dbaccess64/multi/dbaccess.ini

if [ "$1" = 'dbaccess' ]; then

  until echo -n > /dev/tcp/${DB_HOST}/${DB_PORT}
  do
      echo "INFO Esperando serviço de banco de dados..."
      sleep 0.5
  done

  echo "INFO Conectado ao serviço de banco de dados."

  exec "/totvs11/dbaccess64/multi/dbaccess64opt"

elif [ "$1" = 'dbmonitor' ]; then

  exec "/totvs11/dbaccess64/dbmonitor"

fi

exec "$@"
