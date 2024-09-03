create database vitech_dev_db;

create schema vitech_OMS_bronze_data;

create schema vitech_OMS_silver_data;

create schema vitech_OMS_gold_data;


//2) Create IAM Roles

s3://vitech-etl-customer

arn:aws:iam::024848483653:role/vitech-etl-customer

User_ARN :-   arn:aws:iam::211125613752:user/externalstages/ci2ly60000
External_ID : YI56648_SFCRole=2_8f2ElrbXBUWafJ2wWHRYhz2HjYY=

// create storage integration object

create or replace storage integration s3_integtation
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::024848483653:role/vitech-etl-customer'
  STORAGE_ALLOWED_LOCATIONS = ('s3://vitech-etl-customer')
   COMMENT = 'This is an s3 integration object ' 

// describe integration
DESC integration s3_integtation;

//create stage
    CREATE OR REPLACE stage stage_aws_csv
    URL = 's3://vitech-etl-customer'
    STORAGE_INTEGRATION = s3_integtation;

//List stage
list @stage_aws_csv;

// create file_format
CREATE OR REPLACE file format csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE    
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'  ;

//create 8 Tables and copy data from stage

//Table-1 suppliers
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

//creating suppliers pipe
CREATE OR REPLACE PIPE suppliers_pipe
AUTO_INGEST = TRUE
AS
COPY INTO suppliers
FROM @stage_aws_csv
FILE_FORMAT = csv_fileformat
PATTERN = '.*Supplier.*';    

//describe pipe
desc PIPE suppliers_pipe;

select * from suppliers;

alter pipe suppliers_pipe refresh;

//Table-2 orders
CREATE TABLE orders (
    OrderID INT,                   -- Unique identifier for each order
    OrderDate DATE,                -- Date of the order
    CustomerID INT,                -- ID of the customer placing the order
    EmployeeID INT,                -- ID of the employee handling the order
    StoreID INT,                   -- ID of the store where the order is placed
    Status VARCHAR(10),            -- Order status (e.g., 'Pending', 'Shipped')
    Updated_at TIMESTAMP           -- Timestamp of the last update
);

//creating orders pipe
CREATE OR REPLACE PIPE orders_pipe
AUTO_INGEST = TRUE
AS
COPY INTO orders
FROM @stage_aws_csv
FILE_FORMAT = csv_fileformat
PATTERN = '.*Orders.*';    

//describe pipe
desc PIPE orders_pipe;

select * from orders;

alter pipe orders_pipe refresh;


//Table-3 Customers
CREATE  TABLE customers (
    CustomerID VARCHAR(10),           -- Unique identifier for each customer
    FirstName VARCHAR(50),            -- Customer's first name
    LastName VARCHAR(50),             -- Customer's last name
    Email VARCHAR(100),               -- Customer's email address
    Phone VARCHAR(100),               -- Customer's contact number
    Address VARCHAR(100),             -- Customer's address
    City VARCHAR(50),                 -- City name
    State VARCHAR(2),                 -- State abbreviation
    ZipCode VARCHAR(10),              -- Postal code
    Updated_at TIMESTAMP,             -- Timestamp of the last update
    orderitems_OrderItemID INT,       -- Associated order item ID
    stores_StoreID INT                -- Associated store ID
);

//creating customers pipe
CREATE OR REPLACE PIPE customers_pipe
AUTO_INGEST = TRUE
AS
COPY INTO customers
FROM @stage_aws_csv
FILE_FORMAT = csv_fileformat
PATTERN = '.*Customers.*';    

//describe pipe
desc PIPE customers_pipe;

select * from customers;

alter pipe customers_pipe refresh;

//Table-4 Stores
CREATE TABLE stores (
    StoreID INT,                    -- Unique identifier for each store
    StoreName VARCHAR(100),         -- Name of the store
    Address VARCHAR(200),           -- Address of the store
    City VARCHAR(50),               -- City where the store is located
    State VARCHAR(50),              -- State where the store is located
    ZipCode VARCHAR(10),            -- Postal code of the store
    Email VARCHAR(200),             -- Store's email address
    Phone VARCHAR(50),              -- Store's contact phone number
    Updated_at TIMESTAMP,           -- Timestamp of the last update
    dates_Date DATE                 -- Date associated with the store record
);

//creating stores pipe
CREATE OR REPLACE PIPE stores_pipe
AUTO_INGEST = TRUE
AS
COPY INTO stores
FROM @stage_aws_csv
FILE_FORMAT = csv_fileformat
PATTERN = '.*Stores.*';    

//describe pipe
desc PIPE stores_pipe;

select * from stores;

alter pipe stores_pipe refresh;

//Table-5 products
CREATE or replace TABLE products (
    ProductID INT,                   -- Unique identifier for each product
    Name VARCHAR(100),              -- Name of the product
    Category VARCHAR(100),          -- Category of the product
    RetailPrice DECIMAL(10,2),      -- Retail price of the product
    SupplierPrice DECIMAL(10,2),    -- Supplier price of the product
    SupplierID INT,                 -- ID of the supplier (references suppliers table)
    Updated_at TIMESTAMP,           -- Timestamp of the last update
    orders_OrderID INT,             -- Associated order ID (references orders table)
    stores_StoreID INT              -- Associated store ID (references stores table)
);
//creating Products pipe
CREATE OR REPLACE PIPE products_pipe
AUTO_INGEST = TRUE
AS
COPY INTO products
FROM @stage_aws_csv
FILE_FORMAT = csv_fileformat
PATTERN = '.*Products.*';    

//describe pipe
desc PIPE products_pipe;

select * from Products;

alter pipe products_pipe refresh;

//Table-6 Dates
CREATE  TABLE dates (
    Date DATE,                       -- Date value
    Day VARCHAR(3),                 -- Day of the month (e.g., '01', '15')
    Month VARCHAR(10),              -- Month name (e.g., 'January', 'December')
    Year VARCHAR(4),                -- Year (e.g., '2024')
    Quarter INT,                    -- Quarter of the year (1 to 4)
    DayOfWeek VARCHAR(10),         -- Day of the week (e.g., 'Monday', 'Friday')
    WeekOfYear INT,                 -- Week number in the year (1 to 53)
    Updated_at TIMESTAMP,           -- Timestamp of the last update
    stores_StoreID INT              -- Associated store ID (references stores table)
);
//creating Dates pipe
CREATE OR REPLACE PIPE dates_pipe
AUTO_INGEST = TRUE
AS
COPY INTO dates
FROM @stage_aws_csv
FILE_FORMAT = csv_fileformat
PATTERN = '.*Dates.*';    

//describe pipe
desc PIPE dates_pipe;

select * from Dates;

alter pipe dates_pipe refresh;

//Table-7 OrderItems
CREATE TABLE orderitems (
    OrderItemID INT,              -- Unique identifier for each order item
    OrderID INT,                 -- ID of the order (references orders table)
    ProductID INT,               -- ID of the product (references products table)
    Quantity INT,                -- Quantity of the product ordered
    UnitPrice DECIMAL(10,2),     -- Unit price of the product at the time of the order
    Updated_at TIMESTAMP,        -- Timestamp of the last update
    employees_EmployeeID INT     -- ID of the employee handling the order (references employees table)
);

//creating orderitems pipe
CREATE OR REPLACE PIPE orderitems_pipe
AUTO_INGEST = TRUE
AS
COPY INTO orderitems
FROM @stage_aws_csv
FILE_FORMAT = csv_fileformat
PATTERN = '.*OrderItems.*';    

//describe pipe
desc PIPE orderitems_pipe;

select * from orderitems;

alter pipe orderitems_pipe refresh;

//Table-8 Employees
CREATE TABLE employees (
    EmployeeID INT,                   -- Unique identifier for each employee
    FirstName VARCHAR(100),          -- First name of the employee
    LastName VARCHAR(100),           -- Last name of the employee
    Email VARCHAR(200),              -- Email address of the employee
    JobTitle VARCHAR(100),           -- Job title of the employee
    HireDate DATE,                   -- Date when the employee was hired
    ManagerID INT,                   -- Manager's ID (self-referencing foreign key)
    Address VARCHAR(200),            -- Address of the employee
    City VARCHAR(50),               -- City where the employee lives
    State VARCHAR(50),              -- State where the employee lives
    ZipCode VARCHAR(10),             -- Zip code of the employee's address
    Updated_at TIMESTAMP             -- Timestamp of the last update
);

CREATE OR REPLACE pipe 
auto_ingest = True
as
COPY INTO OUR_FIRST_DB.PUBLIC.employees
FROM @MANAGE_DB.external_stages.csv_folder ; 

















   