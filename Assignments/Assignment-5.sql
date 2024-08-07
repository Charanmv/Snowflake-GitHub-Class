use hr.vitech;
41) Display
name,salary,hra,pf,da,total salary for each employee. The  output should be in the order of total
salary, hra 15% of salary, da 10% of salary,pf 5%  salary,total salary will
be(salary+hra+da)-pf. ;

select 
first_name,
salary * 0.15 as hra,
salary * 0.10 as da,
salary * 0.05 as pf,
(salary +(salary*0.15)+(salary*0.10))-(salary*0.05) as Total_salary
 from employees;

42) Display depart numbers and total
number of employees working in each 
department. ;

select department_id, count(*) as TotalEmp from employees 
group by department_id;

43) Display the various jobs and total
number of employees within each job 
group. ;

select Job_id, count(*) as totalEmp from employees
group by job_id 
order by job_id;

44) Display the depart numbers and total
salary for each department. ;

select department_id , sum(salary) as totalSalary from employees
group by department_id
order by department_id;

45) Display the depart numbers and max
salary for each department. ;

select department_id, max(salary),first_name from employees
group by department_id
order by department_id;

SELECT department_id, first_name, salary
FROM employees
WHERE (department_id, salary) IN (
    SELECT department_id, MAX(salary)
    FROM employees
    GROUP BY department_id
);

46) Display the various jobs and total
salary for each job ;

select job_id , sum(salary) from employees
group by job_id
order by job_id;

47) Display the various jobs and total
salary for each job ;

select job_id , sum(salary) from employees
group by job_id
order by job_id;

48) Display the depart numbers with more
than three employees in each dept. ;

select department_id from employees
group by department_id having count(*) > 3
order by department_id ;

49) Display the various jobs along with
total salary for each of the jobs 
Where total salary is greater than 40000. ;

select job_id , sum(salary) as totalsalary from employees 
group by job_id 
having totalsalary > 10000
order by job_id;


50) Display the various jobs along with
total number of employees in each  job.
The output should contain only those jobs with more than three
employees.;

select job_id, count(*) as totalEmp from employees
group by job_id
having count(*) > 3;