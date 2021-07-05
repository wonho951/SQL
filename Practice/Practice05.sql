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
--매니저별로 묶기
select  manager_id,
        avg(salary),
        max(salary),
        min(salary)
from employees
where to_char(hire_date, 'yyyy') >= '2005'
group by manager_id
having avg(salary) >= 5000;


--위에꺼 넣기
select  e.employee_id,
        e.first_name 매니저이름,
        round(ma.avgsal, 0) "매니저별 평균 급여",
        ma.maxsal "매니저별 최대 급여",
        ma.minsal "매니저별 최소 급여"       
from employees e, (select  manager_id,
                           avg(salary) avgsal,
                           max(salary) maxsal,
                           min(salary) minsal
                  from employees
                  where to_char(hire_date, 'yyyy') >= '2005'
                  group by manager_id
                  having avg(salary) >= 5000) ma
where e.employee_id = ma.manager_id;



/*문제4*/
select  e.employee_id 사번,
        e.first_name 이름,
        d.department_name 부서명,
        m.first_name 매니저이름
from employees e, employees m, departments d
where e.employee_id = m.manager_id
and e.department_id = d.department_id(+);



/*문제5*/
select  ot.rn,
        ot.employee_id 사번,
        ot.first_name 이름,
        de.department_name 부서명,
        ot.salary 급여,
        ot.hire_date 입사일
from departments de,(select  rownum rn,
                            t.employee_id,
                            t.first_name,
                            t.department_id,
                            t.salary,
                            t.hire_date
                    from (select  employee_id,
                                  first_name,
                                  department_id,
                                  salary,
                                  hire_date
                          from employees
                          where to_char(hire_date, 'yyyy-mm-dd') >= '2005'
                          order by hire_date asc) t
                      )ot
where ot.department_id = de.department_id
and ot.rn >= 11
and ot.rn <=20;


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
              avg(salary) avgSal	--여기에 별명 안붙이면 max못구함
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



/*문제8*/
--부서별 평균급여 찾기
select  department_id,
        avg(salary)
from employees
group by department_id;

--평균중 제일 높은 부서 찾기
select  max(salary)
from (select  department_id,
              avg(salary) salary
      from employees
      group by department_id);
      
--두개 조합해서 평균급여 제일 높은 부서 찾기
select  d.department_name --부서 이름만써주면됨
from departments d, (select  department_id,
                             avg(salary) avgsal
                     from employees
                     group by department_id) avgd, (select  max(salary) maxsal
                                                    from (select  department_id,
                                                                  avg(salary) salary
                                                    from employees
                                                    group by department_id)
                                                    ) maxd
where avgd.avgsal = maxd.maxsal
and avgd.department_id = d.department_id;


/*문제9*/
--지역이랑 엮어야 하니까 지역이랑 급여를 맞춰줌
select  r.region_name,
        avg(salary)
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
group by r.region_name;


--max(salary)구함
select  max(salary)
from (select  r.region_name,
              avg(salary) salary
      from employees e, departments d, locations l, countries c, regions r
      where e.department_id = d.department_id
      and d.location_id = l.location_id
      and l.country_id = c.country_id
      and c.region_id = r.region_id
      group by r.region_name) ms;


--두개 조합해서 평균급여 제일 높은 나라 찾기
select  avgr.rName region_name
from (select  r.region_name rName,
              avg(salary) avgs
      from employees e, departments d, locations l, countries c, regions r
      where e.department_id = d.department_id
      and d.location_id = l.location_id
      and l.country_id = c.country_id
      and c.region_id = r.region_id
      group by r.region_name) avgr, (select  max(salary) maxsal
                                     from (select  r.region_name,
                                                   avg(salary) salary
                                           from employees e, departments d, locations l, countries c, regions r
                                           where e.department_id = d.department_id
                                           and d.location_id = l.location_id
                                           and l.country_id = c.country_id
                                           and c.region_id = r.region_id
                                           group by r.region_name) ms
                                    ) maxr
where avgr.avgs = maxr.maxsal;



/*문제10*/
--job_id 평균 급여 구함
select  job_id,
        avg(salary)
from employees
group by job_id;


--가장 높은거 구함
select  max(salary)
from (select  job_id,
              avg(salary) salary
      from employees
      group by job_id);


--두개 조합
select  j.job_title
from jobs j, (select  job_id,
                      avg(salary) asal
              from employees
              group by job_id) jobavg, (select  max(salary) masl
                                        from (select  job_id,
                                                      avg(salary) salary
                                              from employees
                                              group by job_id)
                                        ) jobmax
where j.job_id = jobavg.job_id
and jobavg.asal = jobmax.masl;



/*
select  *
from employees
*/