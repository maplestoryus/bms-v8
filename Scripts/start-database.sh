#!/bin/bash
# Launch MSSQL and send to background
/opt/mssql/bin/sqlservr &
# Wait 30 seconds for it to be available
sleep 10
# Run every script in /scripts
if [ ! -f /var/opt/mssql/data/started ]; then
  for foo in /scripts/*.sql
    do /opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -l 30 -e -i $foo
  done
  echo "Started" >> /var/opt/mssql/data/started
fi
sleep infinity