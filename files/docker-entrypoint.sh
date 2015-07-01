#!/bin/bash
set -e

export DB_HOST=${DB_HOST:-${POSTGRES_PORT_5432_TCP_ADDR}}
export DB_PORT=${DB_PORT:-${POSTGRES_PORT_5432_TCP_PORT}}
export DB_USER=${DB_USER:-${POSTGRES_ENV_POSTGRES_USER}:-postgres}
export DB_PASS=${DB_PASS:-${POSTGRES_ENV_POSTGRES_PASSWORD}}
export DB_NAME=${DB_NAME:-${POSTGRES_ENV_POSTGRES_USER}}

/bin/sed 's/{{DB_HOST}}/'"${DB_HOST}"'/' -i /root/.odbc.ini
/bin/sed 's/{{DB_PORT}}/'"${DB_PORT}"'/' -i /root/.odbc.ini
/bin/sed 's/{{DB_USER}}/'"${DB_USER}"'/' -i /root/.odbc.ini
/bin/sed 's/{{DB_PASS}}/'"${DB_PASS}"'/' -i /root/.odbc.ini
/bin/sed 's/{{DB_NAME}}/'"${DB_NAME}"'/' -i /root/.odbc.ini

export LICENSE_SERVER=${LICENSE_SERVER:-127.0.0.1}
export LICENSE_SERVER_PORT=${LICENSE_SERVER_PORT:-5555}

/bin/sed 's/{{LICENSE_SERVER}}/'"${LICENSE_SERVER}"'/' -i /opt/totvs/dbaccess/multi/dbaccess.ini
/bin/sed 's/{{LICENSE_SERVER_PORT}}/'"${LICENSE_SERVER_PORT}"'/' -i /opt/totvs/dbaccess/multi/dbaccess.ini

if [ "$1" = 'dbaccess' ]; then

  until nc -z $DB_HOST $DB_PORT
  do
      echo "Esperando serviço de banco de dados..."
      sleep 0.5
  done

	exec "/opt/totvs/dbaccess/multi/dbaccess64opt"
fi

exec "$@"