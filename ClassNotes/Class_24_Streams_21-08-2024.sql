      Session-24
--------------------------
Streams 
CDC --> Change data Capture 


--------- Stream example: INSERT ---------

//create database
create or replace transient database streams_db;

//create example table 
create or replace table sales_raw_staging(
  id varchar,
  product varchar,
  price varchar,
  amount varchar,
  store_id varchar);

//insert values
insert into sales_raw_staging 
    values
        (1,'Banana',1.99,1,1),
        (2,'Lemon',0.99,1,1),
        (3,'Apple',1.79,1,2),
        (4,'Orange Juice',1.89,1,2),
        (5,'Cereals',5.98,2,1); 

select * from sales_raw_staging;

//create table store_table
create or replace table store_table(
  store_id number,
  location varchar,
  employees number);

// insert records
INSERT INTO STORE_TABLE VALUES(1,'Chicago',33);
INSERT INTO STORE_TABLE VALUES(2,'London',12);

select * from STORE_TABLE;
delete from sales_raw_staging;

//create final_table
create or replace table sales_final_table(
  id int,
  product varchar,
  price number,
  amount int,
  store_id int,
  location varchar,
  employees int);

//use joins and combine two tables and insert
//Insert into final table
INSERT INTO sales_final_table 
    SELECT 
    SA.id,
    SA.product,
    SA.price,
    SA.amount,
    ST.STORE_ID,
    ST.LOCATION, 
    ST.EMPLOYEES 
    FROM SALES_RAW_STAGING SA
    JOIN STORE_TABLE ST ON ST.STORE_ID=SA.STORE_ID ;

//Create a stream object
create or replace stream sales_stream on table sales_raw_staging;

SHOW STREAMS;

DESC STREAM sales_stream;

-- Get changes on data using stream (INSERTS)
select * from sales_stream;

select * from sales_raw_staging;

-- insert values 
insert into sales_raw_staging  
    values
        (6,'Mango',1.99,1,2),
        (7,'Garlic',0.99,1,1);


-- Get changes on data using stream (INSERTS)
select * from sales_stream;

select * from sales_raw_staging;
                
select * from sales_final_table;  

-- Consume stream object
INSERT INTO sales_final_table 
    SELECT 
    SA.id,
    SA.product,
    SA.price,
    SA.amount,
    ST.STORE_ID,
    ST.LOCATION, 
    ST.EMPLOYEES 
    FROM SALES_STREAM SA
    JOIN STORE_TABLE ST ON ST.STORE_ID=SA.STORE_ID ;

-- Get changes on data using stream (INSERTS)
select * from sales_stream;

-- insert values 
insert into sales_raw_staging  
    values
        (20,'Paprika',4.99,1,2),
        (30,'Tomato',3.99,1,2);


 -- Consume stream object and create task
 CREATE OR REPLACE TASK SALES_INSERT
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = 'USING CRON */10 * * * * UTC'
AS 
INSERT INTO sales_final_table 
    SELECT 
    SA.id,
    SA.product,
    SA.price,
    SA.amount,
    ST.STORE_ID,
    ST.LOCATION, 
    ST.EMPLOYEES 
    FROM SALES_STREAM SA
    JOIN STORE_TABLE ST ON ST.STORE_ID=SA.STORE_ID ;

    
select * from sales_stream;

SHOW TASKS;

ALTER TASK SALES_INSERT  RESUME ;

SELECT * FROM SALES_FINAL_TABLE;

DELETE FROM SALES_FINAL_TABLE ;

SELECT * FROM SALES_RAW_STAGING;  
      
SELECT * FROM SALES_STREAM;


















