/*
SET Operators
1.UNION
2.UNION ALL
3.EXCEPT(Minus)
4.INTERSECT
*/

/*
RULES OF SET OPERATORS
#1 RULE | ORDER BY can be used only once
#2 RULE | Same Number of Columns
#3 RULE | Matching Data Types
#4 RULE | Same Order of Columns
#5 RULE | First Query Controls Aliases
#6 RULE | Mapping Correct Columns
*/
--1.UNION
--Returns all distinct rows from both the queries
--Removes duplicates rows from the result
--Order of queries in a UNION operation does not affect the result

--Task: Combine the data from employees and customers into one table
SELECT
	FirstName,
	LastName
FROM Sales.Customers
UNION
SELECT
	FirstName,
	LastName
FROM Sales.Employees;

/*-------------------------------------------------------------------------*/
--2.UNION ALL
--Returns all rows from both queries, INCLUDING DUPLICATES

/*UNION ALL vs UNION
--UNION ALL is generally FASTER than UNION
--If you are confident that there are no duplicates, use UNION ALL
--Use UNION ALL to find duplicates and quality issues
*/

--Task: Combine the data from employees and customers into one table, including duplicates
SELECT
FirstName,
LastName
FROM Sales.Customers
UNION ALL
SELECT
FirstName,
LastName
FROM Sales.Employees;


/*-------------------------------------------------------------------------*/
--3.EXCEPT (Minus in some other DBs)
--Returns all distinct rows from the first query that are not found in the second query
--It is the only one where the order of queries affects the final result

--Task: Find the employees who are not customers at the same time
SELECT
	FirstName,
	LastName
FROM Sales.Employees
EXCEPT
SELECT
	FirstName,
	LastName
FROM Sales.Customers;

/*NOTE: Order of the queries here is very important as we need employees who are not customers 
and NOT customers who are not employees. Hence Employee table should come first here*/


/*-------------------------------------------------------------------------*/
--INTERSECT
--Returns only the rows that are common in both queries
--Order of the queries DOESN'T MATTER

--Task: Find the employees, who are also customers
SELECT
	FirstName,
	LastName
FROM Sales.Employees
INTERSECT
SELECT
	FirstName,
	LastName
FROM Sales.Customers;

/* --Orders data are stored in separate tables (Orders and OrdersArchive)
--Combine all orders data into one report without duplicates
*/

SELECT * FROM Sales.Orders
UNION
SELECT * FROM Sales.OrdersArchive

--Best Practice: Never use an asterisk (*) to combine tables; list required columns instead.
SELECT
	'Orders' AS SourceTable -- Added this static column to know this data is coming from which table after combining the data
	,[OrderID]
	,[ProductID]
	,[CustomerID]
	,[SalesPersonID]
	,[OrderDate]
	,[ShipDate]
	,[OrderStatus]
	,[ShipAddress]
	,[BillAddress]
	,[Quantity]
	,[Sales]
	,[CreationTime]
FROM Sales.Orders
UNION
SELECT
	'Orders Archive' AS SourceTable -- Added this static column to know this data is coming from which table after combining the data
	,[OrderID]
	,[ProductID]
	,[CustomerID]
	,[SalesPersonID]
	,[OrderDate]
	,[ShipDate]
	,[OrderStatus]
	,[ShipAddress]
	,[BillAddress]
	,[Quantity]
	,[Sales]
	,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID;

--Use case for EXCEPT
--1.Delta Detection -- To find out the new data loaded data in the pipeline from source to Datawarehouse/lakehouse
--2.Data Completeness Check:
--EXCEPT operator can be used to compare tables to detect discrepancies between databases.