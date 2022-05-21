-- Add needed permissions
--SET PASSWORDS:
USE master;
IF  EXISTS (SELECT * FROM master.sys.sql_logins WHERE name = N'centersrv')
DROP LOGIN centersrv;
IF  EXISTS (SELECT * FROM master.sys.sql_logins WHERE name = N'gamesrv')
DROP LOGIN gamesrv;
IF  EXISTS (SELECT * FROM master.sys.sql_logins WHERE name = N'us_trading_user')
DROP LOGIN us_trading_user;
IF  EXISTS (SELECT * FROM master.sys.sql_logins WHERE name = N'couponadmin')
DROP LOGIN couponadmin;
IF  EXISTS (SELECT * FROM master.sys.sql_logins WHERE name = N'log_npt')
DROP LOGIN log_npt;

-- Original password for bms v8, you can change it by overriding using the server extension dll.
-- It can be found in IDA by looking into database.dll and xreferencing the strings.
-- This is not a PRODUCTION password, just replace PASSWORD with the correct word :)

CREATE LOGIN centersrv WITH PASSWORD = 'donggus2gud', CHECK_POLICY = OFF
CREATE LOGIN gamesrv WITH PASSWORD = 'ep2qlemqpzja', CHECK_POLICY = OFF
CREATE LOGIN us_trading_user WITH PASSWORD = 'us_trading_user_password', CHECK_POLICY = OFF
CREATE LOGIN couponadmin WITH PASSWORD = '2chigoalfzl', CHECK_POLICY = OFF
CREATE LOGIN log_npt WITH PASSWORD = 'Ch@pPe!R0r@gE', CHECK_POLICY = OFF

USE [Claim]

CREATE USER centersrv FOR LOGIN centersrv;
CREATE USER gamesrv FOR LOGIN gamesrv;
CREATE USER us_trading_user FOR LOGIN us_trading_user;
CREATE USER couponadmin FOR LOGIN couponadmin;
CREATE USER log_npt FOR LOGIN log_npt;

EXEC sp_addrolemember N'db_datareader', N'gamesrv'
EXEC sp_addrolemember N'db_datawriter', N'gamesrv'
EXEC sp_addrolemember N'db_ddladmin', N'gamesrv'
EXEC sp_addrolemember N'db_owner', N'gamesrv'

EXEC sp_addrolemember N'db_datareader', N'centersrv'
EXEC sp_addrolemember N'db_datawriter', N'centersrv'
EXEC sp_addrolemember N'db_ddladmin', N'centersrv'
EXEC sp_addrolemember N'db_owner', N'centersrv'

EXEC sp_addrolemember N'db_datareader', N'us_trading_user'
EXEC sp_addrolemember N'db_datawriter', N'us_trading_user'
EXEC sp_addrolemember N'db_ddladmin', N'us_trading_user'
EXEC sp_addrolemember N'db_owner', N'us_trading_user'

EXEC sp_addrolemember N'db_datareader', N'log_npt'
EXEC sp_addrolemember N'db_datawriter', N'log_npt'
EXEC sp_addrolemember N'db_ddladmin', N'log_npt'
EXEC sp_addrolemember N'db_owner', N'log_npt'

EXEC sp_addrolemember N'db_datareader', N'couponadmin'
EXEC sp_addrolemember N'db_datawriter', N'couponadmin'
EXEC sp_addrolemember N'db_ddladmin', N'couponadmin'
EXEC sp_addrolemember N'db_owner', N'couponadmin'

USE [Coupon]

CREATE USER centersrv FOR LOGIN centersrv;
CREATE USER gamesrv FOR LOGIN gamesrv;
CREATE USER us_trading_user FOR LOGIN us_trading_user;
CREATE USER couponadmin FOR LOGIN couponadmin;
CREATE USER log_npt FOR LOGIN log_npt;

EXEC sp_addrolemember N'db_datareader', N'gamesrv'
EXEC sp_addrolemember N'db_datawriter', N'gamesrv'
EXEC sp_addrolemember N'db_ddladmin', N'gamesrv'
EXEC sp_addrolemember N'db_owner', N'gamesrv'

EXEC sp_addrolemember N'db_datareader', N'centersrv'
EXEC sp_addrolemember N'db_datawriter', N'centersrv'
EXEC sp_addrolemember N'db_ddladmin', N'centersrv'
EXEC sp_addrolemember N'db_owner', N'centersrv'

EXEC sp_addrolemember N'db_datareader', N'us_trading_user'
EXEC sp_addrolemember N'db_datawriter', N'us_trading_user'
EXEC sp_addrolemember N'db_ddladmin', N'us_trading_user'
EXEC sp_addrolemember N'db_owner', N'us_trading_user'

EXEC sp_addrolemember N'db_datareader', N'log_npt'
EXEC sp_addrolemember N'db_datawriter', N'log_npt'
EXEC sp_addrolemember N'db_ddladmin', N'log_npt'
EXEC sp_addrolemember N'db_owner', N'log_npt'

EXEC sp_addrolemember N'db_datareader', N'couponadmin'
EXEC sp_addrolemember N'db_datawriter', N'couponadmin'
EXEC sp_addrolemember N'db_ddladmin', N'couponadmin'
EXEC sp_addrolemember N'db_owner', N'couponadmin'

USE [GameWorld]

CREATE USER centersrv FOR LOGIN centersrv;
CREATE USER gamesrv FOR LOGIN gamesrv;
CREATE USER us_trading_user FOR LOGIN us_trading_user;
CREATE USER couponadmin FOR LOGIN couponadmin;
CREATE USER log_npt FOR LOGIN log_npt;

EXEC sp_addrolemember N'db_datareader', N'gamesrv'
EXEC sp_addrolemember N'db_datawriter', N'gamesrv'
EXEC sp_addrolemember N'db_ddladmin', N'gamesrv'
EXEC sp_addrolemember N'db_owner', N'gamesrv'

EXEC sp_addrolemember N'db_datareader', N'centersrv'
EXEC sp_addrolemember N'db_datawriter', N'centersrv'
EXEC sp_addrolemember N'db_ddladmin', N'centersrv'
EXEC sp_addrolemember N'db_owner', N'centersrv'

EXEC sp_addrolemember N'db_datareader', N'us_trading_user'
EXEC sp_addrolemember N'db_datawriter', N'us_trading_user'
EXEC sp_addrolemember N'db_ddladmin', N'us_trading_user'
EXEC sp_addrolemember N'db_owner', N'us_trading_user'

EXEC sp_addrolemember N'db_datareader', N'log_npt'
EXEC sp_addrolemember N'db_datawriter', N'log_npt'
EXEC sp_addrolemember N'db_ddladmin', N'log_npt'
EXEC sp_addrolemember N'db_owner', N'log_npt'

EXEC sp_addrolemember N'db_datareader', N'couponadmin'
EXEC sp_addrolemember N'db_datawriter', N'couponadmin'
EXEC sp_addrolemember N'db_ddladmin', N'couponadmin'
EXEC sp_addrolemember N'db_owner', N'couponadmin'

USE [GlobalAccount]

CREATE USER centersrv FOR LOGIN centersrv;
CREATE USER gamesrv FOR LOGIN gamesrv;
CREATE USER us_trading_user FOR LOGIN us_trading_user;
CREATE USER couponadmin FOR LOGIN couponadmin;
CREATE USER log_npt FOR LOGIN log_npt;

EXEC sp_addrolemember N'db_datareader', N'gamesrv'
EXEC sp_addrolemember N'db_datawriter', N'gamesrv'
EXEC sp_addrolemember N'db_ddladmin', N'gamesrv'
EXEC sp_addrolemember N'db_owner', N'gamesrv'

EXEC sp_addrolemember N'db_datareader', N'centersrv'
EXEC sp_addrolemember N'db_datawriter', N'centersrv'
EXEC sp_addrolemember N'db_ddladmin', N'centersrv'
EXEC sp_addrolemember N'db_owner', N'centersrv'

EXEC sp_addrolemember N'db_datareader', N'us_trading_user'
EXEC sp_addrolemember N'db_datawriter', N'us_trading_user'
EXEC sp_addrolemember N'db_ddladmin', N'us_trading_user'
EXEC sp_addrolemember N'db_owner', N'us_trading_user'

EXEC sp_addrolemember N'db_datareader', N'log_npt'
EXEC sp_addrolemember N'db_datawriter', N'log_npt'
EXEC sp_addrolemember N'db_ddladmin', N'log_npt'
EXEC sp_addrolemember N'db_owner', N'log_npt'

EXEC sp_addrolemember N'db_datareader', N'couponadmin'
EXEC sp_addrolemember N'db_datawriter', N'couponadmin'
EXEC sp_addrolemember N'db_ddladmin', N'couponadmin'
EXEC sp_addrolemember N'db_owner', N'couponadmin'

USE [UserConnection]

CREATE USER centersrv FOR LOGIN centersrv;
CREATE USER gamesrv FOR LOGIN gamesrv;
CREATE USER us_trading_user FOR LOGIN us_trading_user;
CREATE USER couponadmin FOR LOGIN couponadmin;
CREATE USER log_npt FOR LOGIN log_npt;

EXEC sp_addrolemember N'db_datareader', N'gamesrv'
EXEC sp_addrolemember N'db_datawriter', N'gamesrv'
EXEC sp_addrolemember N'db_ddladmin', N'gamesrv'
EXEC sp_addrolemember N'db_owner', N'gamesrv'

EXEC sp_addrolemember N'db_datareader', N'centersrv'
EXEC sp_addrolemember N'db_datawriter', N'centersrv'
EXEC sp_addrolemember N'db_ddladmin', N'centersrv'
EXEC sp_addrolemember N'db_owner', N'centersrv'

EXEC sp_addrolemember N'db_datareader', N'us_trading_user'
EXEC sp_addrolemember N'db_datawriter', N'us_trading_user'
EXEC sp_addrolemember N'db_ddladmin', N'us_trading_user'
EXEC sp_addrolemember N'db_owner', N'us_trading_user'

EXEC sp_addrolemember N'db_datareader', N'log_npt'
EXEC sp_addrolemember N'db_datawriter', N'log_npt'
EXEC sp_addrolemember N'db_ddladmin', N'log_npt'
EXEC sp_addrolemember N'db_owner', N'log_npt'

EXEC sp_addrolemember N'db_datareader', N'couponadmin'
EXEC sp_addrolemember N'db_datawriter', N'couponadmin'
EXEC sp_addrolemember N'db_ddladmin', N'couponadmin'
EXEC sp_addrolemember N'db_owner', N'couponadmin'

--Set permissions again
USE [Claim];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='centersrv', 
   @LoginName='centersrv';
GO

USE [Claim];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='gamesrv', 
   @LoginName='gamesrv';
GO

USE [Claim];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='us_trading_user', 
   @LoginName='us_trading_user';
GO

USE [Claim];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='couponadmin', 
   @LoginName='couponadmin';
GO

USE [Claim];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='log_npt', 
   @LoginName='log_npt';
GO

USE [Coupon];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='centersrv', 
   @LoginName='centersrv';
GO

USE [Coupon];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='gamesrv', 
   @LoginName='gamesrv';
GO

USE [Coupon];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='us_trading_user', 
   @LoginName='us_trading_user';
GO

USE [Coupon];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='couponadmin', 
   @LoginName='couponadmin';
GO

USE [Coupon];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='log_npt', 
   @LoginName='log_npt';
GO

USE [GameWorld];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='centersrv', 
   @LoginName='centersrv';
GO

USE [GameWorld];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='gamesrv', 
   @LoginName='gamesrv';
GO

USE [GameWorld];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='us_trading_user', 
   @LoginName='us_trading_user';
GO

USE [GameWorld];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='couponadmin', 
   @LoginName='couponadmin';
GO

USE [GameWorld];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='log_npt', 
   @LoginName='log_npt';
GO

USE [GlobalAccount];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='centersrv', 
   @LoginName='centersrv';
GO

USE [GlobalAccount];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='gamesrv', 
   @LoginName='gamesrv';
GO

USE [GlobalAccount];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='us_trading_user', 
   @LoginName='us_trading_user';
GO

USE [GlobalAccount];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='couponadmin', 
   @LoginName='couponadmin';
GO

USE [GlobalAccount];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='log_npt', 
   @LoginName='log_npt';
GO

USE [UserConnection];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='centersrv', 
   @LoginName='centersrv';
GO

USE [UserConnection];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='gamesrv', 
   @LoginName='gamesrv';
GO

USE [UserConnection];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='us_trading_user', 
   @LoginName='us_trading_user';
GO

USE [UserConnection];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='couponadmin', 
   @LoginName='couponadmin';
GO

USE [UserConnection];
GO
sp_change_users_login @Action='update_one', @UserNamePattern='log_npt', 
   @LoginName='log_npt';
GO