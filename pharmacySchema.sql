--------------------------------------------------------------------
--
-- Drug Store Schema
--
--------------------------------------------------------------------

create table doctor (
  doc_lic	varchar(15) primary key,
  doc_name  varchar(40),
  specialty varchar(20),
  years_exp int(110)
);

create table patient (
  med_rec_num  varchar(15) primary key,
  pat_name     varchar(40),
  age          int(130),
  addr_city    varchar(20),
  addr_state   varchar(2),
  addr_street  varchar(20),
  addr_zip     int 
);

create table has_doc (
  doc_lic	   varchar(15),
  med_rec_num  varchar(15),
  foreign key (doc_lic) references doctor (doc_lic),
  primary key (doc_lic, med_rec_num)
);

create table has_prim_doc (
  doc_lic	   varchar(15),
  med_rec_num  varchar(15),
  foreign key (doc_lic) references doctor (doc_lic),
  primary key (doc_lic, med_rec_num)
);

create table prescription (
  doc_lic     varchar(15),
  med_rec_num varchar(15),
  trade_name  varchar(40),
  presc_date  varchar(10),
  store_num   int,
  foreign key (doc_lic)     references doctor (doc_lic),
  foreign key (med_rec_num) references patient (med_rec_num),
  foreign key (trade_name)  references drug (trade_name),
  foreign key (store_num)   references pharmacy (store_num),
  primary key (doc_lic, med_rec_num, trade_name)
);

create table drug (
  trade_name varchar(40) primary key,
  formula    varchar(40),
  comp_name  varchar(20),
  foreign key(comp_name) references company(comp_name)
);

create table company (
	comp_name varchar(40) primary key,
	phone_num varchar(15)
);

create table pharmacy (
  store_num  int primary key,
  store_name varchar(40),
  address    varchar(40),
  phone_num  varchar(15)
);

create table contract (
  contract_id int primary key,
  trade_name  varchar(40),
  store_num   int,
  supervisor  varchar(40),
  start_date  varchar(20),
  end_date    varchar(20),
  text        varchar(100),
  foreign key (store_num) references pharmacy (store_num),
  foreign key (trade_name) references drug (trade_name)
);

-- inserting doctors
insert into doctor values (182748593, "Brooke Le Femur", "Orthopeadist", 10);
insert into doctor values (992394837, "Ihav Lootse Paine", "Colon and Rectal Surgeon", 20);
insert into doctor values (345687787, "Stichem Wells", "General Surgeon", 50);
insert into doctor values (394938294, "Makyou Feelgood", "Anesthesiologist", 30);
insert into doctor values (349000878, "Pat Healerman", "General Surgeon", 10);
insert into doctor values (234468765, "Yo No Hart", "Cardiac Surgeon", 110);

-- insert patients
insert into patient values (34948, "Neil Patrick Harris", 45, "Los Angeles", "CA", "123 Main Street", 90210);
insert into patient values (23423, "Donald Trump", 79, "Washington", "DC", "1500 Pensylvania Ave.", 20001);
insert into patient values (12232, "Matt Webbster", 18, "Gilroy", "CA", "Gilroy Crossing 123", 95020);
insert into patient values (98723, "Pita Kabi", 12, "Geelroi", "CA", "Corny Lane 1111", 95404);
insert into patient values (12323, "Santa Clause", 99, "North Pole", "AK", "Alaska Hwy 100", 98893);
insert into patient values (12350, "Dwayne Jhonson", 39, "Hollywood", "CA", "Magnolia Dr.", 90211);	
insert into patient values (86900, "Mark Zuckerberg", 30, "Menlo Park", "CA", "Facebook Ln.", 94404);
insert into patient values (99488, "Stuart Little", 3, "Small Ville", "FL", "500 Mouse St. SW", 68694);

-- insert patient and primary care doctor relationship
insert into has_prim_doc values (182748593, 34948);
insert into has_prim_doc values (182748593, 23423);
insert into has_prim_doc values (394938294, 12232);
insert into has_prim_doc values (394938294, 98723);
insert into has_prim_doc values (234468765, 12323);
insert into has_prim_doc values (234468765, 12350);	
insert into has_prim_doc values (234468765, 86900);
insert into has_prim_doc values (234468765, 99488);
	
-- insert patient and doctor relationship
insert into has_doc values (349000878, 34948);
insert into has_doc values (234468765, 34948);
	
-- insert drugs
insert into drug values ("ChocoLax", "50% benzine 50% chocolate", "Drugs Inc.");
insert into drug values ("Naproxen ", "10% caffine 90% placebo", "Drugs Inc.");
insert into drug values ("Flonase", "40% flow 20% saline solution, 40% vaporizer", "Drugs Inc.");
insert into drug values ("Acetaminophen", "90% acetate 10% inophen", "Drugs Inc.");
insert into drug values ("Ibuprophen", "40% ibuteral 20% magnesium, 40% inophen", "Pill Pills Pills");
insert into drug values ("Painstop Ultra", "50% stopping power 50% extra strength", "Pill Pills Pills");
insert into drug values ("AdvAir", "99% air 1% actual medication", "Pill Pills Pills");
	
-- insert company
insert into company values ("Drugs Inc.", "(408)456-9289");
insert into company values ("Pills Pills Pills", "(800)PIL-PILL");
insert into company values ("Meds 4 Cheap", "(800)227-8255");

-- insert pharmacy
insert into pharmacy values (123, "Walgreens", "190 Walnut Ave, CA", "(800)987-6574");
insert into pharmacy values (900, "CVS", "2000 Circle Way, NY", "(800)456-1234");	
insert into pharmacy values (420, "Target", "45 Market Parkway", "(800)400-2000");		
insert into pharmacy values (999, "Walmart", "100 Walmart Lane", "(408)767-9067");	
	
-- insert contracts
insert into contract values (00023423, "ChocoLax", 123, "Super Mc. Visor", "4/4/2018", "4/4/2019", "This contract stipulates the facts of the contract agreement");
insert into contract values (00087475, "ChocoLax", 900, "Super Mc. Visor", "4/4/2018", "4/4/2019", "This contract stipulates the facts of the contract agreement");
insert into contract values (00059400, "ChocoLax", 420, "Super Mc. Visor", "9/9/2017", "4/4/2019", "This contract stipulates the facts of the contract agreement");
insert into contract values (00034939, "Naproxen", 123, "Super Mc. Visor", "4/4/2018", "4/4/2019", "This contract stipulates the facts of the contract agreement");
insert into contract values (00003986, "Naproxen", 900, "Super Mc. Visor", "4/4/2018", "4/4/2019", "This contract stipulates the facts of the contract agreement");
insert into contract values (00009756, "Naproxen", 420, "Super Mc. Visor", "9/9/2017", "4/4/2019", "This contract stipulates the facts of the contract agreement");


