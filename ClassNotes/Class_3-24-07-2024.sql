 Session-3
--------------------------
	Data fetch /  retrieval 
    DQL --> Select 

//practice
--------------------------

use hr.practice;

create or replace table persons(P_Id int,
LastName varchar(50),
FirstName varchar(50),
Address varchar(50),
City varchar(50));

insert into persons(P_Id, LastName, FirstName, Address, City)
values(4, 'Nilsen', 'Tom', 'Vingvn 23' ,'Stavanger');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (5, 'Johnson', 'Emily', 'Baker St 221B', 'London');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (6, 'Smith', 'John', 'Elm St 456', 'New York');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (7, 'Doe', 'Jane', 'Main St 789', 'Los Angeles');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (8, 'Brown', 'Charlie', 'Oak St 123', 'San Francisco');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (9, 'Davis', 'Megan', 'Pine St 456', 'Seattle');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (10, 'Wilson', 'Chris', 'Maple St 789', 'Chicago');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (11, 'Taylor', 'Rachel', 'Cedar St 101', 'Houston');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (12, 'Anderson', 'Michael', 'Birch St 202', 'Austin');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (13, 'Thomas', 'Olivia', 'Spruce St 303', 'Miami');

INSERT INTO persons (P_Id, LastName, FirstName, Address, City)
VALUES (14, 'White', 'David', 'Willow St 404', 'Boston');

select * from persons;

SELECT distinct LastName,FirstName FROM Persons;

SELECT DISTINCT City FROM Persons;

SELECT * FROM Persons
WHERE City='Boston';

SELECT * FROM Persons
WHERE FirstName='Tove'AND LastName='Svendson';

SELECT * FROM Persons
WHERE FirstName='Michael' OR FirstName='Ola';

SELECT * FROM Persons
WHERE LastName='Birch St 202' AND (FirstName='Tove' OR FirstName='Michael');


SELECT * FROM Persons ORDER BY LastName;

SELECT * FROM Persons ORDER BY LastName DESC;

INSERT INTO Persons(P_Id, LastName, FirstName) VALUES (5, 'Tjessem', 'Jakob');

create or replace table test(amount int);

insert into test(amount)values(-100),(200),(600),
(-20),(300),(-10),(900),(805);

select amount,
case when amount <0  then 'lose'   else 'Profit' end as status from test;

use hr.vitech;

select * from employees;

// finding length of characters 
select length('Steven') ;

SELECT length('Hello!');

//useing requried database
use database hr;

//validate
select * from employees;

//updating the table
update employees 
set first_name = 'charan'
where employee_id = 100;


update employees
set first_name = 'sreekanth',last_name = 'gaudari'
where employee_id = 101;

select * from employees where  manager_id = 100 ;

update employees 
set manager_id = null
where manager_id = 100;

select * from employees;

update employees 
set manager_id = 100
where manager_id is null;

desc table employees;

create or replace table employee_v1 as(
select * from employees
);

select * from employee_v1;

create or replace table employees_v2 as( 
select first_name,Last_name,email,phone_number from employees );

select * from employees_v2;

drop table employees_v2;


create or replace table employees_v2 as( 
select first_name,Last_name,email from employees );

delete from employees_v2;

select top 3 * from dependents;

create or replace table dependents_v1 as(
select * from dependents
);

delete from dependents;

select * from dependents;

create or replace table dependents as(
select * from dependents_v1
);

select  employee_id from dependents;

select  first_name as fname from dependents;

select count(*) as totalcount from dependents;

select * from employees  where employee_id in (
   select  employee_id from dependents
 -- 206 ,205 ,100
);


select * from employees  where employee_id not in (
   select  employee_id from dependents
  -- 206 ,205 ,100
);

select * from employees order by salary desc;

select employee_id ,
       first_name,
       salary ,
       case when salary <10000 then 'jr software' else 'sr software'
       end as designation from employees;

select email from employees;


//functions pracrice
-----------------------------
select upper(email) from employees;

select lower(first_name) from employees;

select substr(email,1,10) from employees;

select current_timestamp() ;

select substr(current_timestamp(),1,10 );

select distinct salary,first_name from employees;



select employee_id , first_name , salary 
      , row_number() over(order by salary desc ) as rid
from employees;


select employee_id , first_name , salary 
      , rank() over(order by salary desc ) as rid
from employees;


select employee_id , first_name , salary 
      , dense_rank() over(order by salary desc ) as rid
from employees ;


--String functions
-----------------------------------------------
select ascii('C') as ascii_number;

select char(65) as char_value;

SELECT CHAR(89) AS CodeToCharacter;

SELECT CHARINDEX('t', 'Customer') AS MatchPosition;

SELECT CONCAT('W3Schools', '.com');

SELECT CONCAT_WS('.', 'www', 'W3Schools', 'com');

select concat('charan','kumar');

select substring('HI my name is charan',5,9);

select length('this is snowflak class');

select upper('ramakrishna');

select RIGHT('charan',4);

select LEFT('charan',3);

select repeat('charan',5);


//Numeric functions;
-------------------------------

select abs(-.45612);

SELECT FLOOR(5.8);

SELECT ROUND(3.14159, 2);

SELECT EXP(1);

SELECT PI();

SELECT DEGREES(1.5708);

SELECT POWER(2, 3);

SELECT SQUARE(4);