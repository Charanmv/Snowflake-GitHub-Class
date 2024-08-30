Session-29
--------------------------
UDF  & Stored procedures 

select sysdate();

select substr(sysdate(),11,10);

//Example-1 scaler function

//create a function
create or replace function vitech_date(business_date timestamp)
returns date
language sql
as 
  $$
    to_date(substr(to_char(business_date),1,10))
  $$;

select sysdate();

// calling function
select vitech_date('2024-08-29 09:27:34.334');

//Example-2

//create scalar function to disply time
CREATE OR REPLACE FUNCTION vitech_time(business_time timestamp)
RETURNS string
LANGUAGE SQL
AS
$$
   SUBSTR(TO_CHAR(business_time),11,10)
$$;

select vitech_time('2024-08-28 05:46:11.615');

//Example-3

CREATE OR REPLACE FUNCTION get_sum(a int, b int)
RETURNS int
LANGUAGE SQL
AS
$$
   a+b 
$$;

select get_sum(9,11);

//Example-4

CREATE OR REPLACE TABLE SALES(
   sale_datetime TIMESTAMP,
   sale_amount NUMBER(19,4)
);

INSERT INTO SALES VALUES
('2023-01-01 12:53:22.000','2876.93'),
('2023-01-02 01:14:55.000','3509.75'),
('2023-01-03 01:05:12.000','2971.66'),
('2023-01-04 12:47:49.000','3328.32');

select * from sales ;

select vitech_date(sale_datetime) , sale_amount from sales ;

//Table functions

//Example-1

//create table
CREATE OR REPLACE TABLE sales_by_country(
year NUMBER(4),
country VARCHAR(50),
sale_amount NUMBER
);

//insert data in table
INSERT INTO SALES_BY_COUNTRY VALUES
('2022','US','90000'),
('2022','UK','75000'),
('2022','FR','55000'),
('2023','US','100000'),
('2023','UK','80000'),
('2023','FR','70000');

//Example-2
CREATE OR REPLACE TABLE currency(
country VARCHAR(50),
currency VARCHAR(3)
);

//Insert data into table
INSERT INTO CURRENCY(country,currency) VALUES
('US','USD'),
('UK','GBP'),
('FR','EUR');

select * from SALES_BY_COUNTRY;

//createing table function
CREATE OR REPLACE FUNCTION get_sales(country_name VARCHAR)
RETURNS TABLE (year NUMBER, sale_amount NUMBER, country VARCHAR)
AS
$$
  SELECT year, sale_amount, country
  FROM sales_by_country
  WHERE country = country_name
$$
;

SELECT * FROM TABLE (get_sales('US'));

//To fine max sal from particular country

SELECT   country,max(sale_amount) as maxsales
FROM sales_by_country
WHERE country = 'US'
group by country;

//creating a function
CREATE OR REPLACE FUNCTION get_sales_max_amount(country_name VARCHAR)
RETURNS TABLE ( sale_max_amount NUMBER, country VARCHAR)
AS
$$
  SELECT max(sale_amount) as sale_max_amount, 
  country
  FROM sales_by_country
  WHERE country = country_name
  group by country
$$;

SELECT * FROM TABLE (get_sales_max_amount('UK'));

-----------------------------------------------

//Stored Procedure

select * from employees;

//creating a emp table
create or replace table emp as (
select * from employees );

select * from emp;

delete from emp where salary <= 5000;

//creating a stored procedure
CREATE OR REPLACE PROCEDURE purge_emp_data()
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
DECLARE
    message VARCHAR;
BEGIN
    DELETE FROM emp WHERE salary <= 6000;
    message := 'below 5000 employees data deleted
    successfully';
RETURN message;
END;
$$;

call purge_emp_data();

CREATE OR REPLACE PROCEDURE purge_emp_data(sal int)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
DECLARE
message VARCHAR;
BEGIN
DELETE FROM emp WHERE salary <=:sal;
message := 'below'||:sal||'employees data deleted successfully';
RETURN message;
END;
$$;

call purge_emp_data(15000);

select * from emp;


-------------Task------------

//Create a table name as customers 
//cid , cname , amount ,adress , phone 

//create table customers 
create or replace table customers(
cid string,
cname string,
amount string,
phone string
);

--1)Create a procedure to insert the values to customers table
//insert query
insert into customers(cid,cname,amount,phone)
values('101','charan','30000','854612397');

CREATE OR REPLACE PROCEDURE insert_emp_data(cid varchar,cname varchar,amount varchar,phone varchar)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
DECLARE
   message VARCHAR;
   BEGIN
   insert into customers(cid,cname,amount,phone)
   values(:cid,:cname,:amount,:phone);
   message := 'customers data inserted
   successfully';
   RETURN message;
END;
$$;

call insert_emp_data
('107','banu','26000','7895463210');

select * from customers;

--2)write a procuder for withdraw logic (cid ,1000)

-- Creating a procedure for the withdraw operation

CALL withdraw_amount('107', 1000);

select * from customers;



-- Example call to withdraw 1000 from customer with id '107'
CALL withdraw_amount('107', 1000);

3) write a procuder for with deposit logic (acno ,1000)

4) write a procedure to display customers based on branch/address (blr)

5) wirite a procedure to delete customer is inactive  (accno)

