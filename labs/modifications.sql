-- Turn on foreign key constraint checking
pragma foreign_keys = on;

-- Read in the data and records
.read ../schemas/courses.sql

-- Add a new department ‘Chemistry’, 
-- with building ‘Watson’ and budget $125,000.
insert into department 
values("Chemistry", "Watson", 125000);

-- Add a new course, with course_id ‘CS-130’, title "Discrete Math", 
-- dept_name "Comp. Sci.", and credits = 3
insert into course 
values("CS-130", "Discrete Math", "Comp. Sci.", 3);

-- Make the new discrete math class a prereq for all other CS classes.
insert into prereq select course_id, "CS-130" 
from course where dept_name = "Comp. Sci.";

-- Update instructor salaries by increasing them by 3%.
update instructor set salary = salary * 1.03;

-- Update physics students by adding 3 to their total credits.
update student set tot_cred = tot_cred + 3 where dept_name = "Physics";

-- Try to delete course 319 from the course table.
-- What happens when you do this and why?
delete from course where course_id = "319"; 
-- Error: FOREIGN KEY constraint failed
-- this happens becuae the course_id in course is used at a 
-- primary key in other tables
