--EPS dml queries

--Q1
Insert a new employee without a department
--A
insert into employees (first_name, last_name, email, phone, hire_date,status, address, dob) 
values
('nav', 'koolati', 'nav.koolati@gmail.com', '9345862839', '2023-02-05',
'active', '49,cherukupalli,guntur,andhrapradesh', '1988-03-22');

--Q2
Update the salary of all employees in the Finance department by 10%.
--A
update salaries as s
inner join employees as e on s.employee_id = e.employee_id
inner join departments as d on e.department_id = d.department_id
set s.base_salary = s.base_salary * 1.10
where d.name = 'finance';