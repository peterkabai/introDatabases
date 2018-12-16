.read schemaCampaign.sql

-- How many contributions are contained in the data?
select '-- 1. ';
select count(*) from campaign;

-- Show the min and maximum amounts of all contributions
select '-- 2. ';
select min(contb_receipt_amt), max(contb_receipt_amt) 
from campaign;

-- List the (distinct) ids and names of all the candidates in the data.
-- Order by name.
select '-- 3. ';
select distinct cand_id, cand_nm 
from campaign 
order by cand_nm;

-- Show the candidate name and number of contributions, for each candidate
select '-- 4. ';
select cand_nm, count(*) 
from campaign 
group by cand_nm 
order by count(*) desc;

-- Show the candidate name and average contribution amount for each candidate, 
-- looking at positive contributions only
select '-- 5. ';
select cand_nm, round(avg(contb_receipt_amt)) 
from campaign 
where contb_receipt_amt > 0 
group by cand_nm 
order by avg(contb_receipt_amt) desc;

-- Show the candidate name and the total amount received by each candidate.
-- Order the output by total amount received.
select '-- 6. ';
select cand_nm, sum(contb_receipt_amt) 
from campaign 
group by cand_nm 
order by sum(contb_receipt_amt) desc;
