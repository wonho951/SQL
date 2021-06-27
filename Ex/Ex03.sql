/*그룹함수*/

--단일행함수
select  round(salary, - 4),
        first_name    
from employees;


--그룹함수 --> 오류발생(반드시 이유를 확인할 것)
select  first_name,
        avg(salary)
from employees;

--그룹함수 평균avg()
select  avg(salary)
from employees;



--그룹함수 count()
select  count(*),
        count(first_name),  --컬럼명 사용시 null을 제외한 count
        count(commission_pct) --컬럼명 사용시 null을 제외한 count
from employees;



--조건절 추가
select  count(*),
        salary
from employees
where salary > 16000;



--그룹함수 sum()
select  sum(salary),
        count(*)        --salary랑 * 은 결과값이 하나에 도출되니까 가능
from employees;


--그룹함수 avg() null일때 0으로 변환해서 사용
--null이 평균에 참여하는지 아닌지 확인
select  count(*),   --전체갯수 107
        count(commission_pct),  --35 commission_pct값이 있는 직원
        sum(commission_pct),  --전체합계
        
        avg(commission_pct),    --null을 포함하지 않는다/ 평균은 35인원으로 계산
        sum(commission_pct)/count(commission_pct), --null제외 7.8/35
                
        avg(nvl(commission_pct, 0)),    --null을 0으로 변경해서 평균에 계산된다.
        sum(commission_pct)/count(*)    --null포함 7.8/107        
from employees;

select  count(*),
        sum(salary),
        avg(salary),
        sum(salary)/count(*)
from employees;



--그룹함수  max() min()
select  count(*),
        max(salary),
        min(salary)
from employees;


select  salary,
        first_name
from employees
order by salary desc;


/*group by 절*/
select  department_id,
        salary
from employees
order by department_id asc;

--부서번호, 부서별 평균
select  department_id,
        avg(salary)
from employees
group by department_id
order by department_id asc;


--group by 절 사용시 주의
--select 절에는 group by에 참여한 컬럼이나 그룹함수만 올 수 있다.
--되는 경우
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id;

--안되는 경우
select  department_id,
        job_id, --job_id의 갯수가 오바될수 있어서 안됨
        count(*),
        sum(salary)
from employees
group by department_id;

--그룹을 더 세분화
select  avg(salary)
from employees
group by department_id;






/*그룹함수*/

--단일행함수
select first_name as 이름,
       round(salary, -4) as 월급
from employees;


--그룹함수  --> 오류발생(반드시 이유를 확인할것!!!)
select avg(salary) as 월급  --이름은 여러개가 나오지만
     --first_name  --avg는 모든 월급의 평균이기때문에 실행이 불가능하다.
from employees;     --출력되는 양쪽의 개수가 맞아야한다.


--그룹함수 avg()
select avg(salary) as 월급
from employees;


--그룹함수 avg() null일때 0으로 변환해서 사용
select count(*),                --전체갯수 107개
       count(commission_pct),   --35개  commission_pct 값이 있는 직원
       sum(commission_pct),         --전체합계
       
       avg(commission_pct),         --commission_pct가 null사람을 포함여부? -->null 포함X
       sum(commission_pct)/count(commission_pct),  --null 제외  7.8/35
       
       avg(nvl(commission_pct, 0)),  --null을 0으로 변경하여 전체수 포함
       sum(commission_pct)/count(*)  --null을 포함   7.8/107       
from employees;


--그룹함수 count()
select count(*),              --null을 포함한 count
       count(first_name),     --컬럼명 사용시 0은 갯수에 포함된다!
       count(commission_pct)  --Null을 제외한 실제가지고있는 값의 갯수출력
from employees;


--count()에 조건절 추가
select count(*)
from employees
where salary > 16000;


--그룹함수 sum()
select sum(salary),
       count(*)
     --first_name  넣었을 시 에러가난다
from employees;


--그룹함수  max() min()
select max(salary),
       min(salary)
from employees;

select first_name,
       salary
from employees
order by salary desc;

select --first_name,      오류발생! 이름과 max의 출력갯수가 다름!
       max(salary)
from employees;


/* group by 절 */
--전체 부서, 급여 출력
select department_id,
       salary
from employees
order by department_id asc;

--부서번호, 부서별 평균
select department_id, avg(salary)   --first_name은 avg와 갯수가 맞지않아 오류가 나지만
from employees                      --department_id는 그룹바이 department_id로 묶었기때문에
group by department_id              --가능하다
order by department_id asc;


-- Group by 절 사용시 주의사항!@#!@#
--Select 절에는 Group by에 참여하는 컬림이나 그룹함수만 올 수 있다.
select department_id, count(*), sum(salary) --group by로 컬럼들을 출력하라
from employees
group by department_id; --Group by에 쓴 컬럼은 select에서 쓸수있다.

select department_id,
       --job_id,         --Group by된 department_id의 갯수와 같을수있지만 
       count(*),       --그렇지 않을수도있기때문에 오류가 난다.
       sum(salary) 
from employees
group by department_id;


--그룹을 더 세분화
select department_id,
       job_id,
       avg(salary)
from employees
group by department_id, job_id;

select avg(salary)
from employees
group by department_id;

--예제
--부서별 부서 번호와, 인원수, 급여합계를 출력하세요.
select department_id,
       count(*),
       sum(salary)
from employees
group by department_id;


--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select department_id,
       count(*),
       sum(salary)
from employees
--where sum(salary) >= 20000    --Where절에는 그룹함수를 쓸수가 없다.
group by department_id;


--그룹전용 Where절 --> Having절
select department_id,
       count(*),
       sum(salary)
from employees
group by department_id
having sum(salary) >= 20000;


-- sum(salary) > 20000 이상이면서 부서코드 100인 숫자, 급여합계 100, 6, 51608
select  department_id,
        job_id,
        count(*),
        sum(salary)
from employees
where department_id = 100
group by department_id,job_id  -->여기에 쓴 컬럼명만
having sum(salary) >= 20000
and job_id = 'IT_PROG';    -->여기에 사용가능



select  *
from employees;

/*
select 문
    select 절
    from 절
    where 절
    group by 절
    having 절
    order by 절
*/

--case ~end 문
select employee_id,
       job_id,
       salary,
       case
            when job_id = 'AC_ACCOUNT' then salary+salary*0.1
            when job_id = 'SA_REP' then salary+salary*0.2
            when job_id = 'ST_CLEER' then salary+salary*0.3
            else salary
       end as rSalary      
from employees;

--decode()
select  employee_id,
        job_id,
        salary'
        decode(
            job_id, 'AC_ACCOUNT', salary+salary*0.1
                    'SA_REP' , salary+salary*0.2
                    'ST_CLEER',  salary+salary*0.3
        ) as rSalary'      
from employees;


select employee_id,
       job_id,
       salary,
       Decode(  --모두 job_id ==의 조건이라면 DECODE문 가능!@#!@@!#
            job_id, 'AC_ACCOUNT', salary+salary*0.1,
                    'SA_REP', salary+salary*0.2,
                    'ST_CLERK', salary+salary*0.3,
            salary
       ) as realSalary    
from employees;
                    
                    
select  *
from employees;

select  *
from departments;

--join
--'연관'된 두개 이상의 테이블을 합친다.
select  first_name as 이름,
        hire_date "입사일",
        department_name as 부서이름,
        em.department_id as emp의부서아이디,
        em.manager_id 매니저아이디
from employees em, departments de --얘는 태생이 as사용해서 별명 못붙임 그냥 써야함.
where em.department_id = de.department_id;  --조건 없으면 employees, departments 테이블의 이름이랑 부서이름 싹다 조합함.



select *        
from employees em, departments de; --얘는 태생이 as사용해서 별명 못붙임 그냥 써야함.
