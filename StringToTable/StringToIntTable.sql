IF (OBJECT_ID('StringToIntTable') > 0)
    DROP FUNCTION StringToIntTable
GO
CREATE FUNCTION dbo.StringToIntTable
(
	@String               VARCHAR(MAX),
	@Delimiter            CHAR(1),
	@IgnoreDuplicates     BIT
)
RETURNS TABLE
AS
	RETURN 
	SELECT stt.ItemIndex,
	       CAST(stt.ItemValue AS INT) AS ItemValue
	FROM   Dbo.StringToTable(@String, @Delimiter, @IgnoreDuplicates) stt
GO