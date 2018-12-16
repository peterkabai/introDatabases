.read ../schemas/campaignNormal.sql

-- Create a view 'c_summary' summarizing campaign contributions,
-- with four attributes: cand_name, contbr_name, amount, and zip.  
-- Then write a query to select the first 20 rows of your view.
-- You may use this view in following problems.
select "-- 1.";
create view c_summmary as 
select candidate.name, contributor.name, amount, zip 
from contributor join contribution on contributor.contbr_id = contribution.contbr_id 
join candidate on candidate.cand_id = contribution.cand_id
limit 20;
select * from c_summmary limit 20;

-- For each of the occupations "STUDENT", "TEACHER", and "LAWYER",
-- show the occupation, and average size (in dollars) of contribution
-- from contributors with that occupation.
select "-- 2.";
select occupation, round(avg(amount))
from contribution natural join contributor 
group by occupation 
having occupation in ("STUDENT", "TEACHER", "LAWYER");

-- Let's focus on lawyers.  For each candidate, show the candidate
-- name and total dollar amount of contributions to that candidate,
-- but only for contributions from those with occupation "LAWYER" and
-- zip codes that start with 939.
select "-- 3.";
select name, sum(amount) from
(select candidate.name, contributor.name, amount, zip, occupation
from contributor 
join contribution on contributor.contbr_id = contribution.contbr_id 
join candidate on candidate.cand_id = contribution.cand_id 
where occupation = "LAWYER" and substr(zip, 1, 3) = "939")
group by name;

-- Do lawyers list their occupations in lots of different ways?
-- List the distinct occupations that contain "LAWYER" within them?
select "-- 4.";
select distinct occupation 
from contributor 
where occupation like '%LAWYER%';

-- How many contributors have occupation "LAWYER"?  Give just the count.
select "-- 5.";
select count(*) 
from contributor 
where occupation = "LAWYER";

-- How many contributors have an occupation that contains "LAWYER"?
-- Give just the count.
select "-- 6.";
select count(*) 
from contributor 
where occupation like '%LAWYER%';

-- Give occupation and number of contributors with that occupation for
-- all occupations that contain the string "LAWYER".  Order by decreasing
-- count.
select "-- 7.";
select occupation, count(*) 
from contributor 
where occupation 
like '%LAWYER%' 
group by occupation 
order by count(*) desc;

-- The occupation "LAWYER FOR THE OPPRESSED" has an unusual name.
-- Look at all fields of the contributor table for contributors who
-- list their occupation this way.
select "-- 8.";
select * 
from contributor 
where occupation = "LAWYER FOR THE OPPRESSED";

-- What is the average number of contributions per zip code?  Use only
-- the first five digits of the zip code.  Your result should be a single number.
select "-- 9.";
select sum(num_contbr) / count(num_contbr) from
(select count(*) as num_contbr
from (select substr(zip, 1, 5) as shortzip from contributor natural join contribution)
group by shortzip);
       
-- Looking at only the first five digits of the zip code, show the 20
-- zip codes with the highest number of contributors (not contributions).
-- Give the five-digit form of the zip code plus the number of contributors
-- with that zip.  Order by descending number of contributors.
select "-- 10.";
select shortzip, count(distinct(contbr_id))
from (select substr(zip, 1, 5) as shortzip, contbr_id 
from contributor natural join contribution)
group by shortzip 
order by count(distinct(contbr_id)) desc 
limit 20;

-- For each distinct last name/zip combination, list the last name,
-- zip, and number of contributors with that last name/zip
-- combination, but only for last name/zip combinations that occur more
-- 6 times. List by decreasing count.  HINT: use 'subtr' and
-- 'instr' to get the last name from the name field.
select "-- 11.";
select lname, zip, count(*) from
(select substr(name, 1, instr(name, ",")-1) as lname, zip from contributor) 
group by lname, zip 
having count(*) > 6 
order by count(*) desc;

-- For each contributor that made more than 75 contributions,
-- show the contributor name, total dollar amount contributed,
-- and number of contributions.
select "-- 12.";
select name, sum(amount), count(*) 
from (select * from contributor 
natural join contribution) 
group by name having count(*) > 75 
order by count(*) desc;

-- For each candidate, what fraction of all (positive) contributions
-- came from contributions > $2500?   Show candidate name and fraction.
select "-- 13.";
select name,
case
when typeof(sum2) = typeof(1) and typeof(sum1) = typeof(1)
then round((sum2)/(sum1*1.0)*100 - 0.5)
else round(((sum2)/(sum1*1.0))*100, 1)
end
as percent
from
(select name as name, sum(amount) as sum1 
from (select name, amount from candidate 
natural join contribution where amount > 0) 
group by name)
natural join
(select name as name, sum(amount) as sum2 from 
(select name, amount from candidate 
natural join contribution 
where amount > 2500) 
group by name)
order by percent desc, name desc;   

-- List the contributions to each candidate from contributors
-- that give "SALINAS" as their city. 
-- Show candidate name, and total contributed amount.
-- Order the output by total contributed amount, descending.
select '-- 14. ';
select candidate.name, sum(amount) as sum
from contributor join contribution on contributor.contbr_id = contribution.contbr_id 
join candidate on candidate.cand_id = contribution.cand_id
group by city, candidate.name 
having city = "SALINAS"
order by sum desc;

-- For each of the local zip codes, and each of the candidates,
-- show the number of contributions (if at least one contribution was
-- made).  Order by zip code and then number of contributions.
-- NOTE: In this and the following questions, by "local", I mean in 
-- the zip codes that begin with 93933, 93901, 93905, 93955, or 93906.
select '-- 15. ';
select substr(zip, 1, 5) as shortzip, candidate.name, count(amount) as counts
from contributor 
join contribution on contributor.contbr_id = contribution.contbr_id 
join candidate on candidate.cand_id = contribution.cand_id
where shortzip in ("93933", "93901", "93905", "93955", "93906")
group by shortzip, candidate.name
order by shortzip, counts desc;

-- Who are the top 10 local contributors in terms of total amount
-- contributed?  Show the contributor names and the amount they spent.
select '-- 16. ';
select contributor.name, sum(amount) as sum
from contributor 
natural join contribution
where substr(zip, 1, 5) in ("93933", "93901", "93905", "93955", "93906")
group by contributor.name
order by sum desc
limit 10;

-- Show date and amount for all contributions from 'BATTS, ERIC'.
-- Order by amount, decreasing.
select '-- 17. ';
select date, amount
from contributor 
natural join contribution
where name = "BATTS, ERIC"
order by amount desc;

-- On average, how many contributions did each contributor make?
-- Give a single number, rounded to one digit to the right of the
-- decimal point.
select '-- 18. ';
select round(count(*)*1.0/count(distinct(contbr_id)),1)
from contribution;

-- Create a view 'contbr_date' that has all the attributes of
-- the contribution table, but additionally has fields 
-- 'month', 'year', 'day', and 'month_num'.  Field 'year' will be a
-- four-digit number, like '2015'.  Field 'month_num' will be
-- a number from 1 to 12.
select '-- 19. ';
create view contbr_date as select 
  *, 
  substr(date,4,3) as month, 
  "20" || substr(date,8,2) as year,
  substr(date,1,2) as day,
  case
    when substr(date,4,3) = "JAN"
    then 1
    when substr(date,4,3) = "FEB"
    then 2
    when substr(date,4,3) = "MAR"
    then 3
    when substr(date,4,3) = "APR"
    then 4
    when substr(date,4,3) = "MAY"
    then 5
    when substr(date,4,3) = "JUN"
    then 6
    when substr(date,4,3) = "JUL"
    then 7
    when substr(date,4,3) = "AUG"
    then 8
    when substr(date,4,3) = "SEP"
    then 9
    when substr(date,4,3) = "OCT"
    then 10
    when substr(date,4,3) = "NOV"
    then 11
    when substr(date,4,3) = "DEC"
    then 12
  end
  as month_num
  from contribution;

-- Display the first 10 rows of view 'contbr_date'
select '-- 20. ';
select * from contbr_date limit 10;

-- Which distinct month/year combinations are found in the data?
-- Months should be shown as JAN, FEB, etc.  Years should be shown as
-- 2015, 2016, etc.  Order chronologically!
select '-- 21. ';
select distinct month, year 
from contbr_date 
order by year, month_num;

-- Show the sum of all contributions by month and year, ordered chronologically
select '-- 22. ';
select month, year, round(sum(amount)) 
from contbr_date 
group by month, year 
order by year, month_num;

-- Show the number of contributions by month and year, ordered chronologically.
select '-- 23. ';
select month, year, count(*) 
from contbr_date 
group by month, year 
order by year, month_num;

-- Show the average contribution amount by month and year, ordered chronologically.
select '-- 24. ';
select month, year, round(sum(amount)/round(count(*))) 
from contbr_date 
group by month, year 
order by year, month_num;

-- List the id and name of the candidate with the largest total
-- sum of contributions.
select '-- 25. ';
select cand_id, name, sum(amount) 
from candidate natural join contribution 
group by cand_id 
order by sum(amount) 
desc limit 1;

-- For each candidate, give the candidate name, id, and the
-- number of contributions to that candidate between 5000 and 6000
-- dollars.  The output should show each candidate, even if the
-- number of contributions of between 5000 and 6000 dollars is 0.
-- Order by decreasing number of 5000-6000 dollar contributions.
select '-- 26. ';
select cand_id, name, coalesce(num, 0) from
candidate left outer join  
(select cand_id as cand, count(*) as num
from contribution
where amount >= 5000 and amount <= 6000
group by cand_id) on candidate.cand_id = cand
order by coalesce(num, 0) desc, cand_id;

-- Show the sum of all contributions by day in Nov, 2015, ordered
-- chronologically.  Show the month, day, year, and sum of all
-- contributions for the day.
select '-- 27. ';
select 
substr(date,4,3) as month,
substr(date,0,3) as day,
2000 + substr(date,8,3) as year,
round(sum(amount))
from contribution
where date like "%NOV-15"
group by substr(date,0,3)
order by year;

-- Show the 10 days with the most contributions, ordered chronologically.
-- For each day, show the day, month, year, and sum of  all contributions 
-- for the day.
select '-- 28. ';
select * from (select substr(date,0,3) as day, substr(date,4,3) as month, 2000 + substr(date,8,3) as year, round(sum(amount)) as sum
from contribution
group by date
order by sum desc
limit 10)
order by year, 
case
  when month = "JAN"
  then 1
  when month = "FEB"
  then 2
  when month = "MAR"
  then 3
  when month = "APR"
  then 4
  when month = "MAY"
  then 5
  when month = "JUN"
  then 6
  when month = "JUL"
  then 7
  when month = "AUG"
  then 8
  when month = "SEP"
  then 9
  when month = "OCT"
  then 10
  when month = "NOV"
  then 11
  when month = "DEC"
  then 12
end,
day;

-- For each candidate, show the total amount the candidate
-- received on June 30, 2015.  Order by descending amount received on that day.
-- Hint: check out the sqlite 'coelesce' function to handle the
-- issue where a sum of null values gives null.
select '-- 29. ';
select name, coalesce(sum(amount), 0) as amt from
candidate left outer join  
(select cand_id as cand, amount
from contribution
where date = "30-JUN-15") on candidate.cand_id = cand
group by cand_id
order by amt desc, name;
