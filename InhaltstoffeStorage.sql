USE [InhaltsstoffeLocal]
GO
/****** Object:  Table [dbo].[Allergens]    Script Date: 11.08.2016 23:46:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[AllergensLocals]    Script Date: 11.08.2016 23:46:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[AllergensSymbols]    Script Date: 11.08.2016 23:46:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 11.08.2016 23:46:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[CategoriesLocals]    Script Date: 11.08.2016 23:46:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Ingridients]    Script Date: 11.08.2016 23:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingridients](
	[IngridientID] [int] IDENTITY(1,1) NOT NULL,
	[IngridientOrdinaryName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Ingridients] PRIMARY KEY CLUSTERED 
(
	[IngridientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[IngridientsAllergens]    Script Date: 11.08.2016 23:46:33 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[IngridientsLocals]    Script Date: 11.08.2016 23:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngridientsLocals](
	[IngridientLocalID] [int] IDENTITY(1,1) NOT NULL,
	[IngridientName] [nvarchar](100) NOT NULL,
	[IgrridientToolTip] [nvarchar](600) NOT NULL,
	[IngridientID] [int] NOT NULL,
	[IngridientLanguageID] [int] NOT NULL,
 CONSTRAINT [PK_IngridientsLocals] PRIMARY KEY CLUSTERED 
(
	[IngridientLocalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[IngridientsSymbols]    Script Date: 11.08.2016 23:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngridientsSymbols](
	[IngridientSymbolID] [int] IDENTITY(1,1) NOT NULL,
	[IngridientID] [int] NOT NULL,
	[SymbolID] [int] NOT NULL,
 CONSTRAINT [PK_IngridientsSymbols] PRIMARY KEY CLUSTERED 
(
	[IngridientSymbolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Languages]    Script Date: 11.08.2016 23:46:33 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Locations]    Script Date: 11.08.2016 23:46:33 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Products]    Script Date: 11.08.2016 23:46:33 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ProductsIngridients]    Script Date: 11.08.2016 23:46:33 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ProductsLocals]    Script Date: 11.08.2016 23:46:34 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ProductsLocationsID]    Script Date: 11.08.2016 23:46:34 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Symbols]    Script Date: 11.08.2016 23:46:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Symbols](
	[SymbolID] [int] IDENTITY(1,1) NOT NULL,
	[SymbolImage] [image] NOT NULL,
	[SymbolArt] [smallint] NOT NULL CONSTRAINT [DF_Symbols_SymbolArt]  DEFAULT ((1)),
 CONSTRAINT [PK_Symbols] PRIMARY KEY CLUSTERED 
(
	[SymbolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 11.08.2016 23:46:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[AllergensLocals]  WITH CHECK ADD  CONSTRAINT [FK_AllergensLocals_Allergens] FOREIGN KEY([AllergenID])
REFERENCES [dbo].[Allergens] ([AllergenID])
GO
ALTER TABLE [dbo].[AllergensLocals] CHECK CONSTRAINT [FK_AllergensLocals_Allergens]
GO
ALTER TABLE [dbo].[AllergensLocals]  WITH CHECK ADD  CONSTRAINT [FK_AllergensLocals_Languages] FOREIGN KEY([AllergenLanguageID])
REFERENCES [dbo].[Languages] ([LanguageID])
GO
ALTER TABLE [dbo].[AllergensLocals] CHECK CONSTRAINT [FK_AllergensLocals_Languages]
GO
ALTER TABLE [dbo].[AllergensSymbols]  WITH CHECK ADD  CONSTRAINT [FK_AllergensSymbols_Allergens] FOREIGN KEY([AllergenID])
REFERENCES [dbo].[Allergens] ([AllergenID])
GO
ALTER TABLE [dbo].[AllergensSymbols] CHECK CONSTRAINT [FK_AllergensSymbols_Allergens]
GO
ALTER TABLE [dbo].[AllergensSymbols]  WITH CHECK ADD  CONSTRAINT [FK_AllergensSymbols_Symbols] FOREIGN KEY([SymbolID])
REFERENCES [dbo].[Symbols] ([SymbolID])
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
ALTER TABLE [dbo].[IngridientsLocals]  WITH CHECK ADD  CONSTRAINT [FK_IngridientsLocals_IngridientsSymbols] FOREIGN KEY([IngridientID])
REFERENCES [dbo].[IngridientsSymbols] ([IngridientSymbolID])
GO
ALTER TABLE [dbo].[IngridientsLocals] CHECK CONSTRAINT [FK_IngridientsLocals_IngridientsSymbols]
GO
ALTER TABLE [dbo].[IngridientsLocals]  WITH CHECK ADD  CONSTRAINT [FK_IngridientsLocals_Languages] FOREIGN KEY([IngridientLanguageID])
REFERENCES [dbo].[Languages] ([LanguageID])
GO
ALTER TABLE [dbo].[IngridientsLocals] CHECK CONSTRAINT [FK_IngridientsLocals_Languages]
GO
ALTER TABLE [dbo].[IngridientsSymbols]  WITH CHECK ADD  CONSTRAINT [FK_IngridientsSymbols_Symbols] FOREIGN KEY([SymbolID])
REFERENCES [dbo].[Symbols] ([SymbolID])
GO
ALTER TABLE [dbo].[IngridientsSymbols] CHECK CONSTRAINT [FK_IngridientsSymbols_Symbols]
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
