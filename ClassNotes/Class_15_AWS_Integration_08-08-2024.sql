           Snowflake
    -------Session-15------

    AWS integration with snowflake

    URL: ----> Stages ---> copy(load data)

1) Create AWS account
2) Create S3 bucket (create fplders)
3) Load the data into bucket (manual)
4) Create IAM Roles (provide Access) external id need
   to keep 00000 initaly
5) Goto snowflake create S3 integration object
6) Describe S3 int object and copy User ARN, External identified
and edit the role trust policy from aws
7) Create STAGES
8) List stages
9) Create table and file format 
10) Load data into table using copy command 


Example
url:  s3://vitech-snow11am-batch/csv/
      s3://vitech-snow11am-batch/json/

role arn: arn:aws:iam::024848483653:role/snow-vitech-11am-role

user arn: arn:aws:iam::211125613752:user/externalstages/ci4zx60000

external id: RW49251_SFCRole=2_E6kRWCgttF70FVNxmAyHquLbXU4=

-----------------------------------------------------------

s3://vitech-snow10am-batch/csv/

arn:aws:iam::024848483653:role/snow-vitect-10am-role

user  arn:aws:iam::211125613752:user/externalstages/cib0y60000

ext id  XU91440_SFCRole=2_xUrcqUpV3qyLRgv1a/S3iGjIg2k=



TASK :  


// Create storage integration object

create or replace storage integration s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = ''
  STORAGE_ALLOWED_LOCATIONS = ('s3://<your-bucket-name>/<your-path>/', 's3://<your-bucket-name>/<your-path>/')
   COMMENT = 'This an optional comment' 

   
   
   
// See storage integration properties to fetch external_id so we can update it in S3
DESC integration s3_int;





class notes:
---------------------

s3://snowclass-vitech-practice/csv/
s3://snowclass-vitech-practice/json/

arn:aws:iam::024848483653:role/snowclass-vitech-practice


arn:aws:iam::211125613752:user/externalstages/cib0y60000
XU91440_SFCRole=2_Er9P1WnjM4q8VBrZwEXRzXBUU1Q=



// create storage integration object

create or replace storage integration s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::024848483653:role/snowclass-vitech-practice'
  STORAGE_ALLOWED_LOCATIONS = ('s3://snowclass-vitech-practice/csv/', 's3://snowclass-vitech-practice/json/')
   COMMENT = 'This is an s3 integration object '

   // See storage integration properties to fetch external_id so we can update it in S3
DESC integration s3_int;

CREATE OR REPLACE stage stage_aws_csv
    URL = 's3://snowclass-vitech-practice/csv/'
    STORAGE_INTEGRATION = s3_int

    list @stage_aws_csv

    CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.movie_titles (
  show_id STRING,
  type STRING,
  title STRING,
  director STRING,
  cast STRING,
  country STRING,
  date_added STRING,
  release_year STRING,
  rating STRING,
  duration STRING,
  listed_in STRING,
  description STRING )

  CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE    
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'  

copy into OUR_FIRST_DB.PUBLIC.movie_titles  
  from @stage_aws_csv 
file_format = (FORMAT_NAME  = MANAGE_DB.file_formats.csv_fileformat)
files =('netflix_titles.csv')

select count(*)  from  OUR_FIRST_DB.PUBLIC.movie_titles;

select *  from  OUR_FIRST_DB.PUBLIC.movie_titles;



select count(*) from HR.VITECH.COUNTRIES;// count no 25 now 50
select count(*) from HR.VITECH.DEPARTMENTS;// count no 11
select count(*) from HR.VITECH.DEPENDENTS; // count no 30
select count(*) from HR.VITECH.EMPLOYEES; // count no 40
select count(*) from HR.VITECH.JOBS;// count no 19
select count(*) from HR.VITECH.LOCATIONS; //count no 7
select count(*) from HR.VITECH.REGIONS;// count no 4


s3://snowflake-hrdatabase-vitech/csv/


arn:aws:iam::024848483653:role/snow-hrdatabase-vitech

user arn:aws:iam::211125613752:user/externalstages/cib0y60000


id  XU91440_SFCRole=2_iQx1u1ruGW9agY6bRoGMQi3XAzI=

create or replace storage integration s3_integtation
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::024848483653:role/snow-hrdatabase-vitech'
  STORAGE_ALLOWED_LOCATIONS = ('s3://snowflake-hrdatabase-vitech/csv/')
   COMMENT = 'This is an s3 integration object ' 


   DESC integration s3_integtation;

   CREATE OR REPLACE stage stage_aws_csv
    URL = 's3://snowflake-hrdatabase-vitech/csv/'
    STORAGE_INTEGRATION = s3_integtation;

list @stage_aws_csv;

CREATE OR REPLACE file format csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE    
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'  

copy into countries
  from @stage_aws_csv 
file_format = (FORMAT_NAME  = csv_fileformat)
files =('countries.csv')

copy into HR.VITECH.DEPARTMENTS
  from @stage_aws_csv 
file_format = (FORMAT_NAME  = csv_fileformat)
files =('departments.csv')

copy into dependents
  from @stage_aws_csv 
file_format = (FORMAT_NAME  = csv_fileformat)
files =('dependents.csv')

copy into employees
  from @stage_aws_csv 
file_format = (FORMAT_NAME  = csv_fileformat)
files =('Employees.csv')

copy into jobs
  from @stage_aws_csv 
file_format = (FORMAT_NAME  = csv_fileformat)
files =('jobs.csv')

copy into locations
  from @stage_aws_csv 
file_format = (FORMAT_NAME  = csv_fileformat)
files =('locations.csv')

copy into regions
  from @stage_aws_csv 
file_format = (FORMAT_NAME  = csv_fileformat)
files =('regions.csv')
