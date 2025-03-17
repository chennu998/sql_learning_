--top 50 questions from sql
--Q1   https://leetcode.com/problems/recyclable-and-low-fat-products/
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
 

Write a solution to find the ids of products that are both low fat and recyclable.

Return the result table in any order.
--A
select product_id   from Products
where low_fats='Y'
 and recyclable='Y'

--Q2    https://leetcode.com/problems/find-customer-referee/
Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 

Find the names of the customer that are not referred by the customer with id = 2.

Return the result table in any order.
--Q3 https://leetcode.com/problems/big-countries/
table-world
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
name is the primary key (column with unique values) for this table.
Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
 

A country is big if:

it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write a solution to find the name, population, and area of the big countries.
--A
select name,population,area from
World 
where area>=3000000 or population>=25000000
order by name asc;

--Q4   https://leetcode.com/problems/article-views-i/
Table: Views

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
 

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by id in ascending order.
--Answer
select distinct (author_id)  as id from 
Views 
where author_id=viewer_id 
order by author_id;

--Q5    https://leetcode.com/problems/invalid-tweets/
Table: Tweets

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
content consists of characters on an American Keyboard, and no other special characters.
This table contains all the tweets in a social media app.
 
Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of
 characters used in the content of the tweet is strictly greater than 15.
--Answer
select tweet_id from Tweets
where length(content)>15

--Q6  https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/
Table: Employees   

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains the id and the name of an employee in a company.
 

Table: EmployeeUNI

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+
(id, unique_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id and the corresponding unique id of an employee in the company.
 

Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

Return the result table in any order.
--A
select u.unique_id,e.name
from EmployeeUNI u right join Employees e
on e.id=u.id

--Q7   https://leetcode.com/problems/product-sales-analysis-i/
Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 
Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.
 

Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
--Answer
select p.product_name ,s.year,s.price
from Sales s inner join Product p on s.product_id=p.product_id

--Q8   https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/
Table: Visits

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the column with unique values for this table.
This table contains information about the customers who visited the mall.
 

Table: Transactions

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is column with unique values for this table.
This table contains information about the transactions made during the visit_id.
 

Write a solution to find the IDs of the users who 
visited without making any transactions and the number of times they made these types of visits.
--answer
select v.customer_id as customer_id,count(*) as count_no_trans 
 from
Visits v left join Transactions t
on v.visit_id=t.visit_id
where t.transaction_id is null
group by v.customer_id

--Q9   https://leetcode.com/problems/rising-temperature/
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates id with higher temperatures compared to its previous dates (yesterday).

--Answer
select b.id
from Weather a,Weather b
where a.recordDate=DATE_SUB(b.recordDate, INTERVAL 1 DAY) and b.temperature>a.temperature

--Q10   https://leetcode.com/problems/average-time-of-process-per-machine/
Table: Activity

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.
It is guaranteed that each (machine_id, process_id) pair has a 'start' and 'end' timestamp.
 

There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average
 time as processing_time, which should be rounded to 3 decimal places.
 --Answer
 select a.machine_id,round(avg(b.timestamp)-avg(a.timestamp),3) as processing_time from
Activity a,Activity b
where a.machine_id=b.machine_id  and a.process_id=b.process_id 
and a.activity_type='start'
and b.activity_type='end'
group by a.machine_id

--Q11   https://leetcode.com/problems/employee-bonus/
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 

Table: Bonus

+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
 

Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
--Answer
select e.name,b.bonus
from Employee e left join Bonus b
on e.empId=b.empId
where b.bonus<1000 or b.bonus is null

--Q12    https://leetcode.com/problems/students-and-examinations/
Table: Students

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
 

Table: Subjects

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
 

Table: Examinations

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
 

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by student_id and subject_name.
--Answer
select s.student_id,s.student_name,a.subject_name,count(e.subject_name) as attended_exams  from Students s cross join Subjects a
left join Examinations e on 
s.student_id=e.student_id and a.subject_name=e.subject_name
group by s.student_id,s.student_name,a.subject_name
order by s.student_id,a.subject_name

--Q13   https://leetcode.com/problems/managers-with-at-least-5-direct-reports/
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.
--answer
select a.name from Employee a inner join Employee b
on a.id=b.managerId
group by b.managerId
having count(b.managerId)>=5


--Q14  https://leetcode.com/problems/confirmation-rate/
--Answer 
select user_id ,
round(avg(case when action='confirmed' then 1
when action='timeout' then 0
when action is null then 0 end),2) as confirmation_rate 
from Signups left join Confirmations 
using(user_id)
group by user_id 

--Q15   https://leetcode.com/problems/not-boring-movies/  
Table: Cinema

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
 

Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.
--Answer
select * from Cinema
where id%2!=0 and description!='boring'
order by rating desc;

--Q16  https://leetcode.com/problems/average-selling-price/
--Answer
select * 
from Prices p left join UnitsSold u
on p.product_id=u.product_id
and
u.purchase_date  between p.start_date and p.end_date

--Q17   https://leetcode.com/problems/project-employees-i/
Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. Its guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
 
Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

--Answer
select p.project_id,round(sum(e.experience_years)/count(*),2) as average_years 
from Project p inner join Employee e
on p.employee_id=e.employee_id 
group by p.project_id


--Q18    https://leetcode.com/problems/percentage-of-users-attended-a-contest/
Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.
 

Table: Register

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.
 

Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

--Answer1
select contest_id,round((count(user_id)/(select count(*) from Users))*100,2) as percentage 
from Register 
group by contest_id
order by percentage desc,contest_id  asc

--Answer2
select contest_id,round((count(distinct r.user_id)/count(distinct u.user_id))*100,2) as percentage 
from Register r cross join Users u 
group by contest_id
order by percentage desc,contest_id  asc
--Answer3(best)
with temp as (select count(*) as total_users from Users)
select contest_id,round((count(user_id)/total_users)*100,2) as percentage from Register cross join temp
group by contest_id  
order by percentage desc,contest_id  asc

--Q19   https://leetcode.com/problems/queries-quality-and-percentage/
Table: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 

We define query quality as:

The average of the ratio between query rating and its position.

We also define poor query percentage as:

The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.
--Answer1
select query_name,round(avg(rating/position),2) as quality ,round((COUNT(CASE WHEN rating < 3 THEN 1 END)/count(*))*100,2) as poor_query_percentage 
from Queries
group by query_name
--Answer2
select query_name,round(avg(rating/position),2) as quality ,round(avg(rating < 3)*100,2) as poor_query_percentage 
from Queries
group by query_name


--Q20  https://leetcode.com/problems/monthly-transactions-i/
Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, 
the number of transactions and their total amount, the number of approved transactions and their total amount.

--Answer
select substring(trans_date,1,7) as month,country,count(*) as trans_count ,
count(case when state='approved' then 1 end) as approved_count,sum(amount) as trans_total_amount,
sum(case when state='approved' then amount else 0 end) as approved_total_amount  
from Transactions
group by year(trans_date),month(trans_date),country



--Q21   https://leetcode.com/problems/immediate-food-delivery-ii/
Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customers preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of 
immediate orders in the first orders of all customers, rounded to 2 decimal places.
--Answer1
with temp as (
    select customer_id,min(order_date) as min_order_date 
from Delivery 
group by customer_id 
)
select round((count(case when d.order_date=d.customer_pref_delivery_date then 1 end)/
count(*))*100,2) as immediate_percentage from Delivery d inner join temp
on temp.min_order_date=d.order_date and temp.customer_id=d.customer_id

--Answer1
Select round(avg(order_date = customer_pref_delivery_date)*100, 2) as immediate_percentage
from Delivery
where (customer_id, order_date) in (
  Select customer_id, min(order_date) 
  from Delivery
  group by customer_id
);


--Q22  https://leetcode.com/problems/game-play-analysis-iv/
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
Write a solution to report the fraction of players that logged in again 
on the day after the day they first logged in, rounded to 2 decimal places. 
In other words, you need to count the number of players that logged in for at 
least two consecutive days starting from their first login date, then divide that 
number by the total number of players.
--Answer
with temp as (
    select player_id,min(event_date) as event_date from Activity 
    group by player_id
)
select round(count(a.player_id)/(select count(distinct player_id) from Activity ),2) as fraction   from temp a inner join Activity b
on a.player_id=b.player_id and
 a.event_date=date_add(b.event_date, interval -1 day)


--Q23  https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/
Table: Teacher

+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+
(subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.
 

Write a solution to calculate the number of unique subjects each teacher teaches in the university.
--Answer
select teacher_id,count(distinct subject_id) as cnt
from Teacher 
group by teacher_id


--Q24  https://leetcode.com/problems/user-activity-for-the-past-30-days-i/
--Answer
select activity_date  as day,count(distinct user_id) as active_users 
from Activity 
where activity_date between date_add('2019-07-28', interval -30 day) and '2019-07-28'
group by activity_date


--Q25   https://leetcode.com/problems/product-sales-analysis-iii/
Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.
 

Write a solution to select the product id, year, quantity, and price for the first year of every product sold.
--Answer
select product_id,year as first_year,quantity ,price  from Sales
where (product_id,year) in (select product_id,min(year) 
from Sales 
group by  product_id)


--Q26   https://leetcode.com/problems/classes-more-than-5-students/
Table: Courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 

Write a solution to find all the classes that have at least five students.
--Answer
select class 
from Courses 
group by class
having count(student)>=5

--Q27  https://leetcode.com/problems/find-followers-count/
Table: Followers

+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
(user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user.
 

Write a solution that will, for each user, return the number of followers.

Return the result table ordered by user_id in ascending order.
--Answer
Select user_id, count(Follower_id) as followers_count
from Followers
group by user_id order by user_id ;

--Q28   https://leetcode.com/problems/biggest-single-number/
Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.
--Answer
with temp as (
    select num,count(*)
    from MyNumbers 
    group by num
    having count(*)=1
)
select  case when max(num) is null then null
else max(num) end as num
from temp

--Q29    https://leetcode.com/problems/customers-who-bought-all-products/
Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
 

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.
--Answer
with temp as (
    select customer_id,count(distinct product_key) as ck
    from Customer
    group by customer_id
)
select customer_id from temp
where ck=(select count(distinct product_key ) from Product)

--Answer2
 select customer_id
    from Customer
    group by customer_id
    having count(distinct product_key)=(select count(distinct product_key ) from Product)


--Q30  https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/   
Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.
--Answer
select b.employee_id,b.name,count(*) as reports_count,
round(avg(a.age)) as average_age 
from Employees a inner join Employees b on
a.reports_to=b.employee_id 
where a.reports_to is not null
group by b.employee_id
order by b.employee_id asc

--Q31  https://leetcode.com/problems/primary-department-for-each-employee/
Table: Employee

+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
 

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.

Write a solution to report all the employees 
with their primary department. For employees who belong to one department, report their only department.
--Answer
with temp as (
    select employee_id,count(department_id) as td
from Employee 
group by employee_id
)
select temp.employee_id,e.department_id 
  from temp inner join Employee e
on temp.employee_id=e.employee_id  
where (temp.td=1) or (temp.td>1 and e.primary_flag='Y')

--Q32    https://leetcode.com/problems/triangle-judgement/
--Answer1
select x,y,z,
(case when (x+y>z and y+z>x and z+x>y) then 'Yes' else 'No'
end ) as triangle
 from Triangle

--Answer2
SELECT x, y, z, IF(x + y > z AND y + z > x AND z + x > y, 'Yes', 'No') AS triangle
FROM Triangle;


 --Q33  https://leetcode.com/problems/consecutive-numbers/
 --(done with inner join,with window functions)
 Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

--Answer1(join)
select distinct a.num as ConsecutiveNums  from Logs a inner join Logs b
on a.num=b.num and a.id=b.id-1 inner join Logs c
on b.num=c.num and b.id=c.id-1
--Answer2(window functions)
WITH NumberGroups AS (
    SELECT 
        num,
        ROW_NUMBER() OVER (ORDER BY id) - ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS grp
    FROM Logs),
ConsecutiveCounts AS (
    SELECT 
        num,
        COUNT(*) AS cnt
    FROM NumberGroups
    GROUP BY num, grp
)
select distinct num as consecutivenums
from ConsecutiveCounts 
where cnt >=3

--Q34  https://leetcode.com/problems/product-price-at-a-given-date/
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.

--Answer
with temp as (
    select product_id,max(change_date) as cd from Products 
    where change_date<='2019-08-16'
    group by product_id
)
select p.product_id as product_id ,p.new_price as price  from Products p inner join temp t on
p.product_id=t.product_id and p.change_date=t.cd
union 
select product_id,case 
when change_date >'2019-08-16' then  10 end as price 
from Products 
where product_id not in (select product_id from temp) 

--Answer2
select product_id, 10 as price from Products
group by product_id
having min(change_date) > '2019-08-16'
UNION
select p.product_id, p.new_price as price from Products p
inner join (select product_id, new_price, max(change_date) as change_date from Products
where change_date <= '2019-08-16'
group by product_id) a
on p.product_id = a.product_id and p.change_date=a.change_date

--Q35   https://leetcode.com/problems/last-person-to-fit-in-the-bus/
--Answer
with temp as (
    select person_id,person_name,weight,turn,
sum(weight) over(order by turn) as cumw
from Queue
)
select person_name from temp
where cumw<=1000
order by cumw desc
limit 1

--Q36 https://leetcode.com/problems/count-salary-categories/
Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

--Answer1
with temp1 as (
    select
    case 
    when income<20000 then 'Low Salary'
    when income between 20000 and 50000 then 'Average Salary'
    when income>50000 then 'High Salary'
    end as sc,count(*) as tc
    from Accounts
    group by sc
),
temp2 AS (
    SELECT 'Low Salary' AS sc
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
)
SELECT temp2.sc as category,ifnull(tc,0) as accounts_count FROM temp2 left join temp1
on temp1.sc=temp2.sc

--Answer2
select "Low Salary" as category,
sum(if(income < 20000, 1, 0)) as accounts_count
from accounts
UNION
select "Average Salary" as category,
sum(if(income between 20000 and 50000, 1, 0)) as accounts_count
from accounts
Union
select "High Salary" as category,
sum(if(income > 50000, 1, 0)) as accounts_count
from accounts


--Q37   https://leetcode.com/problems/employees-whose-manager-left-the-company/
--Answer
select employee_id from Employees 
where salary<30000 and manager_id  is not null
and manager_id not in (select distinct employee_id from Employees )
order by employee_id asc


--Q38 (pending)   https://leetcode.com/problems/exchange-seats/


--Q39    https://leetcode.com/problems/movie-rating/
Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the users review date. 
 

Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. 
In case of a tie, return the lexicographically smaller movie name.

--Answer1
select uname as results from 
(select user_id,count(*) as tr,Users.name as uname from MovieRating inner join Users 
using (user_id)
group by user_id,uname
order by  tr desc,uname
limit 1) as temp1
union all
select mt from
(select movie_id,avg(rating),Movies.title as mt from MovieRating inner join Movies
using (movie_id)
where year(created_at)='2020' and month(created_at)='02'
group by movie_id,mt
order by avg(rating) desc,mt asc
limit 1) as temp2

--Answer2
with s1 as
(
    select mr.user_id, name, count(*) rate_cnt
    from MovieRating mr
    join Users u
    on u.user_id = mr.user_id
    group by user_id
    order by rate_cnt desc, name
    limit 1
),
s2 as
(
    select mr.movie_id, title, avg(rating) avg_rate
    from MovieRating mr
    join Movies mv
    on mv.movie_id = mr.movie_id
    where created_at between '2020-02-01' and '2020-02-29'
    group by mr.movie_id
    order by avg_rate desc, title
    limit 1
)

select name results from s1
union all select title results from s2


--Q40(pending)    https://leetcode.com/problems/restaurant-growth/


--Q41   https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
--Answer
with temp as (
    select requester_id as rid,count(*) as tf from
RequestAccepted
group by requester_id
union all
select  accepter_id,count(*) from
RequestAccepted
group by  accepter_id
)
select rid as id,sum(tf) as num
from temp 
group by rid
order by num desc
limit 1


--Q42(pending)    https://leetcode.com/problems/investments-in-2016/


--Q43  leetcode.com/problems/department-top-three-salaries/
Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
 

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.
--Answer
with ranks(Department,Employee,Salary,rnk)  as (
    select d.name,e.name,e.salary,
dense_rank() over(partition by e.departmentId order by e.salary desc) as rnk
from Employee e inner join Department d on e.departmentId=d.id
)
select Department,Employee,Salary from ranks
where rnk<4


--Q44  https://leetcode.com/problems/fix-names-in-a-table/
--Answer
select user_id,
concat(upper(substring(name,1,1)),lower(substring(name,2)))
as name
from Users
order by user_id


--Q45   https://leetcode.com/problems/patients-with-a-condition/
--Answer
select * from Patients
where conditions like '% DIAB1%' or conditions like 'DIAB1%'


--Q46    https://leetcode.com/problems/delete-duplicate-emails/
--Answer
with temp as (
    select min(id) as id
from Person
group by email
)
delete from Person
where id not in (select id from temp)


--Q47  https://leetcode.com/problems/second-highest-salary/
--Answer1
with temp1 as (
    select 2 as rnk
),temp2 as (
    select id,salary,
dense_rank() over(order by salary desc) as rnk
from Employee
)
select distinct temp2.salary as SecondHighestSalary from temp1 left join temp2 using (rnk)
--Answer2
select max(salary) as secondhighestsalary
from employee
where salary<(select max(salary) from employee);


--Q48(pending)    https://leetcode.com/problems/group-sold-products-by-the-date/


--Q49  https://leetcode.com/problems/list-the-products-ordered-in-a-period/
--Answer1 
select p.product_name as product_name,sum(unit) as unit 
from Products p inner join Orders o using(product_id)
where year(order_date)='2020' and month(order_date)='02'
group by product_name
having unit>=100
--Answer2(fast)
select product_name,sum(unit) as unit from Orders join products using (product_id) 
where order_date between "2020-02-01" and "2020-02-29" group by product_id having sum(unit)>=100;


--Q50(pending)    https://leetcode.com/problems/find-users-with-valid-e-mails/




