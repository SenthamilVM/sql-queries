--Retrieve all customer data
USE MyDatabase
SELECT * 
FROM customers

--Retrieve all order data
USE MyDatabase
SELECT *
FROM orders

--Retrieve each customer's name, country and score
USE MyDatabase
SELECT 
	first_name
	,country
	,score
FROM customers

--FILTER DATA
--Retrieve customers with a score not equal to 0
SELECT *
FROM customers
WHERE score != 0;

--Retrieve customers from Germany
SELECT
	first_name
	,country
FROM customers
WHERE country = 'Germany';


--ORDER BY
/*Retrieve all the customers and sort the 
results by the highest score first*/
SELECT *
FROM customers
ORDER BY score DESC;

/*Retrieve all the customers and sort the 
results by the lowest score first*/
SELECT *
FROM customers
ORDER BY score ASC;

--Nested Sorting (Nested Order By)
--Task
/*Retrieve all customers and sort the results by the country 
and then by the highest score*/
SELECT *
FROM customers
ORDER BY country ASC, score DESC;

--Group By -- Aggregate your data
--Task -- Find the total score for each country
SELECT 
	country,
	first_name,
	SUM(score) as TotalScore
FROM customers
GROUP BY country, first_name;

--Find the total score and total number of customers for each country
SELECT
	country,
	SUM(score) AS [Total Score],
	COUNT(id) AS [Total Customers]
FROM customers
GROUP BY country;

--HAVING -- Filter aggregated data
SELECT 
	country
	,SUM(score) as TotalScore
FROM customers
GROUP BY country
HAVING SUM(score) > 800;

--Using Where(before aggregation) and Having(after aggregation)
SELECT 
country, SUM(score) as TotalScore
FROM customers
WHERE score > 400
GROUP BY country
HAVING SUM(score) > 800

/*Task-- Find the average score for each country
considering only customer with a score not equal to 0
And return only those countries with an average score greater than 430*/

SELECT country, AVG(score) as "Average Score"
FROM customers
WHERE score !=0
GROUP BY country
HAVING AVG(score) > 430;

--DISTINCT (DO NOT use DISTINCT unless it's necessary. It can slow down your query)
--Return unique list of all countries
SELECT DISTINCT country
FROM customers;

--TOP
--Retrieve only 3 customers
SELECT TOP 3 *
FROM customers

--Retrieve the Top 3 customers with the Highest scores
SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

--Retrieve the Lowest 2 Customers based on the Score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

--Get the two most recent orders
SELECT TOP 2 * 
FROM orders
ORDER BY order_date DESC;

--Static (Fixed) values
SELECT 123 "Static Number"
SELECT 'Hello World' AS "static string"

--Combining data from table and manual data
SELECT 
id, 
first_name, 
'New Customer' As customer_type
FROM customers;
