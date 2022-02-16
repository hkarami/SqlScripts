IF (OBJECT_ID('StringToTable') > 0)
    DROP FUNCTION StringToTable
GO
CREATE FUNCTION dbo.StringToTable
(
	@String               VARCHAR(MAX),
	@Delimiter            CHAR(1),
	@IgnoreDuplicates     BIT
)
RETURNS @Result TABLE 
(
	ItemIndex     INT,
	ItemValue     INT
)
AS
BEGIN
	DECLARE @idx           INT = 1,
	        @ItemValue     INT,
	        @ItemIndex     INT = 0
	
	IF ((LEN(@String) < 1) OR (@String IS NULL))
	    RETURN     
	
	WHILE @idx != 0
	BEGIN
	    SET @idx = CHARINDEX(@Delimiter, @String)     
	    IF (@idx != 0)
	        SET @ItemValue = LEFT(@String, @idx - 1)
	    ELSE
	        SET @ItemValue = @String
	    
	    IF (LEN(@ItemValue) > 0)
	    BEGIN
			SET @ItemIndex = @ItemIndex + 1
			
	        INSERT INTO @Result(ItemIndex, ItemValue)
	        SELECT @ItemIndex,
				   @ItemValue
	        WHERE  (@IgnoreDuplicates = 0)
	               OR  (
	                       @IgnoreDuplicates = 1
	                       AND NOT EXISTS(
	                               SELECT 1
	                               FROM   @Result
	                               WHERE  ItemValue = @ItemValue
	                           )
	                   )
		END     
	    
	    SET @String = RIGHT(@String, LEN(@String) - @idx)     
	    IF LEN(@String) = 0
	        BREAK
	END 
	RETURN
END
GO
