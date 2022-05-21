USE [Claim]
GO
/****** Object:  User [centersrv]    Script Date: 25/07/2021 05:54:35 ******/
CREATE USER [centersrv] FOR LOGIN [centersrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [couponadmin]    Script Date: 25/07/2021 05:54:35 ******/
CREATE USER [couponadmin] FOR LOGIN [couponadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [gamesrv]    Script Date: 25/07/2021 05:54:35 ******/
CREATE USER [gamesrv] FOR LOGIN [gamesrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [log_npt]    Script Date: 25/07/2021 05:54:35 ******/
CREATE USER [log_npt] FOR LOGIN [log_npt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [us_trading_user]    Script Date: 25/07/2021 05:54:35 ******/
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
ALTER ROLE [db_ddladmin] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [couponadmin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [couponadmin]
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
/****** Object:  Table [dbo].[Claims]    Script Date: 25/07/2021 05:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Claims](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WorldID] [int] NOT NULL,
	[SendAccountID] [int] NOT NULL,
	[SendCharacterName] [varchar](13) NOT NULL,
	[TargetCharacterName] [varchar](13) NOT NULL,
	[Type] [int] NOT NULL,
	[Context] [text] NOT NULL,
	[ChatLog] [text] NOT NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Expired_ItemSlot_EQP]    Script Date: 25/07/2021 05:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expired_ItemSlot_EQP](
	[SN_Expired] [bigint] IDENTITY(1,1) NOT NULL,
	[WorldID] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[RUC] [int] NOT NULL,
	[CUC] [int] NOT NULL,
	[I_STR] [int] NOT NULL,
	[I_DEX] [int] NOT NULL,
	[I_INT] [int] NOT NULL,
	[I_LUK] [int] NOT NULL,
	[I_MaxHP] [int] NOT NULL,
	[I_MaxMP] [int] NOT NULL,
	[I_PAD] [int] NOT NULL,
	[I_MAD] [int] NOT NULL,
	[I_PDD] [int] NOT NULL,
	[I_MDD] [int] NOT NULL,
	[I_ACC] [int] NOT NULL,
	[I_EVA] [int] NOT NULL,
	[I_Speed] [int] NOT NULL,
	[I_Jump] [int] NOT NULL,
	[Title] [text] NOT NULL,
	[Attribute] [int] NOT NULL,
	[ExpirationDate] [datetime] NULL DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemPath]    Script Date: 25/07/2021 05:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemPath](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WorldID] [int] NOT NULL,
	[SN] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[From] [varchar](13) NOT NULL,
	[To] [varchar](13) NOT NULL,
	[Through] [int] NOT NULL,
 CONSTRAINT [PK_ItemPath] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AddClaim]    Script Date: 25/07/2021 05:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erwin Oegema
-- Create date: 2015-10-03
-- Description:	Procedure for WvsClaim (adding claims heh)
-- =============================================
CREATE PROCEDURE [dbo].[AddClaim] 
	-- Add the parameters for the stored procedure here
	@WorldID int, 
	@SendAccountID int, 
	@SendCharacterName varchar(13),
	@TargetCharacterName varchar(13),
	@Type int,
	@Context varchar(501),
	@ChatLog varchar(1601)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Claims VALUES (@WorldID, @SendAccountID, @SendCharacterName, @TargetCharacterName, @Type, @Context, @ChatLog);
END

GO
/****** Object:  StoredProcedure [dbo].[AddItemExpired_Bundle]    Script Date: 25/07/2021 05:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--.data:018C4CC8 00000033 C { call AddItemExpired_Bundle( ?, ?, ?, ?, ?, ? ) }
CREATE PROCEDURE [dbo].[AddItemExpired_Bundle]
@WorldID int,
@ItemID int,
@SN int
AS
BEGIN
	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[AddItemExpired_EQP]    Script Date: 25/07/2021 05:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
--..data:018C4AB8 00000060 C { call AddItemExpired_EQP( @WorldID, @ItemSN, @ItemID, @SN, @RUC, @CUC, @I_STR, @I_DEX, @I_int, @I_LUK, @I_MaxHP, @I_MaxMP, @I_PAD, @I_MAD, @I_PDD, @I_MDD, @I_ACC, @I_EVA, @I_Speed, @I_Craft, @I_Jump, @ExpireDate ) }

/**

 exec AddItemExpired_EQP 
 0,184683593750,1050039,10(ruc),0(cuc),0(str),0(dex),4(int),0(Luk),0(max_hp),0(max_mp),0(L_PAD),0(IMAD),38(I_PDD),18(L_PDD),0(I_MDD),0(I_ACC),0(I_EVA),0(I_SPEED),0(I_JUMP),''(Title),0

*/

CREATE PROCEDURE [dbo].[AddItemExpired_EQP]
@WorldID int,
@ItemSN bigint,
@ItemID int,
@SN int,
@RUC int,
@CUC int,
@I_STR int,
@I_DEX int,
@I_int int,
@I_LUK int,
@I_MaxHP int,
@I_MaxMP int,
@I_PAD int,
@I_MAD int,
@I_PDD int,
@I_MDD int,
@I_ACC int,
@I_EVA int,
@I_Speed int,
@I_Jump int,
@Title text,
@Attribute int
AS
BEGIN
	INSERT INTO Expired_ItemSlot_EQP (WorldID, ItemSN, ItemID, RUC, CUC, I_STR, I_DEX, I_INT, I_LUK, I_MaxHP, I_MaxMP, I_PAD, I_MAD, I_PDD, I_MDD, I_ACC, I_EVA, I_Speed, I_Jump, Title, Attribute) 
	VALUES( @WorldID,
			@ItemSN,
			@ItemID,
			@RUC,
			@CUC,
			@I_STR,
			@I_DEX,
			@I_int,
			@I_LUK,
			@I_MaxHP,
			@I_MaxMP,
			@I_PAD,
			@I_MAD,
			@I_PDD,
			@I_MDD,
			@I_ACC,
			@I_EVA,
			@I_Speed,
			@I_Jump,
			@Title,
			@Attribute
	);
	RETURN(0);
END


GO
/****** Object:  StoredProcedure [dbo].[AddItemMovePath]    Script Date: 25/07/2021 05:54:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erwin Oegema
-- Create date: 2015-10-03
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[AddItemMovePath] 
	-- Add the parameters for the stored procedure here
	@WorldID int, 
	@SN bigint,
	@ItemID int,
	@Type int,
	@From varchar(13),
	@To varchar(13),
	@Through int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO ItemPath VALUES (@WorldID, @SN, @ItemID, @Type, @From, @To, @Through);
END

GO
