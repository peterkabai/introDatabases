.read ../schemas/courses.sql

-- For every course taken by a student, show the 
-- student’s ID, name, and course taken.
select ID, name, course_id 
from student 
natural join takes;

-- Show the names of all students who have taken course
-- '158' as well as the year in which they took the course.
select name, year 
from student natural join takes 
where course_id="158";

-- For every course taught by an instructor, 
-- show the instructor’s name and the course that is taught.
select name, course_id 
from instructor natural join teaches;

-- Do the same as in the previous question, but do not show duplicates.
select distinct name, course_id 
from instructor natural join teaches;

-- Do the same as in the previous question, but sort by instructor name.
select distinct name, course_id 
from instructor 
natural join teaches 
order by name;

-- Give the names of the buildings in which the student with 
-- name 'Williams' has taken a class.
select building from student natural join takes natural join section where name="Williams";

-- Write a SQL query that gives the dept_name, course_id, title, 
-- semester, and year of all the sections offered by the 'Physics' department.
select dept_name, course_id, title, semester, year 
from course natural join 
section where dept_name="Physics"; 
