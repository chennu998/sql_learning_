/* DQL stands data query language
it is used to retreive data from database
it doesnt change structure of the table or database
cant modify data*/

--select 
select column1,column2 from table_name

select name,age from customers
--this query fetch data of name and age columns


--select all columns
select * from table_name

select * from customers
--this query fetch all the columns from the customers table

--select using where condition
select * from table_name where condition
SELECT * FROM marks WHERE score > 50;
--Retrieves records where the score is greater than 50
