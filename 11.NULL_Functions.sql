/*WHAT IS NULL?
NULL means nothing, unknown!
NULL is not equal to anything.
-NULL is not zero
-NULL is not empty string
-NULL is not blank space
*/

--NULL Function: ISNULL -- Replaces 'NULL' with a specified value
--Syntax:ISNULL(value, replacement_value)
--Eg.ISNULL(Shipping_address, 'unknown')
--Eg.ISNULL(Shipping_address, Billing_address)

--COALESCE(): Returns the first non-null value from a list
--Syntax:COALESCE(value1, value2, value3,..)
--Eg.COALESCE(ShippingAddress, BillingAddress, 'N/A') -- Here, we can use multiple values unlike ISNULL

/*ISNULL vs COALESCE

     ISNULL			     |	    COALESCE
						 |
 Limited to two values   |		Unlimited
-------------------------|---------------------------------- 
 Fast				     |		Slow
-------------------------|---------------------------------- 
 SQL server -> ISNULL    | 
 Oracle -> NVL		     |		Available in All Databases
 MySQL -> IFNULL		 |

*/

/* ==============================================================================
   SQL NULL Functions
-------------------------------------------------------------------------------
   This script highlights essential SQL functions for managing NULL values.
   It demonstrates how to handle NULLs in data aggregation, mathematical operations,
   sorting, and comparisons. These techniques help maintain data integrity 
   and ensure accurate query results.

   Table of Contents:
     1. Handle NULL - Data Aggregation
     2. Handle NULL - Mathematical Operators
     3. Handle NULL - Sorting Data
     4. NULLIF - Division by Zero
     5. IS NULL - IS NOT NULL
     6. LEFT ANTI JOIN
     7. NULLs vs Empty String vs Blank Spaces
===============================================================================
*/

/* ==============================================================================
   HANDLE NULL - DATA AGGREGATION
===============================================================================*/
--Handle the NULL before doing data aggregations -- NULLS will be ignored by default by SQL while doing aggregations.
/* TASK 1: 
   Find the average scores of the customers.
   Uses COALESCE to replace NULL Score with 0.
*/
SELECT
CustomerID
,Score
,COALESCE(Score,0) As ScoreWithoutNull
,AVG(Score) OVER() AS AvgScore
,AVG(COALESCE(Score,0)) OVER() AS AvgScore2
FROM Sales.Customers;

/* ==============================================================================
   HANDLE NULL - MATHEMATICAL OPERATORS
===============================================================================*/
--NULL + 5 => NULL
/* TASK 2: 
   Display the full name of customers in a single field by merging their
   first and last names, and add 10 bonus points to each customer's score.
*/
SELECT
CustomerID
,FirstName
,LastName
,Score
,FirstName + ' ' + COALESCE(LastName, '') As FullName
,COALESCE(Score,0) + 10 As ScoreWithBonus
FROM Sales.Customers;


/* ==============================================================================
   Handling NULL - JOINS
===============================================================================*/
/*Eg.Table1 and Table2
		Table1								Table2
Year	Type	Orders			Year	Type	Sales
2024	a		30				2024	a		100
2024	NULL	40				2024	NULL	200
2025	b		50				2025	b		300
2025	NULL	60				2025	NULL	200

Query:
SELECT
a.year, a.type, a.orders, b.sales
FROM Table1 a
JOIN Table2 b
ON a.year = b.year
AND ISNULL(a.type,'') = ISNULL(b.type, '') -- Replacing NULL with empty string so that the output will be correct.

Output:
Year	Type	Orders	Sales
2024	a		30		100
2024	NULL	40		200 -- type column will return null here because NULL is the original value and we replaced NULL only while joining.
2025	b		50		300
2025	NULL	60		200
*/

/* ==============================================================================
   HANDLE NULL - SORTING DATA
===============================================================================*/
/* TASK 3: 
   Sort the customers from lowest to highest scores,
   with NULL values appearing last.
*/
SELECT
CustomerID
,Score
FROM Sales.Customers
ORDER BY Score;

--METHOD 1 : Not professional way
SELECT
CustomerID
,Score
,COALESCE(Score, 9999999) -- replacing NULL with a very big number. Still this is static and not a professional way
FROM Sales.Customers
ORDER BY COALESCE(Score, 9999999);

--METHOD 2 : Professional way using flag
SELECT
CustomerID
,Score
--,CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag -- This flag is added in the Order By
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score; -- Sorting by Flag first and then Score

/* ==============================================================================
   NULLIF - Compares two expressions returns:
   -NULL, if they are equal
   -First value, if they are not equal
===============================================================================*/
--Syntax: NULLIF(value1, value2)
--Eg.NULLIF(Price, -1) -- Replaced with NULL if the Price is equal to 1
--This is exactly opposite of ISNULL and COALESCE
/*Eg.NULLIF(Original Price, Discounted Price)
OrderID		Original_Price	 Discounted_Price	   NULLIF
	1			150				50					150	
	2			250				250					NULL	-- Both the prices are same, hence it is replaced by NULL using NULLIF
*/

/* ==============================================================================
   NULLIF Use Case - DIVISION BY ZERO
===============================================================================*/
/* TASK 4: 
   Find the sales price for each order by dividing sales by quantity.
   Uses NULLIF to avoid division by zero.
*/
SELECT
OrderID
,Sales
,Quantity
--,Sales/Quantity AS Price --This will return by Divide by zero
,Sales/NULLIF(Quantity,0) AS Price
FROM Sales.Orders;

/* ==============================================================================
   IS NULL - IS NOT NULL
===============================================================================*/
--IS NULL -- Returns TRUE if the value IS NULL, otherwise returns FALSE
--IS NOT NULL -- Returns TRUE if the value IS NOT NULL, otherwise returns FALSE
--Syntax: Value IS NULL | Value IS NOT NULL
--Eg.Shipping_Address IS NULL

/* ==============================================================================
IS NULL Use case
===============================================================================*/
--Use case I.Filtering Data
/* TASK 5: 
   Identify the customers who have no scores 
*/
SELECT
*
FROM Sales.Customers
WHERE Score IS NULL;

/* TASK 6: 
   Identify the customers who have scores 
*/
SELECT
*
FROM Sales.Customers
WHERE Score IS NOT NULL;

--Use case II.ANTI JOINS
/* ==============================================================================
   LEFT ANTI JOIN -- All rows from left table but without matching rows from right table
===============================================================================*/
--There is no specific function for this join. We need to use LEFT JOIN + IS NULL

/* TASK 7: 
   List all details for customers who have not placed any orders 
*/
SELECT
c.CustomerID, c.FirstName, c.LastName,o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL; -- The matching customer id will NOT be there in Orders table.
--WHERE o.OrderID IS NULL; -- We can also use OrderID

/* ==============================================================================
   NULLs vs EMPTY STRING vs BLANK SPACES
===============================================================================*/
--NULL: means nothing, unknown value
--EMPTY STRING: String value has zero Characters -- ''
--BLANK SPACES: Staring value has one more or more space characters -- ' '
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*
,DATALENGTH(Category) CategoryLen
FROM Orders;

/*
				NULL				EMPTY STRING				Blank Space
Representation	NULL					''							' '
Meaning			Unknown				Known, Empty value			Known, Space value
Data Type		Special Marker		String(0)					String(1 or more)
Storage			Very minimal		Occupies memory				Occupied memory
Performance		Best				Fast						Slow
Comparison		IS NULL				=''							=' '

*/

--Data Policies
--Set of rules that defines how data should be handled.
--We can define our own data policies accordingly

/* #1 Data Policy
Only use NULLs and empty strings, but avoid blank spaces
*/
--For this Data policy, we can use TRIM function
--remove unwanted leading and trailing spaces from a string

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*
,DATALENGTH(Category) CategoryLen
,DATALENGTH(TRIM(Category)) Policy1_CategoryLen -- Checking the length
,TRIM(Category) Policy1
FROM Orders;

/* #2 Data Policy
Only use NULLs and avoid using empty strings and blank spaces
*/
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*
,DATALENGTH(Category) CategoryLen
,TRIM(Category) Policy1
,NULLIF(TRIM(Category), '') Policy2
FROM Orders;

/* #3 Data Policy
Only the default value 'unknown' and avoid using NULLS, empty strings and blank spaces
*/
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT
*
,DATALENGTH(Category) CategoryLen
,TRIM(Category) Policy1
,NULLIF(TRIM(Category), '') Policy2
,COALESCE(NULLIF(TRIM(Category), ''), 'unknown') Policy3
--,COALESCE(Category, 'unknown') Policy3
FROM Orders;

/*
#2 Data Policy Use case
Replacing empty string and blanks with NULL during data preparation before inserting into a database to optimize storage and performance.

#3 Data Policy Use case
Replacing empty strings, blanks, NULL with default value during data preparation before using it in reporting to improve readability and reduce confusion
*/

