.read ../schemas/pharmacy.sql

-- For each doctor, show the drug manuafaturer who's 
-- drugs are presscribed most often:
select "-- 1";
select doc_name, max(comp_name)
from doctor 
natural join prescription 
natural join drugs_in_presc
natural join drug
group by doc_name;

-- Show the average age of the patients taking each drug:
select "-- 2";
select trade_name, avg(age)
from patient
natural join prescription
natural join drugs_in_presc
group by trade_name;

-- For each drug, show which doctor has prescribed it the most:
select "-- 3";
select trade_name, max(doc_name)
from drugs_in_presc
natural join prescription
natural join doctor
group by trade_name;

-- List the pescription number for prescriptions that can’t be 
-- filled by the pharmacy it was sent to:
select "-- 4";
select presc_num 
from drugs_in_presc
natural join prescription
where (presc_num, trade_name) not in
(select presc_num, trade_name
from drugs_in_presc
natural join prescription
natural join contract);

-- List the patients who have the same drug prescribed by multiple doctors:
select "-- 5";
select pat_name, trade_name, count(*)
from prescription
natural join patient
natural join drugs_in_presc
group by med_rec_num, trade_name
having count(*) > 1;
