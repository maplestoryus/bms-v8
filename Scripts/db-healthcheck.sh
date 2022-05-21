#!/bin/bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "Use GlobalAccount; Select * FROM GameWorld Where GameWorldID = 1"