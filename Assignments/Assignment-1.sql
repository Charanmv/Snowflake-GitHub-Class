 1) Display the details of all employees 
 select * from employees;

 2) Display the depart information from
department table 
select * from departments

3) Display the name and job for all the
employees 
select first_name,EMPLOYEE_ID,JOB_ID from employees

4) Display the name and salary  for all the employees 
select first_name,salary from employees

5) Display the employee no and totalsalary  for all the employees 
select sum(salary) as totalsalary from employees

6) Display the employee name and annual
salary for all employees. 
select first_name,salary from employees 

7) Display the names of all the employees
who are working in depart number 10. 
select first_name, department_id from employees 
where department_id = 10;

8) Display the names of all the employees
who are working as clerks and  drawing
a salary more than 3000. 

select first_name,salary from employees 
where salary > 3000 order by salary;

9) Display the employee number and
name  who are earning comm. 

select first_name, salary from employees
where salary in (
select salary from employees
group by salary
having count(*) > 1
) order by salary

10) Display the employee number and
name  who do not earn any comm.

select first_name, salary from employees
where salary in (
select salary from employees
group by salary
having count(*) = 1
) order by salary
