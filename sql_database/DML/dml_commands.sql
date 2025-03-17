/*DML stands for data manipulation language
we cant change the structure of the tables or databases
we can make changes to data

used to insert data into tables,update the existing data,remove data in table*/

--INSERT COMMAND 
--it is used to insert new data to the table

insert into table_name (column1,column2,column3)
values (value1,value2,value2)

--example

insert into marks(student_id,subject_id,score) 
values (3,1,20),(3,2,30),(3,3,70),(3,4,40),(3,5,50)

--UPDATE COMMAND
--it is used to update or modify existing data

update table_name set column_name=value 
where column_name=value(condition)

--example
update student set email=concat(name,".",surname,year(dob),"@gmail.com") 


--DELETE COMMAND
--it is used to delete one or multiple records from table
--while using delete command we have use where clause ,else all the records will be deleted

delete from table_name where condition

--example
-- delete from customers where age>=10

--example
-- delete from customers where age>=10

