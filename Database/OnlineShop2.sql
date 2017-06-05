USE [OnlineShopDatabase]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 06/05/2017 8:59:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[ParentID] [bigint] NULL,
	[MetaTitle] [nvarchar](250) NULL,
	[DisplayOrder] [int] NULL CONSTRAINT [DF_Category_DisplayOrder]  DEFAULT ((1)),
	[CreateDate] [datetime] NULL CONSTRAINT [DF_Category_CreateDate]  DEFAULT (getdate()),
	[CreateBy] [bigint] NULL,
	[Description] [nvarchar](300) NULL,
	[Tag] [nvarchar](250) NULL,
	[Status] [int] NULL CONSTRAINT [DF_Category_Status]  DEFAULT ((1)),
	[Type] [int] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Credential]    Script Date: 06/05/2017 8:59:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Credential](
	[UserGroupID] [varchar](50) NOT NULL,
	[RoleID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Credential] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Order]    Script Date: 06/05/2017 8:59:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerID] [bigint] NULL,
	[CustomerName] [nvarchar](250) NULL,
	[CustomerAddress] [nvarchar](250) NULL,
	[CustomerPhone] [varchar](50) NULL,
	[CustomerEmail] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL CONSTRAINT [DF_Order_CreateDate]  DEFAULT (getdate()),
	[CreateBy] [bigint] NULL,
	[ChangeBy] [bigint] NULL,
	[LastChange] [datetime] NULL CONSTRAINT [DF_Order_LastChange]  DEFAULT (getdate()),
	[OrderAddress] [nvarchar](300) NULL,
	[Note] [nvarchar](400) NULL,
	[Status] [int] NULL CONSTRAINT [DF_Order_Status]  DEFAULT ((1)),
 CONSTRAINT [PK_Order_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 06/05/2017 8:59:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NOT NULL,
	[ProductID] [bigint] NULL,
	[Amount] [bigint] NULL,
	[Status] [int] NULL CONSTRAINT [DF_OrderProduct_Status]  DEFAULT ((1)),
	[TotalMoney] [decimal](18, 0) NULL,
 CONSTRAINT [PK_OrderProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 06/05/2017 8:59:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Code] [varchar](100) NULL,
	[MetaTitle] [nvarchar](250) NULL,
	[Description] [nvarchar](300) NULL,
	[Price] [decimal](18, 0) NULL,
	[Sale] [decimal](18, 0) NULL,
	[CreateDate] [datetime] NULL CONSTRAINT [DF_Product_CreateDate]  DEFAULT (getdate()),
	[CreateBy] [bigint] NULL,
	[Tag] [nvarchar](250) NULL,
	[Status] [int] NULL CONSTRAINT [DF_Product_Status]  DEFAULT ((1)),
	[Type] [int] NULL CONSTRAINT [DF_Product_Type]  DEFAULT ((1)),
	[LastChange] [datetime] NULL CONSTRAINT [DF_Product_LastChange]  DEFAULT (getdate()),
	[ChangeBy] [bigint] NULL,
	[CategoryID] [bigint] NULL,
	[MainImage] [nvarchar](250) NULL,
	[GalleryImage] [xml] NULL,
	[GroupID] [varchar](50) NULL,
	[Amount] [bigint] NULL CONSTRAINT [DF_Product_Amount]  DEFAULT ((0)),
	[Rate] [int] NULL,
	[BuyAmount] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 06/05/2017 8:59:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [varchar](50) NOT NULL,
	[Name] [nvarchar](250) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 06/05/2017 8:59:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Username] [nvarchar](250) NULL,
	[Password] [varchar](50) NULL,
	[Gender] [int] NULL CONSTRAINT [DF_User_Gender]  DEFAULT ((1)),
	[Address] [nvarchar](250) NULL,
	[JoinDate] [datetime] NULL CONSTRAINT [DF_User_JoinDate]  DEFAULT (getdate()),
	[Phone] [varchar](50) NULL,
	[Email] [nvarchar](250) NULL,
	[Status] [int] NULL CONSTRAINT [DF_User_Status]  DEFAULT ((1)),
	[Type] [int] NULL CONSTRAINT [DF_User_Type]  DEFAULT ((0)),
	[Avatar] [nvarchar](250) NULL,
	[RecentChange] [datetime] NULL CONSTRAINT [DF_User_RecentChange]  DEFAULT (getdate()),
	[GroupID] [varchar](50) NULL CONSTRAINT [DF_User_GroupID]  DEFAULT ('MEMBER'),
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGroup]    Script Date: 06/05/2017 8:59:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGroup](
	[ID] [varchar](50) NOT NULL,
	[Name] [nvarchar](250) NULL,
 CONSTRAINT [PK_UserGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (4, N'Quần áo, Veston', NULL, N'clothing-men', 1, CAST(N'2017-05-17 22:51:46.840' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (5, N'Giày & Ví', NULL, N'shoes-men', 2, CAST(N'2017-05-17 22:52:04.157' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (6, N'Phụ kiện', NULL, N'accessories-men', 3, CAST(N'2017-05-17 22:53:34.350' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (7, N'Váy, đầm công sở', NULL, N'clothing-women', 1, CAST(N'2017-05-17 22:54:02.937' AS DateTime), NULL, NULL, NULL, 1, 2)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (8, N'Giày thể thao và cao gót', NULL, N'shoes-women', 2, CAST(N'2017-05-17 22:54:53.123' AS DateTime), NULL, NULL, NULL, 1, 2)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (9, N'Phụ kiện', NULL, N'accessories', 3, CAST(N'2017-05-17 22:55:08.157' AS DateTime), NULL, NULL, NULL, 1, 2)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (10, N'Quần áo, đồ đôi', NULL, N'clothing-kid', 1, CAST(N'2017-05-17 22:55:32.250' AS DateTime), NULL, NULL, NULL, 1, 3)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (11, N'Giày', NULL, N'shoes-kid', 2, CAST(N'2017-05-17 22:55:50.570' AS DateTime), NULL, NULL, NULL, 1, 3)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (12, N'Mũ', NULL, N'hat-kid', 3, CAST(N'2017-05-17 22:56:01.310' AS DateTime), NULL, NULL, NULL, 1, 3)
SET IDENTITY_INSERT [dbo].[Category] OFF
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'ACCOUNTANT', N'STATISTIC_MANAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'ADMIN', N'ADMIN_MANAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'CLIENT', N'VIEW_PAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'SALE', N'CUSTOMER_MANAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'SALE', N'ORDER_MANAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'SALE', N'PRODUCT_MANAGE')
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (1, NULL, N'Nguyễn Văn Nam', N'Hà Nội', N'0123456789', N'namnguyen@gmail.com', CAST(N'2017-05-18 00:03:55.953' AS DateTime), NULL, NULL, CAST(N'2017-05-18 00:03:55.953' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (2, NULL, N'Nguyễn Thị Thu', N'Ninh Bình', N'0123456789', N'thunguyennb@gmail.com', CAST(N'2017-05-18 00:04:29.583' AS DateTime), NULL, NULL, CAST(N'2017-05-18 00:04:29.583' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (3, NULL, N'Nguyễn Thanh Thảo', N'Hải Phòng', N'0123456789', N'thaosmile@gmail.com', CAST(N'2017-05-18 00:05:04.157' AS DateTime), NULL, NULL, CAST(N'2017-05-18 00:05:04.157' AS DateTime), NULL, NULL, 5)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (4, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 11:25:13.297' AS DateTime), NULL, NULL, NULL, N'', NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (5, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 11:26:39.580' AS DateTime), NULL, NULL, NULL, N'', NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (6, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 11:27:14.437' AS DateTime), NULL, NULL, NULL, N'', NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (7, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 11:28:12.977' AS DateTime), NULL, NULL, NULL, N'', NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (8, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 11:29:57.830' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (9, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 16:14:43.933' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (10, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 16:24:14.003' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (11, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 16:49:42.430' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', NULL, 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (12, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:09:10.817' AS DateTime), NULL, NULL, NULL, N'Hàm Nghi', N'Giao hàng vào buổi chiều ', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (13, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:19:23.923' AS DateTime), NULL, NULL, NULL, N'Nguyễn Cơ Thạch', N'Giao hàng vào buổi sáng từ 7-9h', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (14, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:21:34.797' AS DateTime), NULL, NULL, NULL, N'Nguyễn Cơ Thạch', N'Giao hàng vào buổi sáng', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (15, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:24:17.253' AS DateTime), NULL, NULL, NULL, N'', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (16, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:37:34.460' AS DateTime), NULL, NULL, NULL, N'Nguyễn Chí Thanh, Hà Nội', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (17, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:39:54.697' AS DateTime), NULL, NULL, NULL, N'Hàm Nghi', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (18, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:40:17.153' AS DateTime), NULL, NULL, NULL, N'Hàm Nghi', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (19, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:43:10.330' AS DateTime), NULL, NULL, NULL, N'ssdfds', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (20, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:44:51.650' AS DateTime), NULL, NULL, NULL, N'dgdgf', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (21, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:45:24.640' AS DateTime), NULL, NULL, NULL, N'dgdgf', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (22, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:46:37.163' AS DateTime), NULL, NULL, NULL, N'ỷtyryr', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (23, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:50:26.267' AS DateTime), NULL, NULL, NULL, N'sfsdfdg', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (24, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 17:55:12.157' AS DateTime), NULL, NULL, NULL, N'sèdfdgdg', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (25, 5, N'haunguyen', N'Hà Nam', N'0123456789', N'haunguyen@gmail.com', CAST(N'2017-05-31 18:03:49.567' AS DateTime), NULL, NULL, NULL, N'asdadssad', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (26, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau1996mta@gmail.com', CAST(N'2017-06-04 11:58:17.173' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy, Hà Nội', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (27, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau1996mta@gmail.com', CAST(N'2017-06-04 11:59:47.373' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (28, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau1996mta@gmail.com', CAST(N'2017-06-04 12:01:44.563' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (29, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau1996mta@gmail.com', CAST(N'2017-06-04 12:06:23.757' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (30, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau1996mta@gmail.com', CAST(N'2017-06-04 12:08:18.213' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (31, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau1996mta@gmail.com', CAST(N'2017-06-04 12:10:26.703' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (32, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau1996mta@gmail.com', CAST(N'2017-06-04 12:13:45.453' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (33, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau26041996mta@gmail.com', CAST(N'2017-06-04 12:16:36.723' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (34, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau26041996mta@gmail.com', CAST(N'2017-06-04 12:18:42.540' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (35, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau26041996mta@gmail.com', CAST(N'2017-06-04 12:22:06.477' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (36, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau26041996mta@gmail.com', CAST(N'2017-06-04 12:26:40.803' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [OrderAddress], [Note], [Status]) VALUES (37, 14, N'haunguyen1996', N'Hà Nam', N'0123456789', N'nguyenhau26041996mta@gmail.com', CAST(N'2017-06-04 12:35:02.377' AS DateTime), NULL, NULL, NULL, N'Cầu Giấy', N'', 1)
SET IDENTITY_INSERT [dbo].[Order] OFF
SET IDENTITY_INSERT [dbo].[OrderProduct] ON 

INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (1, 1, 12, 2, 1, CAST(400000 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (2, 4, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (3, 4, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (4, 5, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (5, 5, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (6, 6, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (7, 6, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (8, 7, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (9, 7, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (10, 8, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (11, 8, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (12, 9, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (13, 9, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (14, 9, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (15, 9, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (16, 10, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (17, 10, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (18, 10, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (19, 10, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (20, 11, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (21, 11, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (22, 11, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (23, 11, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (24, 12, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (25, 12, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (26, 12, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (27, 12, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (28, 13, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (29, 13, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (30, 13, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (31, 14, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (32, 14, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (33, 14, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (34, 15, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (35, 15, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (36, 15, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (37, 15, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (38, 16, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (39, 16, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (40, 16, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (41, 17, 22, 1, NULL, CAST(34 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (42, 17, 21, 5, NULL, CAST(171 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (43, 19, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (44, 19, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (45, 19, 27, 7, NULL, CAST(210 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (46, 20, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (47, 20, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (48, 20, 27, 4, NULL, CAST(120 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (49, 22, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (50, 22, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (51, 22, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (52, 22, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (53, 23, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (54, 23, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (55, 23, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (56, 23, 19, 4, NULL, CAST(95 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (57, 24, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (58, 24, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (59, 24, 27, 3, NULL, CAST(90 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (60, 25, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (61, 25, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (62, 25, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (63, 26, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (64, 26, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (65, 26, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (66, 26, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (67, 27, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (68, 27, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (69, 27, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (70, 28, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (71, 28, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (72, 28, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (73, 29, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (74, 29, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (75, 29, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (76, 30, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (77, 30, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (78, 30, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (79, 31, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (80, 31, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (81, 31, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (82, 32, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (83, 32, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (84, 32, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (85, 33, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (86, 33, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (87, 33, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (88, 33, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (89, 34, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (90, 34, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (91, 34, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (92, 35, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (93, 35, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (94, 35, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (95, 36, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (96, 36, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (97, 36, 19, 1, NULL, CAST(24 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (98, 37, 23, 1, NULL, CAST(20 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (99, 37, 20, 1, NULL, CAST(20 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (100, 37, 25, 1, NULL, CAST(29 AS Decimal(18, 0)))
INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductID], [Amount], [Status], [TotalMoney]) VALUES (101, 37, 27, 1, NULL, CAST(30 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[OrderProduct] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (17, N'áo khoác nữ', N'SP1495063949', N'ao-khoac-nu', N'áo khoác nữ', CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-17 23:32:29.210' AS DateTime), NULL, N'áo khoác', 4, NULL, CAST(N'2017-05-17 23:45:16.030' AS DateTime), NULL, 9, N'/Images/Cream-Stylish-Designed-Coat-1jpg.jpg', NULL, N'1495063949', 4, 1, 3)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (18, N'Jewelry Diamond', N'SP1495327744', N'jewelry-diamond', N'Thời trang nữ hàn quốc', CAST(36 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 00:49:03.520' AS DateTime), NULL, N'jacket women', 1, NULL, NULL, NULL, 7, N'/Images/product-15-390x520.jpg', N'<Images><Image>/Images/product-06-390x520.jpg</Image><Image>/Images/product-05-390x520.jpg</Image></Images>', N'1495327744', 5, 4, 10)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (19, N'Veston Office', N'SP1495354772', N'veston-office', N'vestom hàn quốc', CAST(25 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), CAST(N'2017-05-21 08:19:32.033' AS DateTime), NULL, N'veston', 1, NULL, NULL, NULL, 4, N'/Images/product-09.jpg', N'<Images><Image>/Images/product-09-390x520.jpg</Image><Image>/Images/product-01-390x520.jpg</Image></Images>', N'1495354772', 3, 2, 20)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (20, N'Jacket For Men', N'SP1495354864', N'jacket-men', N'Gray Jacket for men ', CAST(20 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 08:21:03.957' AS DateTime), NULL, N'jacket', 1, NULL, NULL, NULL, 4, N'/Images/product-03.jpg', N'<Images><Image>/Images/product-03-390x520.jpg</Image><Image>/Images/product-17.jpg</Image></Images>', N'1495354864', 5, 4, 5)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (21, N'Jean girl', N'SP1495354954', N'jean-girl', N'Quần short jean cho nữ', CAST(36 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), CAST(N'2017-05-21 08:22:33.847' AS DateTime), NULL, N'jean', 1, NULL, CAST(N'2017-05-21 08:22:48.757' AS DateTime), NULL, 7, N'/Images/product-05-390x520.jpg', N'<Images><Image>/Images/product-18-390x520.jpg</Image><Image>/Images/product-04-390x520.jpg</Image></Images>', N'1495354954', 4, 5, 7)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (22, N'Áo khoác da dài ', N'SP1495355065', N'ao-khoac-da-dai', N'Áo khoác da đen dài cho nữ', CAST(37 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)), CAST(N'2017-05-21 08:24:25.187' AS DateTime), NULL, N'áo khoác da', 1, NULL, CAST(N'2017-05-21 08:31:42.943' AS DateTime), NULL, 7, N'/Images/product-13-390x520.jpg', N'<Images><Image>/Images/product-01-390x520.jpg</Image></Images>', N'1495355065', 4, 2, 24)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (23, N'Áo veston thời trang', N'SP1495355163', N'veston-nu', N'Áo veston xám cho nữ', CAST(20 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 08:26:02.753' AS DateTime), NULL, N'veston nữ', 1, NULL, CAST(N'2017-05-21 08:26:07.360' AS DateTime), NULL, 7, N'/Images/product-18-390x520.jpg', N'<Images><Image>/Images/product-02-390x520.jpg</Image><Image>/Images/product-19-390x520.jpg</Image></Images>', N'1495355163', 6, 3, 5)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (24, N'Cadigan đen', N'SP1495355252', N'cadigan-đen', N'Cadigan đen,dài cho nữ', CAST(20 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 08:27:32.237' AS DateTime), NULL, N'cadigan', 1, NULL, NULL, NULL, 7, N'/Images/product-07-390x520.jpg', N'<Images><Image>/Images/product-05-390x520.jpg</Image><Image>/Images/product-17.jpg</Image><Image>/Images/product-20.jpg</Image></Images>', N'1495355252', 5, 4, 8)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (25, N'Cặp da nam', N'SP1495355324', N'cap-da', N'Cặp da đen cho nam giới', CAST(30 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)), CAST(N'2017-05-21 08:28:43.697' AS DateTime), NULL, N'cặp da', 1, NULL, NULL, NULL, 4, N'/Images/product-23.jpg', N'<Images><Image>/Images/product-14.jpg</Image></Images>', N'1495355324', 3, 3, 4)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (26, N'Váy liền công sở', N'SP1495355420', N'vay-lien', N'Váy đen lịch sự, dành cho nữ giới công sở', CAST(30 AS Decimal(18, 0)), CAST(4 AS Decimal(18, 0)), CAST(N'2017-05-21 08:30:19.767' AS DateTime), NULL, N'váy đen', 1, NULL, CAST(N'2017-05-21 08:31:24.520' AS DateTime), NULL, 7, N'/Images/product-20.jpg', N'<Images><Image>/Images/product-01-390x520.jpg</Image></Images>', N'1495355420', 6, 5, 1)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (27, N'Áo len trắng ', N'SP1495355479', N'ao-len', N'Áo len trắng cho nam', CAST(30 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 08:31:18.647' AS DateTime), NULL, N'áo len', 1, NULL, NULL, NULL, 4, N'/Images/product-17.jpg', N'<Images><Image>/Images/product-01-390x520.jpg</Image></Images>', N'1495355479', 5, 4, 4)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (28, N'Áo bò nam', N'SP1495355573', N'ao-bo-nam', N'Áo bò thời trang cho nam giới', CAST(30 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), CAST(N'2017-05-21 08:32:53.207' AS DateTime), NULL, N'áo bò', 1, NULL, NULL, NULL, 4, N'/Images/product-12-390x520.jpg', N'<Images><Image>/Images/product-17.jpg</Image></Images>', N'1495355573', 7, 2, 2)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (29, N'Áo khoác da vàng cam', N'SP1495355642', N'áo-khoac-cam', N'Áo khoác thời trang cho nam giới, màu cam cá tính', CAST(30 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 08:34:01.637' AS DateTime), NULL, N'áo khoác nam', 1, NULL, NULL, NULL, 4, N'/Images/product-10-390x520.jpg', N'<Images><Image>/Images/product-09-390x520.jpg</Image></Images>', N'1495355642', 5, 4, 8)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (30, N'Kính mát nam giới', N'SP1495355720', N'kinh-mat', N'Dành cho nam giơi yêu thích tốc độ', CAST(30 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)), CAST(N'2017-05-21 08:35:20.370' AS DateTime), NULL, N'kính mát', 1, NULL, NULL, NULL, 6, N'/Images/sunglasses-1.png', N'<Images><Image>/Images/sunglasses1-1.png</Image><Image>/Images/sunglasses2-1.png</Image></Images>', N'1495355720', 9, 3, 8)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (31, N't-shirt trắng trẻ em', N'SP1495358150', N't-shirt-tre-em', N't-shirt trắng cho trẻ năng động', CAST(15 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 09:15:49.667' AS DateTime), NULL, N't-shirt', 1, NULL, CAST(N'2017-05-21 09:16:31.653' AS DateTime), NULL, 10, N'/Images/83035518_TM.jpg', N'<Images><Image>/Images/83060096_TS_D6.jpg</Image></Images>', N'1495358150', 5, 5, 4)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (32, N'Quần jean trẻ em', N'SP1495358235', N'jean-tre-em', N'Quần jean cho bé trai', CAST(20 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 09:17:14.667' AS DateTime), NULL, N'jean', 1, NULL, NULL, NULL, 10, N'/Images/83060096_TS_D6.jpg', N'<Images><Image>/Images/83060096_TS_D6.jpg</Image></Images>', N'1495358235', 6, 1, 3)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (33, N'Váy công chúa nhiều màu', N'SP1495358298', N'vay-cong-chua', N'Váy nhiều màu, dễ thương', CAST(20 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 09:18:18.123' AS DateTime), NULL, N'váy công chúa', 1, NULL, NULL, NULL, 10, N'/Images/HM-Studio-1-1.jpg', N'<Images><Image>/Images/83060096_TS_D6.jpg</Image></Images>', N'1495358298', 6, 2, 2)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (34, N'Bộ đồ trẻ em', N'SP1495358364', N'bo-do-tre-em', N'Bộ đồ vải cotton, thoáng  mát cho cả bé trai và bé gái', CAST(30 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), CAST(N'2017-05-21 09:19:23.673' AS DateTime), NULL, N'Bộ đồ trẻ em', 1, NULL, NULL, NULL, 10, N'/Images/HM-Studio-2.jpg', N'<Images><Image>/Images/83060096_TS_D6.jpg</Image></Images>', N'1495358364', 7, 3, 9)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (35, N'Váy trắng cho bé gái', N'SP1495358460', N'vay-trang', N'Váy trắng nhỏ cho bé gái', CAST(30 AS Decimal(18, 0)), CAST(7 AS Decimal(18, 0)), CAST(N'2017-05-21 09:20:59.643' AS DateTime), NULL, N'váy trắng', 1, NULL, CAST(N'2017-05-21 09:27:12.643' AS DateTime), NULL, 10, N'/Images/HM-Studio-Kids-BTS-from-campaign-High-res-14-683x1024-1.jpg', N'<Images><Image>/Images/83060096_TS_D6.jpg</Image></Images>', N'1495358460', 8, 4, 5)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (36, N'Bộ đôi trẻ em', N'SP1495358781', N'bo-doi-tre-em', N'Bộ đôi cá tính dành cho trẻ em', CAST(35 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)), CAST(N'2017-05-21 09:26:21.483' AS DateTime), NULL, N'bộ đôi', 1, NULL, CAST(N'2017-05-21 09:26:54.070' AS DateTime), NULL, 10, N'/Images/landing_kids_milk052017_2.jpg', N'<Images><Image>/Images/landing_kids_milk052017_3.jpg</Image></Images>', N'1495358781', 8, 5, 4)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (37, N'Áo jean trẻ em', N'SP1495358903', N'jean-tre-em', N'Áo bò cho tre từ 5-7 tuổi', CAST(30 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)), CAST(N'2017-05-21 09:28:22.977' AS DateTime), NULL, N'jean', 4, NULL, NULL, NULL, 10, N'/Images/landing_kids_milk052017_3.jpg', NULL, N'1495358903', 10, 4, 6)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (38, N'Jean trẻ em', N'SP1495358972', N'jean-tre-em', N'Jean cho trẻ từ 5-7 tuổi', CAST(30 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), CAST(N'2017-05-21 09:29:31.580' AS DateTime), NULL, N'Jean', 1, NULL, NULL, NULL, 10, N'/Images/landing_kids_milk052017_3.jpg', N'<Images><Image>/Images/83035518_TM.jpg</Image><Image>/Images/83060096_TS_D6.jpg</Image></Images>', N'1495358972', 10, 2, 7)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (39, N'Jacket cam', N'SP1495398480', N'jacket-cam', N'Jacket màu cam', CAST(30 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)), CAST(N'2017-05-21 20:28:00.043' AS DateTime), NULL, N'jacket', 1, NULL, NULL, NULL, 4, N'/Images/blog-05-230x170.jpg', N'<Images><Image>/Images/jackets-1.png</Image><Image>/Images/product-23.jpg</Image></Images>', N'1495398480', 19, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (40, N'Áo khoác đi mưa nam', N'SP1495398589', N'ao-di-mua', N'Áo khoác đi mưa chống ướt', CAST(20 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 20:29:49.460' AS DateTime), NULL, N'áo khoác', 1, NULL, NULL, NULL, 4, N'/Images/float_header_bg.jpg', N'<Images><Image>/Images/product-10-390x520.jpg</Image><Image>/Images/product-09-390x520.jpg</Image></Images>', N'1495398589', 19, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (41, N'Veston nam', N'SP1495398631', N'veston-nam', N'Veston đen lịch lãm cho quý ông', CAST(27 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 20:30:31.270' AS DateTime), NULL, N'veston', 1, NULL, NULL, NULL, 4, N'/Images/blazers-1.png', NULL, N'1495398631', 12, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (42, N'Bộ veston hàn quốc', N'SP1495398687', N'veston-han', N'Veston hàn quốc thời trang', CAST(26 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-05-21 20:31:27.160' AS DateTime), NULL, N'veston', 1, NULL, NULL, NULL, 4, N'/Images/product-14.jpg', N'<Images><Image>/Images/product-09-390x520.jpg</Image></Images>', N'1495398687', 10, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (43, N'Áo nỉ nam', N'SP1495398726', N'ao-ni-nam', N'Áo nỉ nam thời trang', CAST(30 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), CAST(N'2017-05-21 20:32:06.087' AS DateTime), NULL, N'áo nỉ', 1, NULL, NULL, NULL, 4, N'/Images/red-270x270.jpg', NULL, N'1495398726', 19, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (44, N'Test', N'SP1496505188', N'Test', N'tét', CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-06-03 15:53:08.213' AS DateTime), NULL, NULL, 4, NULL, NULL, NULL, 4, N'/Images/discovery.jpg', N'<Images><Image>/Images/mastercard.jpg</Image></Images>', N'1496505188', 12, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (45, N'Test1', N'SP1496505219', N'Test1', N'Test1', CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-06-03 15:53:39.133' AS DateTime), NULL, NULL, 4, NULL, NULL, NULL, 4, N'/Images/amazon.jpg', NULL, N'1496505219', 1, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (46, N'Test2', N'SP1496505248', N'Test2', NULL, CAST(12 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-06-03 15:54:07.617' AS DateTime), NULL, NULL, 4, NULL, NULL, NULL, 4, N'/Images/visa.jpg', N'<Images><Image>/Images/favicon-1.png</Image></Images>', N'1496505248', 1, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (47, N'Test3', N'SP1496505272', N'Test3', NULL, CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-06-03 15:54:32.410' AS DateTime), NULL, NULL, 4, NULL, NULL, NULL, 4, N'/Images/paypal.jpg', NULL, N'1496505272', 12, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (48, N'Test4', N'SP1496505294', N'Test4', NULL, CAST(12 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)), CAST(N'2017-06-03 15:54:53.737' AS DateTime), NULL, NULL, 4, NULL, NULL, NULL, 4, N'/Images/skrill.jpg', NULL, N'1496505294', 12, NULL, NULL)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (49, N'Test', N'SP1496505818', N'Test', NULL, CAST(10 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-06-03 16:03:37.760' AS DateTime), NULL, NULL, 4, NULL, NULL, NULL, 4, N'/Images/amazon.jpg', NULL, N'1496505818', 12, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'ADMIN_MANAGE', N'Quản lý quản trị viên')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'CUSTOMER_MANAGE', N'Quản lý khách hàng')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'ORDER_MANAGE', N'Quản lý đơn hàng')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'PRODUCT_MANAGE', N'Quản lý sản phẩm')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'STATISTIC_MANAGE', N'Thống kê')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'VIEW_ALL_MANAGE', N'Xem tất cả các phần quản lý nhưng không thể chỉnh sửa')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'VIEW_PAGE', N'Truy câp trang Client')
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (5, N'haunguyen', N'haunguyen', N'12345', 0, N'Hà Nam', CAST(N'2017-05-30 23:00:58.163' AS DateTime), N'0123456789', N'haunguyen@gmail.com', 1, 0, NULL, CAST(N'2017-05-30 23:00:58.163' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (6, N'haunguyen', N'haunguyenmta', N'827ccb0eea8a706c4c34a16891f84e7b', 1, NULL, CAST(N'2017-05-31 00:36:39.767' AS DateTime), N'012345678', N'nguyenhau@gmail.com', 2, 0, NULL, CAST(N'2017-06-03 16:56:28.643' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (7, NULL, N'nguyenhau', N'1234', NULL, NULL, CAST(N'2017-05-31 00:49:14.563' AS DateTime), N'0123456789', N'nguyenhau@gmail.com', 2, 0, NULL, NULL, N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (8, N'nguyen thi hau', N'haumta', N'81dc9bdb52d04dc20036dbd8313ed055', 1, NULL, CAST(N'2017-05-31 00:50:29.317' AS DateTime), N'0123456789', N'haumta@gmail.com', 1, 0, NULL, CAST(N'2017-06-03 16:37:02.900' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (10, N'admin', N'admin', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'Hà Nội', CAST(N'2017-06-03 15:15:22.150' AS DateTime), N'012345678', N'admin@gamilc.om', 1, 1, N'/Images/user.png', CAST(N'2017-06-03 15:15:22.150' AS DateTime), N'ADMIN')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (11, N'admin123', N'admin123', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'Haf Nam', CAST(N'2017-06-03 15:39:13.093' AS DateTime), N'0123456789', N'admin@gmail.com', 1, 1, N'/Images/guess-attic-837156_1.jpg', NULL, N'ACCOUNTANT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (12, N'admin12346', N'admin1234', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'ha Nam', CAST(N'2017-06-03 15:43:33.143' AS DateTime), N'0123456789', N'admin@gmail.com', 2, 1, N'/Images/jackets-1.png', CAST(N'2017-06-03 15:46:53.770' AS DateTime), N'SALE')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (14, N'haunguyen1996', N'haunguyen1996', N'c803622f84fdf5f9dcf56726524fadf1', 0, N'Hà Nam', CAST(N'2017-06-03 16:29:21.250' AS DateTime), N'0123456789', N'nguyenhau26041996mta@gmail.com', 1, 0, NULL, NULL, N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (15, N'hau1996', N'hau1996', N'827ccb0eea8a706c4c34a16891f84e7b', 0, N'Hà Nội', CAST(N'2017-06-03 16:31:38.883' AS DateTime), NULL, N'haunguyen@gmail.com', 1, 0, NULL, NULL, N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (16, N'hau123', N'hau123', N'827ccb0eea8a706c4c34a16891f84e7b', 0, N'Hà Nam', CAST(N'2017-06-03 16:47:01.873' AS DateTime), NULL, N'haunguyen@gmail.com', 1, 0, NULL, NULL, N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (17, N'haunguyenhn', N'haunguyenhn', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'Hà Nam', CAST(N'2017-06-03 22:00:23.283' AS DateTime), NULL, N'haunguyen@gmail.com', 1, 1, N'/Images/blazers-coat-1.png', NULL, N'ADMIN')
SET IDENTITY_INSERT [dbo].[User] OFF
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'ACCOUNTANT', N'Kế toán')
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'ADMIN', N'Quản trị viên')
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'CLIENT', N'Khách hàng')
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'SALE', N'Nhân viên bán hàng')
