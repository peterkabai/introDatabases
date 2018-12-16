.read ../schemas/courses.sql

-- Show the number of prereqs for each course, by course_id and title.
-- Sort by descending number of prereqs and then ascending course_id.
-- Show only first 10 rows of output.
select '-- 1. ';
select course_id, title, count(*) as cnt 
from course natural join prereq
group by course_id
order by cnt desc, course_id asc
limit 10;

-- Show the 10 departments that have the highest number
-- of prereqs per course, on average.  Order the output
-- by the average number of prereqs, descending, and then
-- department name.
select '-- 2. ';
select department.dept_name, round(count(*)/(count(distinct course.course_id)*(1.0)), 2) as avg
from (course join prereq on course.course_id = prereq.course_id)
natural join department 
group by department.dept_name
order by avg desc, department.dept_name asc
limit 10;

-- Show the 10 courses that are prerequisites
-- for the most other classes.  Show course title and
-- number of prerequisites.  Order by the count, descending,
-- and then the title, ascending.
select '-- 3. ';
select title, cnt
from (select prereq_id, count(*) as cnt
from (course natural join prereq) 
group by prereq_id) join course on prereq_id = course_id
order by cnt desc, title asc
limit 10;

-- For all courses with a prereq chain of three (meaning
-- a course with three sequential prereqs), show the course IDs of
-- the first prereq, the second prereq, the third prereq, and the
-- course itself.  Order by the course ID, then ID of the third
-- prereq, then the second prereq, then the first prereq.
select '-- 4. ';
select prereq_id, p2, p1, c
form from prereq natural join
(select c, prereq_id as p2, p1, prereq_id as course_id
from prereq natural join
(select course_id as c, prereq_id as p1, prereq_id as course_id
from course natural join prereq))
order by c, prereq_id, p2, p1;

-- What are the names of all students who have taken some course? 
-- Don't show duplicates.
select '-- 5. ';
select distinct name 
from student 
natural join takes;

-- What are the names of departments that offer 4-credit courses? 
-- Don't list duplicates.
select '-- 6. ';
select distinct dept_name 
from department 
natural join course 
where credits=4;

-- What are the names and IDs of all students who have received 
-- an A in a computer science class?
select '-- 7. ';
select distinct name, ID 
from student 
natural join takes 
where grade="A" and dept_name="Comp. Sci.";

-- How many B grades have been given to physics majors?
select '-- 8. ';
select count(name) 
from student 
natural join takes 
where grade="B" and dept_name="Physics";

-- What is the average total credits of students who have taken CS-319?
select '-- 9. ';
select avg(tot_cred) 
from student 
natural join takes 
where course_id="CS-319";

-- What is the average total credits of students who have taken CS-101?
select '-- 10. ';
select avg(tot_cred) 
from student 
natural join takes 
where course_id="CS-101";

-- What are the course IDs of courses taught by instructor Katz?
select '-- 11. ';
select course_id 
from instructor 
natural join teaches 
where name="Katz";

-- What are the course IDs of all courses offered by 
-- instructor Crick's department?
select '-- 12. ';
select course_id 
from instructor 
natural join course 
where dept_name=(select dept_name from instructor where name="Crick");

-- What is the course_id, semester, and year of sections of computer science courses?
-- Don't show duplicates.
select '-- 13. ';
select distinct course_id, semester, year 
from course 
natural join section 
where dept_name="Comp. Sci.";

-- What are the names of students who have taken a class 
-- taught by instructor Srinivasan?
select '-- 14. ';
select distinct student.name 
from (student natural join takes), 
(instructor natural join teaches) 
on takes.course_id=teaches.course_id 
where instructor.name="Srinivasan"; 

-- What are the names of students who have taken at least one CS class?
-- Give student names and IDs only, order by name, don't show duplicates,
-- and limit to 10 students.
select "-- 5. ";
select distinct name, ID 
from student 
natural join 
(select ID from takes natural join course where dept_name = "Comp. Sci.") 
order by name limit 10;

-- For each department, find the maximum salary of instructors in that department.
-- Each line of the output should be a department name and a salary value.
-- Give output in order of decreasing maximum salary.
select "-- 16.";
select dept_name, max(salary) as max 
from instructor 
group by dept_name 
order by max desc;

-- For each instructor ID, show the number of courses taught in 2010.
-- Show every instructor, even if no classes taught in 2010.
-- Each line of output should give an instructor ID and a count.
-- Give the output in order of decreasing number of courses taught in 2010,
-- and then by increasing instructor ID.  (In other words, if two 
-- instructors taught the same number of courses, list the instructors
-- by increasing ID.)
select "-- 17.";
select instructor.ID, count(course_id) as cnt 
from instructor left natural join (
select * from teaches where year = 2010) 
group by instructor.ID 
order by cnt desc, instructor.ID;

-- Which students (by ID) received the most grades of "A" or "A-"?
-- List all students with the highest number of A and A- grades, ordered
-- by name.  Show ID, name, and number of A or A- grades.
-- Hint: you may find it easiest to use a 'with' statement.
select "-- 18.";
select * from (
select ID, name, count(*) as num from student natural join (
select * from takes where grade in ("A", "A-")) group by ID) where num = (
select max(num) from (
select count(*) as num from student natural join (
select * from takes where grade in ("A", "A-")) group by ID))
order by name;

-- Which courses have not been taught at any time?
-- For each such course give the course ID and title.
-- List in order of course title, and then course ID.
-- Limit output to 15 courses.
select "-- 19.";
select distinct course_id, title 
from course left natural join teaches 
where year is null 
order by title, course_id 
limit 15;
