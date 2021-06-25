/*문제1*/
select  count(manager_id) as 매니저가있는직원
from employees;


/*문제2*/
select  max(salary) - min(salary) as "최고임금-최저임금"
from employees;


/*문제3*/
select  to_char(max(hire_date), 'YYYY"년"MM"월"DD"일"') as 마지막신입사원입사
from employees;


/*문제4*/
select  avg(salary) as 평균임금,
        max(salary) as 최고임금,
        min(salary) as 최저임금,
        department_id as 부서번호
from employees
group by department_id
order by department_id desc;


/*문제5*/
select  round(avg(salary), 0) as 평균임금,
        max(salary) as 최고임금,
        min(salary) as 최저임금,
        job_id as 업무아이디
from employees
group by job_id
order by min(salary) desc,
         round(avg(salary), 0) asc;
         
 /*문제6*/        
select  to_char(min(hire_date), 'YYYY-MM-DD')
from employees;
 
 
 /*문제7*/
select department_id as 부서,
        round(avg(salary), 0) as 평균임금,
        min(salary) as 최저임금,
        round(avg(salary) - min(salary), 0) as "평균임금-최저임금"
from employees 
group by department_id
having avg(salary) - min(salary) < 2000
order by avg(salary) - min(salary) desc;
 
 
 /*문제8*/
select  job_id as 업무아이디,
        max(salary) as 최고임금,
        min(salary) as 최저임금,
        max(salary) - min(salary) as "최고임금-최저임금"
from employees
group by job_id
order by max(salary) - min(salary) desc;
 
 
  /*문제9*/
select  manager_id as 관리자아이디,
        round(avg(salary), 0) as 평균급여,
        min(salary) as 최소급여,
        max(salary) as 최대급여
from employees
where hire_date >= '05/01/01'
group by manager_id
having avg(salary) >= 5000
order by avg(salary) desc;


/*문제10*/
select  first_name as 이름,
        hire_date as 입사일,
    case
        when hire_date <= '02/12/31' then '창립멤버'
        when hire_date <= '03/12/31' then '03년입사'
        when hire_date <= '04/12/31' then '04년입사'
        else '상장이후입사'
    end as otpDate  
from employees
order by hire_date asc;