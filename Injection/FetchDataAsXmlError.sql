IF (OBJECT_ID('Injection_SampleData') > 0)
    DROP TABLE Injection_SampleData
GO
CREATE TABLE Injection_SampleData
(
	Id          INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	[NAME]      NVARCHAR(100),
	RegDate     DATETIME DEFAULT(GETDATE())
)
GO
INSERT INTO Injection_SampleData([NAME])
       VALUES
       ('A1'),
	   ('A2'),
	   ('A3'),
	   ('B1'),
	   ('B2'),
	   ('B3'),
	   ('C1'),
	   ('C2'),
	   ('C3')
GO
DECLARE @xml NVARCHAR(MAX) = ''
SET @xml = ISNULL(
        (
            SELECT /*TOP 50*/     
				   Id,
                   [NAME]
            FROM   Injection_SampleData
            WHERE  [NAME]     LIKE 'A1%'
            ORDER BY
                   RegDate DESC FOR XML AUTO
        ),
        'NoData'
    )

RAISERROR (@xml, 18, 3, @xml); 
