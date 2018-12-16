.read ../schemas/census.sql

-- What is the average age for each workclass?
select workclass, round(avg(age)) 
from census g
group by workclass 
limit 5;

-- What is average number of years of education by occupation?  
select occupation, round(avg(education_num)) 
from census 
group by occupation 
limit 5;

-- What is the average age by occupation, listed in order of average age? 
select occupation, round(avg(age)) 
from census 
group by occupation 
order by avg(age) 
limit 5;

-- What is the average of years-of-education by both workclass and sex?
select workclass, sex, round(avg(education_num)) 
from census 
group by workclass, sex 
limit 6;

-- What is the average, maximum, and minimum number of 
-- years of education by workclass?  
select workclass, round(avg(education_num)), round(max(education_num)), round(min(education_num)) 
from census 
group by workclass 
limit 6;
