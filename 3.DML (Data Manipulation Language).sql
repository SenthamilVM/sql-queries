--Modify(Manipulate) your data
--INSERT
--Two ways to insert data
--1.Manual Entry
SELECT * FROM customers
INSERT INTO customers (id, first_name, country, score)
VALUES 
	(6, 'Anna', 'USA', NULL),
	(7, 'Sam', 'NULL', 100);

--Without mentioning column names
INSERT INTO customers 
VALUES 
	(8, 'Anna', 'USA', NULL);

--Insert values for specific columns.
INSERT INTO customers (id, first_name)
VALUES	(9, 'Sahra')

--NOTE: Columns not included in INSERT become NULL(unless a default or constraints exists)
--We cannot skip not null columns like id and we can only skip nullable columns.

--2.INSERT using SELECT
--Task - Copy/insert data from 'customers'	table into 'persons'
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
id,
first_name,
NULL,
'Unknown'
FROM customers

--The same query can be written as 
INSERT INTO persons
SELECT
id,
first_name,
NULL,
'Unknown'
FROM customers

--UPDATE
--Task Change the score of customer with ID 6 to 0
SELECT * 
FROM customers

/*CAUTION -- If we execute the update command without a where clause, 
it will update the value to the whole column not just for one row*/

/* Check with SELECT before running UPDATE to avoid updating the wrong data*/
SELECT * 
FROM customers 
WHERE id = 6;

UPDATE customers
SET score = 0
WHERE id = 6;

--inserting id 10 for the next task.
INSERT INTO customers (id, first_name, country, score)
VALUES (10, 'Sachin', 'India', NULL)

/*Change the score of customer with ID 10 to 0 and update the country to 'UK'*/

--Checking the id to make sure, we are updating the correct record/row
SELECT *
FROM customers
WHERE id = 10

--Updating
UPDATE customers
	SET score = 0,
		country = 'UK'
where id = 10;

/*Update all customers with a NULL score by 
setting their score to 0*/
--Checking
SELECT *
FROM customers
WHERE score IS NULL;

UPDATE customers
SET score = 0
WHERE score IS NULL;

---DELETE
--CAUTION: Always use WHERE to avoid DELETING all rows unintentionally

/*Delete all customers with an ID greater than 5*/

/*Best Practice: Check with SELECT before running DELETE to avoid deleting the wrong data*/
SELECT * 
FROM customers
WHERE id > 5;

DELETE FROM customers
WHERE id > 5;

--DELETE all data from table persons
--DELETE FROM persons
TRUNCATE TABLE persons

--NOTE: TRUNCATE - Clears the whole table at once without checking or logging.
--DELETE can be used for small tables. It will be slow when compared to Truncate.
--DELETE and TRUNCATE will clear the data from the table and the table still exists.







