USE [GameWorld]
GO
/****** Object:  User [centersrv]    Script Date: 11/08/2021 16:58:15 ******/
CREATE USER [centersrv] FOR LOGIN [centersrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [couponadmin]    Script Date: 11/08/2021 16:58:15 ******/
CREATE USER [couponadmin] FOR LOGIN [couponadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [gamesrv]    Script Date: 11/08/2021 16:58:15 ******/
CREATE USER [gamesrv] FOR LOGIN [gamesrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [log_npt]    Script Date: 11/08/2021 16:58:15 ******/
CREATE USER [log_npt] FOR LOGIN [log_npt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [us_trading_user]    Script Date: 11/08/2021 16:58:15 ******/
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
/****** Object:  UserDefinedFunction [dbo].[GetAccountIDFromCharacterName]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[GetAccountIDFromCharacterName](@Name varchar(13))
RETURNS int AS
BEGIN
   DECLARE @ID int;
   SELECT @ID = AccountID From Character WHERE HASHBYTES('SHA1', CharacterName) = HASHBYTES('SHA1', @Name);
   Return @ID;
END


GO
/****** Object:  UserDefinedFunction [dbo].[GetIDFromCharacterName]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[GetIDFromCharacterName](@Name varchar(13))
RETURNS int AS
BEGIN
   DECLARE @ID int;
   SELECT @ID = CharacterID From Character WHERE HASHBYTES('SHA1', CharacterName) = HASHBYTES('SHA1', @Name);
   Return @ID;
END

GO
/****** Object:  UserDefinedFunction [dbo].[isPetItem]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[isPetItem](@ItemID int)
RETURNS BIT
BEGIN
   IF @ItemID >= 5000000 AND @ItemID <= 5000100 
   BEGIN
    RETURN 1;
   END;
   RETURN 0;
END





GO
/****** Object:  UserDefinedFunction [dbo].[ReadInt]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[ReadInt](@Bytes varbinary(max), @Offset int)
RETURNS int
BEGIN
   DECLARE @leftPart varbinary(2) = dbo.ReadShort(@Bytes, @Offset);
   DECLARE @RigthPart varbinary(2) =  dbo.ReadShort(@Bytes, @Offset + 2);
   DECLARE @Final varbinary(4) = @RigthPart + @leftPart;
   RETURN CAST(@Final as int); 
END


GO
/****** Object:  UserDefinedFunction [dbo].[ReadShort]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ReadShort](@Bytes varbinary(max), @Offset int)
RETURNS int
BEGIN
   DECLARE @leftPart varbinary(1) = SUBSTRING(@Bytes, @Offset, 1);
   DECLARE @RigthPart varbinary(1) = SUBSTRING(@Bytes, @Offset + 1, 1);
   DECLARE @Final varbinary(2) = @RigthPart + @leftPart;
   RETURN CAST(@Final as int); 
END

GO
/****** Object:  Table [dbo].[CashItem_EQP]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashItem_EQP](
	[CashItemSN] [bigint] NULL,
	[POS] [smallint] NULL,
	[RUC] [tinyint] NULL,
	[CUC] [tinyint] NULL,
	[I_STR] [smallint] NULL,
	[I_DEX] [smallint] NULL,
	[I_INT] [smallint] NULL,
	[I_LUK] [smallint] NULL,
	[I_MaxHP] [smallint] NULL,
	[I_MaxMP] [smallint] NULL,
	[I_PAD] [smallint] NULL,
	[I_MAD] [smallint] NULL,
	[I_PDD] [smallint] NULL,
	[I_MDD] [smallint] NULL,
	[I_ACC] [smallint] NULL,
	[I_EVA] [smallint] NULL,
	[I_Speed] [smallint] NULL,
	[I_Craft] [smallint] NULL,
	[I_Jump] [smallint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CashItem_PET]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashItem_PET](
	[CashItemSN] [bigint] NOT NULL,
	[Pos] [int] NULL,
	[PetName] [varchar](100) NULL,
	[PetLevel] [int] NULL,
	[Tameness] [int] NULL,
	[Repleteness] [int] NULL,
	[DeadDate] [datetime] NULL,
	[PetAttribute] [int] NULL,
	[PetSkill] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CashItemBought]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashItemBought](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Number] [smallint] NOT NULL,
	[ActivePeriod] [smallint] NOT NULL,
	[NexonClubID] [varchar](20) NOT NULL,
	[DBID] [tinyint] NOT NULL,
	[ChargeNo] [bigint] NOT NULL,
	[CommodityID] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[PaybackRate] [int] NOT NULL,
	[DiscountRate] [int] NOT NULL,
	[DateExpire] [datetime] NOT NULL,
 CONSTRAINT [PK_CashItemBought] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CashItemBundle]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashItemBundle](
	[CashItemSN] [bigint] NOT NULL,
	[Pos] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Character]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Character](
	[CharacterID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[WorldID] [int] NOT NULL,
	[CharacterName] [varchar](20) NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[LogoutDate] [datetime] NOT NULL,
	[C_Skin] [int] NOT NULL,
	[C_Face] [int] NOT NULL,
	[C_Hair] [int] NOT NULL,
	[C_PetLockerSN] [bigint] NOT NULL,
	[B_Level] [tinyint] NOT NULL,
	[B_Job] [smallint] NOT NULL,
	[B_STR] [smallint] NOT NULL,
	[B_DEX] [smallint] NOT NULL,
	[B_INT] [smallint] NOT NULL,
	[B_LUK] [smallint] NOT NULL,
	[S_HP] [smallint] NOT NULL,
	[S_MaxHP] [smallint] NOT NULL,
	[S_MP] [smallint] NOT NULL,
	[S_MaxMP] [smallint] NOT NULL,
	[S_AP] [smallint] NOT NULL,
	[S_SP] [smallint] NOT NULL,
	[S_EXP] [int] NOT NULL,
	[S_POP] [smallint] NOT NULL,
	[S_Money] [int] NOT NULL,
	[P_Map] [int] NOT NULL,
	[P_Portal] [int] NOT NULL,
	[CheckSum] [int] NOT NULL,
	[ItemCountCheckSum] [int] NOT NULL,
 CONSTRAINT [PK_Character] PRIMARY KEY CLUSTERED 
(
	[CharacterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CHARACTER_UNIQUE_NAME] UNIQUE NONCLUSTERED 
(
	[CharacterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CharacterFame]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterFame](
	[CharacterID] [int] NOT NULL,
	[CharacterIDReceiver] [int] NOT NULL,
	[Lastfame] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CharacterLevel]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterLevel](
	[CharacterID] [int] NULL,
	[Level] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CharacterMoney]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterMoney](
	[CharacterID] [int] NOT NULL,
	[Money] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CharacterSue]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CharacterSue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReporterName] [varchar](13) NULL,
	[CharacterName] [varchar](13) NULL,
	[GameWorldID] [int] NULL,
	[ChannelID] [int] NULL,
	[Field] [int] NULL,
	[Offense] [int] NULL,
	[ChatLog] [varchar](270) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CoupleRecord]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CoupleRecord](
	[CharacterID] [int] NOT NULL,
	[PairCharacterID] [int] NOT NULL,
	[PairCharacterName] [varchar](13) NOT NULL,
	[SN] [bigint] NOT NULL,
	[PairSN] [bigint] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EntrustedShop]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntrustedShop](
	[CharacterID] [int] NULL,
	[SlotCount] [int] NULL,
	[Money] [int] NULL,
	[CloseTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EntrustedShop_CON]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EntrustedShop_CON](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NULL,
	[ItemID_CON] [int] NULL,
	[Number] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [varchar](50) NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EntrustedShop_EQP]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntrustedShop_EQP](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NULL,
	[ItemID_EQP] [int] NULL,
	[RUC] [int] NULL,
	[CUC] [int] NULL,
	[I_STR] [int] NULL,
	[I_DEX] [int] NULL,
	[I_INT] [int] NULL,
	[I_LUK] [int] NULL,
	[I_MaxHP] [int] NULL,
	[I_MaxMP] [int] NULL,
	[I_PAD] [int] NULL,
	[I_MAD] [int] NULL,
	[I_PDD] [int] NULL,
	[I_MDD] [int] NULL,
	[I_ACC] [int] NULL,
	[I_EVA] [int] NULL,
	[I_Speed] [int] NULL,
	[I_Craft] [int] NULL,
	[I_Jump] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [text] NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EntrustedShop_ETC]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntrustedShop_ETC](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NULL,
	[ItemID_ETC] [int] NULL,
	[Number] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [text] NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EntrustedShop_INS]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EntrustedShop_INS](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[ItemID_INS] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Attribute] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EntrustedShopMoney]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntrustedShopMoney](
	[CharacterID] [int] NOT NULL,
	[Money] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Friend]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Friend](
	[CharacterID] [int] NOT NULL,
	[FriendID] [int] NOT NULL,
	[FriendName] [varchar](20) NOT NULL,
	[flag] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FriendCount]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FriendCount](
	[CharacterID] [int] NOT NULL,
	[friendCount] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FriendshipRecord]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FriendshipRecord](
	[CharacterID] [int] NOT NULL,
	[PairCharacterID] [int] NOT NULL,
	[PairCharacterName] [varchar](13) NOT NULL,
	[SN] [bigint] NOT NULL,
	[PairSN] [bigint] NOT NULL,
	[FriendItemID] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FuncKeyMapped]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FuncKeyMapped](
	[CharacterID] [int] NOT NULL,
	[FKMValue] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GuildBBSComment]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuildBBSComment](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSN] [bigint] NOT NULL,
	[CharacterID] [int] NOT NULL,
	[Text] [text] NOT NULL,
	[Date] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GuildBBSEntry]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GuildBBSEntry](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[GuildID] [int] NOT NULL,
	[EntryID] [int] NOT NULL,
	[CharacterID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Emoticon] [int] NOT NULL,
	[CommentCount] [int] NOT NULL,
	[Text] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GuildInfo]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GuildInfo](
	[GuildID] [int] IDENTITY(1,1) NOT NULL,
	[GuildName] [varchar](30) NULL,
	[CountMax] [tinyint] NULL,
	[GradeName1] [varchar](20) NULL,
	[GradeName2] [varchar](20) NULL,
	[GradeName3] [varchar](20) NULL,
	[GradeName4] [varchar](20) NULL,
	[GradeName5] [varchar](20) NULL,
	[MarkBg] [int] NULL,
	[MarkBgColor] [int] NULL,
	[Mark] [int] NULL,
	[MarkColor] [int] NULL,
	[Notice] [varchar](150) NULL,
 CONSTRAINT [PK_GuildInfo] PRIMARY KEY CLUSTERED 
(
	[GuildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GuildMember]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GuildMember](
	[GuildID] [int] NOT NULL,
	[CharacterID] [int] NOT NULL,
	[Grade] [int] NOT NULL,
	[CharacterName] [varchar](20) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GuildPoint]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuildPoint](
	[GuildID] [int] NULL,
	[Point] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImitatedNpc]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImitatedNpc](
	[TemplateID] [int] NULL,
	[CharacterName] [varchar](20) NULL,
	[packedData] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemInitSN]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemInitSN](
	[ChannelID] [int] NOT NULL,
	[InitSN] [bigint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemLocker]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemLocker](
	[SN] [bigint] NOT NULL,
	[AccountID] [int] NULL,
	[CharacterID] [int] NULL,
	[ItemID] [int] NULL,
	[Number] [int] NULL,
	[buyCharacterID] [varchar](13) NULL,
	[ExpiredDate] [datetime] NULL,
	[_Pos] [int] NULL,
	[PaybackRate] [int] NULL,
	[DiscountRate] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemSlot_CON]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemSlot_CON](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[POS] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Attribute] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL,
 CONSTRAINT [PK_ItemSlot_CON] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemSlot_EQP]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemSlot_EQP](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[POS] [int] NOT NULL,
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
	[I_Craft] [int] NOT NULL,
	[I_Jump] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Title] [text] NOT NULL,
	[Attribute] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL,
 CONSTRAINT [PK_ItemSlot_EQP] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemSlot_ETC]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemSlot_ETC](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[POS] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Title] [text] NOT NULL,
	[Attribute] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL,
 CONSTRAINT [PK_ItemSlot_ETC] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemSlot_INS]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemSlot_INS](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[POS] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Attribute] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL,
 CONSTRAINT [PK_ItemSlot_INS] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemSlot_Size]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemSlot_Size](
	[CharacterID] [int] NOT NULL,
	[Equip_slot] [tinyint] NULL,
	[Use_slot] [tinyint] NULL,
	[Setup_slot] [tinyint] NULL,
	[Etc_slot] [tinyint] NULL,
	[Cash_slot] [tinyint] NULL,
 CONSTRAINT [PK_ItemSlot_Count] PRIMARY KEY CLUSTERED 
(
	[CharacterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MapTransfer]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MapTransfer](
	[CharacterID] [int] NOT NULL,
	[Map0] [int] NULL,
	[Map1] [int] NULL,
	[Map2] [int] NULL,
	[Map3] [int] NULL,
	[Map4] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MapTransferEx]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MapTransferEx](
	[CharacterID] [int] NOT NULL,
	[Map0] [int] NULL,
	[Map1] [int] NULL,
	[Map2] [int] NULL,
	[Map3] [int] NULL,
	[Map4] [int] NULL,
	[Map5] [int] NULL,
	[Map6] [int] NULL,
	[Map7] [int] NULL,
	[Map8] [int] NULL,
	[Map9] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MarriageRecord]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MarriageRecord](
	[MarriageNo] [int] IDENTITY(1,1) NOT NULL,
	[GroomID] [int] NOT NULL,
	[BrideID] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[GroomItemID] [int] NOT NULL,
	[BrideItemID] [int] NOT NULL,
	[GroomName] [varchar](13) NOT NULL,
	[BrideName] [varchar](13) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Memo]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Memo](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NULL,
	[Sender] [varchar](13) NOT NULL,
	[Content] [text] NOT NULL,
	[SendDate] [datetime] NOT NULL,
	[Flag] [int] NOT NULL,
	[State] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MiniGameRecord]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MiniGameRecord](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[Win] [int] NOT NULL,
	[Draw] [int] NOT NULL,
	[Lose] [int] NOT NULL,
	[Score] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parcel]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parcel](
	[CharacterID] [int] NOT NULL,
	[Sender] [int] NOT NULL,
	[DeliveryType] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[SlotType] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parcel_Bundle]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parcel_Bundle](
	[ExpireDate] [datetime] NOT NULL,
	[ParcelSN] [bigint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parcel_EQP]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parcel_EQP](
	[ExpireDate] [datetime] NOT NULL,
	[ParcelSN] [bigint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuestComplete]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuestComplete](
	[CharacterID] [int] NOT NULL,
	[QRValue] [varbinary](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuestPerform]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestPerform](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[QRKey] [int] NOT NULL,
	[QuestState] [text] NOT NULL,
 CONSTRAINT [PK_QuestPerform] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShopScannerHotList]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShopScannerHotList](
	[ItemID] [int] NOT NULL,
	[Number] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SkillCooltime]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SkillCooltime](
	[CharacterID] [int] NOT NULL,
	[Cooltime] [varbinary](6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SkillRecord]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SkillRecord](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[SkillID] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[MaxLevel] [int] NOT NULL,
	[MasterLevel] [int] NOT NULL,
 CONSTRAINT [PK_SkillRecord] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TamingMob]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TamingMob](
	[CharacterID] [int] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[Exp] [int] NOT NULL,
	[Fatigue] [tinyint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransferHistory]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransferHistory](
	[CharacterID] [int] NOT NULL,
	[AccountID] [int] NOT NULL,
	[PeerWorldID] [int] NOT NULL,
	[TransferStatus] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trunk]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trunk](
	[AccountID] [int] NOT NULL,
	[Slots] [int] NOT NULL CONSTRAINT [DF_Trunk_Slots]  DEFAULT ((4)),
	[Money] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trunk_CON]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trunk_CON](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Attribute] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL,
 CONSTRAINT [PK_Trunk_CON] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Trunk_EQP]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trunk_EQP](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[ItemID] [int] NULL,
	[RUC] [int] NULL,
	[CUC] [int] NULL,
	[I_STR] [int] NULL,
	[I_DEX] [int] NULL,
	[I_INT] [int] NULL,
	[I_LUK] [int] NULL,
	[I_MaxHP] [int] NULL,
	[I_MaxMP] [int] NULL,
	[I_PAD] [int] NULL,
	[I_MAD] [int] NULL,
	[I_PDD] [int] NULL,
	[I_MDD] [int] NULL,
	[I_ACC] [int] NULL,
	[I_EVA] [int] NULL,
	[I_Speed] [int] NULL,
	[I_Craft] [int] NULL,
	[I_Jump] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [text] NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL,
 CONSTRAINT [PK_Trunk_EQP] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trunk_ETC]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trunk_ETC](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NULL,
	[ItemID] [int] NULL,
	[Number] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [text] NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trunk_INS]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trunk_INS](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[ItemID] [int] NULL,
	[Number] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [text] NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL,
 CONSTRAINT [PK_Trunk_INS] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrunkMoney]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrunkMoney](
	[AccountID] [int] NULL,
	[Money] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WeddingGift_CON]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WeddingGift_CON](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[ReservationNo] [int] NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[ItemID_CON] [int] NULL,
	[Number] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [varchar](50) NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WeddingGift_EQP]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeddingGift_EQP](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[ReservationNo] [int] NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[ItemID_EQP] [int] NULL,
	[RUC] [int] NULL,
	[CUC] [int] NULL,
	[I_STR] [int] NULL,
	[I_DEX] [int] NULL,
	[I_INT] [int] NULL,
	[I_LUK] [int] NULL,
	[I_MaxHP] [int] NULL,
	[I_MaxMP] [int] NULL,
	[I_PAD] [int] NULL,
	[I_MAD] [int] NULL,
	[I_PDD] [int] NULL,
	[I_MDD] [int] NULL,
	[I_ACC] [int] NULL,
	[I_EVA] [int] NULL,
	[I_Speed] [int] NULL,
	[I_Craft] [int] NULL,
	[I_Jump] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [text] NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WeddingGift_ETC]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeddingGift_ETC](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[ReservationNo] [int] NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[ItemID_ETC] [int] NULL,
	[Number] [int] NULL,
	[ExpireDate] [datetime] NULL,
	[Title] [text] NULL,
	[Attribute] [int] NULL,
	[ItemSN] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WeddingGift_INS]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WeddingGift_INS](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[ReservationNo] [int] NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[ItemID_INS] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[ExpireDate] [datetime] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Attribute] [int] NOT NULL,
	[ItemSN] [bigint] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WeddingReservation]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WeddingReservation](
	[ReservationNo] [int] NOT NULL,
	[GroomID] [int] NOT NULL,
	[BrideID] [int] NOT NULL,
	[GroomName] [varchar](13) NOT NULL,
	[BrideName] [varchar](13) NOT NULL,
	[WeddingType] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WishList]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WishList](
	[CharacterID] [int] NULL,
	[CommoditySN_1] [int] NULL,
	[CommoditySN_2] [int] NULL,
	[CommoditySN_3] [int] NULL,
	[CommoditySN_4] [int] NULL,
	[CommoditySN_5] [int] NULL,
	[CommoditySN_6] [int] NULL,
	[CommoditySN_7] [int] NULL,
	[CommoditySN_8] [int] NULL,
	[CommoditySN_9] [int] NULL,
	[CommoditySN_10] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WishList_Wedding]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WishList_Wedding](
	[ReservationNo] [int] NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[ItemName] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WorldSpecificEvent]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorldSpecificEvent](
	[ItemCount] [int] NOT NULL,
	[CharacterCount] [int] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CharacterLevel]  WITH CHECK ADD  CONSTRAINT [FK_CharacterLevel_Character] FOREIGN KEY([CharacterID])
REFERENCES [dbo].[Character] ([CharacterID])
GO
ALTER TABLE [dbo].[CharacterLevel] CHECK CONSTRAINT [FK_CharacterLevel_Character]
GO
ALTER TABLE [dbo].[CharacterMoney]  WITH CHECK ADD  CONSTRAINT [FK_CharacterMoney_Character] FOREIGN KEY([CharacterID])
REFERENCES [dbo].[Character] ([CharacterID])
GO
ALTER TABLE [dbo].[CharacterMoney] CHECK CONSTRAINT [FK_CharacterMoney_Character]
GO
/****** Object:  StoredProcedure [dbo].[AddMarriageRecord]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
declare @p8 int
set @p8=NULL
exec AddMarriageRecord 83,69,1,4031357,4031358,'Coders','ImBee',@p8 output
select @p8

*/
CREATE PROCEDURE [dbo].[AddMarriageRecord]
@GroomID int,
@BrideID int,
@Status int,
@GroomItemID int,
@BrideItemID int,
@GroomName varchar(13),
@BrideName varchar(13),
@MarriageNo int output
AS
BEGIN
	INSERT INTO MarriageRecord VALUES(@GroomID, @BrideID, @Status, @GroomItemID, @BrideItemID, @GroomName, @BrideName);
	SET @MarriageNo = SCOPE_IDENTITY();
	return(0);
END;


GO
/****** Object:  StoredProcedure [dbo].[Avatar_Update]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 for positive ints:

	a << b = a * power(2, b)
	a >> b = a / power(2, b)


*/
CREATE PROCEDURE [dbo].[Avatar_Update]
	-- Add the parameters for the stored procedure here
	@CharacterID int,
	@p2 varbinary(20),
	@p3 varbinary(2)
AS
BEGIN
	DECLARE @firstBit varbinary(1) = substring(@p2, 1, 1);
	DECLARE @secondBit varbinary(1) = substring(@p2, 2, 1);
	DECLARE @thirdBit varbinary(1) = substring(@p2, 3, 1);
	DECLARE @fourBit varbinary(1) = substring(@p2, 4, 1);
	DECLARE @Gender int = CAST((@firstBit & 1) AS int);
	DECLARE @Skin int = CAST((@firstBit / power(2, 1)) & 0xF AS int);
	DECLARE @firstCheck int = CAST((@secondBit / power(2, 7)) & 0xF AS int);
	DECLARE @v18 int;
	IF @firstCheck > 0
		BEGIN
			SET @v18 = 2000;
		END
	ELSE
	BEGIN
		SET @v18 = 1000 * @Gender;
	END;
	
	DECLARE @nFaceLow int = CAST((@firstBit / power(2, 5)) & 0x3FF AS int) + @v18 + 20000;

	SET @nFaceLow = @nFaceLow + CAST((@secondBit * power(2, 3)) AS int);

	DECLARE @anHairEquipZero int = CAST(@thirdBit as int)  & 0x3FF;
	DECLARE @anHairEquipOne int;
	IF @anHairEquipZero = 1023
	BEGIN
		SET @anHairEquipZero = 0;
	END
	ELSE
	BEGIN
		DECLARE @secondCheck int = CAST((@fourBit / power(2, 2)) & 0x1 AS int);
		DECLARE @v17 int = 0;
		IF @secondCheck > 0
		BEGIN
			SET @v17 = 2000;
		END;
		ELSE
		BEGIN
			SET @v17 = 1000 * @Gender;
		END;
		SET @anHairEquipZero = @anHairEquipZero + @v17 + 30000;
	END;
	SET @anHairEquipOne = CAST((@fourBit / power(2, 3)) & 0x3FF AS int);
	
	IF((@fourBit & 1) = 1) 
	BEGIN
	 SET @anHairEquipZero = @anHairEquipZero + 256;
	END;

	IF((@fourBit & 2^7) = 2^7)
	BEGIN
		SET @anHairEquipZero = @anHairEquipZero + 512;
	END;

	UPDATE Character 
		SET Gender = @Gender, 
			C_Skin = @Skin,
			C_Face = @nFaceLow,
			C_Hair = @anHairEquipZero
	WHERE 
		CharacterID = @CharacterID;

	SET NOCOUNT ON;

	SELECT @firstBit as firstByte, CAST((@secondBit * power(2, 3)) AS int) as secondByte,  @Gender as Gender, @Skin as Skin, @nFaceLow as Face, @anHairEquipZero as Hair, @fourBit, CASE @fourBit & 1 WHEN 1 THEN 1 WHEN 0 THEN 0 END;
	
    -- Insert statements for procedure here
	RETURN(0)
END



GO
/****** Object:  StoredProcedure [dbo].[BuyCashItem]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Erwin Oegema
-- Create date: 2015-10-04
-- Description:	CashShop call to create a new cash item
-- =============================================
CREATE PROCEDURE [dbo].[BuyCashItem] 
	 	@AccountID int, 
	@ItemID int,
	@Number smallint,
	@ActivePeriod smallint,
	@NexonClubID varchar(20),
	@DBID tinyint,
	@ChargeNo bigint,
	@CommodityID int,
	@Price int,
	@PaybackRate int,
	@DiscountRate int,
	@DateExpire datetime output,
	@SN bigint output
AS
BEGIN
	
	IF @ChargeNo < 0
	BEGIN
		SELECT 0, 0;
		RETURN(-2);
	END
	IF [dbo].isPetItem(@ItemID) = 1
	BEGIN 
	 SET @ActivePeriod = 90;
	END;
	
	
	SET @DateExpire = DATEADD(day, @ActivePeriod, CURRENT_TIMESTAMP);
	

	INSERT INTO CashItemBought VALUES (
		@AccountID, 
		@ItemID,
		@Number,
		@ActivePeriod,
		@NexonClubID,
		@DBID,
		@ChargeNo,
		@CommodityID,
		@Price,
		@PaybackRate,
		@DiscountRate,
		@DateExpire
	);
	SET @SN = SCOPE_IDENTITY();
		
	INSERT INTO [dbo].[ItemLocker]
           ([SN]
		   ,[CharacterID]
           ,[AccountID]
		   ,[buyCharacterID]
           ,[_Pos]
           ,[ItemID]
           ,[Number]
           ,[ExpiredDate]
           ,[PaybackRate]
           ,[DiscountRate]
           )
     VALUES
           (@SN,
			0,
			@AccountID,
			'',
			1,
			@ItemID,
			@Number,
			@DateExpire,
			0,
			0);
	
	

	
	
	
END;

GO
/****** Object:  StoredProcedure [dbo].[BuyCashItemByMaplePoint]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuyCashItemByMaplePoint]
   	@AccountID int, 
	@ItemID int,
	@Number smallint,
	@ActivePeriod smallint,
	@NexonClubID varchar(20),
	@DBID tinyint,
	@ChargeNo bigint,
	@CommodityID int,
	@Price int,
	@PaybackRate int,
	@DiscountRate int,
	@DateExpire datetime output,
	@SN bigint output
AS
BEGIN
	DECLARE @maplePoint int;

	SELECT 
		@maplePoint = maplePoint 
	FROM 
		GlobalAccount.dbo.Account 
	WHERE AccountID = @AccountID;

	IF @maplePoint > 0 AND @maplePoint > @price
	BEGIN
			UPDATE GlobalAccount.dbo.Account 
			SET maplePoint = (@maplePoint - @price)
			WHERE AccountID = @AccountID;
	END
	ELSE
	BEGIN
		SELECT 0, 0;
		RETURN(2);
	END; 

	IF [dbo].isPetItem(@ItemID) = 1
	BEGIN 
	 SET @ActivePeriod = 90;
	END;
	
	SET @DateExpire = DATEADD(day, @ActivePeriod, CURRENT_TIMESTAMP);
	
	

	INSERT INTO CashItemBought VALUES (
		@AccountID, 
		@ItemID,
		@Number,
		@ActivePeriod,
		@NexonClubID,
		@DBID,
		@ChargeNo,
		@CommodityID,
		@Price,
		@PaybackRate,
		@DiscountRate,
		@DateExpire
	);
	SET @SN = SCOPE_IDENTITY();
		
	INSERT INTO [dbo].[ItemLocker]
           ([SN]
		   ,[CharacterID]
           ,[AccountID]
		   ,[buyCharacterID]
           ,[_Pos]
           ,[ItemID]
           ,[Number]
           ,[ExpiredDate]
           ,[PaybackRate]
           ,[DiscountRate]
           )
     VALUES
           (@SN,
			0,
			@AccountID,
			'',
			1,
			@ItemID,
			@Number,
			@DateExpire,
			0,
			0);
	
	

	

	
	
END;


GO
/****** Object:  StoredProcedure [dbo].[BuyCoupleCashItem]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
 Return values: 
 -1

*/


--{ call BuyCoupleCashItem( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) }
CREATE PROCEDURE [dbo].[BuyCoupleCashItem]
@WorldID int,
@RcvCharacterName varchar(13),
@SndCharacterName varchar(13),
@Text varchar(200),
@ItemID int,
@Number int,
@ActivePeriod int,
@NexonClubID varchar(20),
@DbID int,
@ChargeNo int,
@CommodityID int,
@Price int,
@PaybackRate int,
@PaybackRate2 int,
@DiscountRate int,
@RcvCharacterID int output,
@OgnRcvCharacterName varchar(13) output,
@SNRcv bigint output,
@SNSnd bigint output,
@DateExpire datetime output,
@Error int output

AS
BEGIN
	DECLARE @SndCharacterID int; DECLARE @RcvAccountID int;
	SET @RcvCharacterID = [dbo].GetIDFromCharacterName(@RcvCharacterName);
	SET @RcvAccountID = [dbo].GetAccountIDFromCharacterName(@RcvCharacterName);
	SET @SndCharacterID = [dbo].GetIDFromCharacterName(@SndCharacterName);

	DECLARE @CoupleSnd int;
	DECLARE @CoupleRcv int;
	SELECT @CoupleSnd = count(*) FROM CoupleRecord WHERE CharacterID = @SndCharacterID;
	SELECT @CoupleRcv = count(*) FROM CoupleRecord WHERE CharacterID = @SndCharacterID;

	/*IF @CoupleSnd > 0 or @CoupleRcv > 0 or @RcvCharacterID IS NULL or @SndCharacterID IS NULL OR @RcvAccountID IS NULL
	BEGIN
	 SET @Error = 1;
	 RETURN(0);
	END;*/

	SET @OgnRcvCharacterName = @RcvCharacterName;	
	
	exec CreateCoupleCashItem @WorldID, @RcvCharacterName, @Text, @ItemID, @Number, @ActivePeriod, @NexonClubID, @DbID, @ChargeNo,@CommodityID,@Price,@PaybackRate, @PaybackRate2,@DiscountRate, @SNRcv output, @DateExpire output
    exec CreateCoupleCashItem @WorldID, @SndCharacterName, @Text, @ItemID, @Number, @ActivePeriod, @NexonClubID, @DbID, @ChargeNo,@CommodityID,@Price,@PaybackRate, @PaybackRate2,@DiscountRate, @SNSnd output, @DateExpire output
   
    INSERT INTO CoupleRecord VALUES(@SndCharacterID, @RcvCharacterID, @RcvCharacterName, @SNSnd, @SNRcv);
	INSERT INTO CoupleRecord VALUES(@RcvCharacterID, @SndCharacterID, @SndCharacterName, @SNRcv, @SNSnd);
	
    SET @Error = 0;

	

	return(3);

END



GO
/****** Object:  StoredProcedure [dbo].[BuyFriendshipCashItem]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
 Return values: 
 -1

*/

--{ call BuyFriendshipCashItem
CREATE PROCEDURE [dbo].[BuyFriendshipCashItem]
@WorldID int,
@RcvCharacterName varchar(13), 
@SndCharacterName varchar(13), 
@Text varchar(200), 
@ItemID int, 
@Number int,
@ActivePeriod int,
@NexonClubID varchar(20),
@DbID int,
@ChargeNo int,
@CommodityID int,
@Price int,
@RcvCharacterID int output,
@OgnRcvCharacterName varchar(13) output,
@SNRcv bigint output,
@SNSnd bigint output,
@DateExpire datetime output,
@Error int output

AS
BEGIN
	DECLARE @SndCharacterID int; DECLARE @RcvAccountID int;
	SET @RcvCharacterID = [dbo].GetIDFromCharacterName(@RcvCharacterName);
	SET @RcvAccountID = [dbo].GetAccountIDFromCharacterName(@RcvCharacterName);
	SET @SndCharacterID = [dbo].GetIDFromCharacterName(@SndCharacterName);

	DECLARE @CoupleSnd int;
	DECLARE @CoupleRcv int;
	SELECT @CoupleSnd = count(*) FROM FriendshipRecord WHERE CharacterID = @SndCharacterID;
	SELECT @CoupleRcv = count(*) FROM FriendshipRecord WHERE CharacterID = @SndCharacterID;

	IF @RcvCharacterID IS NULL or @SndCharacterID IS NULL OR @RcvAccountID IS NULL
	BEGIN
	 SET @Error = 1;
	 RETURN(0);
	END;
	
	SET @OgnRcvCharacterName = @RcvCharacterName;	
	
	exec CreateCoupleCashItem @WorldID, @RcvCharacterName, @Text, @ItemID, @Number, @ActivePeriod, @NexonClubID, @DbID, @ChargeNo,@CommodityID,@Price,0, 0,0, @SNRcv output, @DateExpire output
    exec CreateCoupleCashItem @WorldID, @SndCharacterName, @Text, @ItemID, @Number, @ActivePeriod, @NexonClubID, @DbID, @ChargeNo,@CommodityID,@Price,0, 0,0, @SNSnd output, @DateExpire output
   
    INSERT INTO FriendshipRecord VALUES(@SndCharacterID, @RcvCharacterID, @RcvCharacterName, @SNSnd, @SNRcv, @ItemID);
	INSERT INTO FriendshipRecord VALUES(@RcvCharacterID, @SndCharacterID, @SndCharacterName, @SNRcv, @SNSnd, @ItemID);
	
    SET @Error = 0;

	

	return(0);

END




GO
/****** Object:  StoredProcedure [dbo].[CheckGivePopularity]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  2- Users bellow 15 cannot fame.
  3- Cannot fame today.
  4- Cannot fame this user this month.

*/
CREATE PROCEDURE [dbo].[CheckGivePopularity]
@CharacterID int,
@TargetCharacterID int
AS
BEGIN
	DECLARE @LastFameDate datetime;
	DECLARE @LastFameDateForCharacter datetime;
	DECLARE @Diff int;
	DECLARE @Fames int;
	DECLARE @FamesCharacter int;
	SELECT @LastFameDate = MAX(Lastfame), @Fames = COUNT(*) FROM CharacterFame WHERE CharacterID = @CharacterID;
	SELECT @LastFameDateForCharacter = MAX(Lastfame), @FamesCharacter = COUNT(*) FROM CharacterFame WHERE CharacterID = @CharacterID AND CharacterIDReceiver = @TargetCharacterID;
	IF (@Fames = 0) 
	BEGIN
		INSERT INTO CharacterFame VALUES(@CharacterID, @TargetCharacterID, GETDATE());
		RETURN(0);
	END;
	IF(@FamesCharacter > 0 AND DATEDIFF(day, @LastFameDateForCharacter, CURRENT_TIMESTAMP) < 30)
	BEGIN
		RETURN(4);
	END;
	SET @Diff = DATEDIFF(day, @LastFameDate, CURRENT_TIMESTAMP);
	IF (@Diff > 0)
	BEGIN
		INSERT INTO CharacterFame VALUES(@CharacterID, @TargetCharacterID, GETDATE());
		RETURN(0);
	END;
	
	RETURN(3);
END



GO
/****** Object:  StoredProcedure [dbo].[CreateCoupleCashItem]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[CreateCoupleCashItem]
@WorldID int,
@CharacterName varchar(13),
@Text varchar(200),
@ItemID int,
@Number int,
@ActivePeriod int,
@NexonClubID varchar(20),
@DbID int,
@ChargeNo int,
@CommodityID int,
@Price int,
@PaybackRate int,
@PaybackRate2 int,
@DiscountRate int,
@SN bigint output,
@DateExpire datetime output
AS
BEGIN  
    DECLARE @AccountID varchar(13);
    SET @DateExpire = DATEADD(day, @ActivePeriod, CURRENT_TIMESTAMP);
	SET @AccountID = [dbo].GetAccountIDFromCharacterName(@CharacterName);
	INSERT INTO CashItemBought VALUES (
		@AccountID, 
		@ItemID,
		@Number,
		@ActivePeriod,
		@NexonClubID,
		@DBID,
		@ChargeNo,
		@CommodityID,
		@Price,
		@PaybackRate,
		@DiscountRate,
		@DateExpire
	);
	SET @SN = SCOPE_IDENTITY();

	INSERT INTO [dbo].[ItemLocker]
           ([SN]
		   ,[CharacterID]
           ,[AccountID]
		   ,[buyCharacterID]
           ,[_Pos]
           ,[ItemID]
           ,[Number]
           ,[ExpiredDate]
           ,[PaybackRate]
           ,[DiscountRate]
           )
     VALUES
           (@SN,
			0,
			@AccountID,
			'',
			1,
			@ItemID,
			@Number,
			@DateExpire,
			0,
			0);

	
	return(-1);

END
GO
/****** Object:  StoredProcedure [dbo].[CreateNewCharacter]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateNewCharacter]
	@AccountID int,
	@WorldID int,
	@CharacterName varchar(20),
	@Gender int,
	@FaceID int,
	@SkinID int,
	@HairID int,
	@p8 int,--hat?
	@Equip_Top int,
	@Equip_Bottom int,
	@Equip_Shoes int,
	@p12 int,--glove?
	@p13 int,--shield?
	@Equip_Weapon int,
	@STR int,
	@DEX int,
	@INT int,
	@LUK int,
	@CheckSum int,--or not?
	@NewCharacterID int output
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--INSERT INTO [Character] VALUES (@AccountID, @WorldID, @CharacterName, @Gender, GETDATE(), @SkinID, @FaceID, @HairID, 0, 1, 0, @STR, @DEX, @INT, @LUK, 50, 50, 50, 50, 0, 0, 0, 0, 0, 0, 0, @CheckSum, 0);
	INSERT INTO [Character] VALUES (@AccountID, @WorldID, @CharacterName, @Gender, GETDATE(), @SkinID, @FaceID, @HairID, 0, 1, 0, @STR, @DEX, @INT, @LUK, 50, 50, 50, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	SET @NewCharacterID = SCOPE_IDENTITY()

	--Add shoes
	INSERT INTO [ItemSlot_EQP]
           ([CharacterID]
           ,[POS]
           ,[ItemID]
           ,[RUC]
           ,[CUC]
           ,[I_STR]
           ,[I_DEX]
           ,[I_INT]
           ,[I_LUK]
           ,[I_MaxHP]
           ,[I_MaxMP]
           ,[I_PAD]
           ,[I_MAD]
           ,[I_PDD]
           ,[I_MDD]
           ,[I_ACC]
           ,[I_EVA]
           ,[I_Speed]
           ,[I_Craft]
           ,[I_Jump]
           ,[ExpireDate]
           ,[Title]
           ,[Attribute]
           ,[ItemSN])
     VALUES
           (@NewCharacterID
           ,-7
           ,@Equip_Shoes
           ,7
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,2
           ,0
           ,0
           ,0
           ,0
           ,0
           ,99999
           ,''
           ,0
           ,0);

	--Add bottom:
	INSERT INTO [ItemSlot_EQP]
           ([CharacterID]
           ,[POS]
           ,[ItemID]
           ,[RUC]
           ,[CUC]
           ,[I_STR]
           ,[I_DEX]
           ,[I_INT]
           ,[I_LUK]
           ,[I_MaxHP]
           ,[I_MaxMP]
           ,[I_PAD]
           ,[I_MAD]
           ,[I_PDD]
           ,[I_MDD]
           ,[I_ACC]
           ,[I_EVA]
           ,[I_Speed]
           ,[I_Craft]
           ,[I_Jump]
           ,[ExpireDate]
           ,[Title]
           ,[Attribute]
           ,[ItemSN])
     VALUES
           (@NewCharacterID
           ,-6
           ,@Equip_Bottom
           ,7
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,2
           ,0
           ,0
           ,0
           ,0
           ,0
           ,99999
           ,''
           ,0
           ,0);

	--Add top
	INSERT INTO [ItemSlot_EQP]
           ([CharacterID]
           ,[POS]
           ,[ItemID]
           ,[RUC]
           ,[CUC]
           ,[I_STR]
           ,[I_DEX]
           ,[I_INT]
           ,[I_LUK]
           ,[I_MaxHP]
           ,[I_MaxMP]
           ,[I_PAD]
           ,[I_MAD]
           ,[I_PDD]
           ,[I_MDD]
           ,[I_ACC]
           ,[I_EVA]
           ,[I_Speed]
           ,[I_Craft]
           ,[I_Jump]
           ,[ExpireDate]
           ,[Title]
           ,[Attribute]
           ,[ItemSN])
     VALUES
           (@NewCharacterID
           ,-5
           ,@Equip_Top
           ,7
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,2
           ,0
           ,0
           ,0
           ,0
           ,0
           ,99999
           ,''
           ,0
           ,0);
	--Add weapon
	INSERT INTO [ItemSlot_EQP]
           ([CharacterID]
           ,[POS]
           ,[ItemID]
           ,[RUC]
           ,[CUC]
           ,[I_STR]
           ,[I_DEX]
           ,[I_INT]
           ,[I_LUK]
           ,[I_MaxHP]
           ,[I_MaxMP]
           ,[I_PAD]
           ,[I_MAD]
           ,[I_PDD]
           ,[I_MDD]
           ,[I_ACC]
           ,[I_EVA]
           ,[I_Speed]
           ,[I_Craft]
           ,[I_Jump]
           ,[ExpireDate]
           ,[Title]
           ,[Attribute]
           ,[ItemSN])
     VALUES
           (@NewCharacterID
           ,-11
           ,@Equip_Weapon
           ,7
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,17
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,99999
           ,''
           ,0
           ,0);
    
	EXEC InventorySize_Set @NewCharacterID, 24, 24, 24, 24, 64;

	SELECT * FROM Trunk WHERE AccountID = @AccountID;
	IF @@ROWCOUNT < 1
	BEGIN
	  INSERT INTO Trunk VALUES(@AccountID, 4, 0);
	END;

	RETURN(0)
END



GO
/****** Object:  StoredProcedure [dbo].[CreateNewGuild]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--.data:019F3EF4 00000039 C { ? = call CreateNewGuild( ?, ?, ?, ?, ?, ?, ?, ?, ? ) }
CREATE PROCEDURE [dbo].[CreateNewGuild]
@GuildID [int] output,
@GuildName [varchar](20),
@CountMax [int],
@CharacterID_1 [int],
@CharacterID_2 [int],
@CharacterID_3 [int],
@CharacterID_4 [int],
@CharacterID_5 [int],
@CharacterID_6 [int]
AS
BEGIN 
	BEGIN TRAN
	INSERT INTO 
	GuildInfo 
	(
	GuildName,
	CountMax,
	GradeName1,
	GradeName2,
	GradeName3,
	GradeName4,
	GradeName5,
	MarkBg,
	MarkBgColor,
	Mark,
	MarkColor,
	Notice
	)VALUES(
		@GuildName,
		@CountMax,
		'Mestre',
		'Membro',
		'Membro',
		'Membro',
		'Membro',
		0,
		0,
		0,
		0,
		''
	);
	
	--GuildInfo (GuildName, CountMax) VALUES (@GuildName, @CountMax);
	SET @GuildID = SCOPE_IDENTITY()

	DECLARE @NAME_1 varchar(20);
	DECLARE @NAME_2 varchar(20);
	DECLARE @NAME_3 varchar(20);
	DECLARE @NAME_4 varchar(20);
	DECLARE @NAME_5 varchar(20);
	DECLARE @NAME_6 varchar(20);

	SELECT @NAME_1 = CharacterName FROM Character WHERE CharacterID = @CharacterID_1;
	SELECT @NAME_2 = CharacterName FROM Character WHERE CharacterID = @CharacterID_2;
	SELECT @NAME_3 = CharacterName FROM Character WHERE CharacterID = @CharacterID_3;
	SELECT @NAME_4 = CharacterName FROM Character WHERE CharacterID = @CharacterID_4;
	SELECT @NAME_5 = CharacterName FROM Character WHERE CharacterID = @CharacterID_5;
	SELECT @NAME_6 = CharacterName FROM Character WHERE CharacterID = @CharacterID_6;

	INSERT INTO GuildMember(GuildID, CharacterID, Grade, CharacterName) VALUES (@GuildID, @CharacterID_1, 1, @NAME_1);
	INSERT INTO GuildMember(GuildID, CharacterID, Grade, CharacterName)  VALUES (@GuildID, @CharacterID_2, 5, @NAME_2);
	INSERT INTO GuildMember(GuildID, CharacterID, Grade, CharacterName)  VALUES (@GuildID, @CharacterID_3, 5, @NAME_3);
	INSERT INTO GuildMember(GuildID, CharacterID, Grade, CharacterName)  VALUES (@GuildID, @CharacterID_4, 5, @NAME_4);
	INSERT INTO GuildMember(GuildID, CharacterID, Grade, CharacterName)  VALUES (@GuildID, @CharacterID_5, 5, @NAME_5);
	INSERT INTO GuildMember(GuildID, CharacterID, Grade, CharacterName)  VALUES (@GuildID, @CharacterID_6, 5, @NAME_6);

	COMMIT;
	
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteCharacter]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteCharacter]
	@AccountID int,
	@p2 int,
	@CharacterID int,
	@p4 int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--exec DeleteCharacter 5,0,12,0
	DELETE FROM [Character] WHERE CharacterID = @CharacterID AND AccountID = @AccountID
	IF @@ROWCOUNT < 0
	BEGIN
		return(1);
	END;


	DELETE FROM [ItemLocker] WHERE CharacterID =  @CharacterID;
	DELETE FROM [GuildMember] WHERE CharacterID = @CharacterID;
	
	DELETE FROM [ItemSlot_CON] WHERE CharacterID = @CharacterID;
	DELETE FROM [ItemSlot_EQP] WHERE CharacterID = @CharacterID;
	DELETE FROM [ItemSlot_ETC] WHERE CharacterID = @CharacterID;
	DELETE FROM [ItemSlot_INS] WHERE CharacterID = @CharacterID;
	
	DELETE FROM [ItemSlot_CON] WHERE CharacterID = @CharacterID;
	DELETE FROM [ItemSlot_EQP] WHERE CharacterID = @CharacterID;
	DELETE FROM [ItemSlot_ETC] WHERE CharacterID = @CharacterID;
	DELETE FROM [ItemSlot_INS] WHERE CharacterID = @CharacterID;


	DELETE FROM [SkillRecord] WHERE CharacterID = @CharacterID;
	DELETE FROM [SkillCooltime] WHERE CharacterID = @CharacterID;
	
	DELETE FROM [QuestComplete] WHERE CharacterID = @CharacterID;
	DELETE FROM [QuestPerform] WHERE CharacterID = @CharacterID;
	DELETE FROM [WishList] WHERE CharacterID = @CharacterID;
	DELETE FROM [FuncKeyMapped]  WHERE CharacterID = @CharacterID;
	DELETE FROM [ItemSlot_Size] WHERE CharacterID = @CharacterID;


	RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteMarriageRecord]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[DeleteMarriageRecord]
@MarriageNo int
AS
BEGIN
	DELETE FROM MarriageRecord WHERE MarriageNo = @MarriageNo;
	return(0);
END;




GO
/****** Object:  StoredProcedure [dbo].[DeleteWeddingReservation]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[DeleteWeddingReservation]
@ReservationNo int
AS
BEGIN
	DELETE FROM WeddingReservation WHERE ReservationNo = @ReservationNo;
	DELETE FROM WishList_Wedding WHERE ReservationNo = @ReservationNo; 
	return(0);
END;





GO
/****** Object:  StoredProcedure [dbo].[ExpireCashItem]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExpireCashItem]
@AccountID int,
@CharacterID int,
@SN int
AS
BEGIN
	DECLARE @Expire datetime;
	DECLARE @ItemID int = 0;
	SET @Expire =  GETDATE();
	SELECT @ItemID = ItemID FROM ItemLocker WHERE SN = @SN AND AccountID = @AccountID AND ExpiredDate < @Expire;
	IF @ItemID > 0
	 BEGIN

		IF [dbo].isPetItem(@ItemID) = 1
		BEGIN
		  UPDATE ItemLocker SET CharacterID = 0, ExpiredDate = cast('01/01/2079 23:59:59' as datetime) WHERE SN = @SN;
		  UPDATE CashItem_PET SET Repleteness = 0, DeadDate = cast('01/01/2079 23:59:59' as datetime)  Where CashItemSN = @SN;
		  
		  RETURN(0);
		END;

		DELETE FROM ItemLocker WHERE SN = @SN AND AccountID = @AccountID AND ExpiredDate < @Expire;
		DELETE FROM CashItem_EQP WHERE CashItemSN = @SN;
		DELETE FROM CashItem_PET WHERE CashItemSN = @SN;
		DELETE FROM CoupleRecord WHERE SN = @SN;
		DELETE FROM CashItemBundle WHERE CashItemSN = @SN;
	 END
	return(0);
END

GO
/****** Object:  StoredProcedure [dbo].[GetCharacterIdList]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCharacterIdList]

@AccountID int

AS
BEGIN
     DECLARE @World INT;
     SELECT 
      @World = ChannelID
     FROM [UserConnection].[dbo].[Connections]
	 WHERE AccountID = @AccountID;
     SELECT * FROM [Character] WHERE AccountID = @AccountID
	 AND WorldID = @World;
END

GO
/****** Object:  StoredProcedure [dbo].[GetCharacterInfoByName]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCharacterInfoByName]
	@CharacterName varchar(20),
	@CharacterID int output,
	@WorldID smallint output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @CharacterID = CharacterID, @WorldID = WorldID FROM [Character] WHERE CharacterName = @CharacterName
	RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[GetEquippedItemList]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetEquippedItemList]
	@AccountID int,
	@CharacterID int
AS
BEGIN
	SET NOCOUNT ON;

   SELECT POS, ItemID FROM [ItemSlot_EQP] WHERE CharacterID = @CharacterID AND POS < 0
    UNION 
   SELECT POS, ItemID FROM ItemLocker INNER JOIN CashItem_EQP ON CashItemSN = SN
		WHERE CharacterID = @CharacterID AND POS < 0;
   RETURN(1)
END

GO
/****** Object:  StoredProcedure [dbo].[GetRank]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetRank]
	@WorldID int,
	@CharacterID int,
	@Rank int = NULL output,
	@RankMove int = NULL output,
	@JobRank int = NULL output,
	@JobRankMove int = NULL output
AS
BEGIN
	EXEC GlobalAccount.dbo.GetRankJob @WorldID, @CharacterID, @JobRank = @JobRank OUTPUT;
	SELECT 
		@Rank = Rank_
	FROM(
		SELECT 
			CharacterID, 
			CharacterName, 
			B_Job, B_Level, ROW_NUMBER()  OVER(order by B_Level desc) 
			Rank_ 
		FROM 
			GameWorld.dbo.Character WHERE AccountID NOT IN (
				SELECT AccountID From GlobalAccount.dbo.Account WHERE Admin IN (1, 255) OR IsBanned = 1
			)
	) a
	WHERE 
		a.CharacterID = @CharacterID
	SET @RankMove = 0
	SET @JobRankMove = 0
	RETURN(0)
END






GO
/****** Object:  StoredProcedure [dbo].[GetReceivedGiftList]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetReceivedGiftList]
	@AccountID int
AS
BEGIN
    SET NOCOUNT ON;

	SELECT 1;

	RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[GiveCommodityItemToAccount]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GiveCommodityItemToAccount]
@AccountID int,
@ItemID int,
@Number int,
@ActivePeriod int,
@SN_Item int output
AS
BEGIN
	DECLARE @DateExpire datetime;
	DECLARE @SN int;
	SET @DateExpire = DATEADD(day, @ActivePeriod, CURRENT_TIMESTAMP);
	
	INSERT INTO CashItemBought VALUES (
				@AccountID, 
				@ItemID,
				@Number,
				@ActivePeriod,
				'gift',
				'',
				0,
				0,
				0,
				0,
				0,
				@DateExpire
			);
	SET @SN = SCOPE_IDENTITY();
	SET @SN_Item = @SN;
	INSERT INTO [dbo].[ItemLocker]
           ([SN]
		   ,[CharacterID]
           ,[AccountID]
		   ,[buyCharacterID]
           ,[_Pos]
           ,[ItemID]
           ,[Number]
           ,[ExpiredDate]
           ,[PaybackRate]
           ,[DiscountRate]
           )
     VALUES
           (@SN,
			0,
			@AccountID,
			'',
			1,
			@ItemID,
			@Number,
			@DateExpire,
			0,
			0);
				IF @ItemID >= 5000000 AND @ItemID <= 5000100 
				BEGIN
					INSERT INTO [dbo].CashItem_PET
					([CashItemSN]
					  ,[Pos]
					  ,[PetName]
					  ,[PetLevel]
					  ,[Tameness]
					  ,[Repleteness]
					  ,[DeadDate]
					  ,[PetAttribute]
					  ,[PetSkill])
					VALUES(
					@SN,
					0,
					'Fanzinho',
					0,
					0,
					100,
					@DateExpire,
					0,
					0
					);
				END


				IF @ItemID / 1000000 = 1
				BEGIN
					INSERT INTO [dbo].[CashItem_EQP]
					   ([CashItemSN]
					  ,[POS]
					  ,[RUC]
					  ,[CUC]
					  ,[I_STR]
					  ,[I_DEX]
					  ,[I_INT]
					  ,[I_LUK]
					  ,[I_MaxHP]
					  ,[I_MaxMP]
					  ,[I_PAD]
					  ,[I_MAD]
					  ,[I_PDD]
					  ,[I_MDD]
					  ,[I_ACC]
					  ,[I_EVA]
					  ,[I_Speed]
					  ,[I_Craft]
					  ,[I_Jump])
					VALUES
					   (@SN
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0
					   ,0);
		END;

	return(0);
END



GO
/****** Object:  StoredProcedure [dbo].[GiveFreeCommodityItem]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GiveFreeCommodityItem]
@ItemID int,
@Number int,
@ActivePeriod int,
@MinLevelToReceive int,
@NumberOfDaysDifference int
AS
BEGIN
	
	
	DECLARE @AccountID int;
	DECLARE @SN int;
	DECLARE @DateExpire datetime;
	DECLARE CharactersCursor CURSOR LOCAL FOR SELECT DISTINCT(AccountID) FROM Character WHERE B_Level >= @MinLevelToReceive AND  DATEDIFF(DAY,  DATEADD(day, -1, LogoutDate), GETDATE())  <= @NumberOfDaysDifference
	SET @DateExpire = DATEADD(day, @ActivePeriod, CURRENT_TIMESTAMP);

	OPEN CharactersCursor;
	FETCH NEXT FROM CharactersCursor INTO @AccountID;
	
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @numberOfRepetatedItems int;
		SELECT @numberOfRepetatedItems = count(*) FROM ItemLocker WHERE AccountID = @AccountID AND ItemID = @ItemID;
		IF @numberOfRepetatedItems >= 1
		BEGIN
			print 'Count for item is greater than 1'
		END
		ELSE
		BEGIN
		 DECLARE @SN_OUT int;
		 exec GiveCommodityItemToAccount @AccountID, @ItemID, @Number, @ActivePeriod, @SN_OUT output
		END
		FETCH NEXT FROM CharactersCursor INTO @AccountID;	
	END

	CLOSE CharactersCursor

	DEALLOCATE CharactersCursor

	return(0);
END



GO
/****** Object:  StoredProcedure [dbo].[GiveFreeCommodityItemInMap]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GiveFreeCommodityItemInMap]
@ItemID int,
@Number int,
@ActivePeriod int,
@MinLevelToReceive int,
@NumberOfDaysDifference int,
@Map int,
@MinNumber int
AS
BEGIN
	
	
	DECLARE @AccountID int;
	DECLARE @SN int;
	DECLARE @DateExpire datetime;
	DECLARE CharactersCursor CURSOR LOCAL FOR SELECT DISTINCT(AccountID) FROM Character WHERE B_Level >= @MinLevelToReceive AND  DATEDIFF(DAY,  DATEADD(day, -1, LogoutDate), GETDATE())  <= @NumberOfDaysDifference AND P_Map = @Map
	AND AccountID IN (Select AccountID from [UserConnection].[dbo].[Connections]);
	SET @DateExpire = DATEADD(day, @ActivePeriod, CURRENT_TIMESTAMP);

	OPEN CharactersCursor;
	FETCH NEXT FROM CharactersCursor INTO @AccountID;
	
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @numberOfRepetatedItems int;
		SELECT @numberOfRepetatedItems = count(*) FROM ItemLocker WHERE AccountID = @AccountID AND ItemID = @ItemID;
		IF @numberOfRepetatedItems >= @MinNumber
		BEGIN
			print 'Count for item is greater than 1'
		END
		ELSE
		BEGIN
		    DECLARE @SN_OUT int;
		  	exec GiveCommodityItemToAccount @AccountID, @ItemID, @Number, @ActivePeriod, @SN_OUT output;
		END;

		FETCH NEXT FROM CharactersCursor INTO @AccountID;	
	END

	CLOSE CharactersCursor

	DEALLOCATE CharactersCursor

	return(0);
END



GO
/****** Object:  StoredProcedure [dbo].[GuildBBS_DeleteComment]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GuildBBS_DeleteComment]
@SN int
AS
BEGIN
	DECLARE @ParentSN int;
	DECLARE @Count int;

	SELECT @ParentSN = ParentSN FROM GuildBBSComment
	  WHERE SN = @SN; 
	
	SELECT @Count = Count(*) FROM GuildBBSComment WHERE ParentSN = @ParentSN;

	IF @Count > 0
	BEGIN
		UPDATE GuildBBSEntry SET CommentCount = @Count - 1 
		WHERE SN = @ParentSN;
	END;


	DELETE FROM GuildBBSComment WHERE SN = @SN;
	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[GuildBBS_DeleteEntry]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GuildBBS_DeleteEntry]
@SN int
AS
BEGIN
	DELETE FROM GuildBBSComment WHERE ParentSN = @SN;
	DELETE FROM GuildBBSEntry WHERE SN = @SN;
	return(0);
END



GO
/****** Object:  StoredProcedure [dbo].[GuildBBS_ModifyEntry]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec GuildBBS_ModifyEntry 11,'Testt','22222',1
CREATE PROCEDURE [dbo].[GuildBBS_ModifyEntry]
@EntryID int,
@Title varchar(25),
@Text varchar(650),
@Emoticon int
AS
BEGIN
	UPDATE GuildBBSEntry SET Title = @Title,
		 Text = @Text, Emoticon = @Emoticon
		 WHERE 
		 EntryID = @EntryID;
		 
	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[GuildBBS_RegisterComment]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GuildBBS_RegisterComment]
@ParentSN int,
@CharacterID int,
@Text varchar(25),
@Date datetime output,
@SN int output
AS
BEGIN
	
	SET @Date = GETDATE();	
	INSERT INTO [dbo].[GuildBBSComment]
           ([ParentSN]
           ,[CharacterID]
           ,[Text]
           ,[Date])
     VALUES
           (@ParentSN
           ,@CharacterID
           ,@Text
           ,@Date);
	SET @SN = SCOPE_IDENTITY();

	UPDATE GuildBBSEntry SET CommentCount = CommentCount + 1 
		WHERE SN = @ParentSN;


	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[GuildBBS_RegisterEntry]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GuildBBS_RegisterEntry]
@GuildID int,
@EntryID int,
@CharacterID int,
@Title varchar(25),
@Text varchar(600),
@Emoticon int, 
@Date datetime output,
@SN int output
AS
BEGIN
	SET @Date = GETDATE();
	INSERT INTO [dbo].[GuildBBSEntry]
           ([GuildID]
           ,[EntryID]
           ,[CharacterID]
           ,[Title]
           ,[Date]
           ,[Emoticon]
           ,[CommentCount]
           ,[Text])
     VALUES
           (@GuildID,
           @EntryID,
           @CharacterID,
           @Title,
           @Date,
           @Emoticon,
           0,
           @Text);

	SET @SN = SCOPE_IDENTITY();
	

	SELECT @Date, @SN;

	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[IncGuildCountMax]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IncGuildCountMax]
@GuildID int,
@CountMax int
AS
BEGIN
	UPDATE GuildInfo 
		SET CountMax = @CountMax
		WHERE GuildID = @GuildID;


	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[IncreaseItemSlotCount]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec IncreaseItemSlotCount 3955,4,8,1,'coder',0,1571956697,4000,@p9 output
CREATE PROCEDURE [dbo].[IncreaseItemSlotCount]
   	@CharacterID int, 
	@ItemSlotTableIdx int,
	@Delta smallint,
	@AccountID smallint,
	@NexonClubID varchar(20),
	@DBID tinyint,
	@ChargeNo bigint,
	@Price bigint,
	@SlotCount bigInt output
AS
BEGIN

    IF @Price < 0
	BEGIN
	  return (1);
  	END; 

    
	IF @ItemSlotTableIdx = 1
	BEGIN
	  SELECT @SlotCount = Equip_slot FROM ItemSlot_Size WHERE CharacterID = @CharacterID;
	  IF @SlotCount >= 48 OR @@ROWCOUNT < 1
	  BEGIN
	    return(0);
	  END;
	  UPDATE ItemSlot_Size SET Equip_slot = Equip_slot + @Delta WHERE CharacterID = @CharacterID;
	END;
	
	IF @ItemSlotTableIdx = 2
	BEGIN
	  SELECT @SlotCount = Use_slot FROM ItemSlot_Size WHERE CharacterID = @CharacterID;
	  IF @SlotCount >= 48 OR @@ROWCOUNT < 1
	  BEGIN
	    return(0);
	  END;
	  UPDATE ItemSlot_Size SET Use_slot = Use_slot + @Delta WHERE CharacterID = @CharacterID;
	END;
	
	IF @ItemSlotTableIdx = 3
	BEGIN
	  SELECT @SlotCount = Setup_slot FROM ItemSlot_Size WHERE CharacterID = @CharacterID;
	   IF @SlotCount >= 48 OR @@ROWCOUNT < 1
	  BEGIN
	    return(0);
	  END;
	  UPDATE ItemSlot_Size SET Setup_slot = Setup_slot + @Delta WHERE CharacterID = @CharacterID;
	END;

	IF @ItemSlotTableIdx = 4
	BEGIN
	  SELECT @SlotCount = Etc_slot FROM ItemSlot_Size WHERE CharacterID = @CharacterID;
	   IF @SlotCount >= 48 OR @@ROWCOUNT < 1
	  BEGIN
	    return(0);
	  END;
	  UPDATE ItemSlot_Size SET Etc_slot = Etc_slot + @Delta WHERE CharacterID = @CharacterID;
	END;
	
	UPDATE GlobalAccount.dbo.Account SET NexonCash = NexonCash - @Price
	WHERE AccountID = @AccountID;

	RETURN (0);
END;


GO
/****** Object:  StoredProcedure [dbo].[IncreaseItemSlotCountByMaplePoint]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec IncreaseItemSlotCountByMaplePoint 3955,4,8,1,'coder',0,0,4000,@p9 output

CREATE PROCEDURE [dbo].[IncreaseItemSlotCountByMaplePoint]
    @CharacterID int, 
	@ItemSlotTableIdx int,
	@Delta smallint,
	@AccountID smallint,
	@NexonClubID varchar(20),
	@DBID tinyint,
	@ChargeNo bigint,
	@Price bigint,
	@SlotCount bigInt output
AS
BEGIN
    
	IF @Price < 0
	BEGIN
	  return (1);
  	END; 

    
	IF @ItemSlotTableIdx = 1
	BEGIN
	  SELECT @SlotCount = Equip_slot FROM ItemSlot_Size WHERE CharacterID = @CharacterID;
	  IF @SlotCount >= 48 OR @@ROWCOUNT < 1
	  BEGIN
	    return(0);
	  END;
	  UPDATE ItemSlot_Size SET Equip_slot = Equip_slot + @Delta WHERE CharacterID = @CharacterID;
	END;
	
	IF @ItemSlotTableIdx = 2
	BEGIN
	  SELECT @SlotCount = Use_slot FROM ItemSlot_Size WHERE CharacterID = @CharacterID;
	  IF @SlotCount >= 48 OR @@ROWCOUNT < 1
	  BEGIN
	    return(0);
	  END;
	  UPDATE ItemSlot_Size SET Use_slot = Use_slot + @Delta WHERE CharacterID = @CharacterID;
	END;
	
	IF @ItemSlotTableIdx = 3
	BEGIN
	  SELECT @SlotCount = Setup_slot FROM ItemSlot_Size WHERE CharacterID = @CharacterID;
	   IF @SlotCount >= 48 OR @@ROWCOUNT < 1
	  BEGIN
	    return(0);
	  END;
	  UPDATE ItemSlot_Size SET Setup_slot = Setup_slot + @Delta WHERE CharacterID = @CharacterID;
	END;

	IF @ItemSlotTableIdx = 4
	BEGIN
	  SELECT @SlotCount = Etc_slot FROM ItemSlot_Size WHERE CharacterID = @CharacterID;
	   IF @SlotCount >= 48 OR @@ROWCOUNT < 1
	  BEGIN
	    return(0);
	  END;
	  UPDATE ItemSlot_Size SET Etc_slot = Etc_slot + @Delta WHERE CharacterID = @CharacterID;
	END;

	UPDATE GlobalAccount.dbo.Account SET maplePoint = maplePoint - @Price
	WHERE AccountID = @AccountID;
    return(0);
END;


GO
/****** Object:  StoredProcedure [dbo].[IncreaseTrunkCount]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec IncreaseTrunkCountByMaplePoint 1,8,'coder',0,63586938,4000,@p7 output
CREATE PROCEDURE [dbo].[IncreaseTrunkCount]
   	@AccountID int, 
	@Delta smallint,
	@NexonClubID varchar(20),
	@DBID tinyint,
	@ChargeNo bigint,
	@Price bigint,
	@SlotCount bigInt output
AS
BEGIN

    IF @Price < 0
	BEGIN
	  return (1);
  	END; 
	
	UPDATE Trunk SET Slots = Slots + @Delta WHERE AccountID = @AccountID;
    
    SELECT @SlotCount = Slots FROM Trunk WHERE AccountID = @AccountID;
	IF @SlotCount > 48 OR @@ROWCOUNT < 1
	BEGIN
	    return(0);
	END;
	
	
	UPDATE GlobalAccount.dbo.Account SET maplePoint = maplePoint - @Price
	WHERE AccountID = @AccountID;

	RETURN (0);
END;


GO
/****** Object:  StoredProcedure [dbo].[IncreaseTrunkCountByMaplePoint]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--IncreaseTrunkCountByMaplePoint 1579,8,'admin',0,0,4000,@p7 output
CREATE PROCEDURE [dbo].[IncreaseTrunkCountByMaplePoint]
   	@AccountID int, 
	@Delta smallint,
	@NexonClubID varchar(20),
	@DBID tinyint,
	@ChargeNo bigint,
	@Price bigint,
	@SlotCount bigInt output
AS
BEGIN

    IF @Price < 0
	BEGIN
	  return (1);
  	END; 
	
	UPDATE Trunk SET Slots = Slots + @Delta WHERE AccountID = @AccountID;
    
    SELECT @SlotCount = Slots FROM Trunk WHERE AccountID = @AccountID;
	IF @SlotCount > 48 OR @@ROWCOUNT < 1
	BEGIN
	    return(0);
	END;
	
	
	UPDATE GlobalAccount.dbo.Account SET maplePoint = maplePoint - @Price
	WHERE AccountID = @AccountID;

	RETURN (0);
END;


GO
/****** Object:  StoredProcedure [dbo].[InventorySize_Get]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InventorySize_Get]
	@CharacterID int,
	@EQP int output,
	@USE int output,
	@SETUP int output,
	@ETC int output,
	@CASH int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT @EQP = Equip_Slot, @USE = Use_Slot,
	@Setup = Setup_Slot,
	@Etc = ETC_Slot, @Cash = Cash_Slot FROM ItemSlot_Size
	WHERE CharacterID = @CharacterID; 

    /* Insert statements for procedure here
	set @EQP = 64
	set @USE = 64
	set @SETUP = 64
	set @ETC = 64
	set @CASH = 64
	*/
	RETURN(0)
END




GO
/****** Object:  StoredProcedure [dbo].[InventorySize_Set]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InventorySize_Set]
	@CharacterID int,
	@EQP int,
	@USE int,
	@SETUP int,
	@ETC int,
	@CASH int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [ItemSlot_Size] SET Equip_Slot = @EQP,
	Use_Slot = @USE,
	Setup_Slot = @SETUP,
	Etc_Slot = @ETC,
	Cash_Slot = @CASH WHERE CharacterID = @CharacterID;
	IF @@ROWCOUNT = 0
	BEGIN
	  INSERT INTO [ItemSlot_Size] VALUES(@CharacterID, @EQP, @USE, @SETUP, @ETC, @CASH);
	END;

	RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[JoinGuild]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec JoinGuild 41,1,4,'Coder'
CREATE PROCEDURE [dbo].[JoinGuild]
@CharacterID int,
@GuildID int,
@Grade int,
@CharacterName varchar(13)
AS
BEGIN
	INSERT INTO GuildMember (GuildID, CharacterID, Grade, CharacterName)
		 VALUES(@GuildID, @CharacterID, @Grade, @CharacterName);
	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[LoadPetExceptionList]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--{ ? = call dbo.LoadPetExceptionList( ?, ? ) }',0
CREATE PROCEDURE [dbo].[LoadPetExceptionList]
@PetSN bigint,
@Count int output
AS
BEGIN
	SET @Count = 0;
	return(0);
END;


GO
/****** Object:  StoredProcedure [dbo].[Memo_Delete]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Memo_Delete]
@CharacterID int,
@SN int
AS
BEGIN
	UPDATE MEMO SET State = 0 WHERE SN = @SN;
	return(0);
END;



GO
/****** Object:  StoredProcedure [dbo].[Memo_Send]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Memo_Send]
@SendCharacterID int,
@Sender varchar(13),
@Content Text,
@Flag int
AS
BEGIN
    DECLARE @CharacterID int;
    SELECT @CharacterID = CharacterID FROM Character Where CharacterName = @Sender;
	INSERT INTO MEMO(CharacterID, Sender, Content, SendDate, Flag, State)
	   VALUES(@CharacterID, @Sender, @Content, CURRENT_TIMESTAMP, @Flag, 1);
	return(0);
END;


GO
/****** Object:  StoredProcedure [dbo].[MoveCashItemLtoS]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[MoveCashItemLtoS]
@AccountID int,
@CharacterID int,
@SN bigint,
@number int output ,
@expiration datetime output 
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
	BEGIN TRANSACTION;
		UPDATE ItemLocker SET CharacterID = @CharacterID WHERE SN = @SN AND AccountID = @AccountID;
		IF @@ROWCOUNT < 1 
		BEGIN
			return (1);
		END;
		SELECT @number = Number, @expiration = ExpiredDate FROM ItemLocker WHERE SN = @SN AND CharacterID = @CharacterID;
		DECLARE @ItemID int;
		SELECT @ItemID = ItemID FROM ItemLocker WHERE SN = @SN;
		SELECT * FROM CashItemBundle WHERE CashItemSN = @SN;
		IF @@ROWCOUNT < 1 AND (@ItemID / 1000000 != 1) AND NOT(@ItemID >= 5000000 AND @ItemID <= 5000100) 
		BEGIN
			INSERT INTO CashItemBundle VALUES(@SN, @number);
		END;
	COMMIT TRANSACTION;
	return (0);
END



GO
/****** Object:  StoredProcedure [dbo].[MoveCashItemStoL]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MoveCashItemStoL]
@AccountID int,
@characterID int,
@SN bigint,
@Name varchar(20) output,
@ItemID int output,
@PaybackRate int output,
@DiscountRate int output
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
	BEGIN TRANSACTION;
	UPDATE ItemLocker SET CharacterID = 0 
		WHERE 
			AccountID = @AccountID AND
			characterID = @characterID AND SN = @SN;
	IF @@ROWCOUNT < 1 
		BEGIN
			return (1);
	END;
	Select @name = buyCharacterID, 
			@ItemID = ItemID, @PaybackRate = 0, @DiscountRate = 0  FROM ItemLocker
	  WHERE 
		AccountID = @AccountID AND
		characterID = @characterID AND
		SN = @SN;
	
	

	 DELETE FROM CashItemBundle WHERE CashItemSN = @SN;
	COMMIT TRANSACTION;
	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[MovePetStat]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[MovePetStat]
	-- Add the parameters for the stored procedure here
	@fromSN int,
	@toSN int
AS
BEGIN
    DECLARE @tamenessFrom int;
	DECLARE @tamenessTo int;
	SELECT @tamenessFrom = Tameness from CashItem_PET WHERE CashItemSN = @fromSN;
	SELECT @tamenessTo = Tameness from CashItem_PET WHERE CashItemSN = @toSN; 
	UPDATE  CashItem_PET set Tameness = @tamenessTo  WHERE CashItemSN = @fromSN;
	UPDATE  CashItem_PET set Tameness = @tamenessFrom  WHERE CashItemSN = @toSN;
	RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[RemoveGuild]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RemoveGuild]
@GuildID int
AS
BEGIN
	DELETE FROM GuildMember WHERE GuildID = @GuildID;
	DELETE FROM GuildInfo WHERE GuildID = @GuildID;
	DELETE FROM GuildPoint WHERE GuildID = @GuildID;
END

GO
/****** Object:  StoredProcedure [dbo].[SetFuncKeyMapped]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetFuncKeyMapped]
	@CharacterID int,
	@UpdateBytes varbinary(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE FuncKeyMapped SET FKMValue = @UpdateBytes WHERE CharacterID = @CharacterID;
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO FuncKeyMapped VALUES(@CharacterID, @UpdateBytes);
	END;
	return(0)
END
GO
/****** Object:  StoredProcedure [dbo].[SetGuildGradeName]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetGuildGradeName]
@GuildID int,
@GradeName1 varchar(20),
@GradeName2 varchar(20),
@GradeName3 varchar(20),
@GradeName4 varchar(20),
@GradeName5 varchar(20)
AS
BEGIN
	UPDATE GuildInfo SET 
	GradeName1 = @GradeName1,
	GradeName2 = @GradeName2,
	GradeName3 = @GradeName3,
	GradeName4 = @GradeName4,
	GradeName5 = @GradeName5
	WHERE GuildID = @GuildID;
	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[SetGuildMark]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetGuildMark]
@GuildID int,
@MarkBG int,
@MarkBgColor int,
@Mark int,
@MarkColor int
AS
BEGIN
	UPDATE GuildInfo 
		SET MarkBG = @MarkBG,
		MarkBgColor = @MarkBgColor,
		Mark = @Mark,
		MarkColor = @MarkColor
		WHERE GuildID = @GuildID;


	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[SetGuildMemberGrade]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SetGuildMemberGrade 41,2
CREATE PROCEDURE [dbo].[SetGuildMemberGrade]
@CharacterID int,
@Grade int
AS
BEGIN
	UPDATE GuildMember SET Grade = @Grade
		WHERE CharacterID = @CharacterID;
	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[SetGuildNotice]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetGuildNotice]
@GuildID int,
@Notice varchar(101)
AS
BEGIN
	UPDATE GuildInfo SET Notice = @Notice WHERE GuildID = @GuildID;
	Delete from [GameWorld].[dbo].[GuildMember] where GuildID = 0;
	return(0);
END


GO
/****** Object:  StoredProcedure [dbo].[SetPetLife]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SetPetLife]
	@AccountID int,
	@CharacterID int,
	@ItemSN bigint,
	@PetSN int,
	@Life int,
	@DeadTime datetime output,
	@Number int output
AS
BEGIN
    declare @count int;
    SELECT @DeadTime = DATEADD(day, 90, CURRENT_TIMESTAMP), @Number = 0;
    UPDATE ItemLocker SET ExpiredDate = @DeadTime WHERE SN = @PetSN;
    UPDATE CashItem_PET SET DeadDate = @DeadTime Where CashItemSN = @PetSN;
	exec UseCashItem @AccountID, @CharacterID, @ItemSN, 0, 0, @count
	
	RETURN(0)
END;


GO
/****** Object:  StoredProcedure [dbo].[SetPetName]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--.data:018CAF54 00000030 C { ? = call dbo.SetPetName( ?, ?, ?, ?, ?, ? ) }
CREATE PROCEDURE [dbo].[SetPetName]
@AccountID int,
@CharacterID int,
@ItemSN int,
@PetSN int,
@PetName varchar(12),
@Number int output
AS
BEGIN
	BEGIN TRANSACTION SAVE_PET
	BEGIN
		DELETE FROM ItemLocker WHERE SN = @ItemSN;
		UPDATE CashItem_PET SET PetName = @PetName WHERE CashItemSN = @PetSN;
		SET @Number = 0;
	END;
	IF @@ERROR > 0
	BEGIN
		SET @Number = 0;
		ROLLBACK;
		return(1);
	END;
	COMMIT;
	return(0);
END;


GO
/****** Object:  StoredProcedure [dbo].[SetPurchaseExp]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetPurchaseExp]
@AccountID int,
@exp int
AS
BEGIN
	UPDATE GlobalAccount.dbo.Account SET PurchaseExp = ISNULL(PurchaseExp, 0) + @exp
		WHERE AccountID = @AccountID;
	return(@exp);
END;

GO
/****** Object:  StoredProcedure [dbo].[SetQuestComplete]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetQuestComplete]
	@CharacterID int,
	@QRValue varbinary(max)
AS
BEGIN
	/*SET NOCOUNT ON;
	DECLARE @QuestLen int = DATALENGTH(@QRValue) / 6;
	DECLARE @Offset int = 1;
	WHILE @QuestLen > 0
	BEGIN
		DECLARE @QuestNumber int = dbo.ReadShort(@QRValue, @Offset);
		DECLARE @Time int = dbo.ReadInt(@QRValue, @Offset + 2);

		SET @QuestLen = @QuestLen - 1;
		SET @Offset = @Offset + 6;
		INSERT INTO QuestComplete VALUES(@CharacterID, @QuestNumber, dateadd(S, @Time, '1970-01-01'));
	END;*/
	UPDATE QuestComplete SET QRValue = @QRValue WHERE CharacterID = @CharacterID;
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO QuestComplete VALUES(@CharacterID, @QRValue);
	END;

	RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[SetSkillCooltime]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetSkillCooltime]
	@CharacterID int,
	@CooltimeInfo varbinary(6)
AS
BEGIN
	
	SELECT Cooltime FROM SkillCooltime WHERE CharacterID = @CharacterID;
	IF @@ROWCOUNT > 0
	BEGIN
	   UPDATE SkillCooltime SET Cooltime = @CooltimeInfo WHERE CharacterID = @CharacterID;
	   RETURN(0);
	END;

	INSERT INTO SkillCooltime VALUES(@CharacterID, @CooltimeInfo);

   RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[SetTamingMobInfo]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--{ call SetTamingMobInfo( ?, ?, ?, ? ) }',0
CREATE PROCEDURE [dbo].[SetTamingMobInfo]
@CharacterID int,
@Level int,
@Exp int,
@Fatigue int
AS
BEGIN
	UPDATE TamingMob SET Level = @Level, Exp = @Exp, Fatigue = @Fatigue WHERE CharacterID = @CharacterID
	IF @@ROWCOUNT < 1
	BEGIN
		INSERT INTO TamingMob VALUES(@CharacterID, @Level, @Exp, @Fatigue);
	END;
	RETURN(0);
END;


GO
/****** Object:  StoredProcedure [dbo].[SetUserStat]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetUserStat]
	-- Add the parameters for the stored procedure here
	@Date datetime,
	@p1 int,
	@p2 int,
	@p3 int,
	@p4 int,
	@p5 int,
	@p6 int,
	@p7 int,
	@p8 int,
	@p9 int,
	@p10 int,
	@p11 int,
	@p12 int,
	@p13 int,
	@p14 int,
	@p15 int,
	@p16 int,
	@p17 int,
	@p18 int,
	@p19 int,
	@p20 int,
	@p21 int,
	@p22 int,
	@p23 int,
	@p24 int,
	@p25 int
AS
BEGIN
	RETURN(1)
END

GO
/****** Object:  StoredProcedure [dbo].[SkillChange]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--.data:018CB5C8 00000031 C { ? = call dbo.SkillChange( ?, ?, ?, ?, ?, ? ) }
CREATE PROCEDURE [dbo].[SkillChange]
	@AccountID int,
	@CharacterID int,
	@SN bigint,
	@SkillID int,
	@DecSkillID int,
	@Number int output
AS
BEGIN
	UPDATE ItemLocker SET Number = Number - 1 WHERE SN = @SN AND CharacterID = @CharacterID AND AccountID = @AccountID;
	SELECT @Number = Number FROM ItemLocker WHERE SN = @SN;
	IF @Number <= 0
	BEGIN
		DELETE FROM ItemLocker WHERE AccountID = @AccountID AND CharacterID = @CharacterID AND SN = @SN;
	END;
	UPDATE SkillRecord SET MaxLevel = MaxLevel + 1 WHERE CharacterID = @CharacterID AND SkillID = @SkillID;
	UPDATE SkillRecord SET MaxLevel = MaxLevel - 1 WHERE CharacterID = @CharacterID AND SkillID = @DecSkillID;
	IF(@@ROWCOUNT <= 0)
	BEGIN
		RETURN (1);
	END;
	RETURN(0)
END;

GO
/****** Object:  StoredProcedure [dbo].[StatChange]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--.data:018CB53C 00000039 C { ? = call dbo.StatChange( ?, ?, ?, ?, ?, ?, ?, ?, ? ) }
CREATE PROCEDURE [dbo].[StatChange]
	@AccountID int,
	@CharacterID int,
	@SN bigint,
	@IncStat int,
	@DecStat int,
	@IncHP int,
	@IncMP int,
	@Checksum int,
	@Number int output
AS
BEGIN
	UPDATE ItemLocker SET Number = Number - 1 WHERE SN = @SN AND CharacterID = @CharacterID AND AccountID = @AccountID;
	SELECT @Number = Number FROM ItemLocker WHERE SN = @SN;
	IF @Number <= 0
	BEGIN
		DELETE FROM ItemLocker WHERE AccountID = @AccountID AND CharacterID = @CharacterID AND SN = @SN;
	END;

	RETURN(0)
END;
GO
/****** Object:  StoredProcedure [dbo].[SueCharacter]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SueCharacter]
	@ReporterID int,
	@CharacterID int,
	@GameWorldID int,
	@ChannelID int,
	@Field int,
	@Offense int,
	@ChatLog varchar(270)
AS
BEGIN
	DECLARE @ReporterName VARCHAR(13);
	DECLARE @CharacterName VARCHAR(13);

	SELECT @ReporterName = CharacterName FROM Character WHERE CharacterID = @ReporterID;
	SELECT @CharacterName = CharacterName FROM Character WHERE CharacterID = @CharacterID;


	BEGIN TRAN
		INSERT INTO 
			CharacterSue(ReporterName, CharacterName, GameWorldID, ChannelID, Field, Offense, ChatLog)
		VALUES
			(@ReporterName, @CharacterName, @GameWorldID, @ChannelID, @Field, @Offense, @ChatLog);
	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK
		RETURN(1);
	END
	ELSE
	COMMIT;
	RETURN(0)
END;

GO
/****** Object:  StoredProcedure [dbo].[UpdateMarriageRecord]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec UpdateMarriageRecord 1,3,1112809,1112809

CREATE PROCEDURE [dbo].[UpdateMarriageRecord]
@MarriageNo int,
@Status int,
@GroomItemID int,
@BrideItemID int
AS
BEGIN
	UPDATE MarriageRecord SET Status = @Status, GroomItemID = @GroomItemID, BrideItemID = @BrideItemID WHERE
	MarriageNo = @MarriageNo;
	return(0);
END;



GO
/****** Object:  StoredProcedure [dbo].[UpdateSueCharacterList]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateSueCharacterList]

@var1 int,
@var2 int

AS
BEGIN    
     RETURN(0)
END
GO
/****** Object:  StoredProcedure [dbo].[UseCashItem]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UseCashItem]
@AccountID int,
@CharacterID int,
@SN bigint,
@param4 int,
@itemID int,
@number int output 
AS
BEGIN
   UPDATE ItemLocker set NUMBER = NUMBER - 1 WHERE SN = @SN AND AccountID = @AccountID AND NUMBER >= 1;
	SELECT @number = Number from ItemLocker WHERE SN = @SN AND AccountID = @AccountID;;
	IF @number <= 0
		DELETE FROM ItemLocker WHERE SN = @SN AND NUMBER = 0 AND AccountID = @AccountID;;
	return(0);
END

GO
/****** Object:  StoredProcedure [dbo].[UseNormalCoupon]    Script Date: 11/08/2021 16:58:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UseNormalCoupon]
@AccountID int,
@CharacterID int,
@Kind int,
@Param int
AS
BEGIN
	/*IF @Kind = 1--Amoriam Hair cut coupon
	BEGIN
		UPDATE Character SET C_Hair = @Param
		 WHERE CharacterID = @CharacterID;
	END;*/
	RETURN(0);
END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TODO: check datatype
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestPerform'
GO
