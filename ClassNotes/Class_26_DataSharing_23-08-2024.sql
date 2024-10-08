   Session-26
--------------------
								
Data Sharing 
				   
 Provider SQLs

 ----Provider -----
 
CREATE OR REPLACE DATABASE DATA_SHARE;


CREATE OR REPLACE STAGE aws_stage
    url='s3://bucketsnowflakes3';

// List files in stage
LIST @aws_stage;

// Create table
CREATE OR REPLACE TABLE ORDERS (
ORDER_ID	VARCHAR(30)
,AMOUNT	NUMBER(38,0)
,PROFIT	NUMBER(38,0)
,QUANTITY	NUMBER(38,0)
,CATEGORY	VARCHAR(30)
,SUBCATEGORY	VARCHAR(30))   


// Load data using copy command
COPY INTO ORDERS
    FROM @aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*OrderDetails.*';
    
SELECT * FROM ORDERS;




// Create a share object
CREATE OR REPLACE SHARE ORDERS_SHARE;

---- Setup Grants ----

// Grant usage on database
GRANT USAGE ON DATABASE DATA_SHARE TO SHARE ORDERS_SHARE; 

// Grant usage on schema
GRANT USAGE ON SCHEMA DATA_SHARE.PUBLIC TO SHARE ORDERS_SHARE; 

// Grant SELECT on table

GRANT SELECT ON TABLE DATA_SHARE.PUBLIC.ORDERS TO SHARE ORDERS_SHARE; 

// Validate Grants
SHOW GRANTS TO SHARE ORDERS_SHARE;


---- Add Consumer Account ----
ALTER SHARE ORDERS_SHARE ADD ACCOUNT=<account-identifier>;

 
 
 Consumer SQLS:
-----------------

---Consumer to read --open anothere browser with differet credentials 
-- Create database from share --  to verify the shares 

// Show all shares (consumer & producers)
SHOW SHARES;

// See details on share
DESC SHARE <account_name_producer>.ORDERS_SHARE;

desc share WGIFXXA.PS70340.ORDERS_SHARE

// Create a database in consumer account using the share
CREATE DATABASE DATA_SHARE_DB FROM SHARE WGIFXXA.PS70340.ORDERS_SHARE;

// Validate table access
SELECT * FROM  DATA_SHARE_DB.PUBLIC.ORDERS


delete  FROM  DATA_SHARE_DB.PUBLIC.ORDERS