--------------과제--------------
/*Practice04_실습문제_서브쿼리*/
/*문제1*/
select  count(salary)
from employees
where salary < (select  avg(salary)
                from employees);
                
/*문제2*/
select  employee_id 직원번호,
        first_name 이름,
        salary
from employees
where salary >= (select avg(salary)
                 from employees)
and salary <= (select max(salary)
               from employees)
order by salary asc;



select  e.employee_id 직원번호,
        e.first_name 이름,
        e.salary 급여,
        t.avgSal 평균급여,
        t.maxsal 최대급여
from employees e, (select  avg(salary) avgSal,
                           max(salary) maxSal
                   from employees)t
where e.salary >= t.avgsal
and e.salary <= t.maxsal
order by e.salary asc;



/*문제3*/
select  e.first_name || e.last_name 이름,
        l.location_id 도시아이디,
        l.street_address 거리명,
        l.postal_code 우편번호,
        l.city 도시명,
        l.state_province 주,
        l.country_id 나라아이디
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.first_name = 'Steven'
and e.last_name = 'King';


/*문제4*/
select  employee_id 사번,
        first_name 이름,
        salary 급여
from employees
where salary < any(select  salary 
                     from employees
                     where job_id = 'ST_MAN')
order by salary desc;


/*문제5*/
--조건절 비교
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        department_id 부서번호
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;


--테이블조인
select  e.employee_id 직원번호,
        e.first_name 이름,
        e.salary 급여,
        e.department_id 부서번호
from employees e, (select  department_id,
                           max(salary) maxSal
                   from employees
                   group by department_id) t
where e.salary = t.maxsal
and e.department_id = t.department_id
order by e.salary desc;



/*문제6*/
select  j.job_title,
        s.salary
from jobs j, (select  job_id,
                      sum(salary) salary
              from employees
              group by job_id) s
where j.job_id = s.job_id
order by s.salary desc;


/*문제7*/
select  e.employee_id 직원번호,
        e.first_name 이름,
        e.salary
from employees e, (select  department_id,
                           trunc(avg(salary), 0) salary
                   from employees
                   group by department_id) t
where e.department_id = t.department_id
and e.salary > t.salary;


/*문제8*/
--->> 1.정렬을 한다. 2.rownum을 멕인다. 3.where절을 한다.
select  ot.rn,
        ot.employee_id,
        ot.first_name,
        ot.salary,
        ot.hire_date
from (select  rownum rn,
              t.employee_id,
              t.first_name,
              t.salary,
              t.hire_date
      from (select  employee_id,
                    first_name,
                    salary,
                    hire_date
            from employees
            order by hire_date asc) t
        )ot
where rn >= 11
and rn <= 15;