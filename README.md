
# Brazil Maple Story v8 server files docker

This is the almost complete(99%) and fully functional maplestory v8 database compatible with the bms leak server files and available with docker.

It has been reverse engineered from the binaries using `IDA` and `SQL Server Profiler`.

The credits goes to the developers who worked hours on it.

## Server files
[Link available since 2014](https://www.mediafire.com/file/z0vkal61ymwyxlw/5366a09f4e67570decdbef93468edf19.tar.bz2)
## Before starting

- Copy the `DataSvr` from the original server into `Server/DataSvr`, however keep all the already existent configuration files.
- Copy `BinSvr` from the original server into `Server/BinSvr`.
- Run `docker-compose up`
- Start-up logs will be at `temp` folder.

