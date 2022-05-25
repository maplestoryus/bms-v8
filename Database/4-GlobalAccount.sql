USE [GlobalAccount]
GO
/****** Object:  User [centersrv]    Script Date: 17/07/2021 06:30:23 ******/
CREATE USER [centersrv] FOR LOGIN [centersrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [couponadmin]    Script Date: 17/07/2021 06:30:23 ******/
CREATE USER [couponadmin] FOR LOGIN [couponadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [gamesrv]    Script Date: 17/07/2021 06:30:23 ******/
CREATE USER [gamesrv] FOR LOGIN [gamesrv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [log_npt]    Script Date: 17/07/2021 06:30:23 ******/
CREATE USER [log_npt] FOR LOGIN [log_npt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [us_trading_user]    Script Date: 17/07/2021 06:30:23 ******/
CREATE USER [us_trading_user] FOR LOGIN [us_trading_user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [centersrv]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [centersrv]
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
/****** Object:  UserDefinedFunction [dbo].[ipIntToString]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ipIntToString] 
( 
    @ip INT 
) 
RETURNS CHAR(15) 
AS 
BEGIN 
    DECLARE @o1 INT, 
        @o2 INT, 
        @o3 INT, 
        @o4 INT 
 
    IF ABS(@ip) > 2147483647 
        RETURN '255.255.255.255' 
 
    SET @o1 = @ip / 16777216 
 
    IF @o1 = 0 
        SELECT @o1 = 255, @ip = @ip + 16777216 
 
    ELSE IF @o1 < 0 
    BEGIN 
        IF @ip % 16777216 = 0 
            SET @o1 = @o1 + 256 
        ELSE 
        BEGIN 
            SET @o1 = @o1 + 255 
            IF @o1 = 128 
                SET @ip = @ip + 2147483648 
            ELSE 
                SET @ip = @ip + (16777216 * (256 - @o1)) 
        END 
    END 
    ELSE 
    BEGIN 
        SET @ip = @ip - (16777216 * @o1) 
    END 
 
    SET @ip = @ip % 16777216 
    SET @o2 = @ip / 65536 
    SET @ip = @ip % 65536 
    SET @o3 = @ip / 256 
    SET @ip = @ip % 256 
    SET @o4 = @ip 
 
    RETURN 
        CONVERT(VARCHAR(4), @o1) + '.' + 
        CONVERT(VARCHAR(4), @o2) + '.' + 
        CONVERT(VARCHAR(4), @o3) + '.' + 
        CONVERT(VARCHAR(4), @o4) 
END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](20) NOT NULL,
	[PasswordHash] [varchar](32) NOT NULL,
	[Pin] [varchar](4) NOT NULL DEFAULT (''),
	[ReadEULA] [tinyint] NOT NULL DEFAULT ((0)),
	[IsBanned] [tinyint] NOT NULL DEFAULT ((0)),
	[AccountStatusID] [int] NOT NULL DEFAULT ((0)),
	[PrivateStatusID] [int] NOT NULL DEFAULT ((0)),
	[BirthDate] [datetime] NOT NULL,
	[CurrentIP] [varchar](15) NOT NULL DEFAULT (''),
	[Admin] [tinyint] NOT NULL DEFAULT ((0)),
	[NeedVerification] [int] NOT NULL DEFAULT ((0)),
	[AccountFlags] [int] NOT NULL DEFAULT ((0)),
	[ChatBlock] [int] NOT NULL DEFAULT ((0)),
	[PacketDump] [int] NOT NULL DEFAULT ((0)),
	[Gender] [smallint] NOT NULL CONSTRAINT [DF_Account_Gender]  DEFAULT ((-1)),
	[RegisterDate] [datetime] NOT NULL CONSTRAINT [DF_Account_RegisterDate]  DEFAULT (getdate()),
	[maplePoint] [int] NULL CONSTRAINT [DF_Account_maplePoint]  DEFAULT ((0)),
	[PurchaseExp] [int] NULL DEFAULT ((0)),
	[Email] [varchar](70) NULL,
	[NexonCash] [int] NULL CONSTRAINT [DF_Account_NexonCash]  DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountBans]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountBans](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BlockedUser] [varchar](20) NOT NULL,
	[BlockType] [int] NOT NULL,
	[BlockAmount] [int] NOT NULL,
	[worldID] [int] NOT NULL,
	[channelID] [int] NOT NULL,
	[mapID] [int] NOT NULL,
	[BlockerUser] [varchar](20) NOT NULL,
	[Reason] [varchar](200) NOT NULL,
	[DateBlock] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountIDForBR]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountIDForBR](
	[AccountID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClaimLiar]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaimLiar](
	[AccountID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Donation]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Donation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](20) NOT NULL,
	[Amount] [int] NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[transaction_code] [varchar](100) NOT NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameWorld]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameWorld](
	[GameWorldID] [int] NOT NULL,
	[GameWorldName] [varchar](50) NOT NULL,
	[port] [int] NOT NULL,
	[adminPort] [int] NOT NULL,
	[CenterAddress] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IntegratedIncRate]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegratedIncRate](
	[SN] [bigint] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[DayOfWeek] [tinyint] NOT NULL,
	[StartTime] [int] NOT NULL,
	[EndTime] [int] NOT NULL,
	[WorldID] [tinyint] NOT NULL,
	[ChannelID] [tinyint] NOT NULL,
	[IsPremium] [int] NOT NULL,
	[IsNormal] [int] NOT NULL,
	[IsDrop] [int] NOT NULL,
	[IsExp] [int] NOT NULL,
	[IncRate] [int] NOT NULL,
 CONSTRAINT [PK_IntegratedIncRate] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IPBans]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IPBans](
	[IP] [varchar](15) NOT NULL,
	[BanEntry] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProcessNameList]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProcessNameList](
	[Name] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProcessSignCodeList]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProcessSignCodeList](
	[SN] [bigint] NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[Value0] [int] NOT NULL,
	[Value1] [int] NOT NULL,
	[Value2] [int] NOT NULL,
	[Value3] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Donation] ADD  DEFAULT (getdate()) FOR [Date]
GO
/****** Object:  StoredProcedure [dbo].[Character_CheckByChrName]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Character_CheckByChrName]
	@CharacterName varchar(20),
	@WorldID tinyint
AS
BEGIN
	DECLARE @Used tinyint
	SELECT @Used = COUNT(*) FROM [GameWorld].[dbo].[Character] WHERE CharacterName = @CharacterName
	RETURN(@Used)
END
GO
/****** Object:  StoredProcedure [dbo].[CheckEULA]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckEULA]
	@AccountID int,
	@Read tinyint output
AS
BEGIN
	SELECT @Read = ReadEULA FROM Account WHERE AccountID = @AccountID
	RETURN(@Read)
END




GO
/****** Object:  StoredProcedure [dbo].[CheckPassword]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--24 = ignore login
CREATE PROCEDURE [dbo].[CheckPassword]
	-- Add the parameters for the stored procedure here
	@AccountName varchar(20),
	@PassHash varchar(32),
	@Somevar1 int,--0
	@Somevar2 int,--7
	@Somevar3 int,--30
	
	@AccountID int output,
	@AccountStatus tinyint output,
	@Birthdate datetime output,
	@AccountFlags tinyint output,
	@AccountNameOut varchar(20) output,
	@Admin tinyint output,
	@NeedVerification tinyint output,
	@Outvar8 int output,
	@Outvar9 tinyint output,
	@Outvar10 int output,
	@Outvar11 datetime output,
	@ChatBlock int output,
	@Outvar13 datetime output,
	@PacketDump tinyint output,
	@Outvar15 datetime output
AS
BEGIN
	declare @Exists int
	declare @mPassHash varchar(32)
	declare @Banned tinyint
	declare @CurrentIP varchar(15)
	declare @Pin varchar(4)
	declare @Gender smallint
	declare @LoggedIn int;


	select @Exists = COUNT(*) from Account WHERE AccountName = @AccountName

	
	if (@Exists = 0)
		return(5)	--account doesn't exist
		
	SELECT	@AccountID = AccountID,
			@AccountNameOut = AccountName,
			@mPassHash = PasswordHash,
			@Banned = IsBanned,
			@CurrentIP = CurrentIP,
			@Admin = Admin,
			@NeedVerification = NeedVerification,
			@AccountFlags = AccountFlags,
			@ChatBlock = ChatBlock,
			@PacketDump = PacketDump,
			@Pin = Pin,
			@Gender = Gender,
			@BirthDate = BirthDate
	FROM Account
	WHERE AccountName = @AccountName
	
	declare @IPbanned int;
	select @IPbanned = COUNT(*) from IPBans where IP = @CurrentIP;
	if (@Banned > 0)
	begin
		RETURN(2);
	end

	DECLARE @Account_ID INT = -1;
     SELECT 
      @Account_ID = AccountID
     FROM [UserConnection].[dbo].[Connections]
	 WHERE AccountID = @AccountID;

	 iF (@Account_ID > -1)
	   Return(7);
	 


	if (UPPER(@mPassHash) != @PassHash)
		return(4)	-- wrong password
	if (@Banned = 1)
		return(2)	-- banned
	if (@CurrentIP != NULL)
		return(7)	-- already logged in, cleared by various logout funcs and ClearWorldConnect

	if (@Gender = -1)
		SET @AccountStatus = 10
	else if (@Pin = '' or @Pin IS NULL)
		SET @AccountStatus = 11
	else
		SET @AccountStatus = @Gender

    set @Outvar8 = 0
    set @Outvar9 = 0
    set @Outvar10 = 0
    set @Outvar11 = GETDATE()
    set @Outvar13 = GETDATE()
    set @Outvar15 = GETDATE()
    --return(21);
	RETURN(0)	-- successful login
END









GO
/****** Object:  StoredProcedure [dbo].[CheckPinCode]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckPinCode]
	-- Add the parameters for the stored procedure here
	@AccountID int,
	@Pin varchar(4)
AS
BEGIN
	declare @realPin varchar(4)
	select @realPin = Pin from Account where AccountID = @AccountID
	
	if @realPin = '' or @realPin IS NULL
		return(1)--What if you want them to register a pin??
	
	if @Pin = @realPin
		return(0)
	else 
		return(2)

END




GO
/****** Object:  StoredProcedure [dbo].[ClearWorldConnect]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClearWorldConnect]
	@p1 int = NULL
AS
BEGIN
	delete from Connections
	RETURN (1)
END

GO
/****** Object:  StoredProcedure [dbo].[ConfirmEULA]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConfirmEULA]
	@AccountID int,
	@Read tinyint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	UPDATE Account SET ReadEULA = @Read WHERE AccountID = @AccountID
	RETURN(0)
END



GO
/****** Object:  StoredProcedure [dbo].[GetEveryWorldCharList]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetEveryWorldCharList]
	@AccountID int
AS
BEGIN
	SELECT WorldID, CharacterID FROM [GameWorld].[dbo].[Character] WHERE AccountID = @AccountID
	
	
END




GO
/****** Object:  StoredProcedure [dbo].[GetImitatedNPC]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetImitatedNPC]

AS
BEGIN    
     SELECT * FROM GameWorld.dbo.ImitatedNpc;
END



GO
/****** Object:  StoredProcedure [dbo].[GetRankJob]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetRankJob]
@WorldID int,
@CharacterID int,
@JobRank int output
AS
BEGIN
	DECLARE @CharacterJob int;
	SELECT @CharacterJob = B_Job FROM GameWorld.dbo.Character WHERE CharacterID = @CharacterID;
	
	SELECT 
		@JobRank = a.JobRank
	FROM(
		SELECT 
			CharacterID, 
			CharacterName, 
			B_Job, B_Level, ROW_NUMBER()  OVER(order by B_Level desc) 
			JobRank 
		FROM 
			GameWorld.dbo.Character
		WHERE 
			(B_Job / 100) = @CharacterJob / 100
			AND AccountID NOT IN (
				SELECT AccountID From GlobalAccount.dbo.Account WHERE Admin IN (1, 255)
			)
	) a
	WHERE a.CharacterID = @CharacterID

	RETURN(0);
END;


GO
/****** Object:  StoredProcedure [dbo].[MaplePoint_Get]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  Returns account cash points
*/
CREATE PROCEDURE [dbo].[MaplePoint_Get]
	@AccountID int
AS
BEGIN
    DECLARE @maplePoints int;
	SELECT @maplePoints = ISNULL(maplePoint, 0 ) FROM Account WHERE AccountID = @AccountID;
	return(@maplePoints);
END

GO
/****** Object:  StoredProcedure [dbo].[Set_Account]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Set_Account]
	@AccountID int,
	@Gender int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Account] SET Gender = @Gender WHERE AccountID = @AccountID
	RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[SetUserBlockedByCharacterName]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetUserBlockedByCharacterName]
	-- Add the parameters for the stored procedure here
	@BlockedUser varchar(20),
	@BlockType int,
	@BlockAmount int,
	@BlockerWorldID int,
	@BlockerChannelID int,
	@BlockerMapId int,
	@BlockerUser varchar(20),
	@BlockReason text,
	@outvar9 int output
AS
BEGIN
	--TODO: BAN USER IN DB
	SET @outvar9 = 1
	DECLARE @AccountID int;
	DECLARE @CurrentIP varchar(15);
	DECLARE @GradeCode int;

	SELECT @AccountID = AccountID FROM GameWorld.dbo.Character WHERE
		CharacterName = @BlockedUser;

	
	SELECT @CurrentIP = CurrentIP, @GradeCode = @GradeCode FROM Account WHERE AccountID = @AccountID;

	IF @GradeCode = 0 --or @CurrentIP = '127.0.0.1'
	BEGIN
		return (0);
	END;

		
	
	Update GlobalAccount.dbo.Account 
		SET IsBanned = 1
		WHERE AccountID = @AccountID;
	
	INSERT INTO AccountBans VALUES(@BlockedUser, @BlockType, @BlockAmount, @BlockerWorldID, @BlockerChannelID, @BlockerMapId, @BlockerUser, @BlockReason, CURRENT_TIMESTAMP);
	--INSERT INTO IPBans(IP, BanEntry) VALUES(@CurrentIP, Scope_Identity());

	--COMMIT;

	return 1

END





GO
/****** Object:  StoredProcedure [dbo].[UpdateImitatedNpcData]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UpdateImitatedNpcData]
@TemplateID int,
@CharacterName varchar(20),
@PackedData varbinary(max)
AS
BEGIN
	UPDATE GameWorld.dbo.ImitatedNpc 
		SET TemplateID = @TemplateID,
			CharacterName = @CharacterName,
			PackedData = @PackedData
		WHERE 
			CharacterName = @CharacterName; 
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO GameWorld.dbo.ImitatedNpc VALUES(@TemplateID, @CharacterName, @PackedData);
	END

	RETURN(0);
END;




GO
/****** Object:  StoredProcedure [dbo].[UpdatePinCode]    Script Date: 17/07/2021 06:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdatePinCode]
	@AccountID int,
	@NewPin varchar(4)
AS
BEGIN
	UPDATE Account SET Pin = @NewPin WHERE AccountID = @AccountID
	RETURN(0)
END



GO