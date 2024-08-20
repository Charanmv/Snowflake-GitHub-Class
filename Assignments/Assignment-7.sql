81) Display the
jobs found in department 10 and 20 
Eliminate duplicate jobsz;

select distinct jobs from employees 
where department in (10,20);

82) Display the jobs which are unique to
department 10.;

select distinct jobs from employee
where department = 10
and job not in (
    select job from employees where department <> 10
);

84) Display the details of those
employees who are in sales department and 
grade is 3.;







85) Display those who are not managers
and who are managers any one. i)display the managers names ii)display the who
are not managers  







86) Display those employee whose name
contains not less than 4 characters. 







87) Display those department whose name
start with "S" while the location 
name ends with "K". 







88) Display those employees whose manager
name is JONES. 







89) Display those employees whose salary
is more than 3000 after giving 20% 
increment.CC 







90) Display all employees while their
dept names; 







91) Display ename who are working in
sales dept. 







92) Display employee name,deptname,salary
and comm for those sal in between  2000
to 5000 while location is chicago. 







93)Display those employees whose salary
greter than his manager salary. 







94) Display those employees who are
working in the same dept where his 
manager is work. 







95) Display those employees who are not
working under any manager. 







96) Display grade and employees name for
the dept no 10 or 30 but grade is  not
4 while joined the company before 31-dec-82. 







97) Update the salary of each employee by
10% increment who are not  eligiblw for
commission. 







98) SELECT those employee who joined the
company before 31-dec-82 while  their
dept location is newyork or 
Chicago. 







99) DISPLAY EMPLOYEE
NAME,JOB,DEPARTMENT,LOCATION FOR ALL WHO ARE WORKING  AS 
MANAGER? 







100) DISPLAY THOSE EMPLOYEES WHOSE
MANAGER NAME IS JONES? -- [AND ALSO DISPLAY THEIR MANAGER NAME]? 







101) Display name and salary of ford if
his salary is equal to hisal of his 
grade