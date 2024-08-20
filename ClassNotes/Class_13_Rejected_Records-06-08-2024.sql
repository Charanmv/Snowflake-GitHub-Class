 Session-13
--------------------------
/* Working With Rejected /Error Records

Azure Repos --> Microsoft account 
   Bit bucket 
   Git labs  

 TASK: Pracice today's class 
 install git & Git hub creation 
 push all the assignments (Repo )   < Snowflake-<Name>-Assigments >
 Create AWS account 

Git : version controle tool 
Git hub : Code repository (cloud platform) */

----Working With Rejected /Error Records---
---- Use files with errors ----
CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/returnfailed/';

LIST @COPY_DB.PUBLIC.aws_stage_copy;  

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_ERRORS;



COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_1_rows;
    
-------------- Working with error results -----------

---- 1) Saving rejected files after VALIDATION_MODE ---- 

CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @COPY_DB.PUBLIC.aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
   VALIDATION_MODE = RETURN_ERRORS
    --ON_ERROR =CONTINUE ;

select count(*)  from COPY_DB.PUBLIC.ORDERS;  --> 4781   + 4 == 4785  

use COPY_DB.PUBLIC;
// Storing rejected /failed results in a table
CREATE OR REPLACE TABLE COPY_DB.PUBLIC.rejected AS 
select rejected_record from table (result_scan(last_query_id()));
    
    select rejected_record from table (result_scan(last_query_id()));
    use COPY_DB.PUBLIC;

INSERT INTO rejected
select rejected_record from table(result_scan(last_query_id()));

select * from COPY_DB.PUBLIC.rejected;

-- 2) Saving rejected files without VALIDATION_MODE ---- 

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @COPY_DB.PUBLIC.aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    ON_ERROR=CONTINUE;

    ---- 3) Working with rejected records ---- 

SELECT REJECTED_RECORD FROM COPY_DB.PUBLIC.rejected;

create or replace table COPY_DB.PUBLIC.rejected_values as 
select 
split_part(rejected_record,',',1) as order_id,
SPLIT_PART(rejected_record,',',2) as AMOUNT, 
SPLIT_PART(rejected_record,',',3) as PROFIT, 
SPLIT_PART(rejected_record,',',4) as QUANTITY, 
SPLIT_PART(rejected_record,',',5) as CATEGORY, 
SPLIT_PART(rejected_record,',',6) as SUBCATEGORY
FROM COPY_DB.PUBLIC.rejected; 

use COPY_DB.PUBLIC;
SELECT * FROM COPY_DB.PUBLIC.rejected_values;

select count(*) from COPY_DB.PUBLIC.orders; 

update COPY_DB.PUBLIC.rejected_values
set quantity = 7
where quantity ='7-';

update COPY_DB.PUBLIC.rejected_values
set quantity = 3
where quantity ='3a';

update COPY_DB.PUBLIC.rejected_values
set profit = '220'
where profit ='two hundred twenty';

update COPY_DB.PUBLIC.rejected_values
set profit = '1000'
where profit ='one thousand';

insert into COPY_DB.PUBLIC.orders (
SELECT * FROM COPY_DB.PUBLIC.rejected_values);

select count(*) from COPY_DB.PUBLIC.orders; 

