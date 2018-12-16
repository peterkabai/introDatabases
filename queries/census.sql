.read ../schemas/census.sql

-- Show the age of the males in the data set
select '-- 1. ';
select age 
from census 
where sex='Male' 
limit 10;

-- Show all columns for the people with a usid between 100 and 120 (inclusive)
select '-- 2. ';
select * 
from census 
where usid between 100 and 120 
limit 10;

-- Show the workclass and education of people under 20
select '-- 3. ';
select workclass, education 
from census 
where age < 20 
limit 10;

-- Show all columns for people over 80
select '-- 4. ';
select * 
from census 
where age > 80 
limit 10;

-- Show the sex of people who are over 80 and have never married
select '-- 5. ';
select sex 
from census 
where age > 80 and marital_status = "Never_married" 
limit 10;

-- Show the number of years of education for people having 
-- education of 'Some_college'
select '-- 6. ';
select education_num 
from census 
where education = "Some_college" 
limit 10;

-- Show the age, sex, years of education, and capital 
-- gains of people with capital gains > 10000
select '-- 7. ';
select age, sex, education_num, capital_gain 
from census 
where capital_gain > 10000 
limit 10;

-- Show the sex, age, and marital status for people in the armed forces
select '-- 8. ';
select sex, age, marital_status 
from census 
where occupation = "Armed_Forces" 
limit 10;

-- Show the number of years of education for people 
-- over 40 years old in the armed forces
select '-- 9. ';
select education_num 
from census 
where age > 40 and occupation = "Armed_Forces" 
limit 10;

-- Show the marital status of people of age 50 with relationship 'Not_in_family'
select '-- 10. ';
select marital_status 
from census 
where age = 50 and relationship = "Not_in_family" 
limit 10;

-- Show all columns for 17 year olds with less than 5 years of education
select '-- 11. ';
select * 
from census 
where age = 17 and education_num < 5 
limit 10;

-- Show the occupation of women under the age of 40 with a Doctorate degree
select '-- 12. ';
select occupation 
from census 
where sex = "Female" and age < 40 and education = "Doctorate" 
limit 10;

-- Show the workclass of people under the age of 25 with a Masters degree
select '-- 13. ';
select workclass 
from census 
where age < 25 and education = "Masters" 
limit 10;

-- Show all columns for people under the age of 21 with a Masters degree
select '-- 14. ';
select * 
from census where age < 21 and education = "Masters" 
limit 10;

-- Show the age of females with either a bachelors or a masters degree
select '-- 15. ';
select age 
from census 
where sex = "Female" and 
(education = "Masters" or education = "Bachelors") 
limit 10;

-- What is the average age of people from China?
select '-- 16. ';
select avg(age) 
from census 
where native_country="China";

-- What is the average age of people from Taiwan?
select '-- 17. ';
select avg(age) 
from census 
where native_country="Taiwan";

-- Which native countries have "land" in their name?
select '-- 18. ';
select distinct native_country 
from census 
where native_country like "%land%";

-- What values of the attribute 'marital_status' appear 
-- in the data set? Don't show duplicates.
select '-- 19. ';
select distinct marital_status 
from census;

-- What is the average hours per week of work for people 
-- from France between 18 and 25? (inclusive)
select '-- 20. ';
select avg(hours_per_week) 
from census 
where native_country="France" and age >= 18 and age <= 25;

-- Which people (show all columns) are from Laos, Cuba, or Peru?
-- Show only 10 lines.
select '-- 21. ';
select * 
from census 
where native_country="Laos" or native_country="Cuba" or native_country="Peru" 
limit 10;

-- What is the average education years for people 
-- having a native country that is not the US?
select '-- 22. ';
select avg(education_num) 
from census 
where native_country!="United_States";

-- How many executive managers in the data set?
select '-- 23. ';
select count(occupation) 
from census 
where occupation="Exec_managerial";

-- How many executive managers have more than 12 years of education?
select '-- 24. ';
select count(occupation) 
from census 
where occupation="Exec_managerial" and education_num>12;

-- How many different native countries are found in the data set?
select '-- 25. ';
select count(distinct(native_country)) 
from census;
