--------------과제--------------
/*Practice05_실습문제_혼합*/
/*문제1*/
select  first_name 이름,
        manager_id 매니저아이디,
        commission_pct  "커미션 비율",
        salary 월급
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;


/*문제2*/
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        to_char(hire_date, 'yyyy-mm-dd') 입사일,
        replace(phone_number, '.', '-') 전화번호,
        department_id 부서번호
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary) salary
                                  from employees
                                  group by department_id);



/*문제3*/
---하는중
select  manager_id,
        first_name,
        max(salary),
        min(salary)        
from employees
group by manager_id;



/*문제4*/
select  e.employee_id 사번,
        e.first_name 이름,
        e.department_id 부서명,
        m.first_name 매니저이름
from employees e, employees m
where e.employee_id = m.manager_id;



/*문제5*/
select  ot.rn,
        ot.hire_date
from  (select  rownum rn,
             t.hire_date
      from (select  hire_date
            from employees
            where hire_date > '04/12/31'
            order by hire_date asc) t
       ) ot
where ot.rn >= 11
and ot.rn <= 20;


/*문제6*/
select  max(hire_date)
from employees;

select  e.first_name || e.last_name 이름,
        e.salary 연봉,
        d.department_name "부서 이름",
        e.hire_date 입사일
from employees e, departments d, (select  max(hire_date) maxHi
                                  from employees) ma
where e.hire_date = ma.maxHi
and e.department_id = d.department_id;



/*문제7*/
--평균
select  department_id ,
        avg(salary) avgSal
from employees
group by department_id;

--평균중 가장 높은 연봉
select  max(avgSal) maxSal
from (select  department_id,
              avg(salary) avgSal
      from employees
      group by department_id);


--평균연봉 부서 찾아내기
select  avgsa.department_id dp,
        avgsa.avgsal,
        maxsa.maxsal
from (select  department_id ,
              avg(salary) avgSal
      from employees
      group by department_id) avgSa, (select  max(avgSal) maxSal
                                      from (select  department_id,
                                                    avg(salary) avgSal
                                            from employees
                                            group by department_id)
                                      ) maxSa
where avgsa.avgsal = maxsa.maxsal;


--대입해서 직원 찾아내기
select  e.employee_id 직원번호,
        e.first_name 이름,
        e.last_name 성,
        tb.avgsal AVG_SALARY,
        e.salary 급여,        
        js.job_title 업무        
from employees e, jobs js, (select  avgsa.department_id dp,
                                    avgsa.avgsal,
                                    maxsa.maxsal
                            from (select  department_id ,
                                          avg(salary) avgSal
                                          from employees
                                          group by department_id) avgSa, (select  max(avgSal) maxSal
                                                                          from (select  department_id,
                                                                          avg(salary) avgSal
                                                                          from employees
                                                                          group by department_id)
                                                                          ) maxSa
                            where avgsa.avgsal = maxsa.maxsal) tb
where e.job_id = js.job_id
and e.department_id = tb.dp
order by e.salary asc;


/*
select  *
from employees
*/