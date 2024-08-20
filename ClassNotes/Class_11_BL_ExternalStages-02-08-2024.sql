 Session-11
--------------------------
								
Data Loading 
								
External stages 

     Azure , AWS , GCP, SAP , Hadoop , API , (Weather)


1.create database / schema
2.create Exteranl stage (url = Azure/s3 ..ect)
3.List @stage (How many files)
4.create table
5.Load the data by using copy command

--------------------------------------------

//Database to manage stage objects, fileformats etc.
;

create or replace database manage_db;

create or replace schema external_stages;

use manage_db.external_stages;

//creating external stage

create or replace stage 
manage_db.external_stages.aws_stage
url='s3://bucketsnowflakes3/sampledata.csv';

-- credentials=(aws_key_id = 'ABCD_Dummy_ID' aws_secret_key='1234abcd_key')

//Descriptio of external stage

desc stage manage_db.external_stages.aws_stage;

list @aws_stage;
   
   select s.$1, s.$2,s.$3,s.$4 from @manage_db.external_stages.aws_stage s;
// Alter external stage   

ALTER STAGE aws_stage
    SET credentials=(aws_key_id='XYZ_DUMMY_ID' aws_secret_key='987xyz');


// publicly accessible staging area

create or replace stage
manage_db.external_stages.aws_stage
url='s3://bucketsnowflakes3';

//List files in stage 

list @aws_stage;

//createing orders table
;
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
    FROM @aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*';

    select * from OUR_FIRST_DB.PUBLIC.ORDERS;

    select category, count(*) from 
    OUR_FIRST_DB.PUBLIC.ORDERS group by category; 

    create or replace table OUR_FIRST_DB.PUBLIC.order_ex as(
    select order_id, amount from OUR_FIRST_DB.PUBLIC.ORDERS
    );

  select * from OUR_FIRST_DB.PUBLIC.ORDER_ex;

  -------------------------------------------------

// Transforming using the select statement

copy into OUR_FIRST_DB.PUBLIC.orders_ex
from ( select s.$1, s.$2 from
@MANAGE_DB.external_stages.aws_stage s)
 file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv')
    force = true;

// Example 1 - Table

create or replace table OUR_FIRST_DB.PUBLIC.ORDERS_EX(
    ORDER_ID VARCHAR(30),
    AMOUNT INT
);

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

// Example 2 - Table

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    PROFITABLE_FLAG VARCHAR(30)
    );

    SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;


// Example 2 - Copy Command using a SQL function (subset of functions available)
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM (select 
            s.$1,
            s.$2, 
            s.$3,
            CASE WHEN CAST(s.$3 as int) < 0 THEN 'not profitable' ELSE 'profitable' END 
          from @MANAGE_DB.external_stages.aws_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv');

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

// Example 3 - Table

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    CATEGORY_SUBSTRING VARCHAR(5)
    );


// Example 4 - Copy Command using a SQL function (subset of functions available)

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM (select 
            s.$1,
            s.$2, 
            s.$3,
            substring(s.$5,1,5) 
          from @MANAGE_DB.external_stages.aws_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv');


SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;


CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT1 (
    Loan_ID STRING,
  loan_status STRING,
  Principal STRING,
  terms STRING,
  effective_date STRING,
  due_date STRING,
  paid_off_time STRING,
  past_due_days STRING,
  age STRING,
  education STRING,
  Gender STRING);


//load data using copy command

COPY INTO OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT1
    FROM @aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Loan_payments_data.csv*';

    list @aws_stage;

select * from OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT1;  

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT1 (
    Loan_ID STRING,
  loan_status STRING);

copy into OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT1
from ( select s.$1, s.$2 from
@MANAGE_DB.external_stages.aws_stage s)
 file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('Loan_payments_data.csv');

    select * from OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT1;  
    
































































