.read ../schemas/courses.sql

-- Add a 'salary_audits' table
create table salary_audits (
   ID   varchar(5),
   name varchar(20),
   dept_name varchar(20),
   old_salary numeric(8,2),
   new_salary numeric(8,2),
   time_of varchar(25)
);

-- Add a 'salary_update' trigger, that will cause a salary update 
-- to be audited if the salary increase is more than 10%:
create trigger salary_update after update on instructor
  when (new.salary > old.salary * 1.1)
begin
   insert into salary_audits values(new.ID, new.name, new.dept_name, old.salary, new.salary, datetime('now'));
end;

-- Test the trigger by updating two instructor salaries.  
-- First, try increasing one instructor’s salary by a small amount
update instructor set salary = salary * 1.04 where name = "Mingoz";
	
-- Next, try increasing an instructor’s salary by a large amount
update instructor set salary = salary * 1.20 where name = "Mingoz";
	
-- Check to see the trigger does what it is supposed to.
select * from salary_audits;

-- Now make a ‘total_credits_audit’ table, to provide a record of students 
-- who are signing up for more than 16 credits in a semester.  
-- Decide for yourself what the columns of the new table should be.  
-- Add a trigger that will cause a insert into the takes table to be audited 
-- if a student’s total credits become more than 16.
create table total_credits_audit ( 
ID varchar(5), 
name varchar(20) not null, 
dept_name varchar(20), 
tot_cred numeric(3,0) check (tot_cred > 16),
primary key (ID), 
foreign key (dept_name) references department 
on delete set null
);
create trigger total_credits_update after update on student
  when (new.tot_cred > 16)
begin
   insert into total_credits_audit values(new.ID, new.name, new.dept_name, new.tot_cred, datetime('now'));
end;
