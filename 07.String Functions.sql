--String Functions
--Manipulation: CONCAT, UPPER, LOWER, TRIM, REPLACE
--Calculation: LEN
--Extract: LEFT, RIGHT, SUBSTRING

--Manipulation
--1.CONCAT - Combine multiple values into one
--Task: Show a list of customers first names together with their country in one column

--checking data
SELECT * FROM Sales.Customers;

SELECT
FirstName,
country,
CONCAT(FirstName, '-', Country) AS name_country
FROM Sales.Customers

--2.UPPER--converts all characters to uppercase
--Task: transform the customer's first name to lowercase
SELECT
FirstName,
LOWER(FirstName) as lowerfirstname
FROM Sales.Customers

--3.LOWER -converts all characters to lowercase
--Task: transform the customer's first name to uppercase
SELECT
FirstName,
UPPER(FirstName) as lowerfirstname
FROM Sales.Customers

--4.TRIM -- Removes trailing and leading spaces
--Task: Find customers whose first name contains leading or trailing spaces

--Method 1:
SELECT 
FirstName,
TRIM(FirstName) as Cleaned
FROM Sales.Customers
WHERE FirstName != TRIM(FirstName);

--Method 2:
SELECT 
FirstName,
LEN(FirstName) AS len_name,
LEN(TRIM(FirstName)) as Cleaned_Len
FROM Sales.Customers
WHERE LEN(FirstName) != LEN(TRIM(FirstName));

--Method 3:
SELECT
FirstName,
LEN(FirstName) as Len_name,
LEN(TRIM(FirstName)) as Cleaned_Len,
LEN(FirstName) - LEN(TRIM(FirstName)) as flag
FROM Sales.Customers

--5.REPLACE -- Replaces specific character with a new character
--Remove dashes (-) from a phone number
SELECT
'123-456-7890',
REPLACE('123-456-7890', '-', '') AS clean_phone

--Replace file extension from txt to csv
SELECT
'report.txt' AS txt,
REPLACE('report.txt', 'txt', 'csv') AS csv;

/*-------------------------------------------------------------*/

--Calculation:
--LEN -- Counts the number of characters
--Task: calculate the length of each customer's first name

SELECT
FirstName,
LEN(FirstName) AS FName_length
FROM Sales.Customers

/*-------------------------------------------------------------*/
--Extract:
--1.LEFT -- Extract specific number of characters from the start
--Task: Retrieve the first two characters of each first name
SELECT
FirstName,
LEFT(FirstName,2) AS first_two
FROM Sales.Customers

--2.RIGHT -- Extract specific number of characters from the end
SELECT
FirstName,
RIGHT(FirstName,2) AS last_two
FROM Sales.Customers

--in case if we have spaces.
SELECT
FirstName,
RIGHT(TRIM(FirstName),2) AS last_two
FROM Sales.Customers

--3.SUBSTRING --Extracts a part of string at a specified position
--SUBSTRING(Value, Start, Length)
--After the 2nd character extract 2 characters
--Task: Retrieve a list of customer's first names removing the first character
SELECT
FirstName,
LEN(FirstName) as len_name,
SUBSTRING(FirstName,2,LEN(FirstName)) as first_character_removed
FROM Sales.Customers;
