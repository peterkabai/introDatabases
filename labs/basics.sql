.read ../schemas/patients.sql

-- Show all patient names
select first_name from patient;

-- Show the last name of patient nomber 234
select last_name from patient where patient_no = 234;

-- Show all wards with a patient with lst name 'Smith'
select ward from patient where last_name = 'Smith';

-- Show all info on patients in ward 6
select * from patient where ward = 6;

-- Show the name of all female patients
select last_name, first_name from patient where sex = 'F';

-- Show the ward for each patient number
select patient_no, ward from patient;

-- Show all patient numbers between 200 and 300
select patient_no from patient where patient_no between 200 and 300; 

-- Show all patient names in ward 6 or 7
select first_name, last_name from patient where ward = 6 or ward = 7;

-- Show the wards that males are in
select ward from patient where sex = 'M';

-- Show the last name of all males in ward 3
select last_name from patient where ward = 3 or sex = 'M';

.read ../schemas/census.sql

-- What 'workclass' values appear in the data?
-- Don't show any duplicates
select distinct(workclass) from census;

-- What 'relationship' values appear in the data?
select distinct(relationship) from census;

-- What is the minimum number of years of education in the data?
select min(education_num) from census;

-- What is the maximum number of years of education?
select max(education_num) from census;

-- What is the average age of people in the data?
select avg(age) from census;

-- What are the minimum and maximum number of years of education?
select min(education_num), max(education_num) from census;

-- How many countries of birth appear in the data?
select count(distinct(native_country)) from census;

-- Which native countries start with 'F'?
select distinct(native_country) from census where native_country like("F%");

-- Which native countries end with 'a'?
select distinct(native_country) from census where native_country like("%a");

-- Which native countries do not have 'a' anywhere in their name?
select distinct(native_country) from census where native_country not like("%a%");

-- What is the average age of people who have never worked?  
select avg(age) from census where workclass = "Never_worked";

-- If you still have time, what are all the possible combinations of the attributes 
-- 'education' and 'education_num' that are found in the data set?
select distinct education, education_num from census;
