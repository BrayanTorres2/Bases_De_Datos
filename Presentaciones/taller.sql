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
