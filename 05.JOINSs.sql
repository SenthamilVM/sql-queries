/*Basic Joins
1.NO JOIN
2.INNER JOIN
3.LEFT JOIN
4.RIGHT JOIN
5.FULL JOIN
*/

--1.NO Join
/* Retrieve all data from customers and orders
in two different results */

SELECT *
FROM customers;

SELECT *
FROM orders;

--2.INNER JOIN
--Returns only matching rows from both tables
--Order doesn't matter in Inner join

/* Get all customers along with their orders, 
but only for customers who have placed an order*/

SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id;

/*----------------------------------------------------------*/

--3.LEFT JOIN
--Returns All rows from left and only matching rows from right.
--Order of tables is important
--NULL will be returned for non matching rows

/*Get all customers along with their orders, 
including those without orders */

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id;

/*----------------------------------------------------------*/

--4.RIGHT JOIN
--Returns All rows from Right table and only matching rows from left table.
--Order of tables is important

/*Get all customers along with their orders,
including orders without matching customers*/

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id;

--Same task can be performed using LEFT JOIN as well
SELECT 
	o.order_id,
	o.sales,
	c.id,
	c.first_name
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.id;

/*----------------------------------------------------------*/
--5.FULL JOIN
--Returns All rows from both tables.
--Order of tables doesn't matter

/*Get all customers and all orders, even if there's no match */

SELECT 
	c.id,
	c.first_name,
	o.customer_id,
	o.sales
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id;

/*----------------------------------------------------------*/
/*Advanced Joins
1.LEFT ANTI JOIN
2.RIGHT ANTI JOIN
3.FULL ANTI JOIN
4.CROSS JOIN
*/

--1.LEFT ANTI JOIN
--Returns rows from Left that has NO MATCH in right
--Order of tables is important
--There is no specific left anti join in SQL. This can be achieved as follows.

/*Get all customers who haven't placed any order*/
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

/*----------------------------------------------------------*/

--2.RIGHT ANTI JOIN
--Returns rows from right thtat has NO MATCH in Left
--Order of tables is important
--There is no specific right anti join in SQL. This can be achieved as follows.

/*Get all orders without matching customers*/
SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL;

/*Solve the above task using LEFT JOIN*/
SELECT *
FROM orders o
LEFT JOIN customers c
ON c.id = o.customer_id
WHERE c.id IS NULL;

/*----------------------------------------------------------*/
--3.FULL ANTI JOIN
--Returns only rows that DON"T MATCH in either tables
--Order of tables is DOES'T MATTER

/*Find customers without orders and orders without customers*/

SELECT *
FROM orders o 
FULL JOIN customers c
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;

/*Get all customers along with their orders, but only for customers
who have placed an order (Without Using INNER JOIN)*/

SELECT *
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NOT NULL AND o.customer_id IS NOT NULL;

--This above solution can be achieved as below.
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;

/*----------------------------------------------------------*/
--4.CROSS JOIN
--Combines Every Row from Left with Every Row from Right. All possible Combinations - Cartesian JOIN
--The order of the tables DOESN'T MATTER
--NO CONDITION needed


/*Generate all possible combinations of customers and orders*/
SELECT *
FROM customers
CROSS JOIN orders

--NOTE: This can be used in some scenarios. For eg. Table Product, Table Color. If I want to see all combinations for all the products and colors.

/*----------------------------------------------------------*/
--Advanced Join Types
--Multi-Table JOIN

/*Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, and employment details. For each order, display:
Order ID, Customer's name, Product name, Sales, Price, Sales person's name*/
USE SalesDB;

--Check the data from the related tables
SELECT TOP 10 * FROM Sales.Orders;
SELECT TOP 10 * FROM Sales.Customers;
SELECT TOP 10 * FROM Sales.Products;
SELECT TOP 10 * FROM Sales.Employees;

SELECT 
	o.OrderID,
	o.Sales,
	c.FirstName AS [Customer FName],
	c.LastName AS [Customer LName],
	--c.FirstName + ' ' + c.LastName AS [Customer Name], --This is giving NULL if the lastname or firstname is NULL
	p.Product AS [Product Name],
	p.Price,
	--e.FirstName + ' ' + e.LastName AS [Sales Person's Name] --This is giving NULL if the lastname or firstname is NULL
FROM Sales.Orders o
LEFT JOIN Sales.Customers c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees e
ON o.SalesPersonID = e.EmployeeID


