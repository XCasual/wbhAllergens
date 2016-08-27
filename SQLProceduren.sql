USE [InhaltsstoffeLocal]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	



GO
/****** Object:  UserDefinedFunction [dbo].[v_AllergenSymbol]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[v_AllergenSymbol] (@AllergenID INT)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	SELECT        dbo.AllergenData.AllergenID, dbo.SymbolData.SymbolID, dbo.SymbolData.SymbolImage
	FROM            dbo.AllergenData INNER JOIN
							 dbo.SymbolData ON dbo.AllergenData.SymbolID = dbo.SymbolData.SymbolID
	WHERE        (dbo.AllergenData.AllergenID = @AllergenID)
	)




GO
/****** Object:  UserDefinedFunction [dbo].[v_CategoryProducts]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[v_CategoryProducts](
	@LanguageID INT,
	@CategoryID INT
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT        dbo.ProductData.*
	FROM            dbo.ProductData
	WHERE        (ProductLanguageID = @LanguageID) AND (ProductCategoryID = @CategoryID)
)



GO
/****** Object:  UserDefinedFunction [dbo].[v_IngridientAllergen]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[v_IngridientAllergen](@IngridientID INT)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	SELECT        dbo.IngridientsAllergens.AllergenID, dbo.IngridientData.IngridientID
	FROM            dbo.IngridientData INNER JOIN
							 dbo.IngridientsAllergens ON dbo.IngridientData.IngridientAllergenID = dbo.IngridientsAllergens.IngridientAllergenID INNER JOIN
							 dbo.AllergenData ON dbo.IngridientsAllergens.AllergenID = dbo.AllergenData.AllergenID
	WHERE        (dbo.IngridientData.IngridientID = @IngridientID)
)



GO
/****** Object:  UserDefinedFunction [dbo].[v_ProductAllergens]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[v_ProductAllergens](
					@ProductID INT,
					@LocationID INT,
					@CategoryID INT,
					@LanguageID INT)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
SELECT        sub.*, s.SymbolImage
FROM            (SELECT DISTINCT ad.AllergenLocalName, ad.AllergenLocalToolTip, sd.SymbolArt, sd.SymbolID
                          FROM            dbo.ProductData AS root INNER JOIN
                                                    dbo.ProductsIngridients AS pi ON root.ProductID = pi.ProductID INNER JOIN
                                                    dbo.IngridientData AS id ON pi.IngridientID = id.IngridientID INNER JOIN
                                                    dbo.AllergenData AS ad ON id.AllergenID = ad.AllergenID INNER JOIN
                                                    dbo.SymbolData AS sd ON ad.SymbolID = sd.SymbolID
                          WHERE        (root.ProductID = @ProductID) AND (root.LocationID = @LocationID) AND (root.ProductCategoryID = @CategoryID) AND (root.ProductLanguageID = @LanguageID)
 AND (ad.AllergenLanguageID = @LanguageID)) AS sub INNER JOIN
                         dbo.SymbolData AS s ON sub.SymbolID = s.SymbolID
)



GO
/****** Object:  UserDefinedFunction [dbo].[v_ProductIngridients]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[v_ProductIngridients](@ProductID INT)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	SELECT        dbo.ProductData.ProductID, dbo.IngridientData.IngridientID
	FROM          dbo.ProductData INNER JOIN
							 dbo.ProductsIngridients ON dbo.ProductData.ProductID = dbo.ProductsIngridients.ProductID INNER JOIN
							 dbo.IngridientData ON dbo.ProductsIngridients.IngridientID = dbo.IngridientData.IngridientID
	WHERE        (dbo.ProductData.ProductID = @ProductID)
)



GO
/****** Object:  UserDefinedFunction [dbo].[v_ProductMask]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[v_ProductMask](
	@LanguageID INT,
	@ProductName NChar
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT        dbo.ProductData.*
FROM            dbo.ProductData
WHERE        (ProductLanguageID = @LanguageID) AND ((ProductName like @ProductName)  OR (ProductOdrinaryName like @ProductName)) 
)



GO
/****** Object:  UserDefinedFunction [dbo].[v_ProductSymbol]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[v_ProductSymbol] (@ProductID INT)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	SELECT        dbo.ProductData.ProductID, dbo.SymbolData.SymbolID, dbo.SymbolData.SymbolImage
	FROM            dbo.ProductData INNER JOIN
							 dbo.SymbolData ON dbo.ProductData.SymbolID = dbo.SymbolData.SymbolID
	WHERE        (dbo.ProductData.ProductID = @ProductID)
	)




GO
/****** Object:  StoredProcedure [dbo].[AllergenCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenCreate]
(
	@AllergenOrdinaryName nvarchar(100)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Allergens] ([AllergenOrdinaryName]) VALUES (@AllergenOrdinaryName);
	
SELECT AllergenID, AllergenOrdinaryName FROM Allergens WHERE (AllergenID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[AllergenDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenDelete]
(
	@Original_AllergenID int,
	@Original_AllergenOrdinaryName nvarchar(100)
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Allergens] WHERE (([AllergenID] = @Original_AllergenID) AND ([AllergenOrdinaryName] = @Original_AllergenOrdinaryName))

GO
/****** Object:  StoredProcedure [dbo].[AllergenLocalCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenLocalCreate]
(
	@AllergenLocalName nvarchar(100),
	@AllergenLocalToolTip nvarchar(600),
	@AllergenID int,
	@AllergenLanguageID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [AllergensLocals] ([AllergenLocalName], [AllergenLocalToolTip], [AllergenID], [AllergenLanguageID]) VALUES (@AllergenLocalName, @AllergenLocalToolTip, @AllergenID, @AllergenLanguageID);
	
SELECT AllergenLocalD, AllergenLocalName, AllergenLocalToolTip, AllergenID, AllergenLanguageID FROM AllergensLocals WHERE (AllergenLocalD = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[AllergenLocalDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenLocalDelete]
(
	@Original_AllergenLocalD int,
	@Original_AllergenLocalName nvarchar(100),
	@Original_AllergenLocalToolTip nvarchar(600),
	@Original_AllergenID int,
	@Original_AllergenLanguageID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [AllergensLocals] WHERE (([AllergenLocalD] = @Original_AllergenLocalD) AND ([AllergenLocalName] = @Original_AllergenLocalName) AND ([AllergenLocalToolTip] = @Original_AllergenLocalToolTip) AND ([AllergenID] = @Original_AllergenID) AND ([AllergenLanguageID] = @Original_AllergenLanguageID))

GO
/****** Object:  StoredProcedure [dbo].[AllergenLocalRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenLocalRead]
AS
	SET NOCOUNT ON;
SELECT        AllergensLocals.*
FROM            AllergensLocals

GO
/****** Object:  StoredProcedure [dbo].[AllergenLocalUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenLocalUpdate]
(
	@AllergenLocalName nvarchar(100),
	@AllergenLocalToolTip nvarchar(600),
	@AllergenID int,
	@AllergenLanguageID int,
	@Original_AllergenLocalD int,
	@Original_AllergenLocalName nvarchar(100),
	@Original_AllergenLocalToolTip nvarchar(600),
	@Original_AllergenID int,
	@Original_AllergenLanguageID int,
	@AllergenLocalD int
)
AS
	SET NOCOUNT OFF;
UPDATE [AllergensLocals] SET [AllergenLocalName] = @AllergenLocalName, [AllergenLocalToolTip] = @AllergenLocalToolTip, [AllergenID] = @AllergenID, [AllergenLanguageID] = @AllergenLanguageID WHERE (([AllergenLocalD] = @Original_AllergenLocalD) AND ([AllergenLocalName] = @Original_AllergenLocalName) AND ([AllergenLocalToolTip] = @Original_AllergenLocalToolTip) AND ([AllergenID] = @Original_AllergenID) AND ([AllergenLanguageID] = @Original_AllergenLanguageID));
	
SELECT AllergenLocalD, AllergenLocalName, AllergenLocalToolTip, AllergenID, AllergenLanguageID FROM AllergensLocals WHERE (AllergenLocalD = @AllergenLocalD)

GO
/****** Object:  StoredProcedure [dbo].[AllergenRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenRead]
AS
	SET NOCOUNT ON;
SELECT        Allergens.*
FROM            Allergens

GO
/****** Object:  StoredProcedure [dbo].[AllergenSymbolCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenSymbolCreate]
(
	@AllergenID int,
	@SymbolID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [AllergensSymbols] ([AllergenID], [SymbolID]) VALUES (@AllergenID, @SymbolID);
	
SELECT AllergenSymbolID, AllergenID, SymbolID FROM AllergensSymbols WHERE (AllergenSymbolID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[AllergenSymbolDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenSymbolDelete]
(
	@Original_AllergenSymbolID int,
	@Original_AllergenID int,
	@Original_SymbolID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [AllergensSymbols] WHERE (([AllergenSymbolID] = @Original_AllergenSymbolID) AND ([AllergenID] = @Original_AllergenID) AND ([SymbolID] = @Original_SymbolID))

GO
/****** Object:  StoredProcedure [dbo].[AllergenSymbolRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenSymbolRead]
AS
	SET NOCOUNT ON;
SELECT        AllergensSymbols.*
FROM            AllergensSymbols

GO
/****** Object:  StoredProcedure [dbo].[AllergenSymbolUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenSymbolUpdate]
(
	@AllergenID int,
	@SymbolID int,
	@Original_AllergenSymbolID int,
	@Original_AllergenID int,
	@Original_SymbolID int,
	@AllergenSymbolID int
)
AS
	SET NOCOUNT OFF;
UPDATE [AllergensSymbols] SET [AllergenID] = @AllergenID, [SymbolID] = @SymbolID WHERE (([AllergenSymbolID] = @Original_AllergenSymbolID) AND ([AllergenID] = @Original_AllergenID) AND ([SymbolID] = @Original_SymbolID));
	
SELECT AllergenSymbolID, AllergenID, SymbolID FROM AllergensSymbols WHERE (AllergenSymbolID = @AllergenSymbolID)

GO
/****** Object:  StoredProcedure [dbo].[AllergenUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AllergenUpdate]
(
	@AllergenOrdinaryName nvarchar(100),
	@Original_AllergenID int,
	@Original_AllergenOrdinaryName nvarchar(100),
	@AllergenID int
)
AS
	SET NOCOUNT OFF;
UPDATE [Allergens] SET [AllergenOrdinaryName] = @AllergenOrdinaryName WHERE (([AllergenID] = @Original_AllergenID) AND ([AllergenOrdinaryName] = @Original_AllergenOrdinaryName));
	
SELECT AllergenID, AllergenOrdinaryName FROM Allergens WHERE (AllergenID = @AllergenID)

GO
/****** Object:  StoredProcedure [dbo].[CategoryCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryCreate]
(
	@CategoryOrdinaryName nvarchar(100)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Categories] ([CategoryOrdinaryName]) VALUES (@CategoryOrdinaryName);
	
SELECT CategoryID, CategoryOrdinaryName FROM Categories WHERE (CategoryID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[CategoryDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryDelete]
(
	@Original_CategoryID int,
	@Original_CategoryOrdinaryName nvarchar(100)
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Categories] WHERE (([CategoryID] = @Original_CategoryID) AND ([CategoryOrdinaryName] = @Original_CategoryOrdinaryName))

GO
/****** Object:  StoredProcedure [dbo].[CategoryLocalCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryLocalCreate]
(
	@CategoryLocalName nvarchar(100),
	@CategoryLocalToolTip nvarchar(600),
	@CategoryID int,
	@CategoryLanguageID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [CategoriesLocals] ([CategoryLocalName], [CategoryLocalToolTip], [CategoryID], [CategoryLanguageID]) VALUES (@CategoryLocalName, @CategoryLocalToolTip, @CategoryID, @CategoryLanguageID);
	
SELECT CategoryLocalID, CategoryLocalName, CategoryLocalToolTip, CategoryID, CategoryLanguageID FROM CategoriesLocals WHERE (CategoryLocalID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[CategoryLocalDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryLocalDelete]
(
	@Original_CategoryLocalID int,
	@Original_CategoryLocalName nvarchar(100),
	@Original_CategoryLocalToolTip nvarchar(600),
	@Original_CategoryID int,
	@Original_CategoryLanguageID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [CategoriesLocals] WHERE (([CategoryLocalID] = @Original_CategoryLocalID) AND ([CategoryLocalName] = @Original_CategoryLocalName) AND ([CategoryLocalToolTip] = @Original_CategoryLocalToolTip) AND ([CategoryID] = @Original_CategoryID) AND ([CategoryLanguageID] = @Original_CategoryLanguageID))

GO
/****** Object:  StoredProcedure [dbo].[CategoryLocalRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryLocalRead]
AS
	SET NOCOUNT ON;
SELECT        CategoriesLocals.*
FROM            CategoriesLocals

GO
/****** Object:  StoredProcedure [dbo].[CategoryLocalUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryLocalUpdate]
(
	@CategoryLocalName nvarchar(100),
	@CategoryLocalToolTip nvarchar(600),
	@CategoryID int,
	@CategoryLanguageID int,
	@Original_CategoryLocalID int,
	@Original_CategoryLocalName nvarchar(100),
	@Original_CategoryLocalToolTip nvarchar(600),
	@Original_CategoryID int,
	@Original_CategoryLanguageID int,
	@CategoryLocalID int
)
AS
	SET NOCOUNT OFF;
UPDATE [CategoriesLocals] SET [CategoryLocalName] = @CategoryLocalName, [CategoryLocalToolTip] = @CategoryLocalToolTip, [CategoryID] = @CategoryID, [CategoryLanguageID] = @CategoryLanguageID WHERE (([CategoryLocalID] = @Original_CategoryLocalID) AND ([CategoryLocalName] = @Original_CategoryLocalName) AND ([CategoryLocalToolTip] = @Original_CategoryLocalToolTip) AND ([CategoryID] = @Original_CategoryID) AND ([CategoryLanguageID] = @Original_CategoryLanguageID));
	
SELECT CategoryLocalID, CategoryLocalName, CategoryLocalToolTip, CategoryID, CategoryLanguageID FROM CategoriesLocals WHERE (CategoryLocalID = @CategoryLocalID)

GO
/****** Object:  StoredProcedure [dbo].[CategoryRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryRead]
AS
	SET NOCOUNT ON;
SELECT        Categories.*
FROM            Categories

GO
/****** Object:  StoredProcedure [dbo].[CategoryUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryUpdate]
(
	@CategoryOrdinaryName nvarchar(100),
	@Original_CategoryID int,
	@Original_CategoryOrdinaryName nvarchar(100),
	@CategoryID int
)
AS
	SET NOCOUNT OFF;
UPDATE [Categories] SET [CategoryOrdinaryName] = @CategoryOrdinaryName WHERE (([CategoryID] = @Original_CategoryID) AND ([CategoryOrdinaryName] = @Original_CategoryOrdinaryName));
	
SELECT CategoryID, CategoryOrdinaryName FROM Categories WHERE (CategoryID = @CategoryID)

GO
/****** Object:  StoredProcedure [dbo].[IngridientAllergenCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientAllergenCreate]
(
	@IngridientID int,
	@AllergenID int,
	@IngridientFeelLimit int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [IngridientsAllergens] ([IngridientID], [AllergenID], [IngridientFeelLimit]) VALUES (@IngridientID, @AllergenID, @IngridientFeelLimit);
	
SELECT IngridientAllergenID, IngridientID, AllergenID, IngridientFeelLimit FROM IngridientsAllergens WHERE (IngridientAllergenID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[IngridientAllergenDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientAllergenDelete]
(
	@Original_IngridientAllergenID int,
	@Original_IngridientID int,
	@Original_AllergenID int,
	@Original_IngridientFeelLimit int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [IngridientsAllergens] WHERE (([IngridientAllergenID] = @Original_IngridientAllergenID) AND ([IngridientID] = @Original_IngridientID) AND ([AllergenID] = @Original_AllergenID) AND ([IngridientFeelLimit] = @Original_IngridientFeelLimit))

GO
/****** Object:  StoredProcedure [dbo].[IngridientAllergenRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientAllergenRead]
AS
	SET NOCOUNT ON;
SELECT        IngridientsAllergens.*
FROM            IngridientsAllergens

GO
/****** Object:  StoredProcedure [dbo].[IngridientAllergenUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientAllergenUpdate]
(
	@IngridientID int,
	@AllergenID int,
	@IngridientFeelLimit int,
	@Original_IngridientAllergenID int,
	@Original_IngridientID int,
	@Original_AllergenID int,
	@Original_IngridientFeelLimit int,
	@IngridientAllergenID int
)
AS
	SET NOCOUNT OFF;
UPDATE [IngridientsAllergens] SET [IngridientID] = @IngridientID, [AllergenID] = @AllergenID, [IngridientFeelLimit] = @IngridientFeelLimit WHERE (([IngridientAllergenID] = @Original_IngridientAllergenID) AND ([IngridientID] = @Original_IngridientID) AND ([AllergenID] = @Original_AllergenID) AND ([IngridientFeelLimit] = @Original_IngridientFeelLimit));
	
SELECT IngridientAllergenID, IngridientID, AllergenID, IngridientFeelLimit FROM IngridientsAllergens WHERE (IngridientAllergenID = @IngridientAllergenID)

GO
/****** Object:  StoredProcedure [dbo].[IngridientCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientCreate]
(
	@IngridientOrdinaryName nvarchar(100),
	@IngridientTyp nvarchar(100),
	@IngridientClass nvarchar(100)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Ingridients] ([IngridientOrdinaryName], [IngridientTyp], [IngridientClass]) VALUES (@IngridientOrdinaryName, @IngridientTyp, @IngridientClass);
	
SELECT * FROM Ingridients WHERE (IngridientID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[IngridientDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientDelete]
(
	@Original_IngridientID int,
	@Original_IngridientOrdinaryName nvarchar(100)
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Ingridients] WHERE (([IngridientID] = @Original_IngridientID) AND ([IngridientOrdinaryName] = @Original_IngridientOrdinaryName))

GO
/****** Object:  StoredProcedure [dbo].[IngridientLocalCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientLocalCreate]
(
	@IngridientName nvarchar(100),
	@IgrridientToolTip nvarchar(600),
	@IngridientClass nvarchar(100),
	@IngridientID int,
	@IngridientLanguageID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [IngridientsLocals] ([IngridientName], [IgrridientToolTip], [IngridientClass], [IngridientID], [IngridientLanguageID]) VALUES (@IngridientName, @IgrridientToolTip, @IngridientClass , @IngridientID, @IngridientLanguageID);
	
SELECT * FROM IngridientsLocals WHERE (IngridientLocalID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[IngridientLocalDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientLocalDelete]
(
	@Original_IngridientLocalID int,
	@Original_IngridientName nvarchar(100),
	@Original_IgrridientToolTip nvarchar(600),
	@Original_IngridientID int,
	@Original_IngridientLanguageID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [IngridientsLocals] WHERE (([IngridientLocalID] = @Original_IngridientLocalID) AND ([IngridientName] = @Original_IngridientName) AND ([IgrridientToolTip] = @Original_IgrridientToolTip) AND ([IngridientID] = @Original_IngridientID) AND ([IngridientLanguageID] = @Original_IngridientLanguageID))

GO
/****** Object:  StoredProcedure [dbo].[IngridientLocalRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientLocalRead]
AS
	SET NOCOUNT ON;
SELECT        IngridientsLocals.*
FROM            IngridientsLocals

GO
/****** Object:  StoredProcedure [dbo].[IngridientLocalUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientLocalUpdate]
(
	@IngridientName nvarchar(100),
	@IgrridientToolTip nvarchar(600),
	@IngridientID int,
	@IngridientLanguageID int,
	@Original_IngridientLocalID int,
	@Original_IngridientName nvarchar(100),
	@Original_IgrridientToolTip nvarchar(600),
	@Original_IngridientID int,
	@Original_IngridientLanguageID int,
	@IngridientLocalID int
)
AS
	SET NOCOUNT OFF;
UPDATE [IngridientsLocals] SET [IngridientName] = @IngridientName, [IgrridientToolTip] = @IgrridientToolTip, [IngridientID] = @IngridientID, [IngridientLanguageID] = @IngridientLanguageID WHERE (([IngridientLocalID] = @Original_IngridientLocalID) AND ([IngridientName] = @Original_IngridientName) AND ([IgrridientToolTip] = @Original_IgrridientToolTip) AND ([IngridientID] = @Original_IngridientID) AND ([IngridientLanguageID] = @Original_IngridientLanguageID));
	
SELECT IngridientLocalID, IngridientName, IgrridientToolTip, IngridientID, IngridientLanguageID FROM IngridientsLocals WHERE (IngridientLocalID = @IngridientLocalID)

GO
/****** Object:  StoredProcedure [dbo].[IngridientRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientRead]
AS
	SET NOCOUNT ON;
SELECT        Ingridients.*
FROM            Ingridients

GO
/****** Object:  StoredProcedure [dbo].[IngridientUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngridientUpdate]
(
	@IngridientOrdinaryName nvarchar(100),
	@Original_IngridientID int,
	@Original_IngridientOrdinaryName nvarchar(100),
	@Original_Conservant bit,
	@IngridientTyp nvarchar(100),
	@IngridientClass nvarchar(100),
	@IngridientID int
)
AS
	SET NOCOUNT OFF;
UPDATE [Ingridients] SET [IngridientOrdinaryName] = @IngridientOrdinaryName, [IngridientTyp] = @IngridientTyp, [IngridientClass] = @IngridientClass WHERE (([IngridientID] = @Original_IngridientID) AND ([IngridientOrdinaryName] = @Original_IngridientOrdinaryName));
	
SELECT * FROM Ingridients WHERE (IngridientID = @IngridientID)

GO
/****** Object:  StoredProcedure [dbo].[LanguageCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageCreate]
(
	@LanguageShortCode nchar(2),
	@LanguageEnglishName nvarchar(100),
	@LanguageGermanName nvarchar(100)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Languages] ([LanguageShortCode], [LanguageEnglishName], [LanguageGermanName]) VALUES (@LanguageShortCode, @LanguageEnglishName, @LanguageGermanName);
	
SELECT LanguageID, LanguageShortCode, LanguageEnglishName, LanguageGermanName FROM Languages WHERE (LanguageID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[LanguageDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageDelete]
(
	@Original_LanguageID int,
	@Original_LanguageShortCode nchar(2),
	@Original_LanguageEnglishName nvarchar(100),
	@Original_LanguageGermanName nvarchar(100)
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Languages] WHERE (([LanguageID] = @Original_LanguageID) AND ([LanguageShortCode] = @Original_LanguageShortCode) AND ([LanguageEnglishName] = @Original_LanguageEnglishName) AND ([LanguageGermanName] = @Original_LanguageGermanName))

GO
/****** Object:  StoredProcedure [dbo].[LanguageRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageRead]
AS
	SET NOCOUNT ON;
SELECT        Languages.*
FROM            Languages

GO
/****** Object:  StoredProcedure [dbo].[LanguageUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageUpdate]
(
	@LanguageShortCode nchar(2),
	@LanguageEnglishName nvarchar(100),
	@LanguageGermanName nvarchar(100),
	@Original_LanguageID int,
	@Original_LanguageShortCode nchar(2),
	@Original_LanguageEnglishName nvarchar(100),
	@Original_LanguageGermanName nvarchar(100),
	@LanguageID int
)
AS
	SET NOCOUNT OFF;
UPDATE [Languages] SET [LanguageShortCode] = @LanguageShortCode, [LanguageEnglishName] = @LanguageEnglishName, [LanguageGermanName] = @LanguageGermanName WHERE (([LanguageID] = @Original_LanguageID) AND ([LanguageShortCode] = @Original_LanguageShortCode) AND ([LanguageEnglishName] = @Original_LanguageEnglishName) AND ([LanguageGermanName] = @Original_LanguageGermanName));
	
SELECT LanguageID, LanguageShortCode, LanguageEnglishName, LanguageGermanName FROM Languages WHERE (LanguageID = @LanguageID)

GO
/****** Object:  StoredProcedure [dbo].[LocationCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LocationCreate]
(
	@LocationCity nvarchar(100),
	@LocationLocalName nvarchar(10),
	@LocationPostalCode nvarchar(8),
	@LocationStreet nvarchar(200),
	@LocationLocalNumber nchar(10),
	@LocationCountry nvarchar(100)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Locations] ([LocationCity], [LocationLocalName], [LocationPostalCode], [LocationStreet], [LocationLocalNumber], [LocationCountry]) VALUES (@LocationCity, @LocationLocalName, @LocationPostalCode, @LocationStreet, @LocationLocalNumber, @LocationCountry);
	
SELECT LocationID, LocationCity, LocationLocalName, LocationPostalCode, LocationStreet, LocationLocalNumber, LocationCountry FROM Locations WHERE (LocationID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[LocationDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LocationDelete]
(
	@Original_LocationID int,
	@Original_LocationCity nvarchar(100),
	@Original_LocationLocalName nvarchar(10),
	@Original_LocationPostalCode nvarchar(8),
	@Original_LocationStreet nvarchar(200),
	@Original_LocationLocalNumber nchar(10),
	@Original_LocationCountry nvarchar(100)
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Locations] WHERE (([LocationID] = @Original_LocationID) AND ([LocationCity] = @Original_LocationCity) AND ([LocationLocalName] = @Original_LocationLocalName) AND ([LocationPostalCode] = @Original_LocationPostalCode) AND ([LocationStreet] = @Original_LocationStreet) AND ([LocationLocalNumber] = @Original_LocationLocalNumber) AND ([LocationCountry] = @Original_LocationCountry))

GO
/****** Object:  StoredProcedure [dbo].[LocationRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LocationRead]
AS
	SET NOCOUNT ON;
SELECT        Locations.*
FROM            Locations

GO
/****** Object:  StoredProcedure [dbo].[LocationUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LocationUpdate]
(
	@LocationCity nvarchar(100),
	@LocationLocalName nvarchar(10),
	@LocationPostalCode nvarchar(8),
	@LocationStreet nvarchar(200),
	@LocationLocalNumber nchar(10),
	@LocationCountry nvarchar(100),
	@Original_LocationID int,
	@Original_LocationCity nvarchar(100),
	@Original_LocationLocalName nvarchar(10),
	@Original_LocationPostalCode nvarchar(8),
	@Original_LocationStreet nvarchar(200),
	@Original_LocationLocalNumber nchar(10),
	@Original_LocationCountry nvarchar(100),
	@LocationID int
)
AS
	SET NOCOUNT OFF;
UPDATE [Locations] SET [LocationCity] = @LocationCity, [LocationLocalName] = @LocationLocalName, [LocationPostalCode] = @LocationPostalCode, [LocationStreet] = @LocationStreet, [LocationLocalNumber] = @LocationLocalNumber, [LocationCountry] = @LocationCountry WHERE (([LocationID] = @Original_LocationID) AND ([LocationCity] = @Original_LocationCity) AND ([LocationLocalName] = @Original_LocationLocalName) AND ([LocationPostalCode] = @Original_LocationPostalCode) AND ([LocationStreet] = @Original_LocationStreet) AND ([LocationLocalNumber] = @Original_LocationLocalNumber) AND ([LocationCountry] = @Original_LocationCountry));
	
SELECT LocationID, LocationCity, LocationLocalName, LocationPostalCode, LocationStreet, LocationLocalNumber, LocationCountry FROM Locations WHERE (LocationID = @LocationID)

GO
/****** Object:  StoredProcedure [dbo].[ProductCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductCreate]
(
	@ProductOdrinaryName nvarchar(100),
	@ProductCategoryID int,
	@ProductStatus smallint,
	@ProductWeight int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Products] ([ProductOdrinaryName], [ProductCategoryID], [ProductStatus], [ProductWeight]) VALUES (@ProductOdrinaryName, @ProductCategoryID, @ProductStatus, @ProductWeight);
	
SELECT ProductID, ProductOdrinaryName, ProductCategoryID, ProductStatus, ProductWeight FROM Products WHERE (ProductID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[ProductDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductDelete]
(
	@Original_ProductID int,
	@Original_ProductOdrinaryName nvarchar(100),
	@Original_ProductCategoryID int,
	@Original_ProductStatus smallint,
	@Original_ProductWeight int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Products] WHERE (([ProductID] = @Original_ProductID) AND ([ProductOdrinaryName] = @Original_ProductOdrinaryName) AND ([ProductCategoryID] = @Original_ProductCategoryID) AND ([ProductStatus] = @Original_ProductStatus) AND ([ProductWeight] = @Original_ProductWeight))

GO
/****** Object:  StoredProcedure [dbo].[ProductIngridientCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductIngridientCreate]
(
	@ProductID int,
	@IngridientID int,
	@IngridientFeel int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [ProductsIngridients] ([ProductID], [IngridientID], [IngridientFeel]) VALUES (@ProductID, @IngridientID, @IngridientFeel);
	
SELECT ProductIngridientID, ProductID, IngridientID, IngridientFeel FROM ProductsIngridients WHERE (ProductIngridientID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[ProductIngridientDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductIngridientDelete]
(
	@Original_ProductIngridientID int,
	@Original_ProductID int,
	@Original_IngridientID int,
	@Original_IngridientFeel int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [ProductsIngridients] WHERE (([ProductIngridientID] = @Original_ProductIngridientID) AND ([ProductID] = @Original_ProductID) AND ([IngridientID] = @Original_IngridientID) AND ([IngridientFeel] = @Original_IngridientFeel))

GO
/****** Object:  StoredProcedure [dbo].[ProductIngridientRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductIngridientRead]
AS
	SET NOCOUNT ON;
SELECT        ProductsIngridients.*
FROM            ProductsIngridients

GO
/****** Object:  StoredProcedure [dbo].[ProductIngridientUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductIngridientUpdate]
(
	@ProductID int,
	@IngridientID int,
	@IngridientFeel int,
	@Original_ProductIngridientID int,
	@Original_ProductID int,
	@Original_IngridientID int,
	@Original_IngridientFeel int,
	@ProductIngridientID int
)
AS
	SET NOCOUNT OFF;
UPDATE [ProductsIngridients] SET [ProductID] = @ProductID, [IngridientID] = @IngridientID, [IngridientFeel] = @IngridientFeel WHERE (([ProductIngridientID] = @Original_ProductIngridientID) AND ([ProductID] = @Original_ProductID) AND ([IngridientID] = @Original_IngridientID) AND ([IngridientFeel] = @Original_IngridientFeel));
	
SELECT ProductIngridientID, ProductID, IngridientID, IngridientFeel FROM ProductsIngridients WHERE (ProductIngridientID = @ProductIngridientID)

GO
/****** Object:  StoredProcedure [dbo].[ProductLocalCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLocalCreate]
(
	@ProductName nvarchar(100),
	@ProductToolTip nvarchar(600),
	@ProductID int,
	@ProductLanguageID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [ProductsLocals] ([ProductName], [ProductToolTip], [ProductID], [ProductLanguageID]) VALUES (@ProductName, @ProductToolTip, @ProductID, @ProductLanguageID);
	
SELECT ProductLocalID, ProductName, ProductToolTip, ProductID, ProductLanguageID FROM ProductsLocals WHERE (ProductLocalID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[ProductLocalDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLocalDelete]
(
	@Original_ProductLocalID int,
	@Original_ProductName nvarchar(100),
	@Original_ProductToolTip nvarchar(600),
	@Original_ProductID int,
	@Original_ProductLanguageID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [ProductsLocals] WHERE (([ProductLocalID] = @Original_ProductLocalID) AND ([ProductName] = @Original_ProductName) AND ([ProductToolTip] = @Original_ProductToolTip) AND ([ProductID] = @Original_ProductID) AND ([ProductLanguageID] = @Original_ProductLanguageID))

GO
/****** Object:  StoredProcedure [dbo].[ProductLocalRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLocalRead]
AS
	SET NOCOUNT ON;
SELECT        ProductsLocals.*
FROM            ProductsLocals

GO
/****** Object:  StoredProcedure [dbo].[ProductLocalUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLocalUpdate]
(
	@ProductName nvarchar(100),
	@ProductToolTip nvarchar(600),
	@ProductID int,
	@ProductLanguageID int,
	@Original_ProductLocalID int,
	@Original_ProductName nvarchar(100),
	@Original_ProductToolTip nvarchar(600),
	@Original_ProductID int,
	@Original_ProductLanguageID int,
	@ProductLocalID int
)
AS
	SET NOCOUNT OFF;
UPDATE [ProductsLocals] SET [ProductName] = @ProductName, [ProductToolTip] = @ProductToolTip, [ProductID] = @ProductID, [ProductLanguageID] = @ProductLanguageID WHERE (([ProductLocalID] = @Original_ProductLocalID) AND ([ProductName] = @Original_ProductName) AND ([ProductToolTip] = @Original_ProductToolTip) AND ([ProductID] = @Original_ProductID) AND ([ProductLanguageID] = @Original_ProductLanguageID));
	
SELECT ProductLocalID, ProductName, ProductToolTip, ProductID, ProductLanguageID FROM ProductsLocals WHERE (ProductLocalID = @ProductLocalID)

GO
/****** Object:  StoredProcedure [dbo].[ProductLocationCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLocationCreate]
(
	@ProductID int,
	@LocationID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [ProductsLocationsID] ([ProductID], [LocationID]) VALUES (@ProductID, @LocationID);
	
SELECT ProductLocationID, ProductID, LocationID FROM ProductsLocationsID WHERE (ProductLocationID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[ProductLocationDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLocationDelete]
(
	@Original_ProductLocationID int,
	@Original_ProductID int,
	@Original_LocationID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [ProductsLocationsID] WHERE (([ProductLocationID] = @Original_ProductLocationID) AND ([ProductID] = @Original_ProductID) AND ([LocationID] = @Original_LocationID))

GO
/****** Object:  StoredProcedure [dbo].[ProductLocationRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLocationRead]
AS
	SET NOCOUNT ON;
SELECT        ProductsLocationsID.*
FROM            ProductsLocationsID

GO
/****** Object:  StoredProcedure [dbo].[ProductLocationUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLocationUpdate]
(
	@ProductID int,
	@LocationID int,
	@Original_ProductLocationID int,
	@Original_ProductID int,
	@Original_LocationID int,
	@ProductLocationID int
)
AS
	SET NOCOUNT OFF;
UPDATE [ProductsLocationsID] SET [ProductID] = @ProductID, [LocationID] = @LocationID WHERE (([ProductLocationID] = @Original_ProductLocationID) AND ([ProductID] = @Original_ProductID) AND ([LocationID] = @Original_LocationID));
	
SELECT ProductLocationID, ProductID, LocationID FROM ProductsLocationsID WHERE (ProductLocationID = @ProductLocationID)

GO
/****** Object:  StoredProcedure [dbo].[ProductProductCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductProductCreate]
(
	@ProductParentID int,
	@ProductChildID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [ProductProducts] ([ProductParentID], [ProductChildID]) VALUES (@ProductParentID, @ProductChildID);
	
SELECT ProductProductsID, ProductParentID, ProductChildID FROM ProductProducts WHERE (ProductProductsID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[ProductProductDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductProductDelete]
(
	@Original_ProductProductsID int,
	@Original_ProductParentID int,
	@Original_ProductChildID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [ProductProducts] WHERE (([ProductProductsID] = @Original_ProductProductsID) AND ([ProductParentID] = @Original_ProductParentID) AND ([ProductChildID] = @Original_ProductChildID))

GO
/****** Object:  StoredProcedure [dbo].[ProductProductRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductProductRead]
AS
	SET NOCOUNT ON;
SELECT        ProductProducts.*
FROM            ProductProducts

GO
/****** Object:  StoredProcedure [dbo].[ProductProductUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductProductUpdate]
(
	@ProductParentID int,
	@ProductChildID int,
	@Original_ProductProductsID int,
	@Original_ProductParentID int,
	@Original_ProductChildID int,
	@ProductProductsID int
)
AS
	SET NOCOUNT OFF;
UPDATE [ProductProducts] SET [ProductParentID] = @ProductParentID, [ProductChildID] = @ProductChildID WHERE (([ProductProductsID] = @Original_ProductProductsID) AND ([ProductParentID] = @Original_ProductParentID) AND ([ProductChildID] = @Original_ProductChildID));
	
SELECT ProductProductsID, ProductParentID, ProductChildID FROM ProductProducts WHERE (ProductProductsID = @ProductProductsID)

GO
/****** Object:  StoredProcedure [dbo].[ProductRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductRead]
AS
	SET NOCOUNT ON;
SELECT        Products.*
FROM            Products

GO
/****** Object:  StoredProcedure [dbo].[ProductSymbolCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductSymbolCreate]
(
	@ProductID int,
	@SymbolID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [ProductsSymbols] ([ProductID], [SymbolID]) VALUES (@ProductID, @SymbolID);
	
SELECT ProductSymbolID, ProductID, SymbolID FROM ProductsSymbols WHERE (ProductSymbolID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[ProductSymbolDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductSymbolDelete]
(
	@Original_ProductSymbolID int,
	@Original_ProductID int,
	@Original_SymbolID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [ProductsSymbols] WHERE (([ProductSymbolID] = @Original_ProductSymbolID) AND ([ProductID] = @Original_ProductID) AND ([SymbolID] = @Original_SymbolID))

GO
/****** Object:  StoredProcedure [dbo].[ProductSymbolRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductSymbolRead]
AS
	SET NOCOUNT ON;
SELECT        ProductsSymbols.*
FROM            ProductsSymbols

GO
/****** Object:  StoredProcedure [dbo].[ProductSymbolUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductSymbolUpdate]
(
	@ProductID int,
	@SymbolID int,
	@Original_ProductSymbolID int,
	@Original_ProductID int,
	@Original_SymbolID int,
	@ProductSymbolID int
)
AS
	SET NOCOUNT OFF;
UPDATE [ProductsSymbols] SET [ProductID] = @ProductID, [SymbolID] = @SymbolID WHERE (([ProductSymbolID] = @Original_ProductSymbolID) AND ([ProductID] = @Original_ProductID) AND ([SymbolID] = @Original_SymbolID));
	
SELECT ProductSymbolID, ProductID, SymbolID FROM ProductsSymbols WHERE (ProductSymbolID = @ProductSymbolID)

GO
/****** Object:  StoredProcedure [dbo].[ProductUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductUpdate]
(
	@ProductOdrinaryName nvarchar(100),
	@ProductCategoryID int,
	@ProductStatus smallint,
	@ProductWeight int,
	@Original_ProductID int,
	@Original_ProductOdrinaryName nvarchar(100),
	@Original_ProductCategoryID int,
	@Original_ProductStatus smallint,
	@Original_ProductWeight int,
	@ProductID int
)
AS
	SET NOCOUNT OFF;
UPDATE [Products] SET [ProductOdrinaryName] = @ProductOdrinaryName, [ProductCategoryID] = @ProductCategoryID, [ProductStatus] = @ProductStatus, [ProductWeight] = @ProductWeight WHERE (([ProductID] = @Original_ProductID) AND ([ProductOdrinaryName] = @Original_ProductOdrinaryName) AND ([ProductCategoryID] = @Original_ProductCategoryID) AND ([ProductStatus] = @Original_ProductStatus) AND ([ProductWeight] = @Original_ProductWeight));
	
SELECT ProductID, ProductOdrinaryName, ProductCategoryID, ProductStatus, ProductWeight FROM Products WHERE (ProductID = @ProductID)

GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	



GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	



GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	



GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	



GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	



GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	



GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	



GO
/****** Object:  StoredProcedure [dbo].[SymbolCreate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SymbolCreate]
(
	@SymbolImage image,
	@SymbolArt smallint
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Symbols] ([SymbolImage], [SymbolArt]) VALUES (@SymbolImage, @SymbolArt);
	
SELECT SymbolID, SymbolImage, SymbolArt FROM Symbols WHERE (SymbolID = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[SymbolDelete]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SymbolDelete]
(
	@Original_SymbolID int,
	@Original_SymbolArt smallint
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Symbols] WHERE (([SymbolID] = @Original_SymbolID) AND ([SymbolArt] = @Original_SymbolArt))

GO
/****** Object:  StoredProcedure [dbo].[SymbolRead]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SymbolRead]
AS
	SET NOCOUNT ON;
SELECT        Symbols.*
FROM            Symbols

GO
/****** Object:  StoredProcedure [dbo].[SymbolUpdate]    Script Date: 27.08.2016 12:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SymbolUpdate]
(
	@SymbolImage image,
	@SymbolArt smallint,
	@Original_SymbolID int,
	@Original_SymbolArt smallint,
	@SymbolID int
)
AS
	SET NOCOUNT OFF;
UPDATE [Symbols] SET [SymbolImage] = @SymbolImage, [SymbolArt] = @SymbolArt WHERE (([SymbolID] = @Original_SymbolID) AND ([SymbolArt] = @Original_SymbolArt));
	
SELECT SymbolID, SymbolImage, SymbolArt FROM Symbols WHERE (SymbolID = @SymbolID)

GO
