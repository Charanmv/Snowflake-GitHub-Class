      -- Session-12
-----------------------------------
      copy options

      success scenarious --> 1000 -->100 worng data

--copy command syntax

copy into <table_name>
from @ExternalStage
files = ('<file_name','<file_name2>')
file_fromat =<file_format_name>
copyOptions  
;

--> major copy options

1.validation_mode
2.return_filed_only
3.on_error
4.force
5.size_limit
6.truncatecolumns
7.enforce_length
8.purge
;

1.validation_mode

copy into <table_name>
from @ExternalStage
files = ('<file_name','<file_name2>')
file_fromat =<file_format_name>
validation_mode = return_n_rows|return_errors|return_all_errors

-> valadate the data file instead of loading them into the table
->Return_errors gives all errors in the external_table_files.
->return_all_errors gives all errors from previously loaded files if we have 
used on_error = continue;

2.return_filed_only

copy into <table_name>
from @ExternalStage
files = ('<file_name','<file_name2>')
file_fromat =<file_format_name>
return_filed_only = true | false

->Specifies whether to return only file that have failed to load in the statement result
->Default is False;

3.on_error

copy into <table_name>
from @ExternalStage
files = ('<file_name','<file_name2>')
file_fromat =<file_format_name>
on_error = continue | skip_file | skip_file_num |
           skip_fife_num% | Abort_statement

-> continue - To skip error records and load remaining records
-> skip_file - To skip the files that contain external_table_file_registration_history
-> skip_file_num -skip the file when the number of error rows found in the file is equal to or
 exceeds the specified number
->skip_fife_num% 
->Abort_statement;


4.force

copy into <table_name>
from @ExternalStage
files = ('<file_name','<file_name2>')
file_fromat =<file_format_name>
force = true | false;

--> To load the files, regardless of whether they've been loaded previously


5.size_limit

copy into <table_name>
from @ExternalStage
files = ('<file_name','<file_name2>')
file_fromat =<file_format_name>
size_limit = <number>

-> specify maximum size in bytes of data loaded in that command
-> when the threshold is exceeded, the copy operation stops loading
;

6.truncatecolumns or emforce_length

copy into <table_name>
from @ExternalStage
files = ('<file_name','<file_name2>')
file_fromat =<file_format_name>
truncatecolums = true | false - default is flase
or emforce_length = true | false - default is True;
;

use manage_db.external_stages;

// create new stage

create or replace stage
manage_db.external_stages.aws_stage_errorex
url='s3://bucketsnowflakes4';

 // List files in stage
 LIST @MANAGE_DB.external_stages.aws_stage_errorex;

  // Create example table
 CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));


     // Demonstrating error message
 COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv');

     // Validating table is empty    
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX ;


// Error handling using the ON_ERROR option
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv')
    ON_ERROR = 'CONTINUE'
    force=true  
   ;

    // Validating results and truncating table 
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;

// Error handling using the ON_ERROR option = ABORT_STATEMENT (default)
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'ABORT_STATEMENT';

  // Validating results and truncating table 
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;
    
// Error handling using the ON_ERROR option = SKIP_FILE
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    -- ON_ERROR = 'SKIP_FILE'
    VALIDATION_MODE = RETURN_ERRORS;


      // Validating results and truncating table 
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;  


// Error handling using the ON_ERROR option = SKIP_FILE_<number>
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE_2';


    // Validating results and truncating table 
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;  


SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

 CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

    COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'continue'
    --SIZE_LIMIT = 50000;

    SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

    ---------------------------------------------------


---- VALIDATION_MODE ----
// Prepare database & table
CREATE OR REPLACE DATABASE COPY_DB;


CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(3),
    SUBCATEGORY VARCHAR(30));

    // Prepare stage object
CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/size/';

    LIST @COPY_DB.PUBLIC.aws_stage_copy;


     //Load data using copy command
COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_ERRORS;

    COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (FORMAT_NAME=my_file_frmt)
    pattern='.*Order.*'
    -- VALIDATION_MODE = RETURN_5_ROWS 
     ON_ERROR =CONTINUE 
    --size_Limit = 5000
    -- RETURN_FAILED_ONLY = true
     TRUNCATECOLUMNS = true; 
    
     // Prepare stage object
CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/returnfailed/';

    //try to execute for the above to see errors 

    CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(3),
    SUBCATEGORY VARCHAR(30));

    
   SELECT * FROM ORDERS;

   select * from employees;

    CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_assignment
    url='s3://snowflake-assignments-mc/copyoptions/example1';

     LIST @COPY_DB.PUBLIC.aws_stage_assignment;

     
    CREATE OR REPLACE FILE FORMAT my_file_frmt
        TYPE=CSV,
        field_delimiter=',' ,
        skip_header=1 ;

        desc file format  my_file_frmt;


        //Load data using copy command  validate errors 

    
COPY INTO COPY_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage_assignment
    file_format= (FORMAT_NAME=my_file_frmt )
    pattern='.*employee.*'
    VALIDATION_MODE = RETURN_ERRORS ;

    //Load data regarless on errors 
COPY INTO COPY_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage_assignment
    file_format= (FORMAT_NAME=my_file_frmt )
    pattern='.*employee.*'
    --VALIDATION_MODE = RETURN_ERRORS 
 ON_ERROR = 'CONTINUE'   ;

 select * from hr.vitech.employees ;