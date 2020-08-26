select initcap('angelo') from dual;
select last_name, initcap(last_name) from online_subscribers;

select employee_id
from employee
where uppler(employee_name) = 'MCGILLICUTTY'
