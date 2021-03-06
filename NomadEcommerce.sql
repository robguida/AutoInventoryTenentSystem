USE [master]
GO
/****** Object:  Database [NomadEcommerce]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[GetAuthKeyExpireDate]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  User [nomad]    Script Date: 10/31/2020 5:58:47 PM ******/
--CREATE USER [nomad] FOR LOGIN [nomad] WITH DEFAULT_SCHEMA=[dbo]
--GO
--ALTER ROLE [db_owner] ADD MEMBER [nomad]
--GO
/****** Object:  UserDefinedFunction [dbo].[GetAuthKeyExpireDate]    Script Date: 10/31/2020 5:58:47 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
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
/****** Object:  UserDefinedFunction [dbo].[GetSeededHashedString]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSeededHashedString]
(
	-- Add the parameters for the function here
	@RightNow DATETIME,
	@HashMe VARCHAR(MAX),
	@TenentId INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @String VARCHAR(2000) = CONCAT(CAST(@RightNow AS VARCHAR(20)), @HashMe, CAST(@RightNow AS VARCHAR(20)), CAST(@TenentId AS VARCHAR(20)))
	DECLARE @Hash VARBINARY(MAX) = HASHBYTES('SHA2_256', @String);
	RETURN CONVERT(VARCHAR(max), @Hash, 2);
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSeededHashString]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSeededHashString]
(
	-- Add the parameters for the function here
	@RightNow DATETIME,
	@HashMe VARCHAR(MAX),
	@TenentId INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @String VARCHAR(2000) = CONCAT(CAST(@RightNow AS VARCHAR(20)), @HashMe, CAST(@RightNow AS VARCHAR(20)), CAST(@TenentId AS VARCHAR(20)))
	DECLARE @Hash VARBINARY(MAX) = HASHBYTES('SHA2_256', @String);
	RETURN CONVERT(VARCHAR(max), @Hash, 2);
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSqlOrderByClause]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSqlOrderByClause] 
(
	@OrderBy VARCHAR(256) = null
)
RETURNS NVARCHAR(1000)
AS
BEGIN
	DECLARE @ReturnVal VARCHAR(1000) = '';

	IF @OrderBy IS NOT NULL
		SET @ReturnVal = ' ORDER BY ' + @OrderBy;
	
	RETURN @ReturnVal;
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSqlPagingClause]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSqlPagingClause] 
(
	@PagingOffset INT = null,
	@PagingLimit INT = 50
)
RETURNS NVARCHAR(1000)
AS
BEGIN
	IF @PagingOffset IS NULL
		SET @PagingOffset = 0;

	RETURN ' OFFSET ' + CAST(@PagingOffset AS VARCHAR(20)) +
					' ROWS FETCH NEXT ' + CAST(@PagingLimit AS VARCHAR(20)) + ' ROWS ONLY';
END
GO
/****** Object:  Table [dbo].[Auto]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  Table [dbo].[AutoColor]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoColor](
	[AutoColorId] [int] IDENTITY(1,1) NOT NULL,
	[TenentId] [int] NOT NULL,
	[DisplayName] [varchar](20) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_AutoColor] PRIMARY KEY CLUSTERED 
(
	[AutoColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AutoInventory]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoInventory](
	[AutoInventoryId] [int] IDENTITY(1,1) NOT NULL,
	[AutoId] [int] NOT NULL,
	[TenentId] [int] NOT NULL,
	[VIN] [varchar](50) NOT NULL,
	[AutoColorId] [int] NOT NULL,
	[AutoTrimId] [int] NOT NULL,
	[Doors] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_AutoInventory] PRIMARY KEY CLUSTERED 
(
	[AutoInventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AutoTrim]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  Table [dbo].[Tenent]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  Table [dbo].[TenentUser]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	[Password] [varchar](max) NOT NULL,
	[AuthKey] [varchar](max) NULL,
	[AuthKeyExpires] [datetime] NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_TenentUser] PRIMARY KEY CLUSTERED 
(
	[TenentUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TenentUserAuthKey]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TenentUserAuthKey](
	[TenentUserId] [int] NOT NULL,
	[AuthKey] [varchar](256) NOT NULL,
	[DateExpired] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Auto_Classification]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE NONCLUSTERED INDEX [IX_Auto_Classification] ON [dbo].[Auto]
(
	[Classification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Auto_ModelNumber]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Auto_ModelNumber] ON [dbo].[Auto]
(
	[ModelNumber] ASC,
	[Classification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AutoColor]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE NONCLUSTERED INDEX [IX_AutoColor] ON [dbo].[AutoColor]
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AutoInventory_1]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE NONCLUSTERED INDEX [IX_AutoInventory_1] ON [dbo].[AutoInventory]
(
	[AutoColorId] ASC,
	[Doors] ASC,
	[AutoTrimId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_AutoInventory_VIN]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AutoInventory_VIN] ON [dbo].[AutoInventory]
(
	[VIN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Tenent_TenantName]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Tenent_TenantName] ON [dbo].[Tenent]
(
	[TenentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Tenent_TenentDomain]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Tenent_TenentDomain] ON [dbo].[Tenent]
(
	[TenentDomain] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_TenentUser_Email]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TenentUser_Email] ON [dbo].[TenentUser]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UIX_TenentUserAuthKey_TenentUserId]    Script Date: 11/2/2020 4:16:22 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_TenentUserAuthKey_TenentUserId] ON [dbo].[TenentUserAuthKey]
(
	[TenentUserId] ASC
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
ALTER TABLE [dbo].[AutoInventory]  WITH CHECK ADD  CONSTRAINT [FK_AutoInventory_TenentId] FOREIGN KEY([TenentId])
REFERENCES [dbo].[Tenent] ([TenentId])
GO
ALTER TABLE [dbo].[AutoInventory] CHECK CONSTRAINT [FK_AutoInventory_TenentId]
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
/****** Object:  StoredProcedure [dbo].[spAuto_Create]    Script Date: 11/2/2020 4:16:22 PM ******/
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

    DECLARE @AutoId INT = (SELECT AutoID FROM [Auto] WHERE TenentId = @TenentId AND ModelNumber = @ModelNumber AND [Classification] = @Classification);
	IF @AutoId IS NULL OR 0 = @AutoId BEGIN
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
	END ELSE BEGIN
		SELECT @AutoId AS AutoID
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spAuto_Delete]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@AutoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [Auto] WHERE AutoId = @AutoId AND TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAuto_List]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuto_List] 
	@TenentId INT,
	@ModelNumber VARCHAR(50) = null,
	@Classification VARCHAR(20) = null,
	@OrderBy VARCHAR(256) = null,
	@PagingOffset INT = null,
	@PagingLimit INT = 50
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Statement NVARCHAR(4000) = 'SELECT a.*
											, ai.AutoInventoryId, ai.VIN, ai.Doors
											, ac.DisplayName AS Color
											, at.DisplayName AS Trim
									     FROM Auto a
											JOIN AutoInventory ai ON ai.AutoId = a.AutoId
												JOIN AutoColor ac ON ac.AutoColorId = ai.AutoColorId
												JOIN AutoTrim at ON at.AutoTrimId = ai.AutoTrimId';
	DECLARE @Where NVARCHAR(2000) = ' WHERE a.TenentId = ' + CAST(@TenentId AS VARCHAR(20));
	DECLARE @Paging NVARCHAR(1000) = '';
	DECLARE @Ordering NVARCHAR(1000) = '';

	IF @ModelNumber IS NOT NULL
		SET @Where = @Where + ' AND a.ModelNumber LIKE ''' + @ModelNumber + '%''';

	IF @Classification IS NOT NULL
		SET @Where = @Where + ' AND a.Classification LIKE ''' + @Classification + '%''';

	SET @Paging = (SELECT dbo.GetSqlPagingClause(@PagingOffset, @PagingLimit));
	SET @Ordering = (SELECT dbo.GetSqlOrderByClause(@OrderBy));

	SET @Statement = @Statement + @Where + @Ordering + @Paging + ';';
	--SELECT @Statement;
	EXECUTE sp_executesql @statement;
END
GO
/****** Object:  StoredProcedure [dbo].[spAuto_Read]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@AutoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [Auto] WHERE AutoId = @AutoId AND TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAuto_Update]    Script Date: 11/2/2020 4:16:22 PM ******/
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
    @Classification varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Auto] SET
		[ModelNumber] = @ModelNumber
		,[Classification] = @Classification
	WHERE AutoId = @AutoId AND TenentId = @TenentId
	;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoColor_Create]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAutoColor_Delete]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@AutoColorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM AutoColor WHERE AutoColorId = @AutoColorId AND TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoColor_List]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoColor_List] 
	@TenentId INT = null,
	@DisplayName VARCHAR(20) = null,
	@OrderBy VARCHAR(256) = null,
	@PagingOffset INT = null,
	@PagingLimit INT = 50
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Statement NVARCHAR(4000) = 'SELECT * FROM AutoColor';
	DECLARE @Where NVARCHAR(2000) = ' WHERE TenentId = ' + CAST(@TenentId AS VARCHAR(20));
	DECLARE @Paging NVARCHAR(1000) = '';
	DECLARE @Ordering NVARCHAR(1000) = '';

	IF @DisplayName IS NOT NULL
		SET @Where = @Where + ' AND DisplayName LIKE ''' + @DisplayName + '%''';

	SET @Paging = (SELECT dbo.GetSqlPagingClause(@PagingOffset, @PagingLimit));
	SET @Ordering = (SELECT dbo.GetSqlOrderByClause(@OrderBy));

	SET @Statement = @Statement + @Where + @Ordering + @Paging + ';';
	--SELECT @Statement;
	EXECUTE sp_executesql @statement;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoColor_Read]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@AutoColorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM AutoColor WHERE AutoColorId = @AutoColorId AND TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoColor_Update]    Script Date: 11/2/2020 4:16:22 PM ******/
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
		[DisplayName] = @DisplayName
	WHERE AutoColorId = @AutoColorId AND TenentId = @TenentId
	;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_Create]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
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
				[TenentId]
			   ,[AutoId]
			   ,[VIN]
			   ,[AutoColorId]
			   ,[AutoTrimId]
			   ,[Doors]
		   )
     VALUES
           (
			   @TenentId
			   , @AutoId
			   , @VIN
			   , @AutoColorId
			   , @AutoTrimId
			   , @Doors
		   )
	;

	SELECT @@IDENTITY AS AutoInventoryId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_Delete]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@AutoInventoryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM AutoInventory WHERE AutoInventoryId = @AutoInventoryId AND TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_List]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoInventory_List] 
	@TenentId INT,
	@AutoId INT = null,
	@VIN VARCHAR(50) = null,
	@AutoColorId Int = null,
	@AutoTrimId Int = null,
	@Doors Int = null,
	@OrderBy VARCHAR(256) = null,
	@PagingOffset INT = null,
	@PagingLimit INT = 50
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Statement NVARCHAR(4000) = 'SELECT * FROM AutoInventory';
	DECLARE @Where NVARCHAR(2000) = ' WHERE TenentId = ' + CAST(@TenentId AS VARCHAR(20));
	DECLARE @Paging NVARCHAR(1000) = '';
	DECLARE @Ordering NVARCHAR(1000) = '';

	IF @AutoId IS NOT NULL
		SET @Where = @Where + ' AND AutoId = ' + CAST(@AutoId AS VARCHAR(20));

	IF @VIN IS NOT NULL
		SET @WHERE = @Where + ' AND VIN LIKE ''' + @VIN + '%''';

	IF @AutoColorId IS NOT NULL
		SET @Where = @Where + ' AND AutoColorId = ' + CAST(@AutoColorId AS VARCHAR(20));

	IF @AutoTrimId IS NOT NULL
		SET @Where = @Where + ' AND AutoTrimId = ' + CAST(@AutoTrimId AS VARCHAR(20));

	IF @Doors IS NOT NULL
		SET @Where = @Where + ' AND Doors = ' + CAST(@Doors AS VARCHAR(20));

	SET @Paging = (SELECT dbo.GetSqlPagingClause(@PagingOffset, @PagingLimit));
	SET @Ordering = (SELECT dbo.GetSqlOrderByClause(@OrderBy));

	SET @Statement = @Statement + @Where + @Ordering + @Paging + ';';
	--SELECT @Statement;
	EXECUTE sp_executesql @statement;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_Read]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@AutoInventoryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM AutoInventory WHERE AutoInventoryId = @AutoInventoryId AND TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoInventory_Update]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
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
	WHERE AutoInventoryId = @AutoInventoryId  AND TenentId = @TenentId
	;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoTrim_Create]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAutoTrim_Delete]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@AutoTrimId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM AutoTrim
	WHERE AutoTrimId = @AutoTrimId AND TenentId = @TenentId;

END
GO
/****** Object:  StoredProcedure [dbo].[spAutoTrim_List]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAutoTrim_List] 
	@TenentId INT = null,
	@DisplayName VARCHAR(20) = null,
	@OrderBy VARCHAR(256) = null,
	@PagingOffset INT = null,
	@PagingLimit INT = 50
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Statement NVARCHAR(4000) = 'SELECT * FROM AutoTrim';
	DECLARE @Where NVARCHAR(2000) = ' WHERE TenentId = ' + CAST(@TenentId AS VARCHAR(20));
	DECLARE @Paging NVARCHAR(1000) = '';
	DECLARE @Ordering NVARCHAR(1000) = '';

	IF @DisplayName IS NOT NULL
		SET @Where = @Where + ' AND DisplayName LIKE ''' + @DisplayName + '%''';

	SET @Paging = (SELECT dbo.GetSqlPagingClause(@PagingOffset, @PagingLimit));
	SET @Ordering = (SELECT dbo.GetSqlOrderByClause(@OrderBy));

	SET @Statement = @Statement + @Where + @Ordering + @Paging + ';';
	--SELECT @Statement;
	EXECUTE sp_executesql @statement;
END
GO
/****** Object:  StoredProcedure [dbo].[spAutoTrim_Read]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@AutoTrimId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM AutoTrim
	WHERE AutoTrimId = @AutoTrimId AND TenentId = @TenentId;

END
GO
/****** Object:  StoredProcedure [dbo].[spAutoTrim_Update]    Script Date: 11/2/2020 4:16:22 PM ******/
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
		DisplayName = @DisplayName
	WHERE AutoTrimId = @AutoTrimId AND TenentId = @TenentId;

END
GO
/****** Object:  StoredProcedure [dbo].[spTenent_Create]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentDomain VARCHAR(256),
	@TenentHeaderBanner Varbinary(max) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Tenent (TenentName, TenentDomain, TenentHeaderBanner)
	VALUES (@TenentName, @TenentDomain, @TenentHeaderBanner);

	SELECT @@IDENTITY AS TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenent_Delete]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spTenent_List]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenent_List] 
	@TenentName VARCHAR(50) = null,
	@TenentDomain VARCHAR(256) = null,
	@OrderBy VARCHAR(256) = 'TenentName DESC',
	@PagingOffset INT = null,
	@PagingLimit INT = 50
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Statement NVARCHAR(4000) = 'SELECT * FROM Tenent';
	DECLARE @Where NVARCHAR(2000) = '';
	DECLARE @Paging NVARCHAR(1000) = '';
	DECLARE @Ordering NVARCHAR(1000) = '';

	IF @TenentName IS NOT NULL
		SET @WHERE = ' WHERE TenentName LIKE ''' + @TenentName + '%''';

	IF @TenentDomain IS NOT NULL BEGIN
		IF @Where = '' BEGIN
			SET @WHERE = ' WHERE TenentDomain = ''' + @TenentDomain + '''';
		END ELSE BEGIN
			SET @Where = @Where + ' AND  TenentDomain = ''' + @TenentDomain + '''';
		END
	END

	SET @Paging = (SELECT dbo.GetSqlPagingClause(@PagingOffset, @PagingLimit));
	SET @Ordering = (SELECT dbo.GetSqlOrderByClause(@OrderBy));

	SET @Statement = @Statement + @Where + @Ordering + @Paging + ';';
	SELECT @Statement;
	EXECUTE sp_executesql @statement;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenent_Read]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spTenent_Update]    Script Date: 11/2/2020 4:16:22 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spTenentUser_Authenticate]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUser_Authenticate] 
	@TenentId INT,
	@Email VARCHAR(256),
	@Password VARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TenentUserId INT;
	DECLARE @DateCreated DATETIME;
	DECLARE @PasswordBinary VARCHAR(MAX);
	DECLARE @PasswordHashed VARCHAR(MAX)

	SET @TenentUserId = (SELECT TenentUserId FROM TenentUser WHERE Email = @Email AND TenentId = @TenentId);
	IF 0 < @TenentUserId BEGIN
		SET @DateCreated = (SELECT DateCreated FROM TenentUser WHERE TenentUserId = @TenentUserId);
		SET @PasswordBinary = (SELECT [Password] FROM TenentUser WHERE TenentUserId = @TenentUserId);
		SET @PasswordHashed = (SELECT dbo.GetSeededHashString(@DateCreated, @Password, @TenentId));
		IF @PasswordBinary = @PasswordHashed BEGIN
			SELECT TenentUserId, TenentId, FirstName, LastName, Email, [Password], DateCreated FROM TenentUser WHERE TenentUserId = @TenentUserId;
		END ELSE BEGIN
			SELECT 'The Email/Password did not work' AS Error;
		END
	END ELSE BEGIN
		SELECT 'The Email/Password did not work' AS Error;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_Create]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	DECLARE @PasswordHashed VARCHAR(MAX) = (SELECT dbo.GetSeededHashedString(@RightNow, @Password, @TenentId));

	INSERT INTO TenentUser (TenentId, FirstName, LastName, Email, [Password], DateCreated)
	VALUES (@TenentId, @FirstName, @LastName, @Email, @PasswordHashed, @RightNow);

	SELECT @@IDENTITY AS TenentUserId;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_Delete]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT,
	@TenentUserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM TenentUser WHERE TenentUserId = @TenentUserId AND TenentId = @TenentId;	
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_List]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUser_List] 
	@TenentId INT,
	@FirstName VARCHAR(50) = null,
	@LastName VARCHAR(50) = null,
	@Email VARCHAR(256) = null,
	@OrderBy VARCHAR(256) = null,
	@PagingOffset INT = null,
	@PagingLimit INT = 50
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Statement NVARCHAR(4000) = 'SELECT * FROM TenentUser';
	DECLARE @Where NVARCHAR(2000) = ' WHERE TenentId = ' + CAST(@TenentId AS VARCHAR(20));
	DECLARE @Paging NVARCHAR(1000) = '';
	DECLARE @Ordering NVARCHAR(1000) = '';

	IF @FirstName IS NOT NULL
		SET @Where = @Where + ' AND FirstName LIKE ''' + @FirstName + '%''';

	IF @LastName IS NOT NULL
		SET @Where = @Where + ' AND LastName LIKE ''' + @LastName + '%''';

	IF @Email IS NOT NULL
		SET @Where = @Where + ' AND Email LIKE ''' + @Email + '%''';


	SET @Paging = (SELECT dbo.GetSqlPagingClause(@PagingOffset, @PagingLimit));
	SET @Ordering = (SELECT dbo.GetSqlOrderByClause(@OrderBy));

	SET @Statement = @Statement + @Where + @Ordering + @Paging + ';';
	--SELECT @Statement;
	EXECUTE sp_executesql @statement;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_Read]    Script Date: 11/2/2020 4:16:22 PM ******/
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
	@TenentId INT, 
	@TenentUserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TenentUserId, TenentId, FirstName, LastName, Email, [Password], DateCreated FROM TenentUser WHERE TenentUserId = @TenentUserId AND TenentId = @TenentId;	
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_ReadAuthToken]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUser_ReadAuthToken]
	@TenentId INT,
	@TenentUserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AuthKeyExpires DATETIME =  DATEADD(MINUTE, 20, GETDATE());

	UPDATE TenentUser SET
		AuthKey = dbo.GetSeededHashString(@AuthKeyExpires, NEWID(), @TenentId),
		AuthKeyExpires = @AuthKeyExpires
	WHERE
		TenentUserId = @TenentUserId
		AND
		TenentId = @TenentId;

	SELECT AuthKey
	FROM TenentUser
	WHERE
		TenentUserId = @TenentUserId
		AND
		TenentId = @TenentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_Update]    Script Date: 11/2/2020 4:16:22 PM ******/
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
			FirstName = @FirstName
			, LastName = @LastName
			, Email = @Email
			, [Password] = @PasswordHashed
		WHERE TenentUserId = @TenentUserId AND TenentId = @TenentId;	
	END ELSE BEGIN
		UPDATE TenentUser SET
			FirstName = @FirstName
			, LastName = @LastName
			, Email = @Email
		WHERE TenentUserId = @TenentUserId AND TenentId = @TenentId;		
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spTenentUser_ValidateAuthToken]    Script Date: 11/2/2020 4:16:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTenentUser_ValidateAuthToken] 
	@AuthToken VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF 0 < (SELECT COUNT(TenentUserId) FROM TenentUser WHERE AuthKey = @AuthToken AND AuthKeyExpires >= GETDATE()) BEGIN
		SELECT TenentUserId, TenentId, FirstName, LastName, Email, DateCreated FROM TenentUser WHERE AuthKey = @AuthToken;
	END
	/* Remove the AuthKey regardless if it is expired or not, the AuthKey is removed once it is accessed */
	UPDATE TenentUser SET AuthKey = NULL, AuthKeyExpires = NULL WHERE AuthKey = @AuthToken;
END
GO
USE [master]
GO
ALTER DATABASE [NomadEcommerce] SET  READ_WRITE 
GO
