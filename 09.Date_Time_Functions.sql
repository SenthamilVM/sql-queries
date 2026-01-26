--Date & Time functions
--Date -- Year-Month-Day
--Time -- Hours:Minutes:Seconds

SELECT
	OrderID,
	OrderDate,
	ShipDate,
	CreationTime
FROM Sales.Orders;

--Hardcoded constant string value/date value
SELECT
	OrderID,
	'2025-08-01' AS Hardcoded,
	CreationTime
FROM Sales.Orders;

--GETDATE() Function -- Returns the current date and time at the moment when the query is executed.
SELECT
	OrderID,
	'2025-08-01' AS Hardcoded,
	GETDATE() Today,
	CreationTime
FROM Sales.Orders;

/*Date & Time Function types:
1.Part Extraction -- DAY | MONTH | YEAR | DATEPART | DATENAME | DATETRUNC | EOMONTH
2.Format & Casting -- FORMAT | CONVERT | CAST
3.Calculations -- DATEADD | DATEDIFF
4.Validation -- ISDATE
*/

--1.Part Extraction:
--DAY | MONTH | YEAR
SELECT DAY('2025-9-20') as Day_column;

SELECT
	OrderID,
	CreationTime,
	YEAR(CreationTime) as Year_col,
	MONTH(CreationTime) as Month_col,
	DAY(CreationTime) as Day_col
FROM Sales.Orders;

--DATEPART -- Returns specific part of a date as number -- Here the output will be an integer
--Week? Quarter?
--Syntax  DATEPART(part, date)
SELECT
	OrderID,
	CreationTime,
	YEAR(CreationTime) as Year_col,
	MONTH(CreationTime) as Month_col,
	DAY(CreationTime) as Day_col,
	DATEPART(YEAR, CreationTime) as Year_dp,
	DATEPART(MONTH, CreationTime) as Month_dp,
	DATEPART(DAY, CreationTime) as Day_dp,
	DATEPART(HOUR, CreationTime) as Hour_dp,
	DATEPART(MINUTE, CreationTime) as Minute_dp,
	DATEPART(SECOND, CreationTime) as Seconds_dp,
	DATEPART(WEEK, CreationTime) as Week_dp,
	DATEPART(WEEKDAY, CreationTime) as Weekday_dp,
	DATEPART(QUARTER, CreationTime) as Quarter_dp
FROM Sales.Orders;

--DATENAME -- Returns the name of a specific part of a date -- Here the output will be a string
--Syntax - DATENAME(part, date)

SELECT
	OrderID,
	CreationTime,
	DATENAME(MONTH, CreationTime) as Month_dn,
	DATENAME(WEEKDAY, CreationTime) as WeekDay_dn, -- For day, we need to use WEEKDAY, here the output is a string Eg.Wednesday
	DATENAME(DAY, CreationTime) as Day_dn, -- Eventhough this is returning the days but the data type of this will be a STRING
	DATENAME(YEAR, CreationTime) as Year_dn -- This will stored as a String data type
FROM Sales.Orders;

--DATETRUNC --Truncates(resets) the date to a specific part
--Syntax - DATETRUNC(part, date)
--Datepart resets to 01 (since there is no 0 day) and if we are truncating day and timepart resets to 0

SELECT
	OrderID,
	CreationTime,
	DATETRUNC(MINUTE, CreationTime) as Minute_dt,
	DATETRUNC(DAY, CreationTime) as day_dt,
	DATETRUNC(YEAR, CreationTime) as year_dt
FROM Sales.Orders;

--Examples:

--truncating and grouping by month level -- This rolls up the data to the month level
SELECT
DATETRUNC(MONTH, CreationTime) as month_dt,
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH, CreationTime);

--truncating and grouping by year level -- This rolls up the data to the year level
SELECT
DATETRUNC(YEAR, CreationTime) as year_dt,
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(YEAR, CreationTime);

--EOMONTH -- Returns the last day of the month

SELECT EOMONTH('2025-08-02') as enddate;

SELECT
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) as endofmonth
FROM Sales.Orders;

--How do we get the first day of the month? There is NO specific function for this
--This can be achieved by

SELECT
	OrderID,
	CreationTime,
	DATETRUNC(MONTH, CreationTime) as StartOfMonth
FROM Sales.Orders;

--How do we convert the date_time value to date?
SELECT
	OrderID,
	CreationTime,
	CAST(DATETRUNC(MONTH, CreationTime) AS DATE) as StartOfMonth
FROM Sales.Orders;

--PART EXTRACTION USE CASES
--1.Data Aggregations
--How many orders were placed each year?
SELECT 
YEAR(OrderDate) AS YEAR, 
COUNT(*) AS NumberofOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate);

--How many orders were placed each month?
SELECT 
MONTH(OrderDate) AS MONTH, 
COUNT(*) AS NumberofOrders
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

--To show full name of the month
SELECT 
DATENAME(MONTH, OrderDate) AS Month,
COUNT(*) AS NumberOfOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate);

--2.Data Filtering
--Show all orders that were placed during the month of february
SELECT *
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2;

--NOTE: Filtering Data using an Integer is faster than using a String.
--Avoid using DATENAME for filtering data, instead use DATEPART

--Functions Comaprison
--DAY | MONTH | YEAR | DATEPART - Data type is INT
--DATENAME - Data type is STRING
--DATETRUNCT - Data type is DATETIME
--EOMONTH - Data type is DATE

/*Format Specifier
YYYY-MM-dd HH:mm:ss
Format is Case sensitive here. Eg.MM is month but mm is minute
Formatting and Casting
Formatting - Changing the format of a value from one to another
1.FORMAT
2.CONVERT - using style numbers
The output of these functions will be a string

CASTING - This will change the data type from one to another. Eg.String to Number
CAST()
CONVERT() */

--I.FORMAT() - FORMAT(value, format [,culture])
--Default culture = 'en-US'

SELECT
OrderDate
,CreationTime
,FORMAT(CreationTime, 'MM-dd-yyyy') USA_format
,FORMAT(CreationTime, 'dd-MM-yyyy') Europe_India_format
,FORMAT(CreationTime, 'dd') dd
,FORMAT(CreationTime, 'ddd') ddd
,FORMAT(CreationTime, 'dddd') dddd
,FORMAT(CreationTime, 'MM') MM
,FORMAT(CreationTime, 'MMM') MMM
,FORMAT(CreationTime, 'MMMM') MMMM
FROM Sales.Orders;

/*==================================================================*/
/*Task 1: Show CreationTime using the following format:
Day Wed Jan Q1 2025 12:34:56 PM
*/
SELECT
OrderDate
,CreationTime
,'Day' + ' ' + FORMAT(CreationTime, 'ddd MMM ') 
+ 'Q' + DATENAME(quarter, CreationTime) + ' ' + 
FORMAT(CreationTime, 'yyyy hh:mm:ss tt') as CustomFormat
FROM Sales.Orders;
/*===============================================*/

--FORMATTING USE CASES
--I.Data Aggregations
--Start from SQL Ultimate Course -- Date & Time Functions-- Formatting timestamp - 14.57

SELECT
FORMAT(OrderDate, 'MMM yy') AS OrderDate
,COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy');

--Here, we are changing the granularity using FORMAT

--II.Data Standardization -- FORMAT will be used to standardize the dates coming from different data sources.

--CONVERT() - Converts a date or time value to a different data type & Formats the value
--Syntax: CONVERT(data_type, value [,style])
--Eg.CONVERT(INT, '123')
SELECT
CONVERT(INT, '123') AS [String to Int Convert]
,CONVERT(DATE, '2025-08-20') AS [String to Date Convert]
,CreationTime
,CONVERT(DATE, CreationTime) AS [Datetime to Date Convert]
FROM Sales.Orders;

--NOTE: CAST will change the data type but convert will change the data type as well as do the formatting(Date and Datetime)
SELECT
CreationTime
,CONVERT(DATE, CreationTime) AS [Datetime to Date Convert]
,CONVERT(VARCHAR, CreationTime, 32) AS [USA Std.Style:32]
,CONVERT(VARCHAR, CreationTime, 34) AS [Europe Std.Style:34]
FROM Sales.Orders

--CAST(): Converts a value to a specific data type -- No format can be specified
--Syntax: CAST(value AS data_type)
SELECT
CAST('123' AS INT) AS [String to Int]
,CAST(123 AS VARCHAR) AS [Int to String]
,CAST('2025-08-20' AS DATE) AS [String to Date]
,CAST('2025-08-20' AS DATETIME2) AS [String to Datetime2]
,CreationTime
,CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders

--FORMAT vs CONVERT vs CAST
/*
			CASTING					|	FORMATTING
CAST	|	Any Type to Any Type	| No Formatting
--------------------------------------------------------------------------
CONVERT	|	Any Type to Any Type	| Formats only to Date&Time
--------------------------------------------------------------------------
FORMAT	|	Any Type to Only String	| Formats to Date&Time and to Numbers
*/

/* ==============================================================================
   DATEADD() / DATEDIFF()
===============================================================================*/
--DATEADD() - Adds or subtracts a specific time interval to/from a date
--Syntax: DATEADD(part, interval, date)
--Eg.DATEADD(year, 2, OrderDate)
SELECT
OrderID
,OrderDate
,DATEADD(day, -10, OrderDate) AS TenDaysBefore
,DATEADD(month, 3, OrderDate) AS ThreeMonthsLater
,DATEADD(year, 2, OrderDate) AS TwoyearsLater
FROM Sales.Orders;

--DATEDIFF() -- Find the difference between two dates.
--Syntax: DATEDIFF(part, start_date, end_date)

--Task: Calculate the age of employees
SELECT
EmployeeID
,BirthDate
,DATEDIFF(year, BirthDate, GETDATE()) AS Age
FROM Sales.Employees

--Task:Find the average shipping duration in days for each month
SELECT
MONTH(OrderDate) As OrderDate
,AVG(DATEDIFF(day, OrderDate, ShipDate)) AS [Days to Ship]
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

--Time Gap Analysis
--Task: Find the number of days between each order and the previous order
SELECT
OrderID
,OrderDate AS CurrentOrderDate
,LAG(OrderDate) OVER(ORDER BY OrderDate) AS PreviousOrderDate
,DATEDIFF(day, LAG(OrderDate) OVER(ORDER BY OrderDate), OrderDate) AS NumberofDays
FROM Sales.Orders;

/* ====================================================================================================================
Validation:   ISDATE(): Check if a value is a date. Returns 1 if the string value is a valid date, else 0
=====================================================================================================================*/
SELECT 
ISDATE('123') Datecheck1
,ISDATE('2025-09-20') Datecheck2
,ISDATE('20-08-2025') Datecheck3 -- Returns 0 since it is not following the standard format of SQL('yyyy-mm-dd')
,ISDATE('2025') Datecheck4 -- Returns 1 as it can be January 1st of 2025(SQL understands like this)
,ISDATE('08') Datecheck5;

--Scenario - to indentify data quality issues and do the data cleanup in real world

--casting to date
SELECT '2025-08-20' AS OrderDate UNION
SELECT '2025-08-21' UNION
SELECT '2025-08-23' UNION
SELECT '2025-08' -- We cannot convert this to date as it didn't follow SQL date format even as string

--Error - Because of the last value '2025-08'
SELECT
CAST(OrderDate AS DATE) OrderDate
FROM
(
SELECT '2025-08-20' AS OrderDate UNION
SELECT '2025-08-21' UNION
SELECT '2025-08-23' UNION
SELECT '2025-08' -- We cannot convert this to date as it didn't follow SQL date format even as string
)t;

--To fix this, try the following
SELECT
	OrderDate
	,ISDATE(OrderDate)
	,CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
		  ELSE '9999-01-01' --to remove NULL and dummy value
	END NewOrderDate
FROM
(
SELECT '2025-08-20' AS OrderDate UNION
SELECT '2025-08-21' UNION
SELECT '2025-08-23' UNION
SELECT '2025-08' -- We cannot convert this to date as it didn't follow SQL date format even as string
)t
--WHERE ISDATE(OrderDate) = 0 -- To find the rows which doesn't have dates