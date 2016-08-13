USE [InhaltsstoffeLocal]
GO
/****** Object:  StoredProcedure [dbo].[AddAllergen]    Script Date: 12.08.2016 19:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddAllergen]
(
  @AllergenOrdinaryName nvarchar(100),
  @AllergenId int OUTPUT
)
AS
BEGIN TRY
	BEGIN TRANSACTION
    --IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName=@CategoryName)
    --BEGIN
    --    INSERT INTO dbo.Categories (CategoryName) VALUES (@CategoryName);
    --END

    --DECLARE @CatID int
    --SET @CatID = (SELECT CategoryID FROM dbo.Categories WHERE CategoryName=@CategoryName);
    INSERT dbo.Allergens(AllergenOrdinaryName) 
    VALUES (@AllergenOrdinaryName);
    COMMIT TRANSACTION
    SET @AllergenId = SCOPE_IDENTITY();
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
    ROLLBACK
    -- Raise an error with the details of the exception
	DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
	SELECT @ErrMsg = ERROR_MESSAGE(),
           @ErrSeverity = ERROR_SEVERITY()
	RAISERROR(@ErrMsg, @ErrSeverity, 1)
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[DeleteAllergen]    Script Date: 12.08.2016 19:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAllergen]
(
  @AllergenID int
 )
AS
BEGIN TRY
    BEGIN TRANSACTION
	--DECLARE @CatId int
	--SET @CatId = (SELECT CategoryID FROM Products WHERE @ProductId=ProductId);
	--IF @CatId IS NOT NULL
	    BEGIN
			DELETE FROM dbo.Allergens WHERE AllergenID = @AllergenID;
			--IF (SELECT COUNT(*) FROM dbo.Products WHERE CategoryID = @CatId) = 0
			--	DELETE FROM dbo.Categories WHERE CategoryID = @CatId;
	    END
	COMMIT	    
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
    ROLLBACK
	DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
	SELECT @ErrMsg = ERROR_MESSAGE(),
           @ErrSeverity = ERROR_SEVERITY()
	RAISERROR(@ErrMsg, @ErrSeverity, 1)
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[UpdateAllergen]    Script Date: 12.08.2016 19:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAllergen]
(
  @AllergenOrdinaryName nvarchar(100),
  @AllergenID int
)
AS
BEGIN TRY
	BEGIN TRANSACTION
    --IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName=@CategoryName)
    --BEGIN
    --    INSERT INTO dbo.Categories (CategoryName) VALUES (@CategoryName)
    --END
    UPDATE dbo.Allergens
    SET AllergenOrdinaryName=@AllergenOrdinaryName
	WHERE AllergenID=@AllergenID
	COMMIT TRANSACTION    
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
		ROLLBACK
END CATCH

GO
