# Maple Story Brazil Server Files


## Disclaimer

The effort of this project is only to protect Maple Story history since the game changed so much after big bang, and to give players a chance to play the old 
Maple Story offline.

## Current database status

I believe 90% of the database schema  / procedures is complete.

## Credits

- Specially thanks to [diamond25](https://github.com/diamondo25) for reversing enginnering most of the database.
- Me for reversing many SQL queries, Tables and procedures.

## Structure

- Claim - Stores in-game information about transactions in the game.
- Coupon - Stores game coupons used in cash shop.
- GameWorld - Stores game play data such as guild, characters, etc.
- GlobalAccount - Stores the account information such as login and password.
- UserConnection - Stores the users connections.

## Running the server

## Create the DNS entries

The configuration files expects the following DNS entries: 

```
127.0.0.1 bmsdb
127.0.0.1 bms_server
```

##  Database container

The database runs on SQL Server Express for Linux:

```bash
$ docker-compose up
```

There is a file named `created` in the SQL server mounted volume that will prevent the database from being recreated during start up.

## Reverse Enginnering game queries

SQLProfiler can be used for sniffing server queries and IDA to  find the correct data types / database structure.
