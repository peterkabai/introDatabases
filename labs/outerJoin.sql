-- Read in the data and records
.read ../schemas/courses.sql

-- Perform a natural join on the student and takes tables.
select * 
from student 
natural join takes;

-- Perform a natural left outer join on the student and takes tables.  
select * 
from student 
natural left join takes;

-- Write an SQL query that gives the names of students 
-- who have not taken any classes. 
select name 
from student natural left join takes 
where course_id is null;

-- Write an SQL query that gives the course_id of courses have not been taught.
select course_id 
from course natural left join teaches 
where sec_id is null;

-- Write an SQL query that gives the number of courses taken 
-- for every student in the student table.  
-- Students who have taken no courses should have a course count of 0.
select name, count(course_id) 
from student 
natural left join takes 
group by name 
order by count(course_id) desc;