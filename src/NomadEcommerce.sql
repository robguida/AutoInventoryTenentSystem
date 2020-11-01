USE [master]
GO
/****** Object:  Database [NomadEcommerce]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE DATABASE [NomadEcommerce]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NomadEcommerce', FILENAME = N'D:\Projects\TestsForJobOpportunities\NomadEcommerce\Database\NomadEcommerce.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NomadEcommerce_log', FILENAME = N'D:\Projects\TestsForJobOpportunities\NomadEcommerce\Database\NomadEcommerce_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [NomadEcommerce] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NomadEcommerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NomadEcommerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NomadEcommerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NomadEcommerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NomadEcommerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NomadEcommerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [NomadEcommerce] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NomadEcommerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NomadEcommerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NomadEcommerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NomadEcommerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NomadEcommerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NomadEcommerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NomadEcommerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NomadEcommerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NomadEcommerce] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NomadEcommerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NomadEcommerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NomadEcommerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NomadEcommerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NomadEcommerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NomadEcommerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NomadEcommerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NomadEcommerce] SET RECOVERY FULL 
GO
ALTER DATABASE [NomadEcommerce] SET  MULTI_USER 
GO
ALTER DATABASE [NomadEcommerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NomadEcommerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NomadEcommerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NomadEcommerce] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NomadEcommerce] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NomadEcommerce] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'NomadEcommerce', N'ON'
GO
ALTER DATABASE [NomadEcommerce] SET QUERY_STORE = OFF
GO
USE [NomadEcommerce]
GO

-- =============================================
-- Author:		Rob Guida
-- Create date: <Create Date, ,>
-- Description:	Gets the expiration date for auth keys
-- =============================================
CREATE FUNCTION [dbo].[GetAuthKeyExpireDate]()
RETURNS DATETIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar DATETIME;

	-- Add the T-SQL statements to compute the return value here
	SET @ResultVar = (SELECT DATEADD(MINUTE, 30, GETDATE()));

	-- Return the result of the function
	RETURN @ResultVar;

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetPasswordHash]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetPasswordHash]
(
	-- Add the parameters for the function here
	@RightNow DATETIME,
	@Password VARCHAR(20)
	
)
RETURNS VARBINARY(MAX)
AS
BEGIN
	RETURN HASHBYTES('SHA2_256', CONCAT(CAST(@RightNow AS VARCHAR(20)), @Password, CAST(@RightNow AS VARCHAR(20))));
END
GO
/****** Object:  Table [dbo].[Auto]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auto](
	[AutoId] [int] IDENTITY(1,1) NOT NULL,
	[TenentId] [int] NOT NULL,
	[ModelNumber] [varchar](50) NOT NULL,
	[Classification] [varchar](20) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Auto] PRIMARY KEY CLUSTERED 
(
	[AutoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AutoColor]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoColor](
	[AutoColorId] [int] NOT NULL,
	[TenentId] [int] NOT NULL,
	[DisplayName] [varchar](20) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_AutoColor] PRIMARY KEY CLUSTERED 
(
	[AutoColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AutoInventory]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoInventory](
	[AutoInventoryId] [int] IDENTITY(1,1) NOT NULL,
	[AutoId] [int] NOT NULL,
	[VIN] [varchar](50) NOT NULL,
	[AutoColorId] [int] NOT NULL,
	[AutoTrimId] [int] NOT NULL,
	[Doors] [smallint] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_AutoInventory] PRIMARY KEY CLUSTERED 
(
	[AutoInventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AutoTrim]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoTrim](
	[AutoTrimId] [int] IDENTITY(1,1) NOT NULL,
	[TenentId] [int] NOT NULL,
	[DisplayName] [varchar](20) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_AutoTrim] PRIMARY KEY CLUSTERED 
(
	[AutoTrimId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tenent]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tenent](
	[TenentId] [int] IDENTITY(1,1) NOT NULL,
	[TenentName] [varchar](50) NOT NULL,
	[TenentHeaderBanner] [varbinary](max) NULL,
	[TenentDomain] [varchar](256) NOT NULL,
	[DateCreate] [datetime] NOT NULL,
 CONSTRAINT [PK_Tenent] PRIMARY KEY CLUSTERED 
(
	[TenentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TenentUser]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TenentUser](
	[TenentUserId] [int] IDENTITY(1,1) NOT NULL,
	[TenentId] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](256) NOT NULL,
	[Password] [varbinary](max) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_TenentUser] PRIMARY KEY CLUSTERED 
(
	[TenentUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TenentUserAuthKey]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TenentUserAuthKey](
	[TenentUserId] [int] NOT NULL,
	[AuthKey] [varchar](256) NOT NULL,
	[DateExpired] [datetime] NOT NULL,
 CONSTRAINT [PK_TenentUserAuthKey_1] PRIMARY KEY CLUSTERED 
(
	[TenentUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Auto_Classification]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_Auto_Classification] ON [dbo].[Auto]
(
	[Classification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Auto_ModelNumber]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Auto_ModelNumber] ON [dbo].[Auto]
(
	[ModelNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AutoColor]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_AutoColor] ON [dbo].[AutoColor]
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AutoInventory_1]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_AutoInventory_1] ON [dbo].[AutoInventory]
(
	[AutoColorId] ASC,
	[Doors] ASC,
	[AutoTrimId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_AutoInventory_VIN]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AutoInventory_VIN] ON [dbo].[AutoInventory]
(
	[VIN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Tenent_TenantName]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Tenent_TenantName] ON [dbo].[Tenent]
(
	[TenentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Tenent_TenentDomain]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Tenent_TenentDomain] ON [dbo].[Tenent]
(
	[TenentDomain] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_TenentUser_Email]    Script Date: 10/31/2020 5:58:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TenentUser_Email] ON [dbo].[TenentUser]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Auto] ADD  CONSTRAINT [DF_Auto_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[AutoColor] ADD  CONSTRAINT [DF_AutoColor_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[AutoInventory] ADD  CONSTRAINT [DF_AutoInventory_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[AutoTrim] ADD  CONSTRAINT [DF_AutoTrim_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Tenent] ADD  CONSTRAINT [DF_Tenent_DateCreate]  DEFAULT (getdate()) FOR [DateCreate]
GO
ALTER TABLE [dbo].[TenentUser] ADD  CONSTRAINT [DF_Table_1_PasswordHash]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[TenentUserAuthKey] ADD  CONSTRAINT [DF_TenentUserAuthKey_AuthKey]  DEFAULT (newid()) FOR [AuthKey]
GO
ALTER TABLE [dbo].[TenentUserAuthKey] ADD  CONSTRAINT [DF_TenentUserAuthKey_DateExpired]  DEFAULT ([dbo].[GetAuthKeyExpireDate]()) FOR [DateExpired]
GO
ALTER TABLE [dbo].[Auto]  WITH CHECK ADD  CONSTRAINT [FK_Auto_TenentId] FOREIGN KEY([TenentId])
REFERENCES [dbo].[Tenent] ([TenentId])
GO
ALTER TABLE [dbo].[Auto] CHECK CONSTRAINT [FK_Auto_TenentId]
GO
ALTER TABLE [dbo].[AutoColor]  WITH CHECK ADD  CONSTRAINT [FK_AutoColor_TenentId] FOREIGN KEY([TenentId])
REFERENCES [dbo].[Tenent] ([TenentId])
GO
ALTER TABLE [dbo].[AutoColor] CHECK CONSTRAINT [FK_AutoColor_TenentId]
GO
ALTER TABLE [dbo].[AutoInventory]  WITH CHECK ADD  CONSTRAINT [FK_AutoInventory_AutoColorId] FOREIGN KEY([AutoColorId])
REFERENCES [dbo].[AutoColor] ([AutoColorId])
GO
ALTER TABLE [dbo].[AutoInventory] CHECK CONSTRAINT [FK_AutoInventory_AutoColorId]
GO
ALTER TABLE [dbo].[AutoInventory]  WITH CHECK ADD  CONSTRAINT [FK_AutoInventory_AutoId] FOREIGN KEY([AutoId])
REFERENCES [dbo].[Auto] ([AutoId])
GO
ALTER TABLE [dbo].[AutoInventory] CHECK CONSTRAINT [FK_AutoInventory_AutoId]
GO
ALTER TABLE [dbo].[AutoInventory]  WITH CHECK ADD  CONSTRAINT [FK_AutoInventory_AutoTrimId] FOREIGN KEY([AutoTrimId])
REFERENCES [dbo].[AutoTrim] ([AutoTrimId])
GO
ALTER TABLE [dbo].[AutoInventory] CHECK CONSTRAINT [FK_AutoInventory_AutoTrimId]
GO
ALTER TABLE [dbo].[AutoTrim]  WITH CHECK ADD  CONSTRAINT [FK_AutoTrim_TenentId] FOREIGN KEY([TenentId])
REFERENCES [dbo].[Tenent] ([TenentId])
GO
ALTER TABLE [dbo].[AutoTrim] CHECK CONSTRAINT [FK_AutoTrim_TenentId]
GO
ALTER TABLE [dbo].[TenentUser]  WITH CHECK ADD  CONSTRAINT [FK_TenentUser_TenentId] FOREIGN KEY([TenentId])
REFERENCES [dbo].[Tenent] ([TenentId])
GO
ALTER TABLE [dbo].[TenentUser] CHECK CONSTRAINT [FK_TenentUser_TenentId]
GO
ALTER TABLE [dbo].[TenentUser]  WITH CHECK ADD  CONSTRAINT [FK_TenentUserAuthKey_TenentUserId] FOREIGN KEY([TenentUserId])
REFERENCES [dbo].[TenentUserAuthKey] ([TenentUserId])
GO
ALTER TABLE [dbo].[TenentUser] CHECK CONSTRAINT [FK_TenentUserAuthKey_TenentUserId]
GO
/****** Object:  StoredProcedure [dbo].[spAuto_Create]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuto_Create]
	@TenentId int,
    @ModelNumber varchar(50),
    @Classification varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Auto]
           (
			   [TenentId]
			   ,[ModelNumber]
			   ,[Classification]
		   )
     VALUES
           (	
				@TenentId,
				@ModelNumber,
				@Classification
			)
		;

	SELECT @@IDENTITY AS AutoId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAuto_Delete]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuto_Delete]
	@AutoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [Auto] WHERE AutoId = @AutoId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAuto_Read]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuto_Read]
	@AutoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [Auto] WHERE AutoId = @AutoId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAuto_Update]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuto_Update]
	@AutoId int,
	@TenentId int,
    @ModelNumber varchar(50),
    @Classification varchar(20),
    @DateCreated datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Auto] SET
         [TenentId] = @TenentId
		,[ModelNumber] = @ModelNumber
		,[Classification] = @Classification
	WHERE AutoId = @AutoId
	;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoColor_Create]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoColor_Create]
	@TenentId int,
    @DisplayName varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].AutoColor
           (
			   [TenentId]
			   ,[DisplayName]
		   )
     VALUES
           (	
				@TenentId,
				@DisplayName
			)
		;

	SELECT @@IDENTITY AS AutoColorId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoColor_Delete]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoColor_Delete]
	@AutoColorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM AutoColor WHERE AutoColorId = @AutoColorId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoColor_Read]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoColor_Read]
	@AutoColorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM AutoColor WHERE AutoColorId = @AutoColorId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoColor_Update]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoColor_Update]
	@AutoColorId INT,
	@TenentId int,
    @DisplayName varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].AutoColor SET
			   [TenentId] = @TenentId
			   ,[DisplayName] = @DisplayName
	WHERE AutoColorId = @AutoColorId
	;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_Create]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoInventory_Create]
	@AutoId INT,
	@VIN VARCHAR(50),
	@AutoColorId INT,
	@AutoTrimId INT,
	@Doors SMALLINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   INSERT INTO [dbo].[AutoInventory]
           (
			   [AutoId]
			   ,[VIN]
			   ,[AutoColorId]
			   ,[AutoTrimId]
			   ,[Doors]
		   )
     VALUES
           (
			   @AutoId
			   , @VIN
			   , @AutoColorId
			   , @AutoTrimId
			   , @Doors
		   )
	;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_Delete]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoInventory_Delete]
	@AutoInventoryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM AutoInventory WHERE AutoInventoryId = @AutoInventoryId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_Read]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoInventory_Read]
	@AutoInventoryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM AutoInventory WHERE AutoInventoryId = @AutoInventoryId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_Update]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoInventory_Update]
	@AutoInventoryId INT,
	@AutoId INT,
	@VIN VARCHAR(50),
	@AutoColorId INT,
	@Doors SMALLINT,
	@AutoTrimId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   UPDATE [dbo].[AutoInventory] SET
           [AutoId] = @AutoId
			,[VIN] = @VIN
			,[AutoColorId] = @AutoColorId
			,[AutoTrimId] = @AutoTrimId
			,[Doors] = @Doors
	WHERE AutoInventoryId = @AutoInventoryId
	;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoTrim_Create]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoTrim_Create]
	@TenentId INT,
	@DisplayName VARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO AutoTrim (TenentId, DisplayName) VALUES (@TenentId, @DisplayName);

	SELECT @@IDENTITY;

END
GO
/****** Object:  StoredProcedure [dbo].[spAutoTrim_Delete]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoTrim_Delete]
	@AutoTrimId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM AutoTrim
	WHERE AutoTrimId = @AutoTrimId;

END
GO
/****** Object:  StoredProcedure [dbo].[spAutoTrim_Read]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoTrim_Read]
	@AutoTrimId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM AutoTrim
	WHERE AutoTrimId = @AutoTrimId;

END
GO
/****** Object:  StoredProcedure [dbo].[spAutoTrim_Update]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoTrim_Update]
	@AutoTrimId INT,
	@TenentId INT,
	@DisplayName VARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE AutoTrim  SET
		TenentId = @TenentId
		, DisplayName = @DisplayName
	WHERE AutoTrimId = @AutoTrimId;

END
GO
/****** Object:  StoredProcedure [dbo].[spTenent_Create]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenent_Create]
	@TenentName VARCHAR(50),
	@TenentHeaderBanner Varbinary(max),
	@TenentDomain VARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Tenent (TenentName, TenentHeaderBanner, TenentDomain)
	VALUES (@TenentName, @TenentHeaderBanner, @TenentDomain);

	SELECT @@IDENTITY AS TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenent_Delete]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenent_Delete]
	@TenentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Tenent WHERE TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenent_Read]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenent_Read] 
	@TenentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Tenent WHERE TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenent_Update]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenent_Update]
	@TenentId INT,
	@TenentName VARCHAR(50),
	@TenentHeaderBanner Varbinary(max),
	@TenentDomain VARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Tenent SET
		TenentName = @TenentName,
		TenentHeaderBanner = @TenentHeaderBanner,
		TenentDomain = @TenentDomain
	WHERE TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_Create]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUser_Create] 
	@TenentId INT,
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@Email VARCHAR(256),
	@Password VARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @RightNow DATETIME = GETDATE();
	DECLARE @PasswordHashed VARBINARY(MAX) = (SELECT dbo.GetPasswordHash(@RightNow, @Password));

	INSERT INTO TenentUser (TenentId, FirstName, LastName, Email, [Password], DateCreated)
	VALUES (@TenentId, @FirstName, @LastName, @Email, @PasswordHashed, @RightNow);

	SELECT @@IDENTITY AS TenentUserId;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_Delete]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUser_Delete]
	@TenentUserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM TenentUser WHERE TenentUserId = @TenentUserId;	
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_Read]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUser_Read]
	@TenentUserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM TenentUser WHERE TenentUserId = @TenentUserId;	
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_Update]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUser_Update]
	@TenentUserId INT,
	@TenentId INT,
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@Email VARCHAR(256),
	@Password VARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Password IS NOT NULL BEGIN
		DECLARE @DateCreated DATETIME = (SELECT DateCreated FROM TenentUser WHERE TenentUserId = @TenentUserId);
		DECLARE @PasswordHashed VARBINARY(MAX) = (SELECT dbo.GetPasswordHash(@DateCreated, @Password));
		UPDATE TenentUser SET
			TenentId = @TenentId
			, FirstName = @FirstName
			, LastName = @LastName
			, Email = @Email
			, [Password] = @PasswordHashed
		WHERE TenentUserId = @TenentUserId;	
	END ELSE BEGIN
		UPDATE TenentUser SET
			TenentId = @TenentId
			, FirstName = @FirstName
			, LastName = @LastName
			, Email = @Email
		WHERE TenentUserId = @TenentUserId;		
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUserAuthKey_CreateUpdate]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUserAuthKey_CreateUpdate]
	@TenentUserId INT
	, @AuthKey VARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF 0 = (SELECT COUNT(*) FROM TenetUserAuthKey WHERE TenentUserId = @TenentUserId) BEGIN
		INSERT INTO TenentUserAuthKey (TenentUserId, AuthKey)
		VALUES (@TenentUserId, @AuthKey);
	END ELSE BEGIN
		UPDATE TenentUserAuthKey SET
			AuthKey = @AuthKey
			, DateExpired = GETDATE()
		WHERE TenentUserId = @TenentUserId;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUserAuthKey_Delete]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUserAuthKey_Delete]
	@TenentUserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM TenentUserAuthKey WHERE TenentUserId = @TenentUserId;	
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUserAuthKey_Read]    Script Date: 10/31/2020 5:58:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUserAuthKey_Read]
	@TenentUserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM TenentUserAuthKey WHERE TenentUserId = @TenentUserId;	
END
GO
USE [master]
GO
ALTER DATABASE [NomadEcommerce] SET  READ_WRITE 
GO
