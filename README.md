# Reverse Engineering of BMS V8 Database

This is the almost complete(99%) and fully functional maplestory v8 database compatible with the bms leak server files.

It has been reverse engineered from the binaries using `IDA` and `SQL Server Profiler`.

The credits goes to the developers who worked hours on it.

## How to run

Scripts should be run in sequence from 1 to 9.

## Docker

There is also a dockerized version of the server files using wine, which runs on Linux and will be released later.

```
version: "3.9"
x-extra-hosts: &extra_hosts
  - "bms_server:127.0.0.1"
  - "bms_public:127.0.0.1" # Public IP that clients connect.
x-database-environment: &database-environment
  SA_PASSWORD: "Dong0#1sG00d"
  ACCEPT_EULA: "Y"
  MSSQL_PID: "Express"
services:
  bmsdb:
    image: "mcr.microsoft.com/mssql/server:2017-CU24-ubuntu-16.04"
    container_name: bmsdb
    environment: *database-environment
    healthcheck:
      test: /db-healthcheck.sh
    volumes:
      - "./Database/temp:/var/opt/mssql/data:rw"
      - "./Database:/scripts"
      - "./Scripts/start-database.sh:/start-database.sh"
      - "./Scripts/db-healthcheck.sh:/db-healthcheck.sh"
    ports:
      - "1433:1433" # Add like this for public: 127.0.0.1:1433:1433
    entrypoint: /bin/bash -c "/start-database.sh"
  bms_sidecar:
    image: "mcr.microsoft.com/mssql/server:2017-CU24-ubuntu-16.04"
    container_name: bms_sidecar
    depends_on:
      bmsdb:
        condition: service_healthy
    environment: *database-environment
    volumes:
      - "./Database:/scripts"
      - "./Scripts/clean-world.sh:/clean-world.sh"
    entrypoint: /bin/bash -c "/clean-world.sh"
  bms_server:
    container_name: bms_server
    extra_hosts: *extra_hosts
    depends_on:
      - bms_sidecar
    build: .
    ports:
      - "8484:8484"
      - "8585:8585"
      - "8586:8586"
      - "8587:8587"
      - "8588:8588"
      - "8589:8589"
      - "8787:8787"
    volumes:
      - "./MSLog:/root/.wine32/drive_c/MSLog"
      - "./BinSvr:/root/.wine32/drive_c/Server/BinSvr"
      - "./DataSvr:/root/.wine32/drive_c/Server/DataSvr"
      - "./Scripts/start-server.sh:/start-server.sh"
    entrypoint: /bin/bash -c "/start-server.sh"
```
