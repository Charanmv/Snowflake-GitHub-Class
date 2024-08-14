 session-17
----------------------
snow pipe

data loading
bulk loading -->AWS bucket
IAM
Storage integration
create stage and table
copy command to load the data (manual)

continous loading

--> AWS bucket
--> IAM Roles
--> Storage integration
--> Create pipe (copy command)

        AWS--> Every 5min we are getting employee details
        run-->Copy command for every 5min
        fails to copy 12 files are finding data is not synch
        24 hrs --> we need to perform copy commads
        so we will create pipes

        
s3://snowclass-vitech-practice/csv/
s3://snowclass-vitech-practice/json/

arn:aws:iam::024848483653:role/snowclass-vitech-practice


arn:aws:iam::211125613752:user/externalstages/cib0y60000
XU91440_SFCRole=2_+LXc/kWZWYMX2DqMmfK6H0kd8MU=

;
setup event trigger for pipes
---------------------------------

Amazon S3 --> bucket properties --> Event Notification --> Create event notification

Event Name - snowflake notification as name 
add prefix -csv/

Event type -All or based on your requirement

Destination : Select (sqs Queue) --> Enter SQS Queue ARN 
selected Notification ARN need to configure here 
Save changes

---------------------------------

Goto Objects and test snowpipe
Add the files and see how values are inserted 

run the below SQL  --> It will take 30 to 60 sec to 
run pipe
SELECT * FROM OUR_FIRST_DB.PUBLIC.employees 
ALTER pipe employee_pipe refresh;

----------------------------------
//Create storage integration object

create or replace storage integration s3_int_pipe
    Type = External_stage
    Storage_provider = s3
    Enabled = true
    storage_aws_role_arn ='arn:aws:iam::024848483653:role/snowclass-vitech-practice'
    storage_allowed_locations = ('s3://snowclass-vitech-practice/csv/','s3://snowclass-vitech-practice/json/')
    comment = 'This is to paractice pipe concept';

    // See storage integration properties to fetch external_id so we can update it in S3
DESC integration s3_int_pipe;

// create table first
create or replace table OUR_FIRST_DB.PUBLIC.employees(
id int,
first_name string,
last_name string,
email string,
locations string,
department string
);

//create file format object
create or replace file format our_first_db.public.csv_filefomat
type = csv
field_delimiter = ','
skip_header = 1
null_if =('null','null')
empty_field_as_null = true;

//create stage object with integration object & file fomat object
create or replace stage 
MANAGE_DB.external_stages.csv_folder
url ='s3://snowclass-vitech-practice/csv/'
storage_integration = s3_int_pipe
FILE_FORMAT = our_first_db.public.csv_filefomat;

 // Create stage object with integration object & file format object
LIST @MANAGE_DB.external_stages.csv_folder ;
show stages;


// Create schema to keep things organized
CREATE OR REPLACE SCHEMA MANAGE_DB.pipes;
show schemas;

//Define pipe
CREATE OR REPLACE pipe MANAGE_DB.pipes.employee_pipe
auto_ingest = True
as
COPY INTO OUR_FIRST_DB.PUBLIC.employees
FROM @MANAGE_DB.external_stages.csv_folder ; 

// Describe pipe
DESC pipe  MANAGE_DB.pipes.employee_pipe;

ALTER pipe MANAGE_DB.pipes.employee_pipe refresh;

SELECT * FROM OUR_FIRST_DB.PUBLIC.employees ;


------------------------------------------------


-- Manage pipes -- 

DESC pipe MANAGE_DB.pipes.employee_pipe;

SHOW PIPES;

SHOW PIPES like '%employee%';

SHOW PIPES in database MANAGE_DB;

SHOW PIPES in schema MANAGE_DB.pipes;

SHOW PIPES like '%employee%' in Database MANAGE_DB;


-- Changing pipe (alter stage or file format) --


// Pause pipe
ALTER PIPE MANAGE_DB.pipes.employee_pipe SET PIPE_EXECUTION_PAUSED = true;

ALTER PIPE MANAGE_DB.pipes.employee_pipe SET PIPE_EXECUTION_PAUSED = false;
 
// Verify pipe is paused and has pendingFileCount 0 
SELECT SYSTEM$PIPE_STATUS('MANAGE_DB.pipes.employee_pipe') ;
 
 // Recreate the pipe to change the COPY statement in the definition
CREATE OR REPLACE pipe MANAGE_DB.pipes.employee_pipe
auto_ingest = TRUE
AS
COPY INTO OUR_FIRST_DB.PUBLIC.employees2
FROM @MANAGE_DB.external_stages.csv_folder  ;

ALTER PIPE  MANAGE_DB.pipes.employee_pipe refresh;



// Resume pipe
ALTER PIPE MANAGE_DB.pipes.employee_pipe SET PIPE_EXECUTION_PAUSED = false;

// Verify pipe is running again
SELECT SYSTEM$PIPE_STATUS('MANAGE_DB.pipes.employee_pipe') ;

---------------------------------------
loan payment data practice

// take s3 url and arn role links 

s3 url-   s3://snowclass-vitech-practice/csvloan/
arn role-   arn:aws:iam::024848483653:role/snow-pipe-loandata

user arn-    arn:aws:iam::211125613752:user/externalstages/cib0y60000
external id-    XU91440_SFCRole=2_d5v1RezBQqnY46dcq6GJJga2hOU=
;

// create s3 integration 

create or replace storage integration s3_int_loanpipe
    Type = External_stage
    Storage_provider = s3
    Enabled = true
    storage_aws_role_arn ='arn:aws:iam::024848483653:role/snow-pipe-loandata'
    storage_allowed_locations = ('s3://snowclass-vitech-practice/csvloan/')
    comment = 'This is to paractice pipe concept';

desc integration s3_int_loanpipe;

// create table after s3 integration

create or replace table manage_db.public.loandata(
LOAN_ID string,
LOAN_STATUS	string,
PRINCIPAL string,
TERMS string,
EFFECTIVE_DATE string,
DUE_DATE string,	
PAID_OFF_TIME string,	
PAST_DUE_DAYS string,	
AGE string,	
EDUCATION string,	
GENDER string
);

// create file format object
create or replace file format 
manage_db.public.loan_csv_format
type = csv
field_delimiter = ','
skip_header = 1
null_if =('null','null')
empty_field_as_null = true;

//create stage object with integration object & file format object
create or replace stage
MANAGE_DB.external_stages.loan_folder
url = 's3://snowclass-vitech-practice/csvloan/'
storage_integration = s3_int_loanpipe
file_format = manage_db.public.loan_csv_format; 

// list the stage
list @MANAGE_DB.external_stages.loan_folder;

// Create schema to keep things organized
CREATE OR REPLACE SCHEMA MANAGE_DB.pipes;

//Define pipe
CREATE OR REPLACE pipe MANAGE_DB.pipes.loan_pipe
auto_ingest = True
as
COPY INTO manage_db.public.loandata
FROM @MANAGE_DB.external_stages.loan_folder ;

// Describe pipe
DESC pipe  MANAGE_DB.pipes.loan_pipe;

ALTER pipe MANAGE_DB.pipes.loan_pipe refresh;

SELECT * FROM manage_db.public.loandata;

// Pause pipe
ALTER PIPE MANAGE_DB.pipes.loan_pipe  SET PIPE_EXECUTION_PAUSED = true;

ALTER PIPE MANAGE_DB.pipes.loan_pipe SET PIPE_EXECUTION_PAUSED = false;
 
// Verify pipe is paused and has pendingFileCount 0 
SELECT SYSTEM$PIPE_STATUS('MANAGE_DB.pipes.loan_pipe');
