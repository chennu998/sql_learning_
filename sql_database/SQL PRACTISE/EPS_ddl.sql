/* created a employe management system database with tables
like departments,to which employees belongs,
employe table which consits of employe details,
salaries tables which has salaries of employees,date salary credited,bonus etc
final table is attendance where attendance is managed

these tables rerlated with primary and foreign key*/

--DDL queries
--creating tables
create database EPS

create table departments (
    department_id int primary key auto_increment,
    name varchar(100) unique not null,
    location varchar(100) not null
);

create table employees (
employee_id int primary key auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) unique not null,
phone varchar(15) unique not null,
hire_date date not null,
department_id int not null,
status enum('active', 'inactive') default 'active',
address text not null,
dob date not null,
foreign key (department_id) references departments(department_id) on delete set null
);

create table salaries (
salary_id int primary key auto_increment,employee_id int,base_salary int not null check (base_salary > 0), 
bonus int default 0 check (bonus >= 0),pay_date date not null,
foreign key (employee_id) references employees(employee_id) on delete cascade
);

create table attendance (
attendance_id int primary key auto_increment,employee_id int,check_in datetime not null,check_out datetime,
hours_worked decimal(5,2) check (hours_worked >= 0),status enum('present', 'absent', 'on leave') not null,
foreign key (employee_id) references employees(employee_id)
);

--inserting data into tables
insert into departments (name, location) values
('Human Resources', 'Mumbai'),
('Finance', 'Delhi')

insert into employees (first_name, last_name, email, phone, hire_date, department_id, status, address, dob) 
values
('Jane', 'Smith', 'jane.smith@gmail.com.com', '9876543211', '2025-02-05', 1,
'active', '24-49/1,nizampatnam,guntur,andhrapradesh', '1985-03-22');

INSERT INTO salaries (employee_id, base_salary, bonus, pay_date) VALUES
(31, 50000, 5000, '2025-01-31'),
(32, 60000, 7000, '2025-01-31')

INSERT INTO attendance (employee_id, check_in, check_out, hours_worked, status) VALUES
(1, '2025-02-01 09:15:00', '2025-02-01 17:30:00', 8.25, 'present'),
(31, '2025-02-02 09:05:00', '2025-02-02 17:15:00', 8.17, 'present'),
(32, '2025-02-03 09:10:00', '2025-02-03 16:50:00', 7.67, 'present'),
(33, '2025-02-04 09:00:00', '2025-02-04 18:00:00', 9.00, 'present'),
(34, '2025-02-05 08:45:00', '2025-02-05 17:30:00', 8.75, 'present'),
(35, NULL, NULL, 0.00, 'absent'),
(36, '2025-02-07 09:20:00', '2025-02-07 17:40:00', 8.33, 'present'),
(37, '2025-02-08 09:00:00', '2025-02-08 17:00:00', 8.00, 'present'),
(38, '2025-02-09 09:05:00', '2025-02-09 17:15:00', 8.17, 'present'),
(39, NULL, NULL, 0.00, 'on leave')


--quetion1
write a query to make department_id in employees table to accept null values
--answer
alter table employees modify column department_id int null
--quetion2
query for add a gender column to employees with enum('M','F') and add date to this column
--answer
alter table employees add gender enum('M','F')

update employees set gender ='M'
where employee_id in (1,31,33,35,37,39,41,42,44,46,48,50,52,54,56,57)

--quetion3
Write a query to add a CHECK constraint to ensure base_salary > 2000 in the salaries table
--answer
alter table salaries modify column base_salary int not null check (base_salary > 2000)
alter table salaries drop check `salaries_chk_1`
show create table salaries;

--quetion4
How do you change the phone column in employees to store exactly 10 digits?
--answer
alter table employees add constraint check(phone>1000000000 and phone <9999999999)

--quetion5
write a query to make a column unique
--answer
alter table table_name add constraint constraint_name  unique(column_name)

--question6
Add a Foreign Key to the salaries Table(assume it has no foreign key)
--answer
alter table salaries add constraint foreign_key_1 foreign key(employee_id)
references employees(employee_id)

--question7
 Create an Index on the email Column
 --answer
 create index IX_employees_email on employees(email)
--question8

how to delete foreign key constraint
--answer
alter table table_name drop foreign key foreign_key_name