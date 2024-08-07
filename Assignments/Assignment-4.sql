31) Display the
maximum salary being paid to CLERK. ;

select max(salary) from employees
where job_title = 'cleark'

32) Display the maximum salary being paid
to depart number 20. ;

select max(salary) from employees
where department_id = 10;


33) Display the minimum salary being paid
to any SALESMAN. 

select min(salary) from employees
where job_title = 'salesman'

34) Display the average salary drawn by
MANAGERS. 

select avg(salary) from employees
where job_title ='managers'

35) Display the total salary drawn by
ANALYST working in depart number 40. ;

select sum(salary) from employees
where job_title ="analyst" and department=40;


36) Display the names of the employee in
order of salary i.e the name of  the
employee earning lowest salary should appear first. 
;

select first_name,salary from employees
order by salary asc;


37) Display the names of the employee in
descending order of salary. ;

select first_name,salary from employees
order by salary desc;

38) Display the names of the employee in
order of employee name. ;

select first_name from employees
order by first_name;

39) Display empno,ename,deptno,sal sort
the output first base on name and 
within name by deptno and with in deptno by sal. 
;
select first_name,employee_id,department_id
,salary from employees
order by first_name,department_id,salary;


40) Display the name of the employee
along with their annual salary(sal*12).The name of the employee earning
highest annual salary should apper first.;

select first_name, salary*12 from employees
order by salary 