USE [Coupon]
GO
/****** Object:  User [centersrv]    Script Date: 25/07/2021 05:56:09 ******/
CREATE USER [centersrv] FOR LOGIN [centersrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [couponadmin]    Script Date: 25/07/2021 05:56:09 ******/
CREATE USER [couponadmin] FOR LOGIN [couponadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [gamesrv]    Script Date: 25/07/2021 05:56:09 ******/
CREATE USER [gamesrv] FOR LOGIN [gamesrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [log_npt]    Script Date: 25/07/2021 05:56:09 ******/
CREATE USER [log_npt] FOR LOGIN [log_npt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [us_trading_user]    Script Date: 25/07/2021 05:56:09 ******/
CREATE USER [us_trading_user] FOR LOGIN [us_trading_user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_datareader] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_owner] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_owner] ADD MEMBER [gamesrv]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [gamesrv]
GO
ALTER ROLE [db_datareader] ADD MEMBER [gamesrv]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [gamesrv]
GO
ALTER ROLE [db_owner] ADD MEMBER [log_npt]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [log_npt]
GO
ALTER ROLE [db_datareader] ADD MEMBER [log_npt]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [log_npt]
GO
ALTER ROLE [db_owner] ADD MEMBER [us_trading_user]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [us_trading_user]
GO
ALTER ROLE [db_datareader] ADD MEMBER [us_trading_user]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [us_trading_user]
GO
/****** Object:  Table [dbo].[CouponMap]    Script Date: 25/07/2021 05:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CouponMap](
	[CouponSN] [bigint] NOT NULL,
	[ItemSN] [bigint] NOT NULL,
	[VALID] [int] NOT NULL,
	[Flag] [int] NOT NULL
) ON [PRIMARY]

GO
