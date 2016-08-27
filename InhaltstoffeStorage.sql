USE [InhaltsstoffeLocal]
GO
/****** Object:  Table [dbo].[Allergens]    Script Date: 27.08.2016 14:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Allergens](
	[AllergenID] [int] IDENTITY(1,1) NOT NULL,
	[AllergenOrdinaryName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Allergens] PRIMARY KEY CLUSTERED 
(
	[AllergenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AllergensSymbols]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllergensSymbols](
	[AllergenSymbolID] [int] IDENTITY(1,1) NOT NULL,
	[AllergenID] [int] NOT NULL,
	[SymbolID] [int] NOT NULL,
 CONSTRAINT [PK_AllergensSymbols] PRIMARY KEY CLUSTERED 
(
	[AllergenSymbolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AllergensLocals]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllergensLocals](
	[AllergenLocalD] [int] IDENTITY(1,1) NOT NULL,
	[AllergenLocalName] [nvarchar](100) NOT NULL,
	[AllergenLocalToolTip] [nvarchar](600) NOT NULL,
	[AllergenID] [int] NOT NULL,
	[AllergenLanguageID] [int] NOT NULL,
 CONSTRAINT [PK_AllergensLocals] PRIMARY KEY CLUSTERED 
(
	[AllergenLocalD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Symbols]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Symbols](
	[SymbolID] [int] IDENTITY(1,1) NOT NULL,
	[SymbolImage] [image] NOT NULL,
	[SymbolArt] [smallint] NOT NULL,
 CONSTRAINT [PK_Symbols] PRIMARY KEY CLUSTERED 
(
	[SymbolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[AllergenData]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AllergenData]
AS
SELECT        dbo.Allergens.AllergenID, dbo.Allergens.AllergenOrdinaryName, dbo.AllergensLocals.AllergenLocalD, dbo.AllergensLocals.AllergenLocalName, dbo.AllergensLocals.AllergenLocalToolTip, 
                         dbo.AllergensSymbols.AllergenSymbolID, dbo.AllergensLocals.AllergenLanguageID, dbo.AllergensSymbols.SymbolID, dbo.Symbols.SymbolImage, dbo.Symbols.SymbolArt
FROM            dbo.AllergensSymbols INNER JOIN
                         dbo.Symbols ON dbo.AllergensSymbols.SymbolID = dbo.Symbols.SymbolID INNER JOIN
                         dbo.Allergens ON dbo.AllergensSymbols.AllergenID = dbo.Allergens.AllergenID LEFT OUTER JOIN
                         dbo.AllergensLocals ON dbo.Allergens.AllergenID = dbo.AllergensLocals.AllergenID


GO
/****** Object:  Table [dbo].[ProductsLocationsID]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsLocationsID](
	[ProductLocationID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
 CONSTRAINT [PK_ProductsLocationsID] PRIMARY KEY CLUSTERED 
(
	[ProductLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductsLocals]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsLocals](
	[ProductLocalID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductToolTip] [nvarchar](600) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductLanguageID] [int] NOT NULL,
 CONSTRAINT [PK_ProductsLocals] PRIMARY KEY CLUSTERED 
(
	[ProductLocalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductOdrinaryName] [nvarchar](100) NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[ProductStatus] [smallint] NOT NULL,
	[ProductWeight] [int] NOT NULL,
 CONSTRAINT [PK_Produkts] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductsSymbols]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsSymbols](
	[ProductSymbolID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[SymbolID] [int] NOT NULL,
 CONSTRAINT [PK_ProductSymbols] PRIMARY KEY CLUSTERED 
(
	[ProductSymbolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ProductData]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductData]
AS
SELECT        dbo.Products.ProductID, dbo.Products.ProductOdrinaryName, dbo.ProductsLocals.ProductLocalID, dbo.ProductsLocals.ProductName, dbo.ProductsLocals.ProductToolTip, dbo.Products.ProductStatus, 
                         dbo.Products.ProductWeight, dbo.ProductsLocals.ProductLanguageID, dbo.Products.ProductCategoryID, dbo.ProductsLocationsID.ProductLocationID, dbo.ProductsLocationsID.LocationID, 
                         dbo.ProductsSymbols.ProductSymbolID, dbo.ProductsSymbols.SymbolID
FROM            dbo.Products INNER JOIN
                         dbo.ProductsLocationsID ON dbo.Products.ProductID = dbo.ProductsLocationsID.ProductID INNER JOIN
                         dbo.ProductsLocals ON dbo.Products.ProductID = dbo.ProductsLocals.ProductID INNER JOIN
                         dbo.ProductsSymbols ON dbo.Products.ProductID = dbo.ProductsSymbols.ProductID



GO
/****** Object:  Table [dbo].[Ingridients]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingridients](
	[IngridientID] [int] IDENTITY(1,1) NOT NULL,
	[IngridientOrdinaryName] [nvarchar](100) NOT NULL,
	[IngridientTyp] [nvarchar](100) NULL,
	[IngridientClass] [nvarchar](100) NULL,
 CONSTRAINT [PK_Ingridients] PRIMARY KEY CLUSTERED 
(
	[IngridientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IngridientsAllergens]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngridientsAllergens](
	[IngridientAllergenID] [int] IDENTITY(1,1) NOT NULL,
	[IngridientID] [int] NOT NULL,
	[AllergenID] [int] NOT NULL,
	[IngridientFeelLimit] [int] NOT NULL,
 CONSTRAINT [PK_IngridientsAllergens] PRIMARY KEY CLUSTERED 
(
	[IngridientAllergenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IngridientsLocals]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngridientsLocals](
	[IngridientLocalID] [int] IDENTITY(1,1) NOT NULL,
	[IngridientName] [nvarchar](100) NOT NULL,
	[IgrridientToolTip] [nvarchar](600) NOT NULL,
	[IngridientClass] [nvarchar](100) NULL,
	[IngridientID] [int] NOT NULL,
	[IngridientLanguageID] [int] NOT NULL,
 CONSTRAINT [PK_IngridientsLocals] PRIMARY KEY CLUSTERED 
(
	[IngridientLocalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[IngridientData]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IngridientData]
AS
SELECT        dbo.Ingridients.IngridientID, dbo.Ingridients.IngridientOrdinaryName, dbo.IngridientsLocals.IngridientLocalID, dbo.IngridientsLocals.IngridientName, dbo.IngridientsLocals.IgrridientToolTip, 
                         dbo.IngridientsAllergens.IngridientFeelLimit, dbo.IngridientsLocals.IngridientLanguageID, dbo.IngridientsAllergens.IngridientAllergenID, dbo.IngridientsAllergens.AllergenID, dbo.Ingridients.IngridientTyp, 
                         dbo.Ingridients.IngridientClass
FROM            dbo.Ingridients LEFT OUTER JOIN
                         dbo.IngridientsAllergens ON dbo.Ingridients.IngridientID = dbo.IngridientsAllergens.IngridientID LEFT OUTER JOIN
                         dbo.IngridientsLocals ON dbo.Ingridients.IngridientID = dbo.IngridientsLocals.IngridientID

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryOrdinaryName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Kategories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoriesLocals]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriesLocals](
	[CategoryLocalID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryLocalName] [nvarchar](100) NOT NULL,
	[CategoryLocalToolTip] [nvarchar](600) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[CategoryLanguageID] [int] NOT NULL,
 CONSTRAINT [PK_CategoriesLocals] PRIMARY KEY CLUSTERED 
(
	[CategoryLocalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[CategoryData]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CategoryData]
AS
SELECT        dbo.Categories.CategoryID, dbo.Categories.CategoryOrdinaryName, dbo.CategoriesLocals.CategoryLocalID, dbo.CategoriesLocals.CategoryLocalName, dbo.CategoriesLocals.CategoryLocalToolTip, 
                         dbo.CategoriesLocals.CategoryLanguageID
FROM            dbo.Categories INNER JOIN
                         dbo.CategoriesLocals ON dbo.Categories.CategoryID = dbo.CategoriesLocals.CategoryID



GO
/****** Object:  Table [dbo].[Languages]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[LanguageID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageShortCode] [nchar](2) NOT NULL,
	[LanguageEnglishName] [nvarchar](100) NOT NULL,
	[LanguageGermanName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[LanguageData]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LanguageData]
AS
SELECT        LanguageID, LanguageShortCode, LanguageEnglishName, LanguageGermanName
FROM            dbo.Languages



GO
/****** Object:  Table [dbo].[Locations]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[LocationCity] [nvarchar](100) NOT NULL,
	[LocationLocalName] [nvarchar](10) NOT NULL,
	[LocationPostalCode] [nvarchar](8) NOT NULL,
	[LocationStreet] [nvarchar](200) NOT NULL,
	[LocationLocalNumber] [nchar](10) NOT NULL,
	[LocationCountry] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[LocationData]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LocationData]
AS
SELECT        LocationID, LocationCity, LocationLocalName, LocationPostalCode, LocationStreet, LocationLocalNumber, LocationCountry
FROM            dbo.Locations



GO
/****** Object:  View [dbo].[SymbolData]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SymbolData]
AS
SELECT        SymbolID, SymbolImage, SymbolArt
FROM            dbo.Symbols



GO
/****** Object:  Table [dbo].[ProductProducts]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductProducts](
	[ProductProductsID] [int] IDENTITY(1,1) NOT NULL,
	[ProductParentID] [int] NOT NULL,
	[ProductChildID] [int] NOT NULL,
 CONSTRAINT [PK_ProductProducts] PRIMARY KEY CLUSTERED 
(
	[ProductProductsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductsIngridients]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsIngridients](
	[ProductIngridientID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[IngridientID] [int] NOT NULL,
	[IngridientFeel] [int] NOT NULL,
 CONSTRAINT [PK_ProductsIngridients] PRIMARY KEY CLUSTERED 
(
	[ProductIngridientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 27.08.2016 14:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Ingridients] ADD  CONSTRAINT [DF_Ingridients_Conservant]  DEFAULT ((0)) FOR [IngridientTyp]
GO
ALTER TABLE [dbo].[Symbols] ADD  CONSTRAINT [DF_Symbols_SymbolArt]  DEFAULT ((1)) FOR [SymbolArt]
GO
ALTER TABLE [dbo].[AllergensLocals]  WITH CHECK ADD  CONSTRAINT [FK_AllergensLocals_Allergens] FOREIGN KEY([AllergenID])
REFERENCES [dbo].[Allergens] ([AllergenID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AllergensLocals] CHECK CONSTRAINT [FK_AllergensLocals_Allergens]
GO
ALTER TABLE [dbo].[AllergensLocals]  WITH CHECK ADD  CONSTRAINT [FK_AllergensLocals_Languages] FOREIGN KEY([AllergenLanguageID])
REFERENCES [dbo].[Languages] ([LanguageID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AllergensLocals] CHECK CONSTRAINT [FK_AllergensLocals_Languages]
GO
ALTER TABLE [dbo].[AllergensSymbols]  WITH CHECK ADD  CONSTRAINT [FK_AllergensSymbols_Allergens] FOREIGN KEY([AllergenID])
REFERENCES [dbo].[Allergens] ([AllergenID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AllergensSymbols] CHECK CONSTRAINT [FK_AllergensSymbols_Allergens]
GO
ALTER TABLE [dbo].[AllergensSymbols]  WITH CHECK ADD  CONSTRAINT [FK_AllergensSymbols_Symbols] FOREIGN KEY([SymbolID])
REFERENCES [dbo].[Symbols] ([SymbolID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AllergensSymbols] CHECK CONSTRAINT [FK_AllergensSymbols_Symbols]
GO
ALTER TABLE [dbo].[CategoriesLocals]  WITH CHECK ADD  CONSTRAINT [FK_CategoriesLocals_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[CategoriesLocals] CHECK CONSTRAINT [FK_CategoriesLocals_Categories]
GO
ALTER TABLE [dbo].[CategoriesLocals]  WITH CHECK ADD  CONSTRAINT [FK_CategoriesLocals_Languages] FOREIGN KEY([CategoryLanguageID])
REFERENCES [dbo].[Languages] ([LanguageID])
GO
ALTER TABLE [dbo].[CategoriesLocals] CHECK CONSTRAINT [FK_CategoriesLocals_Languages]
GO
ALTER TABLE [dbo].[IngridientsAllergens]  WITH CHECK ADD  CONSTRAINT [FK_IngridientsAllergens_Allergens] FOREIGN KEY([AllergenID])
REFERENCES [dbo].[Allergens] ([AllergenID])
GO
ALTER TABLE [dbo].[IngridientsAllergens] CHECK CONSTRAINT [FK_IngridientsAllergens_Allergens]
GO
ALTER TABLE [dbo].[IngridientsAllergens]  WITH CHECK ADD  CONSTRAINT [FK_IngridientsAllergens_Ingridients] FOREIGN KEY([IngridientID])
REFERENCES [dbo].[Ingridients] ([IngridientID])
GO
ALTER TABLE [dbo].[IngridientsAllergens] CHECK CONSTRAINT [FK_IngridientsAllergens_Ingridients]
GO
ALTER TABLE [dbo].[IngridientsLocals]  WITH CHECK ADD  CONSTRAINT [FK_IngridientsLocals_Ingridients] FOREIGN KEY([IngridientID])
REFERENCES [dbo].[Ingridients] ([IngridientID])
GO
ALTER TABLE [dbo].[IngridientsLocals] CHECK CONSTRAINT [FK_IngridientsLocals_Ingridients]
GO
ALTER TABLE [dbo].[IngridientsLocals]  WITH CHECK ADD  CONSTRAINT [FK_IngridientsLocals_Languages] FOREIGN KEY([IngridientLanguageID])
REFERENCES [dbo].[Languages] ([LanguageID])
GO
ALTER TABLE [dbo].[IngridientsLocals] CHECK CONSTRAINT [FK_IngridientsLocals_Languages]
GO
ALTER TABLE [dbo].[ProductProducts]  WITH CHECK ADD  CONSTRAINT [FK_ProductProducts_ProductProducts] FOREIGN KEY([ProductParentID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductProducts] CHECK CONSTRAINT [FK_ProductProducts_ProductProducts]
GO
ALTER TABLE [dbo].[ProductProducts]  WITH CHECK ADD  CONSTRAINT [FK_ProductProducts_Products] FOREIGN KEY([ProductChildID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductProducts] CHECK CONSTRAINT [FK_ProductProducts_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[ProductsIngridients]  WITH CHECK ADD  CONSTRAINT [FK_ProductsIngridients_Ingridients] FOREIGN KEY([IngridientID])
REFERENCES [dbo].[Ingridients] ([IngridientID])
GO
ALTER TABLE [dbo].[ProductsIngridients] CHECK CONSTRAINT [FK_ProductsIngridients_Ingridients]
GO
ALTER TABLE [dbo].[ProductsIngridients]  WITH CHECK ADD  CONSTRAINT [FK_ProductsIngridients_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductsIngridients] CHECK CONSTRAINT [FK_ProductsIngridients_Products]
GO
ALTER TABLE [dbo].[ProductsLocals]  WITH CHECK ADD  CONSTRAINT [FK_ProductsLocals_Languages] FOREIGN KEY([ProductLanguageID])
REFERENCES [dbo].[Languages] ([LanguageID])
GO
ALTER TABLE [dbo].[ProductsLocals] CHECK CONSTRAINT [FK_ProductsLocals_Languages]
GO
ALTER TABLE [dbo].[ProductsLocals]  WITH CHECK ADD  CONSTRAINT [FK_ProductsLocals_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductsLocals] CHECK CONSTRAINT [FK_ProductsLocals_Products]
GO
ALTER TABLE [dbo].[ProductsLocationsID]  WITH CHECK ADD  CONSTRAINT [FK_ProductsLocationsID_Locations] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[ProductsLocationsID] CHECK CONSTRAINT [FK_ProductsLocationsID_Locations]
GO
ALTER TABLE [dbo].[ProductsLocationsID]  WITH CHECK ADD  CONSTRAINT [FK_ProductsLocationsID_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductsLocationsID] CHECK CONSTRAINT [FK_ProductsLocationsID_Products]
GO
ALTER TABLE [dbo].[ProductsSymbols]  WITH CHECK ADD  CONSTRAINT [FK_ProductsSymbols_Symbols] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Symbols] ([SymbolID])
GO
ALTER TABLE [dbo].[ProductsSymbols] CHECK CONSTRAINT [FK_ProductsSymbols_Symbols]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[14] 2[20] 3) )"
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
         Begin Table = "AllergensSymbols"
            Begin Extent = 
               Top = 44
               Left = 505
               Bottom = 157
               Right = 689
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Symbols"
            Begin Extent = 
               Top = 237
               Left = 297
               Bottom = 350
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Allergens"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 216
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AllergensLocals"
            Begin Extent = 
               Top = 216
               Left = 38
               Bottom = 346
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4260
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
         Or' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllergenData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllergenData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllergenData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Categories"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CategoriesLocals"
            Begin Extent = 
               Top = 6
               Left = 291
               Bottom = 136
               Right = 497
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CategoryData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CategoryData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Ingridients"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "IngridientsAllergens"
            Begin Extent = 
               Top = 185
               Left = 329
               Bottom = 315
               Right = 524
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IngridientsLocals"
            Begin Extent = 
               Top = 6
               Left = 527
               Bottom = 136
               Right = 730
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2655
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IngridientData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IngridientData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Languages"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 253
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LanguageData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LanguageData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Locations"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 3
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LocationData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LocationData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductsLocationsID"
            Begin Extent = 
               Top = 30
               Left = 601
               Bottom = 143
               Right = 789
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductsLocals"
            Begin Extent = 
               Top = 138
               Left = 264
               Bottom = 268
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductsSymbols"
            Begin Extent = 
               Top = 163
               Left = 618
               Bottom = 276
               Right = 800
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
         Column = 2970
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Symbols"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 205
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SymbolData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SymbolData'
GO
