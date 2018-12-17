.read ../schemas/courses.sql

-- In SQLite, define the 'faculty' view covered in lecture
create view faculty as 
select ID, name, dept_name 
from instructor;

-- Examine the contents of the faculty
select * from faculty limit 10;

-- Define a view that gives the highest salary in each department.  
-- Name the view 'max_dept_salary'.  It should have 
-- fields 'dept_name' and 'max_salary'.
create view max_dept_salary as 
select dept_name, max(salary) as max_salary 
from instructor group by dept_name;

-- Use the max_dept_salary view to find the average salary among the instructors 
-- who are the most highly paid in their departments.
select round(avg(max_salary), 2) 
from max_dept_salary;

-- Define an avg_dept_salary view and use it to define a query 
-- showing all instructors whose salary is greater than the average 
-- salary within their own department.
create view avg_dept_salary as 
select instructor, salary 
from instructor natural join 
(select dept_name, round(avg(salary)) as avg_salary 
from instructor group by dept_name) 
where salary > avg_salary;

-- Delete the max_dept_salary view
drop view max_dept_salary;

-- Using the census data
.read ../schemas/census.sql

-- Define an 'occupation_count' view based on the query 
-- select occupation, count(*) from census group by occupation;
create view occupation_count as 
select occupation, count(*) as count
from census 
group by occupation;

-- Use this view in writing a query to find the fraction 
-- of people in each occupation.
select occupation, count 
from occupation_count;

-- Define a 'avg_educ_age' view, using the query
create view avg_educ_age as 
select round(avg(age)) as avg_age 
from census group by education;

-- Using this view, define a query to find the highest 
-- average age for any education level.
select max(avg_age) from avg_educ_age;
