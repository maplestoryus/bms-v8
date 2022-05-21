#!/bin/bash
/opt/mssql-tools/bin/sqlcmd -S bmsdb -U sa -P $SA_PASSWORD -l 30 -e -i /scripts/9-Reset.sql