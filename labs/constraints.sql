-- Start up SQLite and turn on foreign key constraint checking: 
-- PRAGMA foreign_keys = ON;

-- Create a table actor, with fields 'name' and 'birthyear'
create table actor (
   name      varchar(30),
   birthyear int(30)
);
 
-- Try to add actor Simon Pegg (born 1970) into the table twice
insert into actor values ('Simon Pegg', 1970);
insert into actor values ('Simon Pegg', 1970);

-- Drop the 'actor' table.
drop table actor;

-- Create the actor table again, but this time add an 
-- integer ID field that will be the primary key.
create table actor (
   id        int(5) primary key,
   name      varchar(30),
   birthyear int(30)
);
 
-- Try to insert actor Simon Pegg again.  Use an ID value of 1 both times.
insert into actor values (1, 'Simon Pegg', 1970);
insert into actor values (1, 'Simon Pegg', 1970); -- should fail

-- Drop the actor table and revise it again, this time 
-- requiring that birthyear be greater than 1900.
drop table actor;
create table actor (
   id        int(5) primary key,
   name      varchar(30),
   birthyear int(30) check (birthyear > 1900)
);

-- Insert Simon Pegg again, and then try to insert an actor into the actor 
-- table with ID 3, name 'Neil Old', and birthyear 1754.
insert into actor values (1, 'Simon Pegg', 1970);
insert into actor values (3, 'Neil Old', 1754); -- should fail

-- Create another table 'movie', with fields title, year, and director.  
-- Use type varchar(30) for title and director, and integer for year. 
-- Define the primary key to be the attributes title and year. 
-- Include a check so that the year is greater than 1880.
create table movies (
   title    varchar(30),
   year     int(4) check (year > 1880),
   director varchar(30),
   primary key (title, year)
);

-- Insert a movie into the movie table, with title 'Paul', 
-- year 2011, and directory 'Greg Mottola'.
insert into movies values ('Paul', 2011, 'Greg Mottola');

-- Create another table 'appears', with fields actor_ID, title, and year.  
-- Add a constraint so that the actor_ID is the ID of an actor in the 
-- actor table, and so that title and year appear in some row of the movie table. 
-- The primary key should be the attributes actor_ID, title, year.
create table appears (
    actor_ID int(5),
    title    varchar(30),
    year     int(4),
    primary key (actor_ID, title, year),
    foreign key (actor_ID) references actor (id),
    foreign key (title, year) references movies (title, year)
);

-- Insert a row into the 'appears' table with actor_ID = 1, 
-- title = 'Paul', and year = 2010 (NOT 2011).
insert into appears values (1, 'Paul', 2010); -- should fail

-- The problem could be fixed by changing the year of the 
-- movie 'Paul' in the movie table to 2010, or by 
-- changing the insert statement to us# 2011.
-- The movie was actually 2011, so try the 
-- insert statement again, but this time with 2011.
insert into appears values (1, 'Paul', 2011);

