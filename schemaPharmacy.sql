--------------------------------------------------------------------
--
-- Drug Store Schema
-- Webb Kabai Awesome Database Consultants LLC
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
  doc_lic      varchar(11),
  pat_name     varchar(40),
  age          int(130),
  addr_city    varchar(20),
  addr_state   varchar(20),
  addr_street  varchar(20),
  addr_zip     int 
);

create table has_doc (
  doc_lic	   varchar(15) primary key,
  med_rec_num  varchar(15) primary key,
  foreign key(doc_lic) references doctor(doc_lic)
);

create table has_prim_doc (
  doc_lic	   varchar(15) primary key,
  med_rec_num  varchar(15) primary key,
  foreign key(doc_lic) references doctor(doc_lic)
);

create table prescription (
  doc_lic     varchar(15) primary key,
  med_rec_num varchar(15) primary key,
  trade_name  varchar(40) primary key,
  presc_date  varchar(10),
  store_num   int,
  foreign key(doc_lic)     references doctor(doc_lic),
  foreign key(med_rec_num) references patient(med_rec_num),
  foreign key(trade_name)  references drug(trade_name),
  foreign key(store_num)   references pharmacy(store_num)
);

create table drug (
  trade_name varchar(40) primary key,
  formula    varchar(40),
  comp_name  varchar(20),
  foreign key(comp_name) references company(comp_name)
);

create table company (
	comp_name varchar(40) primary key,
	phone_num  varchar(15)
)

create table pharmacy (
  store_num  int primary key,
  store_name varchar(40),
  address    varchar(40),
  phone_num  varchar(15)
);

create table contract (
  contract_id int primary key,
  comp_name   varchar(20),
  store_num   int,
  supervisor  varchar(40),
  start_date  varchar(20),
  end_date    varchar(20),
  text        varchar(100),	
  foreign key(comp_name) references company(comp_name),
  foreign key(store_num) references pharmacy(store_num)
);


