/* alter table command
it is used to change the structure of the table like 
adding new column,deleting column,changing the names of columns ,datatypes of columns etc.*/

--adding a new column to table 
alter table table_name add  newcolumn_name datatype;
alter table student add column email varchar(100)

--changing datatype of a column
alter table table_name modify column_name new_datatype;
ALTER TABLE students MODIFY age BIGINT;


--deleting a column 
alter table table_name drop column column_name
ALTER TABLE students DROP COLUMN age;


--rename a column
-- alter table table_name rename column  column_name to new_column_name
-- ALTER TABLE
--   player RENAME COLUMN jersey_num TO jersey_number;

--rename a column
-- alter table table_name rename column  column_name to new_column_name
-- ALTER TABLE
--   player RENAME COLUMN jersey_num TO jersey_number;
