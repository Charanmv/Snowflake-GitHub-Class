create table TABLE_A (NUM INT)
INSERT INTO TABLE_A (NUM)
VALUES(1),(2),(2),(3),(3),(3),(4),(4),(4),(4),(5),(5),(5),(5),(5),(NULL)

create table TABLE_B (NUM INT);
INSERT INTO TABLE_B (NUM)
VALUES(1),(1),(2),(2),(3),(3),(4),(4),(5),(5),(5),(NULL),(NULL);
DROP TABLE TABLE_B;

SELECT X.*,Y.* FROM TABLE_A X INNER JOIN TABLE_B Y
ON X.NUM = Y.NUM; // count 35

SELECT X.*,Y.* FROM TABLE_A X LEFT JOIN TABLE_B Y
ON X.NUM = Y.NUM; // count 36

SELECT X.*,Y.* FROM TABLE_A X RIGHT JOIN TABLE_B Y
ON X.NUM = Y.NUM; // count 37

SELECT X.*,Y.* FROM TABLE_A X full JOIN TABLE_B Y
ON X.NUM = Y.NUM; // count 38

select * from employees;

11) Display the
names of employees who are working as clerks, salesman or  analyst and drawing a salary more than
3000. 

SELECT first_name
FROM employees
WHERE job IN ('CLERK', 'SALESMAN', 'ANALYST') AND salary > 3000;


12) Display the names of the employees
who are working in the company for  the
past 5 years; 

SELECT first_name
FROM employees
WHERE hire_date <= DATEADD(year, -5, CURRENT_DATE);



13) Display the list of employees who
have joined the company before 
30-JUN-90 or after 31-DEC-90.

SELECT *
FROM employees
WHERE HIRE_DATE < '1990-07-01' OR hire_date > '1990-12-31';


14) Display current Date.

SELECT CURRENT_DATE;

15) Display the list of all users in your
database (use catalog table). 

SHOW USERS; 

or

SELECT * 
FROM SNOWFLAKE.ACCOUNT_USAGE.USERS;

or

SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

16) Display the names of all tables from
current user; 

show tables;

17) Display the name of the current
user. 

SELECT CURRENT_USER();


18) Display the names of employees
working in depart number 10 or 20 or 40 
or employees working as CLERKS,SALESMAN or ANALYST. 


SELECT first_name
FROM employees
WHERE DEPARTMENT_ID IN (101, 201, 140)
   OR job_title IN ('CLERK', 'SALESMAN', 'ANALYST');

19) Display the names of employees whose
name starts with alaphabet S. 

select first_name from 
employees where first_name like 's%'

20) Display the Employee names for
employees whose name ends with alaphabet S.

select first_name from 
employees where first_name like '%s'