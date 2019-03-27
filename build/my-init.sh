#!/bin/bash
set -e

if [ ! -z ${DATABASE_URL+x} ]; then
  pattern='^(postgresql|sqlserver):\/\/([^:]+):([^@]+)@([^:]+):([^\/]\d+)\/(.+)'

  if [[ "${1}" =~ $pattern ]]; then
    export DB_TYPE=${BASH_REMATCH[1]}
    export DB_USER=${BASH_REMATCH[2]}
    export DB_PASS=${BASH_REMATCH[3]}
    export DB_HOST=${BASH_REMATCH[4]}
    export DB_PORT=${BASH_REMATCH[5]}
    export DB_NAME=${BASH_REMATCH[6]}
  else
    echo "Não foi possível obter configuração a partir de \$DATABASE_URL." > /dev/stderr
    exit 1
  fi
else
  /bin/sed 's/{{DB_USER}}/'"${DB_USER}"'/' -i /etc/odbc.ini
  /bin/sed 's/{{DB_PASS}}/'"${DB_PASS}"'/' -i /etc/odbc.ini
  /bin/sed 's/{{DB_HOST}}/'"${DB_HOST}"'/' -i /etc/odbc.ini
  /bin/sed 's/{{DB_PORT}}/'"${DB_PORT}"'/' -i /etc/odbc.ini
  /bin/sed 's/{{DB_NAME}}/'"${DB_NAME}"'/' -i /etc/odbc.ini
fi

export LICENSE_SERVER=${LICENSE_SERVER:-127.0.0.1}
export LICENSE_SERVER_PORT=${LICENSE_SERVER_PORT:-5555}

/bin/sed 's/{{LICENSE_SERVER}}/'"${LICENSE_SERVER}"'/' -i /opt/totvs/dbaccess64/multi/dbaccess.ini
/bin/sed 's/{{LICENSE_SERVER_PORT}}/'"${LICENSE_SERVER_PORT}"'/' -i /opt/totvs/dbaccess64/multi/dbaccess.ini

if [ "$1" = 'dbaccess' ]; then

  until echo -n > /dev/tcp/${DB_HOST}/${DB_PORT}
  do
      echo "INFO Esperando serviço de banco de dados..."
      sleep 0.5
  done

  echo "INFO Conectado ao serviço de banco de dados."

  exec "/opt/totvs/dbaccess64/multi/dbaccess64"

elif [ "$1" = 'dbmonitor' ]; then

  exec "/opt/totvs/dbaccess64/dbmonitor"

fi

exec "$@"
