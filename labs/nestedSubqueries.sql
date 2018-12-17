.read ../schemas/census.sql

-- What is the highest average age for any education level?  
select round(max(avgage)) 
from (select avg(age) as avgage 
from census 
group by education_num);

select round(avg(age)) as avgage 
from census 
group by education_num 
order by avg(age) desc 
limit 1;

-- What are the usid values and occupations of the 
-- people in the data set with the highest age? 
select usid, occupation 
from census 
where age in (select age from census group by age order by age desc limit 1) 
order by usid limit 6;

select usid, occupation 
from census 
where age in (select max(age) from census) 
order by usid 
limit 6;

--If you can solve both 1 and 2, try solving each of them in another way.