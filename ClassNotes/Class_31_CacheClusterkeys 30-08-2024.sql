     Session-31
--------------------------
	Query performance 
	Cache & Cluster keys 
								  
	Cache --> temporary memory location 

    

       SQL ------------->   select * from employees  where city = 'BLR' 


             
					Table scan --> 100 records 
								
								

CREATE OR REPLACE STAGE VITECH.public.aws_stage
    url='s3://bucketsnowflakes3';

// List files in stage

LIST @VITECH.public.aws_stage;

//Load data using copy command

COPY INTO vitech.PUBLIC.ORDERS
    FROM @VITECH.public.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*OrderDetails.*'
    on_error = continue 


    CREATE OR REPLACE TABLE ORDERS (
ORDER_ID	VARCHAR(30)
,AMOUNT	NUMBER(38,0)
,PROFIT	NUMBER(38,0)
,QUANTITY	NUMBER(38,0)
,CATEGORY	VARCHAR(30)
,SUBCATEGORY	VARCHAR(30))

select * from ORDERS;

// Create table

CREATE OR REPLACE TABLE ORDERS_CACHING (
ORDER_ID	VARCHAR(30)
,AMOUNT	NUMBER(38,0)
,PROFIT	NUMBER(38,0)
,QUANTITY	NUMBER(38,0)
,CATEGORY	VARCHAR(30)
,SUBCATEGORY	VARCHAR(30)
,DATE DATE)    


select count(*) from ORDERS_CACHING;




INSERT INTO ORDERS_CACHING 
SELECT
t1.ORDER_ID
,t1.AMOUNT	
,t1.PROFIT	
,t1.QUANTITY	
,t1.CATEGORY	
,t1.SUBCATEGORY	
,DATE(UNIFORM(1500000000,1700000000,(RANDOM())))
FROM ORDERS t1
CROSS JOIN (SELECT * FROM ORDERS) t2
CROSS JOIN (SELECT TOP 100 * FROM ORDERS) t3

select top 10 * from ORDERS_CACHING
// Query Performance before Cluster Key
select * from ORDERS_CACHING where subcategory = 'Chairs' ;




SELECT * FROM ORDERS_CACHING  WHERE DATE = '2020-06-09'

describe table ORDERS_CACHING;
// Adding Cluster Key & Compare the result

ALTER TABLE ORDERS_CACHING CLUSTER BY ( subcategory ) 

SELECT * FROM ORDERS_CACHING  WHERE DATE  between '2020-01-05'  and  '2020-06-09' ;

SELECT * FROM ORDERS_CACHING  WHERE DATE  between '2020-01-06'  and  '2020-06-19' ;


SELECT * FROM ORDERS_CACHING  WHERE DATE  between '2020-01-07'  and  '2020-06-20' ;

// Not ideal clustering & adding a different Cluster Key using function

SELECT * FROM ORDERS_CACHING  WHERE MONTH(DATE)=12

ALTER TABLE ORDERS_CACHING CLUSTER BY ( MONTH(DATE) )