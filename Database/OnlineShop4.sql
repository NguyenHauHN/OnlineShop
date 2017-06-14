USE [OnlineShopDatabase_Connect1]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 06/14/2017 11:53:14 PM ******/
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
/****** Object:  Table [dbo].[Credential]    Script Date: 06/14/2017 11:53:14 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 06/14/2017 11:53:14 PM ******/
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
	[CreateDate] [datetime] NULL,
	[CreateBy] [bigint] NULL,
	[ChangeBy] [bigint] NULL,
	[LastChange] [datetime] NULL,
	[OrderAddress] [nvarchar](300) NULL,
	[Note] [nvarchar](400) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Order_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 06/14/2017 11:53:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NOT NULL,
	[ProductID] [bigint] NULL,
	[Amount] [bigint] NULL,
	[Status] [int] NULL,
	[TotalMoney] [decimal](18, 0) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_OrderProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 06/14/2017 11:53:14 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 06/14/2017 11:53:14 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 06/14/2017 11:53:14 PM ******/
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
/****** Object:  Table [dbo].[UserGroup]    Script Date: 06/14/2017 11:53:14 PM ******/
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

INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (13, N'Quần áo, Veston', NULL, N'clothing-men', 1, CAST(N'2017-05-17 22:51:46.840' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (14, N'Giày & Ví', NULL, N'shoes-men', 2, CAST(N'2017-05-17 22:52:04.157' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (15, N'Phụ kiện nam', NULL, N'accessories-men', 3, CAST(N'2017-05-17 22:53:34.350' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (16, N'Váy, đầm công sở', NULL, N'clothing-women', 1, CAST(N'2017-05-17 22:54:02.937' AS DateTime), NULL, NULL, NULL, 1, 2)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (17, N'Giày thể thao và cao gót', NULL, N'shoes-women', 2, CAST(N'2017-05-17 22:54:53.123' AS DateTime), NULL, NULL, NULL, 1, 2)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (18, N'Phụ kiện nữ', NULL, N'accessories-women', 3, CAST(N'2017-05-17 22:55:08.157' AS DateTime), NULL, NULL, NULL, 1, 2)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (19, N'Quần áo, đồ đôi', NULL, N'clothing-kid', 1, CAST(N'2017-05-17 22:55:32.250' AS DateTime), NULL, NULL, NULL, 1, 3)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (20, N'Giày', NULL, N'shoes-kid', 2, CAST(N'2017-05-17 22:55:50.570' AS DateTime), NULL, NULL, NULL, 1, 3)
INSERT [dbo].[Category] ([ID], [Name], [ParentID], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [Description], [Tag], [Status], [Type]) VALUES (21, N'Mũ', NULL, N'hat-kid', 3, CAST(N'2017-05-17 22:56:01.310' AS DateTime), NULL, NULL, NULL, 1, 3)
SET IDENTITY_INSERT [dbo].[Category] OFF
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'ACCOUNTANT', N'STATISTIC_MANAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'ADMIN', N'ADMIN_MANAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'CLIENT', N'VIEW_PAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'SALE', N'CUSTOMER_MANAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'SALE', N'ORDER_MANAGE')
INSERT [dbo].[Credential] ([UserGroupID], [RoleID]) VALUES (N'SALE', N'PRODUCT_MANAGE')
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Price], [Sale], [CreateDate], [CreateBy], [Tag], [Status], [Type], [LastChange], [ChangeBy], [CategoryID], [MainImage], [GalleryImage], [GroupID], [Amount], [Rate], [BuyAmount]) VALUES (77, N'áo sơ mi nam', N'SP1497484320', N'ao-so-mi-nam', N'Áo sơ mi trắng cho nam giới', CAST(100000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2017-06-14 23:51:59.500' AS DateTime), NULL, N'áo sơ mi', 1, NULL, CAST(N'2017-06-14 23:52:07.630' AS DateTime), NULL, 13, N'/Images/bow-tie-businessman-fashion-man-1.jpg', NULL, N'1497484320', 12, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'ADMIN_MANAGE', N'Quản lý quản trị viên')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'CUSTOMER_MANAGE', N'Quản lý khách hàng')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'ORDER_MANAGE', N'Quản lý đơn hàng')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'PRODUCT_MANAGE', N'Quản lý sản phẩm')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'STATISTIC_MANAGE', N'Thống kê')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'VIEW_ALL_MANAGE', N'Xem tất cả các phần quản lý nhưng không thể chỉnh sửa')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'VIEW_PAGE', N'Truy câp trang Client')
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (18, N'haunguyen', N'haunguyen', N'12345', 0, N'Hà Nam', CAST(N'2017-05-30 23:00:58.163' AS DateTime), N'0123456789', N'haunguyen@gmail.com', 1, 0, NULL, CAST(N'2017-05-30 23:00:58.163' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (19, N'haunguyen', N'haunguyenmta', N'827ccb0eea8a706c4c34a16891f84e7b', 1, NULL, CAST(N'2017-05-31 00:36:39.767' AS DateTime), N'012345678', N'nguyenhau@gmail.com', 2, 0, NULL, CAST(N'2017-06-03 16:56:28.643' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (20, NULL, N'nguyenhau', N'1234', 1, NULL, CAST(N'2017-05-31 00:49:14.563' AS DateTime), N'0123456789', N'nguyenhau@gmail.com', 2, 0, NULL, CAST(N'2017-06-14 23:32:11.347' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (21, N'nguyen thi hau', N'haumta', N'81dc9bdb52d04dc20036dbd8313ed055', 1, NULL, CAST(N'2017-05-31 00:50:29.317' AS DateTime), N'0123456789', N'haumta@gmail.com', 1, 0, NULL, CAST(N'2017-06-03 16:37:02.900' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (22, N'admin', N'admin', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'Hà Nội', CAST(N'2017-06-03 15:15:22.150' AS DateTime), N'012345678', N'admin@gamilc.om', 1, 1, N'/Images/user.png', CAST(N'2017-06-03 15:15:22.150' AS DateTime), N'ADMIN')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (23, N'admin123', N'admin123', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'Haf Nam', CAST(N'2017-06-03 15:39:13.093' AS DateTime), N'0123456789', N'admin@gmail.com', 1, 1, N'/Images/guess-attic-837156_1.jpg', CAST(N'2017-06-14 23:32:11.460' AS DateTime), N'ACCOUNTANT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (24, N'admin12346', N'admin1234', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'ha Nam', CAST(N'2017-06-03 15:43:33.143' AS DateTime), N'0123456789', N'admin@gmail.com', 2, 1, N'/Images/jackets-1.png', CAST(N'2017-06-03 15:46:53.770' AS DateTime), N'SALE')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (25, N'haunguyen1996', N'haunguyen1996', N'c803622f84fdf5f9dcf56726524fadf1', 0, N'Hà Nam', CAST(N'2017-06-03 16:29:21.250' AS DateTime), N'0123456789', N'nguyenhau26041996mta@gmail.com', 1, 0, NULL, CAST(N'2017-06-14 23:32:11.540' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (26, N'hau1996', N'hau1996', N'827ccb0eea8a706c4c34a16891f84e7b', 0, N'Hà Nội', CAST(N'2017-06-03 16:31:38.883' AS DateTime), NULL, N'haunguyen@gmail.com', 1, 0, NULL, CAST(N'2017-06-14 23:32:11.577' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (27, N'hau123', N'hau123', N'827ccb0eea8a706c4c34a16891f84e7b', 0, N'Hà Nam', CAST(N'2017-06-03 16:47:01.873' AS DateTime), NULL, N'haunguyen@gmail.com', 1, 0, NULL, CAST(N'2017-06-14 23:32:11.610' AS DateTime), N'CLIENT')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (28, N'haunguyenhn', N'haunguyenhn', N'827ccb0eea8a706c4c34a16891f84e7b', 1, N'Hà Nam', CAST(N'2017-06-03 22:00:23.283' AS DateTime), NULL, N'haunguyen@gmail.com', 1, 1, N'/Images/blazers-coat-1.png', CAST(N'2017-06-14 23:32:11.647' AS DateTime), N'ADMIN')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (29, N'hau213', N'hau213', N'827ccb0eea8a706c4c34a16891f84e7b', 1, NULL, CAST(N'2017-06-06 08:20:02.997' AS DateTime), N'012234', N'nguyenhau1996mta@gmail.com', 1, 0, NULL, CAST(N'2017-06-14 23:32:11.703' AS DateTime), N'MEMBER')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (30, N'hauhau', N'hauhau', N'827ccb0eea8a706c4c34a16891f84e7b', 1, NULL, CAST(N'2017-06-06 08:22:19.607' AS DateTime), N'012345', N'nguyenhau1996hn@gmail.com', 1, 0, NULL, CAST(N'2017-06-14 23:32:11.743' AS DateTime), N'MEMBER')
INSERT [dbo].[User] ([ID], [Name], [Username], [Password], [Gender], [Address], [JoinDate], [Phone], [Email], [Status], [Type], [Avatar], [RecentChange], [GroupID]) VALUES (31, N'hauhau123', N'hauhau123', N'827ccb0eea8a706c4c34a16891f84e7b', 1, NULL, CAST(N'2017-06-06 08:24:34.940' AS DateTime), N'12345', N'nguyenhau1996hn@gmail.com', 1, 0, NULL, CAST(N'2017-06-14 23:32:11.780' AS DateTime), N'MEMBER')
SET IDENTITY_INSERT [dbo].[User] OFF
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'ACCOUNTANT', N'Kế toán')
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'ADMIN', N'Quản trị viên')
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'CLIENT', N'Khách hàng')
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'SALE', N'Nhân viên bán hàng')
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_LastChange]  DEFAULT (getdate()) FOR [LastChange]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[OrderProduct] ADD  CONSTRAINT [DF_OrderProduct_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Order]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
