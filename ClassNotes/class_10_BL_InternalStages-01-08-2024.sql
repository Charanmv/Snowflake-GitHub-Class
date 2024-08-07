
// Given Task
use OUR_FIRST_DB.PUBLIC;
create or replace table OUR_FIRST_DB.PUBLIC.loan_paay2 as (
select 
LOAN_ID ,
LOAN_STATUS,
TERMS ,
EDUCATION,
AGE,
GENDER,
CASE 
     WHEN (GENDER = 'male' and age >= 21) THEN 'major'
     when (gender = 'male' and age < 21) then 'minor'
     else 'NA'
end as M_status, 
 CASE 
     WHEN (GENDER = 'female' and age >= 18) THEN 'major'
     when (gender = 'female' and age < 18) then 'minor'
     else 'NA'
end as F_status
from loan_payment order by age asc
);
select * from loan_paay2;

-----------------------------------------------------
Data Loading
Bulk loading
Internal stages & External stages


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


  select * from OUR_FIRST_DB.PUBLIC.LOAN_PAYMENT;

  --------------------1 min  --> 50 files -- 50 mins ----

	Stage can be internal/external locations .

    1) create internal stage 
	2) load data into stages 
	3) from stage you can copy into table 

    Internal stages:
	-------------------
;
   CREATE or replace TABLE LOAN_PAYMENT_2 (
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

  // create stages
  create or replace stage my_inner_stage;

  // loda data into stage
  put file://C:\Users\chara\OneDrive\Desktop\ViVision\Data\data1.csv @my_inner_stage;

  //describ stages
  list @my_inner_stage;

  drop stage my_inner_stage;

  //copy data from stages
  copy into loan_payment_2 from @my_inner_stage
  file_format = (type = csv 
                   field_delimiter = ',' 
                   skip_header=1)
  force = true;

 select * from LOAN_PAYMENT_2;

