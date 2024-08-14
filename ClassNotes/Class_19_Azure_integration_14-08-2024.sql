         Session-19
	--------------------------
								
Azure integration with snowflake 
								
path: 	https://vitechcustdata.blob.core.windows.net/vitech-cars-data


tenat id:    33e91482-094e-448e-a05b-521ef98fc090  
   
								
app name -->   et59z4snowflakepacint_1723617051764 	
	
	Class Notes:
	--------------------------
	
1.Create azure account --> portal.azure.com 


2. Create storage container 
     search your storage container 
          --> data storage
            --> Containers 
3. Creating a container 
		-> Select storage container --> Create Container  (snowflakecsv)
		                                                  ( snowfalkejson)
														  
			Load Data -->
				upload json/csv from locally 

4. Creating Integration Object before that find tenat_id 
	
	TO find TENANT_ID ??  search tenant or 
		type azure << active directory (or) Microsoft entra ID >> and find tenant inforamtion and copy
		
		Tenant ID = c20c9531-4384-4115-a44d-b8bf8118a28f
		
		Storage account and navigate to containers and copy the path 

5	-- Describe integration object to provide access     
	DESC STORAGE integration azure_integration;
	
	Below are important steps 
	-----------------------------
    AZURE_CONSENT_URL : https://login.microsoftonline.com/5db02a30-c9f2-41a5-a6a2-6946a48461c4/oauth2/authorize?client_id=a28ec89f-086e-41e1-82cf-51e7b3f04faa&response_type=code
	AZURE_MULTI_TENANT_APP_NAME : ybaalisnowflakepacint_1721969803255

	Here need to copy AZURE_CONSENT_URL    
	                    copy url and paste in browser in new tab to grant access (provide consent)
						Still need to give access Add role --> Role Assignments 
		Storage account --> IAM --> role --> Add Role Assignments --> search -->text as (Container)--> (storage blob data contributor)
                    copy app name from integration object and add into members(ybaalisnowflakepacint)
							       Select memeber(ybaalisnowflakepacint) 
                               Click on Save 
           Now storage object has access for containers 


----------------------------------------------------

https://vitechpractice.blob.core.windows.net/vitech-cars-practice


tenat id: 33e91482-094e-448e-a05b-521ef98fc090

app_name  bwzrbpsnowflakepacint_1723655903184

https://login.microsoftonline.com/094e-448e-a05b-521ef98fc090/oauth2/authorize?client_id=7f935cd0-33c1-4922-af2a-bf4564999cf9&response_type=code


//Create storage integration object

create or replace storage integration azure_integration
    Type = External_stage
    Storage_provider = azure
    Enabled = true
    azure_tenant_id ='33e91482-094e-448e-a05b-521ef98fc090'
    storage_allowed_locations = 
    ('azure://vitechpractice.blob.core.windows.net/vitech-cars-practice');

    desc storage integration azure_integration;

    // create table first
create or replace table OUR_FIRST_DB.PUBLIC.employees(
id int,
first_name string,
last_name string,
email string,
locations string,
department string
);

//create file format object
create or replace file format our_first_db.public.csv_azure_filefomat
type = csv
field_delimiter = ','
skip_header = 1
null_if =('null','null')
empty_field_as_null = true;

//create stage object with integration object & file fomat object
create or replace stage 
MANAGE_DB.external_stages.csv_azure_folder
url ='azure://vitechpractice.blob.core.windows.net/vitech-cars-practice'
storage_integration = azure_integration
FILE_FORMAT = our_first_db.public.csv_azure_filefomat;

// list the stage
LIST @MANAGE_DB.external_stages.csv_azure_folder ;


COPY INTO OUR_FIRST_DB.PUBLIC.employees
FROM @MANAGE_DB.external_stages.csv_azure_folder;

select * from OUR_FIRST_DB.PUBLIC.employees;
    





