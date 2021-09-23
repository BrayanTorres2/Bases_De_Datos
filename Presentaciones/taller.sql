--1
select  FirstName,LastName from [Person].[Person] where FirstName='Mark'
--2
select count(*) as 'Numero de filas' from [Person].[Person]
--3
select top(100)* from [Production].[Product] where ListPrice <> 0
--4
select * from [HumanResources].[vEmployee] where LastName like '[a-d]%' 
--5
select Name,avg(StandardCost) from Production.Product where StandardCost>0 GROUP BY Name
--6
select PersonType, count(*) from Person.Person group by PersonType
--7
select * from Person.StateProvince where CountryRegionCode='CA' 
--8
select color, count(*) as Productos from [Production].[Product] where Color = 'black' OR Color = 'red' group by Color
--9.	¿Cuál es el valor promedio de Freight por cada venta? 
SELECT TerritoryID,SalesOrderID, AVG(Freight) AS Promedio  FROM [Sales].[SalesOrderHeader] GROUP BY TerritoryID,SalesOrderID
--(Sales.SalesOrderHeader) donde la venta se dio en el TerriotryID 4?
SELECT TerritoryID,SalesOrderID, AVG(Freight) AS Promedio FROM [Sales].[SalesOrderHeader] where TerritoryID=4 GROUP BY TerritoryID,SalesOrderID
--10
select * from Sales.vIndividualCustomer WHERE (LastName = 'Lopez' OR LastName = 'Martin' OR LastName = 'Wood') AND (FirstName LIKE '[c-l]%')
--11
SELECT FirstName as PrimerNombre, LastName as Apellido FROM [Sales].[vIndividualCustomer] WHERE LastName = 'Smith'
--12
SELECT *  FROM [Sales].[vIndividualCustomer] WHERE (CountryRegionName = 'Australia') OR (PhoneNumberType='Cell' AND EmailPromotion = 0)
--13
select max(ListPrice) as 'precio más caro'from Production.Product
--14
SELECT [TerritoryID], SUM(TotalDue) AS Ventas FROM [Sales].[SalesOrderHeader] GROUP BY TerritoryID HAVING SUM(TotalDue) >= 10000000
--15
SELECT S.Name, SUM(O.TotalDue) AS Ventas
  FROM [Sales].[SalesOrderHeader] as O
  JOIN [Sales].[SalesTerritory] as S
  ON S.TerritoryID = O.TerritoryID
  GROUP BY S.Name
  HAVING SUM(TotalDue) >= 10000000
--16
--primera
SELECT *
  FROM [HumanResources].[vEmployeeDepartment]
  WHERE Department = 'Executive' OR Department = 'Tool Design' OR Department = 'Engineering'
--segunda  
SELECT *
  FROM [HumanResources].[vEmployeeDepartment]
  WHERE Department LIKE 'Executive' OR Department LIKE 'Engineering' OR Department LIKE 'Tool Design'
--17
--primera
SELECT *
  FROM [HumanResources].[vEmployeeDepartment]
  WHERE StartDate BETWEEN '2000-07-01' AND '2002-06-30'
--segunda  
SELECT *
  FROM [HumanResources].[vEmployeeDepartment]
  WHERE StartDate >= '2000-07-01' AND StartDate <= '2002-06-30'
--18
SELECT *
  FROM [Sales].[SalesOrderHeader]
  WHERE SalesPersonID >= 0
--19
SELECT COUNT(*) AS NotNULL
  FROM [Person].[Person]
  WHERE MiddleName IS NOT NULL
--20
SELECT SalesPersonID, TotalDue
  FROM [Sales].[SalesOrderHeader]
  WHERE SalesPersonID IS NOT NULL AND TotalDue > 70000
--21
  SELECT *
  FROM [Sales].[vIndividualCustomer]
  WHERE LastName LIKE '[R]%'
 --22
 SELECT *
  FROM [Sales].[vIndividualCustomer]
  WHERE LastName LIKE '%r'
--23
SELECT Color, COUNT(*) AS Productos
  FROM [Production].[Product]
  WHERE COLOR IS NOT NULL
  GROUP BY color
  HAVING COUNT(Color) >=20
 --24
 SELECT SUM(i.Quantity * p.ListPrice) AS Ganancia
  FROM [Production].[Product] as p
  JOIN [Production].[ProductInventory] as i
  ON p.ProductID = i.ProductID
  WHERE p.ListPrice > 0
--25
SELECT [FirstName], [LastName], EmailPromotion =
	CASE
		WHEN EmailPromotion = 0 then 'Promo 1'
		WHEN EmailPromotion = 1 then 'Promo 2'
		WHEN EmailPromotion = 2 then 'Promo 3'
	END
  FROM [Person].[Person]
--26
SELECT t.Name, p.[BusinessEntityID], p.[SalesYTD]
  FROM [Sales].[SalesPerson] as p
  LEFT JOIN [Sales].[SalesTerritory] as t
  ON p.TerritoryID = t.TerritoryID
--27
SELECT pe.FirstName,pe.LastName,t.Name, p.[BusinessEntityID], p.[SalesYTD]
  FROM [Sales].[SalesPerson] as p
  LEFT JOIN [Sales].[SalesTerritory] as t
  ON p.TerritoryID = t.TerritoryID
  JOIN Person.Person as pe
  ON p.BusinessEntityID = pe.BusinessEntityID
  WHERE t.Name = 'Northeast' or t.Name = 'Central'
  --28
  SELECT p.FirstName, p.LastName, pa.PasswordHash
  FROM [Person].[Person] as p
  JOIN Person.Password as pa
  ON p.BusinessEntityID = pa.BusinessEntityID
--29
SELECT FirstName,title =
	CASE
		WHEN Title IS NULL then 'No hay titulo'
		WHEN Title IS NOT NULL then Title
	END
  FROM [Person].[Person]
--30
SELECT FirstName,MiddleName =
	CASE
		WHEN MiddleName IS NULL then CONCAT(FirstName, ' ', LastName)
		WHEN MiddleName IS NOT NULL then CONCAT(FirstName, ' ', MiddleName, ' ', LastName)
	END
  FROM [Person].[Person]
--31
SELECT [ProductID], MakeFlag =
	CASE
		WHEN MakeFlag = FinishedGoodsFlag then NULL
		WHEN NOT MakeFlag = FinishedGoodsFlag then 'Iguales'
	END
  FROM [Production].[Product]
--32
SELECT [ProductID], Color =
	CASE
		WHEN Color IS NOT NULL then Color
		WHEN Color IS NULL then 'Sin color'
	END
  FROM [Production].[Product]
SELECT ProductID, ISNULL(Color, 'Sin color')
  FROM [Production].[Product]


 
