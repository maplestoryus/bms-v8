
USE GlobalAccount;

-- Initialize the world config
INSERT INTO GameWorld VALUES(1, 'Tespia', 9000, 7870,'');



USE GameWorld;
-- Initialize the seed for item SN
INSERT INTO ItemInitSN VALUES(0, 0);
INSERT INTO ItemInitSN VALUES(1, 0);
INSERT INTO ItemInitSN VALUES(2, 0);
INSERT INTO ItemInitSN VALUES(3, 0);
INSERT INTO ItemInitSN VALUES(4, 0);
INSERT INTO ItemInitSN VALUES(5, 0);
INSERT INTO ItemInitSN VALUES(6, 0);
INSERT INTO ItemInitSN VALUES(7, 0);

Use GlobalAccount;

-- Create an initial user with password admin
INSERT INTO Account
           (AccountName
           ,PasswordHash
           ,Pin
           ,ReadEULA
           ,IsBanned
           ,AccountStatusID
           ,PrivateStatusID
           ,BirthDate
           ,CurrentIP
           ,Admin
           ,NeedVerification
           ,AccountFlags
           ,ChatBlock
           ,PacketDump
           ,Gender
           ,RegisterDate
           ,maplePoint
           ,PurchaseExp
           ,Email
           ,NexonCash)
     VALUES
           ('user'
           ,'21232f297a57a5a743894a0e4a801fc3'
           ,''
           ,0
           ,0
           ,0
           ,0
           ,'1990-01-01 00:00:00.000'
           ,''
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,SYSDATETIME()
           ,500000
           ,0
           ,'user@nx.com'
           ,500000);

-- Create an initial admin with password admin
INSERT INTO Account
           (AccountName
           ,PasswordHash
           ,Pin
           ,ReadEULA
           ,IsBanned
           ,AccountStatusID
           ,PrivateStatusID
           ,BirthDate
           ,CurrentIP
           ,Admin
           ,NeedVerification
           ,AccountFlags
           ,ChatBlock
           ,PacketDump
           ,Gender
           ,RegisterDate
           ,maplePoint
           ,PurchaseExp
           ,Email
           ,NexonCash)
     VALUES
           ('admin'
           ,'21232f297a57a5a743894a0e4a801fc3'
           ,''
           ,0
           ,0
           ,0
           ,0
           ,'1990-01-01 00:00:00.000'
           ,''
           ,255
           ,0
           ,0
           ,0
           ,0
           ,0
           ,SYSDATETIME()
           ,500000
           ,0
           ,'user@nx.com'
           ,500000);
