USE [master]
GO
/****** Object:  Database [AgvWarehouseDb]    Script Date: 05/02/2017 17:46:15 ******/
CREATE DATABASE [AgvWarehouseDb] ON  PRIMARY 
( NAME = N'AgvWarehoueDb', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER2008R\MSSQL\DATA\AgvWarehouseDb.mdf' , SIZE = 48128KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AgvWarehoueDb_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER2008R\MSSQL\DATA\AgvWarehouseDb.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AgvWarehouseDb] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AgvWarehouseDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AgvWarehouseDb] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET ANSI_NULLS OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET ANSI_PADDING OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET ARITHABORT OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [AgvWarehouseDb] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [AgvWarehouseDb] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [AgvWarehouseDb] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET  DISABLE_BROKER
GO
ALTER DATABASE [AgvWarehouseDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [AgvWarehouseDb] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [AgvWarehouseDb] SET  READ_WRITE
GO
ALTER DATABASE [AgvWarehouseDb] SET RECOVERY SIMPLE
GO
ALTER DATABASE [AgvWarehouseDb] SET  MULTI_USER
GO
ALTER DATABASE [AgvWarehouseDb] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [AgvWarehouseDb] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'AgvWarehouseDb', N'ON'
GO
USE [AgvWarehouseDb]
GO
/****** Object:  Table [dbo].[StockTaskLog]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockTaskLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StockTaskId] [int] NULL,
	[RoadMachineIndex] [int] NULL,
	[BoxType] [int] NULL,
	[PositionNr] [varchar](50) NULL,
	[PositionFloor] [int] NULL,
	[PositionColumn] [int] NULL,
	[PositionRow] [int] NULL,
	[AgvPassFlag] [int] NULL,
	[RestPositionFlag] [int] NULL,
	[BarCode] [varchar](500) NULL,
	[FromState] [int] NULL,
	[ToState] [int] NULL,
	[Type] [int] NULL,
	[TrayReverseNo] [int] NULL,
	[TrayNum] [int] NULL,
	[PickItemNum] [int] NULL,
	[PickBatchId] [varchar](50) NULL,
	[TrayBatchId] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[PickListItemId] [int] NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[StockTaskLog] ADD [ToPositionNr] [varchar](50) NULL
ALTER TABLE [dbo].[StockTaskLog] ADD [ToPositionFloor] [int] NULL
ALTER TABLE [dbo].[StockTaskLog] ADD [ToPositionColumn] [int] NULL
ALTER TABLE [dbo].[StockTaskLog] ADD [ToPositionRow] [int] NULL
ALTER TABLE [dbo].[StockTaskLog] ADD  CONSTRAINT [PK_StockTaskLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockTask]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockTask](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoadMachineIndex] [int] NULL,
	[BoxType] [int] NULL,
	[PositionNr] [varchar](50) NULL,
	[PositionFloor] [int] NULL,
	[PositionColumn] [int] NULL,
	[PositionRow] [int] NULL,
	[AgvPassFlag] [int] NULL,
	[RestPositionFlag] [int] NULL,
	[BarCode] [varchar](500) NULL,
	[State] [int] NULL,
	[Type] [int] NULL,
	[TrayReverseNo] [int] NULL,
	[TrayNum] [int] NULL,
	[PickItemNum] [int] NULL,
	[PickBatchId] [varchar](50) NULL,
	[TrayBatchId] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[PickListItemId] [int] NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[StockTask] ADD [ToPositionNr] [varchar](50) NULL
ALTER TABLE [dbo].[StockTask] ADD [ToPositionFloor] [int] NULL
ALTER TABLE [dbo].[StockTask] ADD [ToPositionColumn] [int] NULL
ALTER TABLE [dbo].[StockTask] ADD [ToPositionRow] [int] NULL
ALTER TABLE [dbo].[StockTask] ADD  CONSTRAINT [PK_StockTask] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockMovement]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockMovement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UniqItemNr] [varchar](50) NULL,
	[SourcePosition] [varchar](50) NULL,
	[AimedPosition] [varchar](50) NULL,
	[Type] [int] NULL,
	[Operator] [varchar](50) NULL,
	[Time] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK_Movement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Delivery]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Delivery](
	[Nr] [varchar](50) NOT NULL,
	[State] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Delivery] PRIMARY KEY CLUSTERED 
(
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BoxType]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BoxType](
	[Id] [int] NOT NULL,
	[TrayQty] [int] NULL,
	[Type] [int] NULL,
	[Description] [varchar](50) NULL,
 CONSTRAINT [PK_BoxType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PickList]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PickList](
	[Nr] [varchar](50) NOT NULL,
	[State] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_PickList] PRIMARY KEY CLUSTERED 
(
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Part]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Part](
	[Nr] [varchar](50) NOT NULL,
	[BoxType] [int] NULL,
 CONSTRAINT [PK_Part] PRIMARY KEY CLUSTERED 
(
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MoveTaskSchedule]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MoveTaskSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[CreateUserNr] [varchar](50) NULL,
 CONSTRAINT [PK_MoveTaskSchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StorageBak]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StorageBak](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PositionNr] [varchar](50) NOT NULL,
	[PartNr] [varchar](50) NULL,
	[FIFO] [datetime] NULL,
	[UniqItemNr] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Storage_2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Warehouse](
	[Nr] [varchar](50) NOT NULL,
	[AgvId] [int] NULL,
 CONSTRAINT [PK_WareHouse] PRIMARY KEY CLUSTERED 
(
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_WareHouse] UNIQUE NONCLUSTERED 
(
	[AgvId] ASC,
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tray]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tray](
	[Nr] [varchar](50) NOT NULL,
	[State] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Tray] PRIMARY KEY CLUSTERED 
(
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WarehouseArea]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WarehouseArea](
	[Nr] [varchar](50) NOT NULL,
	[IsLocked] [bit] NOT NULL,
	[Remark] [varchar](50) NULL,
	[Color] [varchar](50) NULL,
	[InStorePriority] [int] NOT NULL,
	[WarehouseNr] [varchar](50) NULL,
 CONSTRAINT [PK_WarehouseArea] PRIMARY KEY CLUSTERED 
(
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PickListItem]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PickListItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PickListNr] [varchar](50) NULL,
	[UniqItemNr] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[PositionNr] [varchar](50) NULL,
 CONSTRAINT [PK_PickListItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UniqueItem]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UniqueItem](
	[Nr] [varchar](50) NOT NULL,
	[BoxTypeId] [int] NULL,
	[PartNr] [varchar](50) NULL,
	[KNr] [varchar](50) NULL,
	[KNrWithYear] [varchar](50) NULL,
	[CheckCode] [varchar](50) NULL,
	[KskNr] [varchar](50) NULL,
	[QR] [varchar](50) NULL,
	[State] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[CheckCode2] [varchar](100) NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DeliveryTray]    Script Date: 05/02/2017 17:46:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliveryTray](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryNr] [varchar](50) NULL,
	[TrayNr] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_DeliveryTray] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SetUniqueItemBoxType]    Script Date: 05/02/2017 17:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetUniqueItemBoxType]
	-- Add the parameters for the stored procedure here
	@boxTypeId int,
	@nr varchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    update UniqueItem set BoxTypeId=@boxTypeId where Nr =@nr;
END
GO
/****** Object:  Table [dbo].[Position]    Script Date: 05/02/2017 17:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Position](
	[Nr] [varchar](50) NOT NULL,
	[WarehouseNr] [varchar](50) NOT NULL,
	[Floor] [int] NOT NULL,
	[Column] [int] NOT NULL,
	[Row] [int] NOT NULL,
	[State] [int] NULL,
	[RoadMachineIndex] [int] NULL,
	[IsLocked] [bit] NOT NULL,
	[InStorePriority] [int] NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[Position] ADD [WarehouseAreaNr] [varchar](50) NULL
ALTER TABLE [dbo].[Position] ADD  CONSTRAINT [PK_Posation] PRIMARY KEY CLUSTERED 
(
	[Nr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrayItem]    Script Date: 05/02/2017 17:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrayItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UniqItemNr] [varchar](50) NULL,
	[TrayNr] [varchar](50) NULL,
	[State] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_TrayItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[TrayDeliveryView]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TrayDeliveryView]
AS
SELECT     dbo.Tray.Nr, dbo.Tray.State, dbo.Tray.CreatedAt, dbo.Tray.UpdatedAt, dbo.DeliveryTray.Id AS DeliveryTrayId, dbo.DeliveryTray.DeliveryNr AS DeliveryTrayDeliveryNr, 
                      dbo.DeliveryTray.TrayNr AS DeliveryTrayTrayNr, dbo.DeliveryTray.CreatedAt AS DeliveryTrayCreatedAt, dbo.DeliveryTray.UpdatedAt AS DeliveryTrayUpdatedAt, 
                      dbo.Delivery.Nr AS DeliveryNr, dbo.Delivery.State AS DeliveryState, dbo.Delivery.CreatedAt AS DeliveryCreatedAt, 
                      dbo.Delivery.UpdatedAt AS DeliveryUpdatedAt
FROM         dbo.Tray INNER JOIN
                      dbo.DeliveryTray ON dbo.Tray.Nr = dbo.DeliveryTray.TrayNr INNER JOIN
                      dbo.Delivery ON dbo.DeliveryTray.DeliveryNr = dbo.Delivery.Nr
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[14] 4[49] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tray"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 156
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DeliveryTray"
            Begin Extent = 
               Top = 6
               Left = 218
               Bottom = 156
               Right = 360
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Delivery"
            Begin Extent = 
               Top = 6
               Left = 398
               Bottom = 149
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2970
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TrayDeliveryView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TrayDeliveryView'
GO
/****** Object:  StoredProcedure [dbo].[TASK_RestAllOutTaskToWaitingState]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TASK_RestAllOutTaskToWaitingState]
 @toState int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    update StockTask set State=@toState where [type]=1;
    update [AgvWarehouseDb].[dbo].UniqueItem set State=100;
END
GO
/****** Object:  Table [dbo].[DeliveryItem]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliveryItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryNr] [varchar](50) NULL,
	[UniqItemNr] [varchar](50) NULL,
	[State] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_DeliveryItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Storage]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Storage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PositionNr] [varchar](50) NOT NULL,
	[PartNr] [varchar](50) NULL,
	[FIFO] [datetime] NULL,
	[UniqItemNr] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Storage_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[DELIVERY_DeleteDelivery]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELIVERY_DeleteDelivery]
   @nr varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   delete from DeliveryItem where DeliveryNr=@nr;
delete from Delivery where nr=@nr;
END
GO
/****** Object:  View [dbo].[PositionStorageView]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PositionStorageView]
AS
SELECT     dbo.Position.Nr, dbo.Position.WarehouseNr, dbo.Position.Floor, dbo.Position.[Column], dbo.Position.Row, dbo.Position.State, dbo.Position.RoadMachineIndex, 
                      dbo.Position.IsLocked, dbo.Position.InStorePriority, dbo.Position.WarehouseAreaNr, dbo.Storage.Id AS StorageId, dbo.Storage.PositionNr AS StoragePositionNr, 
                      dbo.Storage.PartNr AS StoragePartNr, dbo.Storage.FIFO AS StorageFIFO, dbo.Storage.UniqItemNr AS StorageUniqItemNr, dbo.Storage.CreatedAt AS StorageCreatedAt, 
                      dbo.WarehouseArea.IsLocked AS WarehouseAreaIsLocked, dbo.WarehouseArea.Remark AS WarehouseAreaRemark, 
                      dbo.WarehouseArea.Color AS WarehouseAreaColor, dbo.WarehouseArea.InStorePriority AS WarehouseAreaInStorePriority, 
                      dbo.WarehouseArea.WarehouseNr AS WarehouseAreaWarehouseNr
FROM         dbo.Position LEFT OUTER JOIN
                      dbo.Storage ON dbo.Position.Nr = dbo.Storage.PositionNr LEFT OUTER JOIN
                      dbo.WarehouseArea ON dbo.WarehouseArea.Nr = dbo.Position.WarehouseAreaNr
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[62] 2[1] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Position"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 188
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Storage"
            Begin Extent = 
               Top = 6
               Left = 257
               Bottom = 213
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PositionStorageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PositionStorageView'
GO
/****** Object:  StoredProcedure [dbo].[TASK_RestAllTaskAndStorage]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	重置所以入库出库操作，重新开始
-- =============================================
CREATE PROCEDURE [dbo].[TASK_RestAllTaskAndStorage]
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
   delete from [AgvWarehouseDb].[dbo].[StockTask];
	 delete from [AgvWarehouseDb].[dbo].[Storage];
	  update [AgvWarehouseDb].[dbo].UniqueItem set State=100;
END
GO
/****** Object:  StoredProcedure [dbo].[TASK_RestAllData]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TASK_RestAllData]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    delete from StockTask;
    delete from Storage;
    delete from TrayItem;
    delete from DeliveryTray;
    delete from Tray;
    delete from DeliveryItem;
    delete from Delivery;
    update [AgvWarehouseDb].[dbo].UniqueItem set State=100;
END
GO
/****** Object:  View [dbo].[StorageUniqueItemView]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StorageUniqueItemView]
AS
SELECT     dbo.Storage.Id, dbo.Storage.PositionNr, dbo.Storage.PartNr, dbo.Storage.FIFO, dbo.Storage.UniqItemNr, dbo.Storage.CreatedAt, dbo.Storage.UpdatedAt, 
                      dbo.UniqueItem.Nr AS UniqueItemNr, dbo.UniqueItem.BoxTypeId AS UniqueItemBoxTypeId, dbo.UniqueItem.PartNr AS UniqueItemPartNr, 
                      dbo.UniqueItem.KNr AS UniqueItemKNr, dbo.UniqueItem.KNrWithYear AS UniqueItemKNrWithYear, dbo.UniqueItem.CheckCode AS UniqueItemCheckCode, 
                      dbo.UniqueItem.KskNr AS UniqueItemKskNr, dbo.UniqueItem.QR AS UniqueItemQR, dbo.UniqueItem.State AS UniqueItemState, 
                      dbo.UniqueItem.CreatedAt AS UniqueItemCreatedAt, dbo.UniqueItem.UpdatedAt AS UniqueItemUpdatedAt, dbo.Position.IsLocked AS PositionIsLocked, 
                      dbo.Position.RoadMachineIndex AS PositionRoadMachineIndex, dbo.Position.State AS PositionState, dbo.Position.Row AS PositionRow, 
                      dbo.Position.[Column] AS PositionColumn, dbo.Position.Floor AS PositionFloor, dbo.Position.WarehouseNr AS PositionWarehouseNr, 
                      dbo.Position.WarehouseAreaNr AS PositionWarehouseAreaNr, dbo.Position.InStorePriority AS PositionInStorePriority, 
                      dbo.WarehouseArea.IsLocked AS WarehouseAreaIsLocked, dbo.WarehouseArea.Remark AS WarehouseAreaRemark, 
                      dbo.WarehouseArea.Color AS WarehouseAreaColor, dbo.WarehouseArea.InStorePriority AS WarehouseAreaInStorePriority, 
                      dbo.WarehouseArea.WarehouseNr AS WarehouseAreaWarehouseNr
FROM         dbo.Storage INNER JOIN
                      dbo.UniqueItem ON dbo.Storage.UniqItemNr = dbo.UniqueItem.Nr INNER JOIN
                      dbo.Position ON dbo.Storage.PositionNr = dbo.Position.Nr LEFT OUTER JOIN
                      dbo.WarehouseArea ON dbo.WarehouseArea.Nr = dbo.Position.WarehouseAreaNr
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[15] 4[63] 2[7] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Storage"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 184
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UniqueItem"
            Begin Extent = 
               Top = 6
               Left = 219
               Bottom = 230
               Right = 369
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Position"
            Begin Extent = 
               Top = 6
               Left = 407
               Bottom = 230
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 5295
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StorageUniqueItemView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StorageUniqueItemView'
GO
/****** Object:  View [dbo].[DeliveryStorageView]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DeliveryStorageView]
AS
SELECT     dbo.Delivery.Nr, dbo.Delivery.State, dbo.Delivery.CreatedAt, dbo.Delivery.UpdatedAt, dbo.DeliveryItem.Id AS DeliveryItemId, 
                      dbo.DeliveryItem.DeliveryNr AS DeliveryItemDeliveryNr, dbo.DeliveryItem.UniqItemNr AS DeliveryItemUniqItemNr, dbo.DeliveryItem.State AS DeliveryItemState, 
                      dbo.DeliveryItem.CreatedAt AS DeliveryItemCreatedAt, dbo.DeliveryItem.UpdatedAt AS DeliveryItemUpdatedAt, dbo.UniqueItem.Nr AS UniqueItemNr, 
                      dbo.UniqueItem.BoxTypeId AS UniqueItemBoxTypeId, dbo.UniqueItem.PartNr AS UniqueItemPartNr, dbo.UniqueItem.KNr AS UniqueItemKNr, 
                      dbo.UniqueItem.KNrWithYear AS UniqueItemKNrWithYear, dbo.UniqueItem.CheckCode AS UniqueItemCheckCode, dbo.UniqueItem.KskNr AS UniqueItemKskNr, 
                      dbo.UniqueItem.QR AS UniqueItemQR, dbo.UniqueItem.State AS UniqueItemState, dbo.UniqueItem.CreatedAt AS UniqueItemCreatedAt, 
                      dbo.UniqueItem.UpdatedAt AS UniqueItemUpdatedAt, dbo.Storage.Id AS StorageId, dbo.Storage.PositionNr AS StoragePositionNr, dbo.Storage.PartNr AS StoragePartNr, 
                      dbo.Storage.FIFO AS StorageFIFO, dbo.Storage.UniqItemNr AS StorageUniqItemNr, dbo.Storage.CreatedAt AS StorageCreatedAt, 
                      dbo.Storage.UpdatedAt AS StorageUpdatedAt, dbo.Position.WarehouseNr AS PositionWarehouseNr, dbo.Position.Floor AS PositionFloor, 
                      dbo.Position.[Column] AS PositionColumn, dbo.Position.Row AS PositionRow, dbo.Position.State AS PositionState, 
                      dbo.Position.RoadMachineIndex AS PositionRoadMachineIndex, dbo.TrayItem.Id AS TrayItemId, dbo.TrayItem.UniqItemNr AS TrayItemUniqItemNr, 
                      dbo.TrayItem.TrayNr AS TrayItemTrayNr, dbo.TrayItem.State AS TrayItemState, dbo.TrayItem.CreatedAt AS TrayItemCreatedAt, 
                      dbo.TrayItem.UpdatedAt AS TrayItemUpdatedAt
FROM         dbo.Delivery INNER JOIN
                      dbo.DeliveryItem ON dbo.DeliveryItem.DeliveryNr = dbo.Delivery.Nr INNER JOIN
                      dbo.UniqueItem ON dbo.DeliveryItem.UniqItemNr = dbo.UniqueItem.Nr LEFT OUTER JOIN
                      dbo.Storage ON dbo.UniqueItem.Nr = dbo.Storage.UniqItemNr LEFT OUTER JOIN
                      dbo.Position ON dbo.Storage.PositionNr = dbo.Position.Nr LEFT OUTER JOIN
                      dbo.TrayItem ON dbo.TrayItem.UniqItemNr = dbo.DeliveryItem.UniqItemNr
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[60] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Delivery"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 184
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DeliveryItem"
            Begin Extent = 
               Top = 18
               Left = 227
               Bottom = 137
               Right = 370
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "UniqueItem"
            Begin Extent = 
               Top = 17
               Left = 424
               Bottom = 136
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Storage"
            Begin Extent = 
               Top = 10
               Left = 651
               Bottom = 239
               Right = 794
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Position"
            Begin Extent = 
               Top = 6
               Left = 832
               Bottom = 217
               Right = 1013
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TrayItem"
            Begin Extent = 
               Top = 143
               Left = 351
               Bottom = 299
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1605
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DeliveryStorageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Alias = 2190
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DeliveryStorageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DeliveryStorageView'
GO
/****** Object:  View [dbo].[DeliveryItemStorageView]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DeliveryItemStorageView]
AS
SELECT     dbo.DeliveryItem.Id, dbo.DeliveryItem.DeliveryNr, dbo.DeliveryItem.UniqItemNr, dbo.DeliveryItem.State, dbo.DeliveryItem.CreatedAt, dbo.DeliveryItem.UpdatedAt, 
                      dbo.UniqueItem.Nr AS UniqueItemNr, dbo.UniqueItem.BoxTypeId AS UniqueItemBoxTypeId, dbo.UniqueItem.PartNr AS UniqueItemPartNr, 
                      dbo.UniqueItem.KNr AS UniqueItemKNr, dbo.UniqueItem.KNrWithYear AS UniqueItemKNrWithYear, dbo.UniqueItem.CheckCode AS UniqueItemCheckCode, 
                      dbo.UniqueItem.KskNr AS UniqueItemKskNr, dbo.UniqueItem.QR AS UniqueItemQR, dbo.UniqueItem.State AS UniqueItemState, 
                      dbo.UniqueItem.CreatedAt AS UniqueItemCreatedAt, dbo.UniqueItem.UpdatedAt AS UniqueItemUpdatedAt, dbo.Storage.Id AS StorageId, 
                      dbo.Storage.PositionNr AS StoragePositionNr, dbo.Storage.PartNr AS StoragePartNr, dbo.Storage.FIFO AS StorageFIFO, dbo.Storage.UniqItemNr AS StorageUniqItemNr, 
                      dbo.Storage.CreatedAt AS StorageCreatedAt, dbo.Storage.UpdatedAt AS StorageUpdatedAt, dbo.TrayItem.Id AS TrayItemId, 
                      dbo.TrayItem.UniqItemNr AS TrayItemUniqItemNr, dbo.TrayItem.TrayNr AS TrayItemTrayNr, dbo.TrayItem.State AS TrayItemState, 
                      dbo.TrayItem.CreatedAt AS TrayItemCreatedAt, dbo.TrayItem.UpdatedAt AS TrayItemUpdatedAt
FROM         dbo.DeliveryItem INNER JOIN
                      dbo.UniqueItem ON dbo.DeliveryItem.UniqItemNr = dbo.UniqueItem.Nr LEFT OUTER JOIN
                      dbo.Storage ON dbo.UniqueItem.Nr = dbo.Storage.UniqItemNr LEFT OUTER JOIN
                      dbo.TrayItem ON dbo.TrayItem.UniqItemNr = dbo.DeliveryItem.UniqItemNr
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[16] 2[53] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DeliveryItem"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 179
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UniqueItem"
            Begin Extent = 
               Top = 6
               Left = 219
               Bottom = 250
               Right = 369
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Storage"
            Begin Extent = 
               Top = 6
               Left = 407
               Bottom = 239
               Right = 550
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TrayItem"
            Begin Extent = 
               Top = 294
               Left = 38
               Bottom = 413
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2895
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DeliveryItemStorageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DeliveryItemStorageView'
GO
/****** Object:  View [dbo].[PickListStorageView]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PickListStorageView]
AS
SELECT     dbo.PickList.Nr, dbo.PickListItem.CreatedAt, dbo.PickList.UpdatedAt, dbo.PickListItem.Id AS PickListItemId, dbo.PickListItem.PickListNr AS PickListItemPickListNr, 
                      dbo.PickListItem.UniqItemNr AS PickListItemUniqItemNr, dbo.PickListItem.CreatedAt AS PickListItemCreatedAt, dbo.PickListItem.UpdatedAt AS PickListItemUpdatedAt, 
                      dbo.UniqueItem.Nr AS UniqueItemNr, dbo.UniqueItem.BoxTypeId AS UniqueItemBoxTypeId, dbo.UniqueItem.PartNr AS UniqueItemPartNr, 
                      dbo.UniqueItem.KNr AS UniqueItemKNr, dbo.UniqueItem.KNrWithYear AS UniqueItemKNrWithYear, dbo.UniqueItem.CheckCode AS UniqueItemCheckCode, 
                      dbo.UniqueItem.KskNr AS UniqueItemKskNr, dbo.UniqueItem.QR AS UniqueItemQR, dbo.UniqueItem.State AS UniqueItemState, 
                      dbo.UniqueItem.CreatedAt AS UniqueItemCreatedAt, dbo.UniqueItem.UpdatedAt AS UniqueItemUpdatedAt, dbo.Storage.Id AS StorageId, 
                      dbo.Storage.PositionNr AS StoragePositionNr, dbo.Storage.PartNr AS StoragePartNr, dbo.Storage.FIFO AS StorageFIFO, dbo.Storage.UniqItemNr AS StorageUniqItemNr, 
                      dbo.Storage.CreatedAt AS StorageCreatedAt, dbo.Storage.UpdatedAt AS StorageUpdatedAt, dbo.Position.WarehouseNr AS PositionWarehouseNr, 
                      dbo.Position.Floor AS PositionFloor, dbo.Position.[Column] AS PositionColumn, dbo.Position.Row AS PositionRow, dbo.Position.State AS PositionState, 
                      dbo.Position.RoadMachineIndex AS PositionRoadMachineIndex,dbo.Position.WarehouseAreaNr as PositionWarehouseAreaNr
FROM         dbo.PickList INNER JOIN
                      dbo.PickListItem ON dbo.PickListItem.PickListNr = dbo.PickList.Nr INNER JOIN
                      dbo.UniqueItem ON dbo.PickListItem.UniqItemNr = dbo.UniqueItem.Nr LEFT OUTER JOIN
                      dbo.Storage ON dbo.UniqueItem.Nr = dbo.Storage.UniqItemNr LEFT OUTER JOIN
                      dbo.Position ON dbo.Storage.PositionNr = dbo.Position.Nr
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[25] 2[41] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PickList"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 110
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PickListItem"
            Begin Extent = 
               Top = 6
               Left = 218
               Bottom = 125
               Right = 361
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UniqueItem"
            Begin Extent = 
               Top = 6
               Left = 399
               Bottom = 125
               Right = 549
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Storage"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Position"
            Begin Extent = 
               Top = 126
               Left = 219
               Bottom = 245
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PickListStorageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PickListStorageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PickListStorageView'
GO
/****** Object:  View [dbo].[PickListItemStorageView]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PickListItemStorageView]
AS
SELECT     dbo.PickListItem.Id, dbo.PickListItem.PickListNr, dbo.PickListItem.UniqItemNr, dbo.PickListItem.CreatedAt, dbo.PickListItem.UpdatedAt, 
                      dbo.UniqueItem.Nr AS UniqueItemNr, dbo.UniqueItem.BoxTypeId AS UniqueItemBoxTypeId, dbo.UniqueItem.PartNr AS UniqueItemPartNr, 
                      dbo.UniqueItem.KNr AS UniqueItemKNr, dbo.UniqueItem.KNrWithYear AS UniqueItemKNrWithYear, dbo.UniqueItem.CheckCode AS UniqueItemCheckCode, 
                      dbo.UniqueItem.KskNr AS UniqueItemKskNr, dbo.UniqueItem.QR AS UniqueItemQR, dbo.UniqueItem.State AS UniqueItemState, 
                      dbo.UniqueItem.CreatedAt AS UniqueItemCreatedAt, dbo.UniqueItem.UpdatedAt AS UniqueItemUpdatedAt, dbo.Storage.Id AS StorageId, 
                      dbo.Storage.PositionNr AS StoragePositionNr, dbo.Storage.PartNr AS StoragePartNr, dbo.Storage.FIFO AS StorageFIFO, dbo.Storage.UniqItemNr AS StorageUniqItemNr, 
                      dbo.Storage.CreatedAt AS StorageCreatedAt, dbo.Storage.UpdatedAt AS StorageUpdatedAt
FROM         dbo.PickListItem LEFT OUTER JOIN
                      dbo.UniqueItem ON dbo.PickListItem.UniqItemNr = dbo.UniqueItem.Nr LEFT OUTER JOIN
                      dbo.Storage ON dbo.UniqueItem.Nr = dbo.Storage.UniqItemNr
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[17] 2[27] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PickListItem"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UniqueItem"
            Begin Extent = 
               Top = 6
               Left = 219
               Bottom = 125
               Right = 369
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Storage"
            Begin Extent = 
               Top = 6
               Left = 407
               Bottom = 125
               Right = 550
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2880
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PickListItemStorageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PickListItemStorageView'
GO
/****** Object:  StoredProcedure [dbo].[SelectCurrentStorage]    Script Date: 05/02/2017 17:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectCurrentStorage]
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
select UniqueItemPartNr as '配置号',	UniqueItemKNr as '大众K号',
   UniqueItemKskNr as '莱尼内部K号', UniqueItemCheckCode as	'验证码',PositionNr as '库位号', FIFO as 'FIFO',
     '箱型'=case when UniqueItemBoxTypeId=1 then 'Big' when UniqueItemBoxTypeId=2 then 'Small' else '' end,	PositionRoadMachineIndex as '巷道机号'
 from StorageUniqueItemView;
END
GO
/****** Object:  Default [DF_WarehouseArea_isLocked]    Script Date: 05/02/2017 17:46:18 ******/
ALTER TABLE [dbo].[WarehouseArea] ADD  CONSTRAINT [DF_WarehouseArea_isLocked]  DEFAULT ((0)) FOR [IsLocked]
GO
/****** Object:  Default [DF_WarehouseArea_InStorePriority]    Script Date: 05/02/2017 17:46:18 ******/
ALTER TABLE [dbo].[WarehouseArea] ADD  CONSTRAINT [DF_WarehouseArea_InStorePriority]  DEFAULT ((1)) FOR [InStorePriority]
GO
/****** Object:  Default [DF_Position_isLocked]    Script Date: 05/02/2017 17:46:20 ******/
ALTER TABLE [dbo].[Position] ADD  CONSTRAINT [DF_Position_isLocked]  DEFAULT ((0)) FOR [IsLocked]
GO
/****** Object:  Default [DF__Position__InStor__7E37BEF6]    Script Date: 05/02/2017 17:46:20 ******/
ALTER TABLE [dbo].[Position] ADD  DEFAULT ((0)) FOR [InStorePriority]
GO
/****** Object:  ForeignKey [FK_WarehouseArea_Warehouse]    Script Date: 05/02/2017 17:46:18 ******/
ALTER TABLE [dbo].[WarehouseArea]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseArea_Warehouse] FOREIGN KEY([WarehouseNr])
REFERENCES [dbo].[Warehouse] ([Nr])
GO
ALTER TABLE [dbo].[WarehouseArea] CHECK CONSTRAINT [FK_WarehouseArea_Warehouse]
GO
/****** Object:  ForeignKey [FK_PickListItem_PickList]    Script Date: 05/02/2017 17:46:18 ******/
ALTER TABLE [dbo].[PickListItem]  WITH CHECK ADD  CONSTRAINT [FK_PickListItem_PickList] FOREIGN KEY([PickListNr])
REFERENCES [dbo].[PickList] ([Nr])
GO
ALTER TABLE [dbo].[PickListItem] CHECK CONSTRAINT [FK_PickListItem_PickList]
GO
/****** Object:  ForeignKey [FK_UniqueItem_BoxType]    Script Date: 05/02/2017 17:46:18 ******/
ALTER TABLE [dbo].[UniqueItem]  WITH CHECK ADD  CONSTRAINT [FK_UniqueItem_BoxType] FOREIGN KEY([BoxTypeId])
REFERENCES [dbo].[BoxType] ([Id])
GO
ALTER TABLE [dbo].[UniqueItem] CHECK CONSTRAINT [FK_UniqueItem_BoxType]
GO
/****** Object:  ForeignKey [FK_DeliveryTray_Delivery]    Script Date: 05/02/2017 17:46:18 ******/
ALTER TABLE [dbo].[DeliveryTray]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryTray_Delivery] FOREIGN KEY([DeliveryNr])
REFERENCES [dbo].[Delivery] ([Nr])
GO
ALTER TABLE [dbo].[DeliveryTray] CHECK CONSTRAINT [FK_DeliveryTray_Delivery]
GO
/****** Object:  ForeignKey [FK_DeliveryTray_Tray]    Script Date: 05/02/2017 17:46:18 ******/
ALTER TABLE [dbo].[DeliveryTray]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryTray_Tray] FOREIGN KEY([TrayNr])
REFERENCES [dbo].[Tray] ([Nr])
GO
ALTER TABLE [dbo].[DeliveryTray] CHECK CONSTRAINT [FK_DeliveryTray_Tray]
GO
/****** Object:  ForeignKey [FK_Posation_WareHouse]    Script Date: 05/02/2017 17:46:20 ******/
ALTER TABLE [dbo].[Position]  WITH CHECK ADD  CONSTRAINT [FK_Posation_WareHouse] FOREIGN KEY([WarehouseNr])
REFERENCES [dbo].[Warehouse] ([Nr])
GO
ALTER TABLE [dbo].[Position] CHECK CONSTRAINT [FK_Posation_WareHouse]
GO
/****** Object:  ForeignKey [FK_Position_WarehouseArea]    Script Date: 05/02/2017 17:46:20 ******/
ALTER TABLE [dbo].[Position]  WITH CHECK ADD  CONSTRAINT [FK_Position_WarehouseArea] FOREIGN KEY([WarehouseAreaNr])
REFERENCES [dbo].[WarehouseArea] ([Nr])
GO
ALTER TABLE [dbo].[Position] CHECK CONSTRAINT [FK_Position_WarehouseArea]
GO
/****** Object:  ForeignKey [FK_TrayItem_Tray]    Script Date: 05/02/2017 17:46:20 ******/
ALTER TABLE [dbo].[TrayItem]  WITH CHECK ADD  CONSTRAINT [FK_TrayItem_Tray] FOREIGN KEY([TrayNr])
REFERENCES [dbo].[Tray] ([Nr])
GO
ALTER TABLE [dbo].[TrayItem] CHECK CONSTRAINT [FK_TrayItem_Tray]
GO
/****** Object:  ForeignKey [FK_TrayItem_UniqueItem]    Script Date: 05/02/2017 17:46:20 ******/
ALTER TABLE [dbo].[TrayItem]  WITH CHECK ADD  CONSTRAINT [FK_TrayItem_UniqueItem] FOREIGN KEY([UniqItemNr])
REFERENCES [dbo].[UniqueItem] ([Nr])
GO
ALTER TABLE [dbo].[TrayItem] CHECK CONSTRAINT [FK_TrayItem_UniqueItem]
GO
/****** Object:  ForeignKey [FK_DeliveryItem_Delivery]    Script Date: 05/02/2017 17:46:23 ******/
ALTER TABLE [dbo].[DeliveryItem]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryItem_Delivery] FOREIGN KEY([DeliveryNr])
REFERENCES [dbo].[Delivery] ([Nr])
GO
ALTER TABLE [dbo].[DeliveryItem] CHECK CONSTRAINT [FK_DeliveryItem_Delivery]
GO
/****** Object:  ForeignKey [FK_DeliveryItem_UniqueItem]    Script Date: 05/02/2017 17:46:23 ******/
ALTER TABLE [dbo].[DeliveryItem]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryItem_UniqueItem] FOREIGN KEY([UniqItemNr])
REFERENCES [dbo].[UniqueItem] ([Nr])
GO
ALTER TABLE [dbo].[DeliveryItem] CHECK CONSTRAINT [FK_DeliveryItem_UniqueItem]
GO
/****** Object:  ForeignKey [FK_Storage_Posation]    Script Date: 05/02/2017 17:46:23 ******/
ALTER TABLE [dbo].[Storage]  WITH CHECK ADD  CONSTRAINT [FK_Storage_Posation] FOREIGN KEY([PositionNr])
REFERENCES [dbo].[Position] ([Nr])
GO
ALTER TABLE [dbo].[Storage] CHECK CONSTRAINT [FK_Storage_Posation]
GO
/****** Object:  ForeignKey [FK_Storage_UniqueItem]    Script Date: 05/02/2017 17:46:23 ******/
ALTER TABLE [dbo].[Storage]  WITH CHECK ADD  CONSTRAINT [FK_Storage_UniqueItem] FOREIGN KEY([UniqItemNr])
REFERENCES [dbo].[UniqueItem] ([Nr])
GO
ALTER TABLE [dbo].[Storage] CHECK CONSTRAINT [FK_Storage_UniqueItem]
GO
