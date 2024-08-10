Skip to main content
Google Classroom
Classroom
Snowflake July-22 Batch
Stream
Classwork
People
Snowflake July-22 Batch

Announce something to your class

Announcement: 'Snowflake Realtime Training Session-16…'
ViVision Technologies
Created YesterdayYesterday
Snowflake Realtime Training
                                        Session-16
                                --------------------------
                                Working with Semi Structured Data 


https://youtu.be/VqRIJLZ1TJE

Snowflake Class-16.txt
Text

Add class comment…

Assignment: "Loading Data Into Tables "
ViVision Technologies posted a new assignment: Loading Data Into Tables
Created YesterdayYesterday

Announcement: 'Snowflake Realtime Training Session-15…'
ViVision Technologies
Created 8 Aug8 Aug
Snowflake Realtime Training
                                        Session-15
                                --------------------------
                                 AWS integration  with snowflake
                                 
                                 https://youtu.be/p-aVbWw3efM
                                 
                                 url:   --->  stages --> copy (load data)
                                 
1)  Create AWS account
2)  Create S3 bucket (create folders)
3)  Load the data into bucket   (manual)
4)  Create IAM Roles   (provide Access)  external id need to keep 0000
5)  Goto snowflake create S3 integration object
6)  Describe S3 int object and copy User ARN , External id and edit the role trust policy from aws
7)  Create Stages
8)  List stages
9)  Load data into table using copy command
10) Create table and file format before 9 th step

Snowflake Class-15.txt
Text

Add class comment…


Announcement: 'Snowflake Realtime Training Session-14…'
ViVision Technologies
Created 7 Aug7 Aug
Snowflake Realtime Training
                                        Session-14
                                --------------------------
                                GIT & github
                                Azure repos
                                Load data into AWs
                               
https://youtu.be/xeM4gFbXWUI
 
    GIT - Tool/software   (Version controle)
   
    Git hub --> code repo   (Create account in github.com)
    Azure Repo --> code repo (need to have microsoft account (outlook))
    bit bucket repo -->
   
   
   
    dev.azure.com
   
    -----------------
   
   
    git clone   <url> -b <branch name>
   
   
   
    git status
    git add .
    git commit -m "comments"
    git push -u origin <brnach>

Add class comment…


Announcement: 'Snowflake Realtime Training Session-13…'
ViVision Technologies
Created 6 Aug6 Aug
Snowflake Realtime Training
                                        Session-13
                                --------------------------
                                Working With Rejected /Error Records
           

TASK: Practice today's class
install git & Git hub creation
push all the assignments (Repo )   < Snowflake-<Name>-Assignments >
Create AWS account

https://youtu.be/9jmpos7qYL4
                               
        GIT & Git hub

 Git : version controlee tool

 Git hub : Code repository (cloud platform)
 

   stages --> 100 sQL
             
           person - B --> copy 200 SQLs
                  (We need to keep all files in to single place )

     Crashed --> 20 days -->       (5 days leave)
     
   
   Azure Repos --> Microsoft account
   Bit bucket
   Git labs    
   
   
   Git -->  https://youtu.be/o1YDW_jnvvk?si=ynwv9iWVPNGKdrW3
   
    Create github account
    git software
   
   
    AWS account --> https://youtu.be/CCaVgwVGlt8?si=W8-vTLXQWeC1O4aV

Snowflake Class-13.txt
Text

Add class comment…


Announcement: 'Snowflake Realtime Training Session-12…'
ViVision Technologies
Created 5 Aug5 Aug
Snowflake Realtime Training
                                        Session-12
                                --------------------------
                                       Copy options
                                      https://youtu.be/2eEawVJrvQs

Snowflake Class-12.txt
Text

Add class comment…

Assignment: "SQL Practice 51-80 "
ViVision Technologies posted a new assignment: SQL Practice 51-80
Created 2 Aug2 Aug

Announcement: 'Snowflake Realtime Training Session-11…'
ViVision Technologies
Created 2 Aug2 Aug (Edited 2 Aug)
Snowflake Realtime Training
                                        Session-11
                                --------------------------
                               
                                Data Loading
                               
                                External stages
                               
    Azure , AWS , GCP , SAP , Hadoop , API (Weather )

https://youtu.be/MyR9gfKT9os

   1. Create database / schema
   2. Create External Stage   (Url = Azure/s3 ..etc )  
   3. List @stage (How many files)
   4. Create table
   5. Load the data by using copy command

Snowflake Class-11.txt
Text

Add class comment…


Announcement: 'Snowflake Realtime Training Session-10…'
ViVision Technologies
Created 1 Aug1 Aug
Snowflake Realtime Training
                                        Session-10
                                --------------------------
                                   Data Loading
                                   
                                   Bulk Loading
                                   
                                   Internal stages & External stages
                                   
                                   https://youtu.be/55Q-pzYLxjo

Snowflake Class-10.txt
Text

data.csv
Comma-separated values

Add class comment…

Assignment: "SQL Practice 41-50 "
ViVision Technologies posted a new assignment: SQL Practice 41-50
Created 31 Jul31 Jul
Stream
                                Snowflake Realtime Training 
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
	 
								
Snowflak ... s-16.txt
Displaying Snowflake Class-16.txt.