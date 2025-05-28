--select * from [Person].[Address]
--select * from [HumanResources].[Department]
--select * from [Sales].[Customer]
--select * from [Person].[Person]

--Section 1: Beginner Level Tasks 

--Task 1: List All Employees and Their Job Titles 
SELECT p.firstname, p.lastname,H.jobTitle 
FROM [Person].[Person] as P
inner join [HumanResources].[Employee] as H on P.BusinessEntityID = H.BusinessEntityID


--Task 2: Display All Products and Their List Prices 

SELECT productID, Name, ListPrice 
FROM [Production].[Product]
order by ListPrice desc




--Task 3: Retrieve Customers Who Placed Orders in 2014

SELECT c.CustomerID, p.FirstName, p.LastName, SOH.SalesOrderID, SOH.OrderDate, SOH.TotalDue
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
INNER JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE YEAR(soh.OrderDate) = 2014;


--Task 4: List the Top 10 Most Expensive Products 
SELECT top 10 ProductID, Name, ProductNumber, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC 


--Task 5: Show the Total Number of Orders Placed in 2012
SELECT COUNT(SalesOrderID) as Total_Orders
FROM [Sales].[SalesOrderHeader]
where year(orderdate) = 2012;

-- Task 6: List Sales Orders with TotalDue Greater Than $1,500 

SELECT  CustomerID, SalesOrderID, OrderDate, DueDate,  TotalDue
FROM [Sales].[SalesOrderHeader]
where (TotalDue) > 1500;

-- Task 7: Retrieve Products with ListPrice Between $100 and $500

SELECT ProductID, Name, ProductNumber, ListPrice
FROM [Production].[Product]
where (ListPrice) BETWEEN 100 AND 500;


--Task 8: Retrieve Customers from a Specific Region (e.g., "United States") 
SELECT c.CustomerID,  p.FirstName, p.LastName, a.AddressLine1,
		A.City, a.StateProvinceID, a.PostalCode,  SP.CountryRegionCode
FROM Sales.Customer AS C
JOIN Person.Person AS P ON c.PersonID = p.BusinessEntityID
JOIN Person.Address AS A ON c.CustomerID = a.AddressID
JOIN Person.StateProvince AS SP ON SP.StateProvinceID = A.StateProvinceID
WHERE  sp.CountryRegionCode = 'US'






--Section 2: Intermediate Level Tasks
--Task 9: Calculate Total Sales Amount for Each Year from 2011 to 2014

SELECT	YEAR(OrderDate) as SalesYear,
		Sum(TotalDue) as TotalSales
FROM [Sales].[SalesOrderHeader]
where YEAR(OrderDate) Between 2011 and 2014
GROUP BY YEAR(OrderDate)
Order BY  SalesYear asc




--Task 10: Display Number of Orders Placed by Each Customer

SELECT  COUNT(SOH.SalesOrderID) AS OrderCount, c.CustomerID, p.FirstName, p.LastName
FROM Sales.SalesOrderHeader AS SOH
JOIN Sales.Customer AS C ON SOH.CustomerID = c.CustomerID
JOIN Person.Person AS P ON c.PersonID = p.BusinessEntityID
GROUP BY  c.CustomerID,  p.FirstName, p.LastName
ORDER BY OrderCount DESC;


--Task 11: List Products That Have Never Been Sold

SELECT P.ProductID, P.Name, P.ProductNumber, P.ListPrice
FROM Production.Product AS P
LEFT JOIN  Sales.SalesOrderDetail AS SOD ON P.ProductID = SOD.ProductID
WHERE SOD.SalesOrderID IS NULL;




--Task 12: Find Total Number of Employees with the Title "Sales Representative" 

SELECT COUNT(JobTitle) as TotalEmployee, JobTitle
FROM [HumanResources].[Employee]
where JobTitle = 'Sales Representative'
Group by JobTitle





--Task 13: Retrieve Average ListPrice for All Products in the "Bikes" Category

SELECT avg(ListPrice) as AVGBikePrice, Pc.Name
from [Production].[Product] as P
Join [Production].[ProductSubcategory] as PS on p.ProductSubcategoryID = PS.ProductSubcategoryID
Join [Production].[ProductCategory] as PC on PS.ProductCategoryID = PC.ProductCategoryID
where PC.Name = 'bikes'
group by Pc.Name


--Task 14: List Top 5 Customers Based on Total Order Amount 

SELECT Top 5 SUM(SOH.TotalDue) AS TotalOrder, C.CustomerID,  P.FirstName,  P.LastName
FROM Sales.SalesOrderHeader AS SOH
JOIN Sales.Customer AS C ON soh.CustomerID = C.CustomerID
JOIN Person.Person AS P ON c.PersonID = P.BusinessEntityID
GROUP BY C.CustomerID, P.FirstName, P.LastName
ORDER BY TotalOrder DESC

--Task 15: Display All Products Sold More Than 50 Times in 2023 

SELECT COUNT(SOD.SalesOrderID) AS TotalSales, p.ProductID, p.Name 
FROM  Production.Product AS p
JOIN  Sales.SalesOrderDetail AS SOD ON p.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader AS SOH ON sod.SalesOrderID = soh.SalesOrderID
WHERE YEAR(soh.OrderDate) = 2012
GROUP BY  p.ProductID, p.Name
HAVING  COUNT(sod.SalesOrderID) > 50  
ORDER BY TotalSales DESC;




--SELECT * from  [Production].[Product]
--SELECT * from  [Production].[ProductSubcategory]
--SELECT * from [Production].[ProductCategory]


--select * from Person.StateProvince
--select * from  Person.Address
--select * from Sales.Customer


--SELECT * from  [Person].[StateProvince]
--SELECT * from   [Person].[CountryRegion]
--SELECT * from  [Person].[Address]
--SELECT * from [Person].[Person]
--SELECT * from  [Sales].[Customer]