Session-18
--------------------------
  Snow Pipe Error handling  
  Azure account creation 
								   
vitech talks azure account creation  
	
	
Azure account creation--->	https://www.youtube.com/watch?v=theBCIC0Pd0
	
	
	
// Handling errors
;
// create the table
create or replace table OUR_FIRST_DB.PUBLIC.employees(
id int,
first_name string,
last_name string,
email string,
locations string,
department string
);

// Create file format object chane delimiter and refresh then observe 
CREATE OR REPLACE file format our_first_db.public.csv_filefomat
    type = csv
    field_delimiter = '|'
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE;


//create stage object with integration object & file fomat object
create or replace stage 
MANAGE_DB.external_stages.csv_folder
url ='s3://snowclass-vitech-practice/csv/'
storage_integration = s3_int_pipe
FILE_FORMAT = our_first_db.public.csv_filefomat;

 // Create stage object with integration object & file format object
LIST @MANAGE_DB.external_stages.csv_folder ;

CREATE OR REPLACE pipe MANAGE_DB.pipes.employee_pipe
auto_ingest = True
as
COPY INTO OUR_FIRST_DB.PUBLIC.employees
FROM @MANAGE_DB.external_stages.csv_folder ;

DESC pipe  MANAGE_DB.pipes.employee_pipe;
    
    
SELECT * FROM OUR_FIRST_DB.PUBLIC.employees  ;

ALTER PIPE  MANAGE_DB.pipes.employee_pipe refresh;
 
// Validate pipe is actually working
SELECT SYSTEM$PIPE_STATUS('MANAGE_DB.pipes.employee_pipe');

// Snowpipe error message
SELECT * FROM TABLE(VALIDATE_PIPE_LOAD(
    PIPE_NAME => 'MANAGE_DB.pipes.employee_pipe',
    START_TIME => DATEADD(HOUR,-2,CURRENT_TIMESTAMP())));

select sysdate();

// COPY command history from table to see error massage

SELECT * FROM TABLE (INFORMATION_SCHEMA.COPY_HISTORY(
   table_name  =>  'OUR_FIRST_DB.PUBLIC.EMPLOYEES',
   START_TIME =>DATEADD(HOUR,-2,CURRENT_TIMESTAMP())));

CREATE OR REPLACE TABLE COPY_DB.PUBLIC.rejected_values AS(
select Rejected_record from table (result_scan('01b658d8-0001-29c2-0005-4c9e00034bee')));

create or replace table COPY_DB.PUBLIC.rejected_result as 
select 
split_part(rejected_record,',',1) as id,
SPLIT_PART(rejected_record,',',2) as first_name, 
SPLIT_PART(rejected_record,',',3) as Last_name, 
SPLIT_PART(rejected_record,',',4) as email, 
SPLIT_PART(rejected_record,',',5) as location, 
SPLIT_PART(rejected_record,',',6) as department
FROM COPY_DB.PUBLIC.rejected_values; 

select * from COPY_DB.PUBLIC.rejected_result;

insert into OUR_FIRST_DB.PUBLIC.employees 
  select * from COPY_DB.PUBLIC.rejected_result
;

SELECT * FROM OUR_FIRST_DB.PUBLIC.employees  ;