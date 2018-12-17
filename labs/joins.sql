-- Read in the data and records
.read ../schemas/courses.sql

-- For every course taken by a student, show 
-- the student’s ID, name, and course taken.
select takes.ID, student.name, takes.course_id 
from student, takes on takes.ID = student.ID;

-- Show the names of all students who have taken course 843, 
-- as well as the year in which they took the course.
select student.name, takes.year 
from student, takes on takes.ID = student.ID 
where takes.course_id = '843';

-- For every course taught by an instructor, show the 
-- instructor’s name and the course that is taught.
select instructor.name, teaches.course_id 
from instructor, teaches on instructor.ID = teaches.ID;

-- Do the same as in the previous question, but do not show duplicates.
select distinct instructor.name, teaches.course_id 
from instructor, teaches on instructor.ID = teaches.ID;

-- Do the same as in the previous question, 
-- but sort by instructor name.
select distinct instructor.name, teaches.course_id 
from instructor, teaches on instructor.ID = teaches.ID 
order by instructor.name;

-- Give the names of the buildings in which the student with name “Williams” has taken a class.
select distinct section.building
from section, takes, student 
on takes.sec_id = section.sec_id
where name = "Williams";
