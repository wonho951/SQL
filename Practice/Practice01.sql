/*문제1*/
select  first_name || last_name as 이름,
        salary as 월급,
        phone_number as 전화번호,
        hire_date as 입사일
from employees
order by hire_date asc;



/*문제2*/
select  job_title as 업무이름,
        max_salary as 최고월급 
from jobs
order by max_salary desc;



/*문제3*/
select  first_name as 이름,
        manager_id as 매니저아이디,
        commission_pct as 커미션비율,
        salary as 월급
from employees
where salary > 3000
and commission_pct is null;



/*문제4*/
select  job_title as 업무이름,
        max_salary as 최고월급        
from jobs
where max_salary >= 10000
order by max_salary desc;



/*문제5*/
select  first_name as 이름,
        salary as 월급,
        nvl(commission_pct, 0) as 커미션퍼센트
from employees
where salary >= 10000 
or   salary < 14000
order by salary desc;



/*문제6*/
select  first_name as 이름,
        salary as 월급,
        to_char(hire_date, 'yyyy-mm') as 입사일,
        department_id as 부서번호
from employees
where department_id = 10
or department_id = 90
or department_id = 100;



/*문제7*/
select  first_name as 이름,
        salary as 월급
from employees
where UPPER(first_name) like '%S%';



/*문제8*/
select  department_name as 부서이름
from departments
order by length(department_name) asc;



/*문제9*/
select  upper(country_name) as 나라이름
from countries
order by country_name asc;



/*문제10*/
select  first_name as 이름,
        salary as 월급,
        replace(phone_number, '.', '-')as 전화번호,
        hire_date as 입사일
from employees
where hire_date <= '03/12/31';