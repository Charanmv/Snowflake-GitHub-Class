create database vitech_adf;

create schema adf;

CREATE TABLE suppliers (
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

INSERT INTO suppliers (SupplierID, SupplierName, ContactPerson, Email, Phone, Address, City, State, ZipCode, Updated_at, orders_OrderID)
VALUES
    (1, 'Tata Steel', 'Ramesh Kumar', 'ramesh.kumar@tata.com', '9876543210', '123 Industrial Area', 'Mumbai', 'MH', '400001', CURRENT_TIMESTAMP, 101),
    (2, 'Reliance Industries', 'Suresh Shah', 'suresh.shah@reliance.com', '9123456789', '45 Marine Drive', 'Mumbai', 'MH', '400002', CURRENT_TIMESTAMP, 102),
    (3, 'Hindustan Unilever', 'Anita Gupta', 'anita.gupta@hul.com', '9812345678', '789 Business Street', 'Bengaluru', 'KA', '560001', CURRENT_TIMESTAMP, 103),
    (4, 'Bharat Petroleum', 'Rajesh Verma', 'rajesh.verma@bpcl.com', '9900123456', '56 Gasoline Lane', 'Delhi', 'DL', '110001', CURRENT_TIMESTAMP, 104),
    (5, 'Tata Motors', 'Vikram Singh', 'vikram.singh@tatamotors.com', '7890123456', '789 Auto Hub', 'Pune', 'MH', '411001', CURRENT_TIMESTAMP, 105),
    (6, 'Tata Steel', 'Sunil Patel', 'sunil.patel@tata.com', '9988776655', '321 Steel Plant', 'Jamshedpur', 'JH', '831001', CURRENT_TIMESTAMP, 106),
    (7, 'Reliance Industries', 'Pooja Mishra', 'pooja.mishra@reliance.com', '9876501234', '67 Reliance Road', 'Surat', 'GJ', '395001', CURRENT_TIMESTAMP, 107),
    (8, 'Hindustan Unilever', 'Meera Rao', 'meera.rao@hul.com', '9012345678', '34 FMCG Zone', 'Chennai', 'TN', '600001', CURRENT_TIMESTAMP, 108),
    (9, 'Bharat Petroleum', 'Amit Sharma', 'amit.sharma@bpcl.com', '9090909090', '65 Oil Street', 'Kolkata', 'WB', '700001', CURRENT_TIMESTAMP, 109),
    (10, 'Tata Motors', 'Kiran Desai', 'kiran.desai@tatamotors.com', '9191919191', '55 Auto Park', 'Ahmedabad', 'GJ', '380001', CURRENT_TIMESTAMP, 110),
    (11, 'Tata Steel', 'Rohit Mehta', 'rohit.mehta@tata.com', '8888888888', '12 Steel Blvd', 'Bhubaneswar', 'OD', '751001', CURRENT_TIMESTAMP, 111),
    (12, 'Reliance Industries', 'Kavita Naik', 'kavita.naik@reliance.com', '7777777777', '23 Petro Street', 'Visakhapatnam', 'AP', '530001', CURRENT_TIMESTAMP, 112),
    (13, 'Hindustan Unilever', 'Anil Yadav', 'anil.yadav@hul.com', '6666666666', '78 Consumer Drive', 'Lucknow', 'UP', '226001', CURRENT_TIMESTAMP, 113),
    (14, 'Bharat Petroleum', 'Geeta Nair', 'geeta.nair@bpcl.com', '5555555555', '90 Oil Hub', 'Hyderabad', 'TG', '500001', CURRENT_TIMESTAMP, 114),
    (15, 'Tata Motors', 'Ajay Kulkarni', 'ajay.kulkarni@tatamotors.com', '4444444444', '67 Motor Ave', 'Nagpur', 'MH', '440001', CURRENT_TIMESTAMP, 115),
    (16, 'Tata Steel', 'Neha Singh', 'neha.singh@tata.com', '3333333333', '85 Iron Street', 'Ranchi', 'JH', '834001', CURRENT_TIMESTAMP, 116),
    (17, 'Reliance Industries', 'Sanjay Pandey', 'sanjay.pandey@reliance.com', '2222222222', '56 Polymer Way', 'Indore', 'MP', '452001', CURRENT_TIMESTAMP, 117),
    (18, 'Hindustan Unilever', 'Preeti Agarwal', 'preeti.agarwal@hul.com', '1111111111', '14 Product Park', 'Jaipur', 'RJ', '302001', CURRENT_TIMESTAMP, 118),
    (19, 'Bharat Petroleum', 'Manoj Tiwari', 'manoj.tiwari@bpcl.com', '1234567890', '72 Energy Lane', 'Patna', 'BR', '800001', CURRENT_TIMESTAMP, 119),
    (20, 'Tata Motors', 'Ravi Kapoor', 'ravi.kapoor@tatamotors.com', '2345678901', '19 Car Zone', 'Coimbatore', 'TN', '641001', CURRENT_TIMESTAMP, 120),
    (21, 'Tata Steel', 'Nikhil Rao', 'nikhil.rao@tata.com', '3456789012', '43 Steelworks', 'Bokaro', 'JH', '827001', CURRENT_TIMESTAMP, 121),
    (22, 'Reliance Industries', 'Alok Saxena', 'alok.saxena@reliance.com', '4567890123', '98 Petrochem', 'Vadodara', 'GJ', '390001', CURRENT_TIMESTAMP, 122),
    (23, 'Hindustan Unilever', 'Swati Das', 'swati.das@hul.com', '5678901234', '54 FMCG Sector', 'Pune', 'MH', '411002', CURRENT_TIMESTAMP, 123),
    (24, 'Bharat Petroleum', 'Devika Chatterjee', 'devika.chatterjee@bpcl.com', '6789012345', '21 Fuel Court', 'Guwahati', 'AS', '781001', CURRENT_TIMESTAMP, 124),
    (25, 'Tata Motors', 'Anupam Verma', 'anupam.verma@tatamotors.com', '7890123456', '31 Auto Square', 'Mysuru', 'KA', '570001', CURRENT_TIMESTAMP, 125),
    (26, 'Tata Steel', 'Shalini Menon', 'shalini.menon@tata.com', '8901234567', '76 Steel Point', 'Durgapur', 'WB', '713201', CURRENT_TIMESTAMP, 126),
    (27, 'Reliance Industries', 'Ritu Saini', 'ritu.saini@reliance.com', '9012345678', '24 Oil Avenue', 'Noida', 'UP', '201301', CURRENT_TIMESTAMP, 127),
    (28, 'Hindustan Unilever', 'Prakash Shetty', 'prakash.shetty@hul.com', '9123456789', '88 Consumer Blvd', 'Kochi', 'KL', '682001', CURRENT_TIMESTAMP, 128),
    (29, 'Bharat Petroleum', 'Tarun Joshi', 'tarun.joshi@bpcl.com', '9234567890', '77 Gas Street', 'Chandigarh', 'CH', '160001', CURRENT_TIMESTAMP, 129),
    (30, 'Tata Motors', 'Isha Kapoor', 'isha.kapoor@tatamotors.com', '9345678901', '52 Motor Hub', 'Thane', 'MH', '400601', CURRENT_TIMESTAMP, 130);

    INSERT INTO suppliers (SupplierID, SupplierName, ContactPerson, Email, Phone, Address, City, State, ZipCode, Updated_at, orders_OrderID)
VALUES
    (31, 'Tata Steel', 'Arjun Mehta', 'arjun.mehta@tata.com', '9456789012', '123 Steel City', 'Jamshedpur', 'JH', '831002', CURRENT_TIMESTAMP, 131),
    (32, 'Reliance Industries', 'Divya Bhatt', 'divya.bhatt@reliance.com', '9567890123', '45 Oil Refinery', 'Jamnagar', 'GJ', '361001', CURRENT_TIMESTAMP, 132),
    (33, 'Hindustan Unilever', 'Sunita Malhotra', 'sunita.malhotra@hul.com', '9678901234', '567 FMCG Park', 'Gurugram', 'HR', '122001', CURRENT_TIMESTAMP, 133),
    (34, 'Bharat Petroleum', 'Naveen Jha', 'naveen.jha@bpcl.com', '9789012345', '78 Petro Hub', 'Bhopal', 'MP', '462001', CURRENT_TIMESTAMP, 134),
    (35, 'Tata Motors', 'Aishwarya Jain', 'aishwarya.jain@tatamotors.com', '9890123456', '89 Car Assembly', 'Lucknow', 'UP', '226002', CURRENT_TIMESTAMP, 135),
    (36, 'Tata Steel', 'Rahul Singh', 'rahul.singh@tata.com', '9901234567', '90 Steel Plaza', 'Rourkela', 'OD', '769001', CURRENT_TIMESTAMP, 136),
    (37, 'Reliance Industries', 'Priya Sen', 'priya.sen@reliance.com', '9012345670', '23 Chemical Park', 'Panipat', 'HR', '132103', CURRENT_TIMESTAMP, 137),
    (38, 'Hindustan Unilever', 'Niharika Rao', 'niharika.rao@hul.com', '9123456781', '44 Consumer Lane', 'Faridabad', 'HR', '121001', CURRENT_TIMESTAMP, 138),
    (39, 'Bharat Petroleum', 'Shivam Tripathi', 'shivam.tripathi@bpcl.com', '9234567892', '78 Gas Line', 'Pune', 'MH', '411003', CURRENT_TIMESTAMP, 139),
    (40, 'Tata Motors', 'Vikas Chandra', 'vikas.chandra@tatamotors.com', '9345678903', '25 Auto Way', 'Nashik', 'MH', '422001', CURRENT_TIMESTAMP, 140),
    (41, 'Tata Steel', 'Rekha Sinha', 'rekha.sinha@tata.com', '9456789013', '51 Metal Works', 'Dhanbad', 'JH', '826001', CURRENT_TIMESTAMP, 141),
    (42, 'Reliance Industries', 'Rajiv Sharma', 'rajiv.sharma@reliance.com', '9567890124', '60 Oil Field', 'Kakinada', 'AP', '533001', CURRENT_TIMESTAMP, 142),
    (43, 'Hindustan Unilever', 'Vinita Kapoor', 'vinita.kapoor@hul.com', '9678901235', '34 FMCG Depot', 'Pondicherry', 'PY', '605001', CURRENT_TIMESTAMP, 143),
    (44, 'Bharat Petroleum', 'Arvind Das', 'arvind.das@bpcl.com', '9789012346', '72 Gas Depot', 'Rajahmundry', 'AP', '533101', CURRENT_TIMESTAMP, 144),
    (45, 'Tata Motors', 'Mehul Shah', 'mehul.shah@tatamotors.com', '9890123457', '99 Motor Workshop', 'Gandhinagar', 'GJ', '382010', CURRENT_TIMESTAMP, 145),
    (46, 'Tata Steel', 'Neeraj Aggarwal', 'neeraj.aggarwal@tata.com', '9901234568', '33 Steel Market', 'Salem', 'TN', '636001', CURRENT_TIMESTAMP, 146),
    (47, 'Reliance Industries', 'Sneha Kapoor', 'sneha.kapoor@reliance.com', '9012345679', '43 Petrochemical Area', 'Kochi', 'KL', '682002', CURRENT_TIMESTAMP, 147),
    (48, 'Hindustan Unilever', 'Akash Sharma', 'akash.sharma@hul.com', '9123456782', '14 Retail Zone', 'Mangalore', 'KA', '575001', CURRENT_TIMESTAMP, 148),
    (49, 'Bharat Petroleum', 'Ritika Bhatnagar', 'ritika.bhatnagar@bpcl.com', '9234567893', '92 Fuel City', 'Vizag', 'AP', '530002', CURRENT_TIMESTAMP, 149),
    (50, 'Tata Motors', 'Karan Mehta', 'karan.mehta@tatamotors.com', '9345678904', '12 Auto Hub', 'Raipur', 'CG', '492001', CURRENT_TIMESTAMP, 150),
    (51, 'Tata Steel', 'Gaurav Khanna', 'gaurav.khanna@tata.com', '9456789014', '74 Steel Market', 'Bhilai', 'CG', '490001', CURRENT_TIMESTAMP, 151),
    (52, 'Reliance Industries', 'Aparna Reddy', 'aparna.reddy@reliance.com', '9567890125', '85 Petroleum Road', 'Chennai', 'TN', '600002', CURRENT_TIMESTAMP, 152),
    (53, 'Hindustan Unilever', 'Varun Singh', 'varun.singh@hul.com', '9678901236', '99 Consumer Park', 'Nagpur', 'MH', '440002', CURRENT_TIMESTAMP, 153),
    (54, 'Bharat Petroleum', 'Sameer Nair', 'sameer.nair@bpcl.com', '9789012347', '12 Gas Field', 'Agra', 'UP', '282001', CURRENT_TIMESTAMP, 154),
    (55, 'Tata Motors', 'Rohini Deshmukh', 'rohini.deshmukh@tatamotors.com', '9890123458', '57 Auto Square', 'Surat', 'GJ', '395002', CURRENT_TIMESTAMP, 155),
    (56, 'Tata Steel', 'Pooja Thakur', 'pooja.thakur@tata.com', '9901234569', '21 Steel Street', 'Asansol', 'WB', '713301', CURRENT_TIMESTAMP, 156),
    (57, 'Reliance Industries', 'Vivek Ahuja', 'vivek.ahuja@reliance.com', '9012345680', '45 Petro Hub', 'Bhubaneswar', 'OD', '751002', CURRENT_TIMESTAMP, 157),
    (58, 'Hindustan Unilever', 'Anjali Verma', 'anjali.verma@hul.com', '9123456783', '24 FMCG Lane', 'Noida', 'UP', '201302', CURRENT_TIMESTAMP, 158),
    (59, 'Bharat Petroleum', 'Ravindra Sharma', 'ravindra.sharma@bpcl.com', '9234567894', '67 Oil Market', 'Patna', 'BR', '800002', CURRENT_TIMESTAMP, 159),
    (60, 'Tata Motors', 'Amit Rathi', 'amit.rathi@tatamotors.com', '9345678905', '32 Motor City', 'Chennai', 'TN', '600003', CURRENT_TIMESTAMP, 160),
    (61, 'Tata Steel', 'Sanjana Das', 'sanjana.das@tata.com', '9456789015', '23 Steel Yard', 'Ranchi', 'JH', '834002', CURRENT_TIMESTAMP, 161),
    (62, 'Reliance Industries', 'Rishi Gupta', 'rishi.gupta@reliance.com', '9567890126', '34 Oil Terminal', 'Baroda', 'GJ', '390002', CURRENT_TIMESTAMP, 162),
    (63, 'Hindustan Unilever', 'Naina Bhargava', 'naina.bhargava@hul.com', '9678901237', '14 Consumer Zone', 'Coimbatore', 'TN', '641002', CURRENT_TIMESTAMP, 163),
    (64, 'Bharat Petroleum', 'Rohit Patil', 'rohit.patil@bpcl.com', '9789012348', '41 Gas Station', 'Nashik', 'MH', '422002', CURRENT_TIMESTAMP, 164),
    (65, 'Tata Motors', 'Vishal Sharma', 'vishal.sharma@tatamotors.com', '9890123459', '78 Car Plaza', 'Kanpur', 'UP', '208001', CURRENT_TIMESTAMP, 165),
    (66, 'Tata Steel', 'Neeta Agarwal', 'neeta.agarwal@tata.com', '9901234570', '52 Iron Plant', 'Bilaspur', 'CG', '495001', CURRENT_TIMESTAMP, 166),
    (67, 'Reliance Industries', 'Aarti Joshi', 'aarti.joshi@reliance.com', '9012345681', '67 Chemical City', 'Kolkata', 'WB', '700002', CURRENT_TIMESTAMP, 167),
    (68, 'Hindustan Unilever', 'Mohan Gupta', 'mohan.gupta@hul.com', '9123456784', '33 Product Hub', 'Chandigarh', 'CH', '160002', CURRENT_TIMESTAMP, 168),
    (69, 'Bharat Petroleum', 'Priyanka Rao', 'priyanka.rao@bpcl.com', '9234567895', '45 Fuel Depot', 'Jabalpur', 'MP', '482001', CURRENT_TIMESTAMP, 169),
    (70, 'Tata Motors', 'Sandeep Mehra', 'sandeep.mehra@tatamotors.com', '9345678906', '57 Auto Park', 'Ahmedabad', 'GJ', '380002', CURRENT_TIMESTAMP, 170);



select * from suppliers;

Snowflake Realtime Training 
      Session-28
 -----------------------
	Data Unloading 
									 
	https://youtu.be/f3qtQTVIEG4
    
  Data Loading --> AWS S3--> IAM --> Storage intgration --> Stage --> copy into Tables 


  Data Unloading -->   Snowflake tables --> AWS 
  
  
  1) We need to Create Table / Take any existing table 
  2) Create AWS S3 bucket 
  3) Create IAM Roles and permisions 
  4) Create Storage integration object  aand describe take external id and user arn modify trust relation ships
  5) Create Stage /List 
  6) Copy the data from stage to Table (Copy the data from table to Stage)
                                            from stage to AWS 
											
											
											
    arn:aws:s3:::vitech-snow-data-unload
	
	s3://vitech-snow-data-unload/csv/
	
	
	role ARN --> arn:aws:iam::390844745092:role/vitech-snow-data-unload-role
	
	
	
	user arn:  arn:aws:iam::211125613752:user/externalstages/cindz60000
	
	external id: AW72378_SFCRole=3_Kj/xH1Zc1ac4y9Y19gwcD4aVKdw=
	
	
--SQLs

select * from HR.VITECH.EMPLOYEES



CREATE OR REPLACE STORAGE INTEGRATION my_s3_integration
  TYPE = 'EXTERNAL_STAGE'
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::390844745092:role/vitech-snow-data-unload-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://vitech-snow-data-unload/csv/');


  desc storage integration my_s3_integration;




  
CREATE OR REPLACE STAGE my_vitech_stage
  STORAGE_INTEGRATION = my_s3_integration
  URL = 's3://vitech-snow-data-unload/csv/'
 --- FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"');


 list @my_vitech_stage


//loading 
 copy into table_name 
     from stage 


//unloading 
 copy into stage 
     from table_name  



COPY INTO @my_vitech_stage/employee_data.csv
FROM HR.VITECH.EMPLOYEES
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' COMPRESSION = 'NONE')
OVERWRITE = TRUE;




arn:aws:iam::024848483653:role/vitech-data-unload

s3://vitech-data-unload/csv/

CREATE OR REPLACE STORAGE INTEGRATION my_s3_integration
  TYPE = 'EXTERNAL_STAGE'
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::024848483653:role/vitech-data-unload'
  STORAGE_ALLOWED_LOCATIONS = ('s3://vitech-data-unload/csv/');

  desc storage integration my_s3_integration;

  arn:aws:iam::211125613752:user/externalstages/cisgz60000

  XA27209_SFCRole=5_/Nn4b7zZUBharB11d+gSPOYCNcw=

   
CREATE OR REPLACE STAGE my_vitech_stage
  STORAGE_INTEGRATION = my_s3_integration
  URL = 's3://vitech-data-unload/csv/'
 --- FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"');

 
 list @my_vitech_stage;

 COPY INTO @my_vitech_stage/suppliers_data.csv
FROM vitech_adf.adf.suppliers
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' COMPRESSION = 'NONE')
OVERWRITE = TRUE;

