	   	Session-16
	--------------------------
	Working with SemiStructured Data 
								
	CSV ->        123 , chanrn ,  89877777 
    TSV --> 	  123   charan    97899999
								
	
JSON /PArquet file foramt /XML 

  1) Today's class 
  2) Parquet file to structured 
  3) Musical Json file to load as Structured format using AWS S3
  4) create another bucket and load empoloyee.csv file and store data into snowflake 

{
  "id" : 123 ,
  "name" : "charan" ,
  "phone" : 8999999

}


[ 1 ,2 ,3,4]  
	
	
	
-------------------------------------------------------------------------

  JSON -->  variant  Data Type 
  
  
  S3 --> json 
    Create s3 integration 
	 config in trust policy 
	 Stage 
	   load -> Variant   table 
	   Extract 
	     json to structured 
		 
		 
		 
{
  "city": "Bakersfield",
  "first_name": "Portia",
  "gender": "Male",
  "id": 1,
  "job": {
    "salary": 32000,
    "title": "Financial Analyst"
  },
  "last_name": "Gioani",
  "prev_company": [],
  "spoken_languages": [
    {
      "language": "Kazakh",
      "level": "Advanced"
    },
    {
      "language": "Lao",
      "level": "Basic"
    }
  ]
}		 
		 
		 
----------------------------
{
  "__index_level_0__": 7,
  "cat_id": "HOBBIES",
  "d": 489,
  "date": 1338422400000000,
  "dept_id": "HOBBIES_1",
  "id": "HOBBIES_1_008_CA_1_evaluation",
  "item_id": "HOBBIES_1_008",
  "state_id": "CA",
  "store_id": "CA_1",
  "value": 12
  
  
  
  
  
  
  
  1) Today's class 
  2) Parquet file to structured 
  3) Musical Json file to load as Structured format using AWS S3
  4) create another bucket and load empoloyee.csv file and store data into snowflake 
     
	  as a developer i need to create S3 bucket
  
  
  
  
}

class notes:
---------------
CREATE SCHEMA EXTERNAL_STAGES 

// First step: Load Raw JSON

CREATE OR REPLACE stage MANAGE_DB.EXTERNAL_STAGES.JSONSTAGE
     url='s3://bucketsnowflake-jsondemo';

LIST @MANAGE_DB.EXTERNAL_STAGES.JSONSTAGE

CREATE OR REPLACE file format MANAGE_DB.FILE_FORMATS.JSONFORMAT
    TYPE = JSON;

   
    
CREATE OR REPLACE table OUR_FIRST_DB.PUBLIC.JSON_RAW (
    raw_file variant);
    
COPY INTO OUR_FIRST_DB.PUBLIC.JSON_RAW
    FROM @MANAGE_DB.EXTERNAL_STAGES.JSONSTAGE
    file_format= MANAGE_DB.FILE_FORMATS.JSONFORMAT
    files = ('HR_data.json');
    
   
SELECT * FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;



SELECT $1:city
       ,$1:first_name
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW



SELECT raw_file:city :: String    as city
       ,raw_file:first_name :: String as fname
       ,raw_file:job.salary :: int as salary 
       ,raw_file:job.title :: String as title 
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW 

create or replace table hrdtls as (

SELECT raw_file: id :: int as sid,
raw_file:city :: String    as city
       ,raw_file:first_name :: String as fname
       ,raw_file:job.salary :: int as salary 
       ,raw_file:job.title :: String as title 
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW )


select * from hrdtls 

select min(salary) from hrdtls

create or replace table languages as (
SELECT 
raw_file: id :: int as sid,
raw_file:spoken_languages[0].language :: string as first_language
,raw_file:spoken_languages[0].level  :: string as first_lan_level,
raw_file:spoken_languages[1].language :: string as sec_language,
raw_file:spoken_languages[1].level :: string as sec_lan_level
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW 

    )  
select * from hrdtls;
    select * from languages;

select A.* , B.* from hrdtls A inner join languages B  
                on A.sid = B.sid 

select A.* , B.* 
    from hrdtls A , languages B  
            where  A.sid = B.sid 

--------------

    // Create file format and stage object
    
CREATE OR REPLACE FILE FORMAT MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT
    TYPE = 'parquet';

CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE
    url = 's3://snowflakeparquetdemo'   
    FILE_FORMAT = MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT;
    
    
    // Preview the data
    
LIST  @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;   
    
SELECT * FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;

                
SELECT $1:dept_id ,$1:item_id FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;
                
  select sysdate();
	 
/*{
  "asin": "1384719342",
  "helpful": [
    0,
    0
  ],
  "overall": 5,
  "reviewText": "Not much to write about here, but it does exactly what it's supposed to. filters out the pop sounds. now my recordings are much more crisp. it is one of the lowest prices pop filters on amazon so might as well buy it, they honestly work the same despite their pricing,",
  "reviewTime": "02 28, 2014",
  "reviewerID": "A2IBPI20UZIR0U",
  "reviewerName": "cassandra tu \"Yeah, well, that's just like, u...",
  "summary": "good",
  "unixReviewTime": 1393545600
}*/


create or replace table musical_instruments as(
select $1:asin :: string as Asin
    ,$1:helpful[0] :: string as helpful1
    ,$1:helpful[1] :: string as helpful2
    ,raw_file:overall :: string as overall
    ,$1:reviewText :: string as reviewText
    ,$1:reviewTime :: sysdate() as reviewTime
    ,$1:reviewerID :: string as reviewerID
    ,$1:reviewerName :: string as reviewerName
    ,$1:summary :: string as summary
    ,$1:unixReviewTime :: current_timestamp as unixReviewTime
    from OUR_FIRST_DB.PUBLIC.JSON_RAW
    )

    select * from musical_instruments

    SELECT $1:dept_id ,$1:item_id FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;

-------------------------------------------------------------
				

