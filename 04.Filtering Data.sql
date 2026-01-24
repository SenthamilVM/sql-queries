--FILTERING DATA

--1.COMPARISON OPERATORS
--Retrieve all customers from Germany
USE MyDatabase
SELECT * 
FROM customers
WHERE country = 'Germany';

--Retrieve all customers who are not from Germany
SELECT * 
FROM customers
WHERE country != 'Germany';
--WHERE country <> 'Germany'; -- We can use this operator as well

--Retrieve all customers with a score greater than 500
SELECT *
FROM customers
WHERE score > 500;

--Retrieve all customers with a score of 500 or more
SELECT *
FROM customers
WHERE score >= 500;

--Retrieve all customers with a score less than 500
SELECT *
FROM customers
WHERE score < 500;

--Retrieve all customers with a score of 500 or less
SELECT *
FROM customers
WHERE score <= 500;

/*----------------------------------------------------------*/

--2.LOGICAL OPERATORS
--AND
/* Retrieve all customers who are from USA 
and have a score greater than 500*/
SELECT *
FROM customers
WHERE country = 'USA' AND score > 500;

--OR
/* Retrieve all customers who are either from USA 
or have a score greater than 500*/
SELECT *
FROM customers
WHERE country = 'USA' OR score > 500;

--NOT
--Retrieve all customers with a score not less than 500
SELECT * 
FROM customers
WHERE score >= 500;

--This can be achieved by NOT operator as well
SELECT *
FROM customers
WHERE NOT score < 500;

/*----------------------------------------------------------*/

--3.RANGE OPERATOR
--Check if a value is within the range
--BETWEEN
--Retrieve all customers whose score falls in the range between 100 and 500
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;

--The same result can be achieved through logical operators
SELECT *
FROM customers
WHERE score >=100 AND score <=500;

/*----------------------------------------------------------*/

--4.MEMBERSHIP OPERATOR
--IN
--Retrieve all customers from either USA or Germany
SELECT * 
FROM customers
WHERE country IN ('USA', 'Germany');

--NOT IN
--Retrieve all customers who are not from USA and Germany
SELECT *
FROM customers
WHERE country NOT IN ('Germany','USA');

/*----------------------------------------------------------*/

--5.Search Operator
--LIKE -- Search for a pattern in a text
--Find all customers whose first name starts with M
SELECT *
FROM customers
where first_name LIKE 'M%';

--Find all customers whose first name ends with n
SELECT *
FROM customers
WHERE first_name LIKE '%n';

--Find all customers whose first name contains r
SELECT *
FROM customers
WHERE first_name LIKE '%r%';

--Find all customers whose first name has 'r' in the third position
SELECT *
FROM customers
WHERE first_name LIKE '__r%';



