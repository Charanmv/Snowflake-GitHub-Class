Session-18
--------------------------
  Snow Pipe Error handling  
  Azure account creation 
								   
vitech talks azure account creation  
	
	
Azure account creation--->	https://www.youtube.com/watch?v=theBCIC0Pd0
	
	
	
// Handling errors


// Create file format object chane delimiter and refresh then observe 
CREATE OR REPLACE file format our_first_db.public.csv_filefomat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE;
    
    
SELECT * FROM OUR_FIRST_DB.PUBLIC.employees  

ALTER PIPE  MANAGE_DB.pipes.employee_pipe refresh
 
// Validate pipe is actually working
SELECT SYSTEM$PIPE_STATUS('employee_pipe')

// Snowpipe error message
SELECT * FROM TABLE(VALIDATE_PIPE_LOAD(
    PIPE_NAME => 'MANAGE_DB.pipes.employee_pipe',
    START_TIME => DATEADD(HOUR,-2,CURRENT_TIMESTAMP())))

    
select sysdate();
// COPY command history from table to see error massage

SELECT * FROM TABLE (INFORMATION_SCHEMA.COPY_HISTORY(
   table_name  =>  'OUR_FIRST_DB.PUBLIC.EMPLOYEES',
   START_TIME =>DATEADD(HOUR,-2,CURRENT_TIMESTAMP())))
