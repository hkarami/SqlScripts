IF (OBJECT_ID('StringToTable_SampleData') > 0)
    DROP TABLE StringToTable_SampleData
GO
CREATE TABLE StringToTable_SampleData
(
	Id              INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	ProductId       INT NOT NULL,
	ProductName     NVARCHAR(100)
)
GO
INSERT INTO StringToTable_SampleData(ProductId, ProductName)
       VALUES
       (10, N'Product 10'),
	   (20, N'Product 20'),
	   (30, N'Product 30'),
	   (50, N'Product 50'),
	   (60, N'Product 60'),
	   (70, N'Product 70'),
	   (80, N'Product 80')
GO
DECLARE @InValues NVARCHAR(MAX) = '70,10,60,20,10'

SELECT ProductId,
       ProductName
FROM   StringToTable_SampleData
       CROSS APPLY (
			SELECT *
			FROM   dbo.StringToIntTable(@InValues, ',', 1) sp
			WHERE  sp.ItemValue = ProductId
		) AS O
ORDER BY
       o.ItemIndex