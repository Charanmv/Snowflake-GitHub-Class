use hr.vitech;

51) Display the
name of the employee who earns highest salary. 
;
select first_name,salary from employees
order by salary desc 
Limit 5;

52) Display the employee number and name
for employee working as clerk and 
earning highest salary among clerks. 
;

select employee_id , first_name ,salary from employees
where job_id =6 order by salary desc limit 1;

53) Display the names of salesman who
earns a salary more than the highest 
salary of any clerk. ;

select first_name,salary from employees
where job_id =5 
and salary > (select max(salary) from employees 
where job_id =9);

54) Display the names of clerks who earn
a salary more than the lowest 
Salary  of any salesman. ;

select first_name , salary from employees
where job_id =7 
and salary > (select min (salary) from
employees where job_id =13 );

Display the names of employees who earn a
salary more than that of  Jones or that
of salary grether than   that of
scott. ;


SELECT first_name
FROM employees
WHERE salary > (SELECT max(salary) FROM employees WHERE first_name = 'nancy')
   OR salary > (SELECT max(salary) FROM employees WHERE first_name = 'Alexander');


55) Display the names of the employees
who earn highest salary in their 
respective departments. 
;

select first_name,department_id from employees e
where salary = (select max(salary) from employees 
where department_id = e.department_id)
order by department_id;

56) Display the names of the employees
who earn highest salaries in their 
respective job groups. ;

select first_name, job_id from employees e
where salary = ( select max(salary) from employees 
where job_id = e.job_id) order by job_id;

57) Display the employee names who are
working in accounting department. ;

select first_name from employees
where department_id = 8;


58) Display the employee names who are
working in Chicago. ;

select first_name from employees
where city = 'chicago';

59) Display the Job groups having total
salary greater than the maximum  salary
for managers. ;

SELECT  job_id AS job_group
FROM employees
GROUP BY job_id
HAVING SUM(salary) > (
    SELECT MAX(salary)
    FROM employees
    WHERE job_id = 5
);


60) Display the names of employees from
department number 10 with salary 
grether than that of any employee working in other department. 
;

SELECT first_name
FROM employees
WHERE department_id = 10
  AND salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id <> 10
);

61) Display the names of the employees
from department number 10 with  salary
greater than that of all employee working in other departments. 
;
SELECT  first_name
FROM employees e
WHERE department_id = 10
  AND salary > ALL (
    SELECT salary
    FROM employees
    WHERE department_id <> 10
);

62) Display the names of the employees in
Uppercase. ;

select upper(first_name) as names_uppercase
from employees;

63) Display the names of the employees in
Lowecase. ;
select LOWER(first_name) as names_uppercase
from employees;
64) Display the names of the employees in
Propercase.; 

select initcap(first_name) as names_uppercase
from employees;

65) Display the length of Your name using
appropriate function. ;

select length('charan kumar mv') as name_length;

66) Display the length of all the
employee names. ;

select first_name, length(first_name) as name_length
from employees;

67) select name of the employee
concatenate with employee number.  ;

select job_id || ' ' || first_name as emp_info
from employees;

68) User appropriate function and extract
3 characters starting from 2 
characters from the following 
string 'Oracle'. i.e the out put should be 'ac'.; 

select substring('Oracle' ,2,3) as extracted_string;


69) Find the First occurance of character
'a' from the following string i.e 
'Computer Maintenance Corporation'. ;

SELECT POSITION('a' IN 'Computer Maintenance Corporation') 
AS position_of_a;



70) Replace every occurance of alphabhet
A with B in the string Allens(use 
translate function) ;

SELECT TRANSLATE('Allens', 'A', 'B') AS replaced_string;


71) Display the informaction from emp
table.Where job manager is found it 
should be displayed as boos(Use replace function). ;

SELECT 
    employee_id,
    REPLACE(job_id, '9', '0') AS job_id
FROM employees;

72) Display empno,ename,deptno from emp
table.Instead of display department 
numbers display the related department 
name(Use decode function). ;

SELECT 
    employee_id,
    first_name,
    DECODE(DEPARTMENT_ID,
        9, 'Accounting',
        2, 'Research',
        6, 'Sales',
        4, 'Operations',
        'Unknown') AS dept_name
FROM employees;

73) Display your age in days. ;

SELECT DATEDIFF(day, '1999-09-21', CURRENT_DATE()) AS age_in_days;

74) Display your age in months.; 

select datediff(month, '1999-09-21', current_date()) as age_in_months;

75) Display the current date as 15th
Augest Friday Nineteen Ninety Saven. ;

SELECT TO_CHAR(CURRENT_DATE(), '04th sep 09 1999') AS formatted_date
FROM dual;

 
76) Display the following output for each
row from emp table. scott has joined the company on wednesday 13th August
ninten nintey. ;
SELECT 
    first_name || ' has joined the company on ' ||
    TO_CHAR(hire_date, 'mon') || ' ' ||
    TO_CHAR(hire_date, '21') || ' ' ||
    TO_CHAR(hire_date, '09') || ' ' ||
    TO_CHAR(hire_date, '2023') AS formatted_output
FROM employees;

77) Find the date for nearest saturday
after current date. ;

SELECT DATEADD(day, 
                (6 - DATE_PART(weekday, CURRENT_DATE()) + 7) % 7, 
                CURRENT_DATE()) AS next_saturday;

78) Display current time. ;

SELECT CURRENT_TIME() AS current_time;

SELECT CURRENT_TIMESTAMP() AS current_timestamp;

79) Display the date three months Before
the current date. ;

SELECT DATEADD(month, -3, CURRENT_DATE()) AS date_three_months_ago;


80) Display the common jobs from
department number 10 and 20.;

SELECT job_id
FROM employees
WHERE department_id = 5

INTERSECT

SELECT job_id
FROM employees
WHERE department_id = 6;

select * from hr.vitech.employees;