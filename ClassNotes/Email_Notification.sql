create database email;

arn:aws:iam::024848483653:role/email-bucket-01
s3://email-bucket-01/xml/

arn:aws:iam::741448919654:user/2ror0000-s
EJ55745_SFCRole=5_aDirkKbxhEXAjl9FaI3Wef6g5+g=

create or replace storage integration email_s3
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::024848483653:role/email-bucket-01'
  STORAGE_ALLOWED_LOCATIONS = ('s3://email-bucket-01/xml/')
   COMMENT = 'This an optional comment'; 
   
desc integration email_s3;

sns topic arn - arn:aws:sns:ap-southeast-2:024848483653:email-notify

CREATE or replace NOTIFICATION INTEGRATION errornotificationsend
  ENABLED = true
  TYPE =QUEUE
  NOTIFICATION_PROVIDER =AWS_SNS
  DIRECTION =OUTBOUND
  AWS_SNS_TOPIC_ARN = 'arn:aws:sns:ap-southeast-2:024848483653:email-notify'
  AWS_SNS_ROLE_ARN = 'arn:aws:iam::024848483653:role/emailbucket-1';

  
DESC NOTIFICATION INTEGRATION errornotificationsend;

SF_AWS_IAM_USER_ARN:  arn:aws:iam::741448919654:user/2ror0000-s
SF_AWS_EXTERNAL_ID: EJ55745_SFCRole=5_d+03hatwzckNReV2lz3K2ENkWNM=


{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": [
			    "sns:Publish"
			    ],
			"Resource": "arn:aws:sns:ap-southeast-2:024848483653:email-notify"
		}
	]
}


CREATE or replace TABLE suppliers (
    SupplierID INT,                         -- Supplier ID
    SupplierName VARCHAR(100),              -- Name of the Supplier
    ContactPerson VARCHAR(100),             -- Contact Person's Name
    Email VARCHAR(200),                     -- Supplier's Email Address
    Phone VARCHAR(50),                      -- Contact Phone Number
    Address VARCHAR(50),                    -- Supplier's Address
    City VARCHAR(50),                       -- City Name
    State VARCHAR(10),                      -- State Abbreviation or Name
    ZipCode VARCHAR(10),                    -- Zip or Postal Code
    Updated_at TIMESTAMP,                   -- Timestamp of the last update
    orders_OrderID INT                      -- Associated Order ID
);

                                  
--file-format creation
create or replace file format email_format
type = csv field_delimiter = ',' skip_header = 1
field_optionally_enclosed_by = '"'
null_if = ('NULL', 'null') 
empty_field_as_null = true;

--stage creation
create or replace stage email_stage
url = 's3://email-bucket-01/xml/'
 STORAGE_INTEGRATION = email_s3
file_format = email_format;

--check the data present in S3
list @email_stage;  
--copy command

select * from suppliers;

create or replace pipe email_pipe_1
auto_ingest = true
ERROR_INTEGRATION = errornotificationsend
as
copy into suppliers from @email_stage

desc pipe email_pipe_1

alter pipe email_pipe_1 refresh

select * from suppliers;



---------------------------------------------------------------------------------------------------------------------------------------
--Table Creation
create or replace table video2 (Id number(10,0),sepal_length number(10,4),sepal_width number(10,4),petal_length number(10,4)  ,
                                  petal_width number(10,4),class varchar(200));

create or replace pipe spa 
auto_ingest=true 
  ERROR_INTEGRATION = errornotificationsend
 as copy into ramu.PUBLIC.video2 from @ramu.PUBLIC.snow_simple FILE_FORMAT=(FORMAT_NAME=my_csv_format) pattern='.*[.]csv';


show  pipes;
