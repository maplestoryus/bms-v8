Use master;

-- Create the empty files .mdf and .ldf in the docker mount before executing
-- Remember to fix the users after with CreateUsers script.

RESTORE DATABASE Claim FROM DISK='/var/opt/mssql/data/Claim.bak' 
  WITH FILE = 1, STATS = 5, REPLACE,
  MOVE 'Claim' to '/var/opt/mssql/data/Claim.mdf',  
  MOVE 'Claim_log' to '/var/opt/mssql/data/Claim_log_db.ldf' 
GO

RESTORE DATABASE Coupon FROM DISK='/var/opt/mssql/data/Coupon.bak' 
  WITH FILE = 1, STATS = 5, REPLACE,
  MOVE 'Coupon' to '/var/opt/mssql/data/Coupon.mdf',
  MOVE 'Coupon_log' to '/var/opt/mssql/data/Coupon_log_db.ldf' 
GO


RESTORE DATABASE UserConnection FROM DISK='/var/opt/mssql/data/UserConnection.bak'
  WITH FILE = 1, STATS = 5, REPLACE,
  MOVE 'UserConnection' to '/var/opt/mssql/data/UserConnection_db.mdf',  
  MOVE 'UserConnection_log' to '/var/opt/mssql/data/UserConnection_log_db.ldf' 
GO

RESTORE DATABASE GlobalAccount FROM DISK='/var/opt/mssql/data/GlobalAccount.bak'
  WITH FILE = 1, STATS = 5, REPLACE,
  MOVE 'GlobalAccount' to '/var/opt/mssql/data/GlobalAccount_db.mdf',  
  MOVE 'GlobalAccount_log' to '/var/opt/mssql/data/GlobalAccount_log_db.ldf' 
GO

RESTORE DATABASE GameWorld FROM DISK='/var/opt/mssql/data/GameWorld.bak'
  WITH FILE = 1, STATS = 5, REPLACE,
  MOVE 'GameWorld' to '/var/opt/mssql/data/GameWorld_db.mdf',  
  MOVE 'GameWorld_log' to '/var/opt/mssql/data/GameWorld_log_db.ldf' 
GO

-- Check if the server can find the file.
RESTORE FILELISTONLY FROM DISK='/var/opt/mssql/data/GlobalAccount.bak'  
GO 