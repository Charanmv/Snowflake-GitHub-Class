use hr;

show tables;

use schema vitech;

select * from employees

21) Display the
names of employees whose names have second alphabet A in  their names.;

select first_name from employees
where first_name like '%_a%';

22) select the names of the employee
whose names is exactly five characters 
in length.;

select first_name from employees
where LENGTH(first_name) =5;

23) Display the names of the employee who
are not working as MANAGERS. ;

select first_name from employees
where job_title != 'manager';

24) Display the names of the employee who
are not working as SALESMAN OR  CLERK
OR ANALYST. 

select first_name from employees 
where job_title not in('salesman
')

select * from employees;