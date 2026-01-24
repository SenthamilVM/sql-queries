/*--Task: Create a new table called persons with columns: 
id, person_name, birth_date and phone*/
USE MyDatabase
CREATE TABLE persons(
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)

)

--ALTER -- Alter the definition of the table
--Task - Add a new column called email to the persons table
USE MyDatabase
ALTER TABLE MyDatabase.dbo.persons
ADD email VARCHAR (50) NOT NULL

--NOTE- The new columns will be appended at the end of table by default.

--Task - Remove the column phone from persons table
USE MyDatabase
ALTER TABLE [MyDatabase].[dbo].[persons]
DROP COLUMN phone;

--Same query can be written as 
ALTER TABLE persons
DROP COLUMN phone;

--NOTE: Dropping column will remove all data from the column.

--DROP in DDL -- Removing table completely from the DB
--Task - Delete the table persons from the database
DROP TABLE persons
