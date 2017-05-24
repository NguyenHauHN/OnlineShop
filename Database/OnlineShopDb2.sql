USE [OnlineShopDatabase]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 05/21/2017 9:54:57 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 05/21/2017 9:54:57 PM ******/
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
	[Status] [int] NULL CONSTRAINT [DF_Order_Status]  DEFAULT ((1)),
 CONSTRAINT [PK_Order_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 05/21/2017 9:54:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NULL,
	[ProductName] [nvarchar](250) NULL,
	[ProductID] [bigint] NULL,
	[ImageProduct] [nvarchar](250) NULL,
	[Amount] [bigint] NULL,
	[Price] [decimal](18, 0) NULL,
	[Sale] [decimal](18, 0) NULL,
	[Status] [int] NULL CONSTRAINT [DF_OrderProduct_Status]  DEFAULT ((1)),
	[TotalMoney] [decimal](18, 0) NULL,
 CONSTRAINT [PK_OrderProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 05/21/2017 9:54:57 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 05/21/2017 9:54:57 PM ******/
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
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
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
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [Status]) VALUES (1, NULL, N'Nguyễn Văn Nam', N'Hà Nội', N'0123456789', N'namnguyen@gmail.com', CAST(N'2017-05-18 00:03:55.953' AS DateTime), NULL, NULL, CAST(N'2017-05-18 00:03:55.953' AS DateTime), 2)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [Status]) VALUES (2, NULL, N'Nguyễn Thị Thu', N'Ninh Bình', N'0123456789', N'thunguyennb@gmail.com', CAST(N'2017-05-18 00:04:29.583' AS DateTime), NULL, NULL, CAST(N'2017-05-18 00:04:29.583' AS DateTime), 1)
INSERT [dbo].[Order] ([ID], [CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreateDate], [CreateBy], [ChangeBy], [LastChange], [Status]) VALUES (3, NULL, N'Nguyễn Thanh Thảo', N'Hải Phòng', N'0123456789', N'thaosmile@gmail.com', CAST(N'2017-05-18 00:05:04.157' AS DateTime), NULL, NULL, CAST(N'2017-05-18 00:05:04.157' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[Order] OFF
SET IDENTITY_INSERT [dbo].[OrderProduct] ON 

INSERT [dbo].[OrderProduct] ([ID], [OrderID], [ProductName], [ProductID], [ImageProduct], [Amount], [Price], [Sale], [Status], [TotalMoney]) VALUES (1, 1, N'Túi xách', 12, N'/Images/Multi-color-two-way-ladies-hand-bag-1.jpg', 2, CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, CAST(400000 AS Decimal(18, 0)))
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
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange]) VALUES (1, N'admin', N'admin', N'81dc9bdb52d04dc20036dbd8313ed055', 0, N'Hà Nam', CAST(N'2017-05-15 10:06:16.433' AS DateTime), N'0123456789', N'admin@gmail.com', 1, 1, N'~/Images/user.png', CAST(N'2017-05-15 10:06:16.433' AS DateTime))
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange]) VALUES (2, N'admin12345', N'admin123', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'Hà Nội', CAST(N'2017-05-15 10:09:38.953' AS DateTime), N'0123456789', N'admin@gmail.com', 0, 1, N'/Images/guess-attic-837156_1.jpg', CAST(N'2017-05-16 08:04:32.590' AS DateTime))
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange]) VALUES (4, N'', NULL, NULL, 1, NULL, CAST(N'2017-05-18 00:03:11.270' AS DateTime), NULL, NULL, 1, 0, NULL, CAST(N'2017-05-18 00:03:11.270' AS DateTime))
SET IDENTITY_INSERT [dbo].[User] OFF
