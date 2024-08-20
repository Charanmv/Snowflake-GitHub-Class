   Session-9
--------------------------
								
Data Loading 
ETL / ELT 

	E - Extract 
    T - Transform 
    L - Load 
	
	E - Extract 
    L - Load 
	T - Transform 

//s3 location ?
//need to create table 
//source --> S3
//Target --> snowflake 

//Creating the table / Meta data

create or replace database OUR_FIRST_DB;

 //Check that table is empy
USE DATABASE OUR_FIRST_DB;

 use schema public;

 show databases;
 -------------------------------------------------------------------------

 // This is ELT(Extract,Load,Transform)
 CREATE or replace TABLE OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT (
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


  select * from OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT ;

  show tables;

  desc table loan_payment;

//loading the data from s3 bucket

copy into loan_payment
      from s3://bucketsnowflakes3/Loan_payments_data.csv
      file_format = (type =csv 
                    field_delimiter =','
                    skip_header =1);

  // validate
  select * from loan_payment;

  desc table loan_payment;                  


create or replace table loan_paay1 as (
select 
 LOAN_ID
,LOAN_STATUS
,PRINCIPAL
,TERMS
,EFFECTIVE_DATE
,DUE_DATE
,PAID_OFF_TIME
,PAST_DUE_DAYS
,EDUCATION
,GENDER
,AGE
,case when age > 21 then 'major' else 'minor' end as Status
from loan_payment order by age asc
);

select * from loan_paay1;

create or replace table loan_paay2 as (
select 
LOAN_ID ,
LOAN_STATUS,
TERMS ,
EDUCATION,
AGE,
GENDER,
CASE 
     WHEN GENDER = 'male' THEN 
                CASE 
                    WHEN AGE > 21 THEN 'Major' 
                    ELSE 'Minor' 
                END 
            ELSE NULL
        END AS M_Status,
        CASE 
            WHEN GENDER = 'female' THEN 
                CASE 
                    WHEN AGE > 18 THEN 'Major' 
                    ELSE 'Minor' 
                END 
            ELSE NULL
        END AS F_Status
        from loan_payment order by age asc
);

select * from loan_paay2;

----------------------------------------------------------------------

//This is ETL(Extract,Transform,Load)

create or replace stage OUR_FIRST_DB.PUBLIC.ext_loan_stage 
      url= 's3://bucketsnowflakes3/Loan_payments_data.csv';

list @our_first_db.public.ext_loan_stage;

/*select 
      s.$1,
      s.$2,
      s.$9,
      s.$3,
        case when s.$9 > 21 then 'major' else 'minor'
      end as "status"
         from @our_first_db.public.ext_loan_stage s;*/

  CREATE or replace TABLE OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT_V1 (
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

drop table loan_payment_v;

  COPY INTO LOAN_PAYMENT_V1
    FROM @OUR_FIRST_DB.PUBLIC.ext_loan_stage
    file_format = (type = csv 
                   field_delimiter = ',' 
                   skip_header=1);

 select * from LOAN_PAYMENT_V1;
 
CREATE or replace TABLE OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT_V2 (
  Loan_ID STRING,
  loan_status STRING,
  age int,
  status string);

  select * from loan_payment_v2 ;


  COPY INTO OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT_V2 (Loan_ID,loan_status,age,status)
    FROM (select 
            s.$1,
            s.$2,
            s.$9,
            case when s.$9 > 21 then 'Major' else 'Minor' end  as "Status"
          from @OUR_FIRST_DB.PUBLIC.ext_loan_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1) ;

    select * from loan_payment_v2 ;


// Class Task
// disply below mentioned columns
/*loanid 
LOAN_STATUS
TERMS  
EDUCATION
AGE
GENDER
M_Status
F_Status*/


CREATE or replace TABLE OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT_V3 (
  Loan_ID STRING,
  loan_status STRING,
  TERMS string,
  EDUCATION string,
  AGE string,
  GENDER string,
  M_Status string,
  F_Status string
 );

  COPY INTO OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT_V3 (Loan_ID,loan_status,TERMS  
,EDUCATION,AGE,GENDER,M_Status,F_Status)
    FROM (select 
            s.$1,
            s.$2,
            s.$4,
            s.$10,
            s.$9,
            s.$11,

           CASE 
            WHEN s.$11 = 'male' THEN 
                CASE 
                    WHEN s.$9 > 21 THEN 'Major' 
                    ELSE 'Minor' 
                END 
            ELSE 'NA'
        END AS M_Status,
        CASE 
            WHEN s.$11 = 'female' THEN 
                CASE 
                    WHEN s.$9 > 18 THEN 'Major' 
                    ELSE 'Minor' 
                END 
            ELSE 'NA'
        END AS F_Status
    FROM @OUR_FIRST_DB.PUBLIC.ext_loan_stage s
)
FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1);

select * from LOAN_PAYMENT_V3;


--------------------------------------------------------