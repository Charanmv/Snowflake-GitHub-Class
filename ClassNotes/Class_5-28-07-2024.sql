
       Session-5
--------------------------
								
Advanced SQL concepts
								
   Rownumber  
   rank
   dense_rank
   CTE 
   Union 
   Union All 

   class notes:
-----------------
select department_id from employees;



select * from employees;


select 
       row_number() over(order by department_id) as rid,
       department_id,
       salary,
       first_name
from employees;


select * from (
select 
       row_number() over(order by department_id) as rid,
       department_id,
       salary,
       first_name
from employees
) where rid = 10;

create or replace table emp as (
select 
       row_number() over(order by department_id) as rid,
       department_id,
       salary,
       first_name
from employees
);

select * from emp where rid = 10;

// CTE -- common table expression ;

with cte_emp as (
select 
       row_number() over(order by department_id) as rid,
       department_id,
       salary,
       first_name
from employees 
)
select * from cte_emp where rid = 10;

--------------------------

with cte_emp as (
select 
       row_number() over(order by salary desc) as rid,
       salary,
       first_name,
       department_id,
from employees 
) 
select * from cte_emp where rid = 6;


--------------------

with cte_emp as (
select 
       dense_rank() over(order by salary desc) as rid,
       salary,
       first_name,
       department_id,
from employees 
) 
select * from cte_emp where rid = 5;
------------------------------------------


with cte_emp as (
select 
       rank() over(order by salary desc) as rid,
       salary,
       first_name,
       department_id,
from employees 
) 
select * from cte_emp where rid = 5


select * from employees  where salary in (
select  max(salary)from employees
group by department_id);

with cte_emp as (
select first_name 
,salary
,department_id,
row_number() over(partition by DEPARTMENT_ID  order by salary desc)   as rid
from employees
)
select * from cte_emp where rid = 1  order by department_id;

--40+30=70 

//it will fetch all the values 
select FIRST_NAME from employees 
     union all
select FIRST_NAME from dependents;

//union -- will remove duplicates
select FIRST_NAME from employees 
     union 
select FIRST_NAME from dependents;  

select * from dependents  ;
