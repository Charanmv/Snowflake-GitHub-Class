      Session-20
---------------------------

Time Travel- Is Nothing but to get the Historical data (0 to 90 days)
suppose we have deleted/updated the data to recover we use time travel

->after 90days you need data you have to contact snowflake team
after completion of time travel with in 7 days you have to connect snowflake team. 

=>ways to recover data
  offset
  Timestamp
  queryId

  // Setting up table

CREATE OR REPLACE TABLE OUR_FIRST_DB.public.test (
   id int,
   first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string);

  
CREATE OR REPLACE FILE FORMAT MANAGE_DB.file_formats.csv_file
    type = csv
    field_delimiter = ','
    skip_header = 1;

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.time_travel_stage
URL = 's3://data-snowflake-fundamentals/time-travel/'
file_format = MANAGE_DB.file_formats.csv_file;

LIST @MANAGE_DB.external_stages.time_travel_stage;

COPY INTO OUR_FIRST_DB.public.test
from @MANAGE_DB.external_stages.time_travel_stage
files = ('customers.csv');

SELECT * FROM OUR_FIRST_DB.public.test;

ALTER TABLE OUR_FIRST_DB.public.test SET DATA_RETENTION_TIME_IN_DAYS=20;

show tables;

// Use-case: Update data (by mistake)

UPDATE OUR_FIRST_DB.public.test
SET FIRST_NAME = 'Joyen'; 


// Using time travel: Method 1 - 2 minutes back
SELECT * FROM OUR_FIRST_DB.public.test at (OFFSET => -60*1.5);

select sysdate();


//Using time travel: Method 2 - before timestamp
SELECT * FROM OUR_FIRST_DB.public.test before (timestamp => '2024-08-15 07:19:13.183'::timestamp);

// Using time travel: Method 3 - before Query ID

// Preparing table
CREATE OR REPLACE TABLE OUR_FIRST_DB.public.test (
  id int,
  first_name string,
  last_name string,
  email string,
  gender string,
  Phone string,
  Job string);

COPY INTO OUR_FIRST_DB.public.test
from @MANAGE_DB.external_stages.time_travel_stage
files = ('customers.csv')
force=true;

SELECT * FROM OUR_FIRST_DB.public.test;

// Altering table (by mistake)
UPDATE OUR_FIRST_DB.public.test
SET EMAIL = null;

delete from OUR_FIRST_DB.public.test;


SELECT * FROM OUR_FIRST_DB.public.test;

SELECT * FROM OUR_FIRST_DB.public.test before (statement => '01b65c7e-0001-29c3-0005-4c9e00035cfa');


drop table OUR_FIRST_DB.public.test;

undrop table OUR_FIRST_DB.public.test;

ALTER TABLE test SET DATA_RETENTION_TIME_IN_DAYS=30;