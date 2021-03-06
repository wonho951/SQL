/*join*/
--EQUI join. --> 가장 많이 씀--> null은 포함 안됨.
select  e.employee_id,  --일관성있게 어느 테이블에 있는건지 표시해주는게 좋다.
        e.first_name,   --e는 소속이고 결국 최종으로는 first_name이기 때문에 별명 붙이는게 좋음.
        e.department_id,
        d.department_id
from employees e, departments d   --이렇게하면 107개 * 27개 출력됨.(카디젼 프로덕트)--> 올바른 join 조건을 where 절에 부여 해야함.
    --가급적 테이블에 별명 붙여주고 테이블명에 별명 붙일때 as 사용 불가하니 주의!
where e.department_id = d.department_id;
    -- null인 값이 있기때문에 107개가 아닌 106개가 출력됨.
    

--예제
select  *
from employees;

select  *
from departments;

select  *
from jobs;


select  em.first_name  직원이름,
        em.department_id,
        em.job_id,
        de.department_name 부서이름,
        de.department_id,
        jo.job_title 업무명,
        jo.job_id
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id;
--한번에 머리로 생각하지말고 따져봐야함.

/*OUTER join*/ 
--종류 left outer join, right outer join, full outer join
--> null 포함시켜야 할때

--left outer join
select  em.employee_id 직원아이디,
        em.first_name 이름,
        em.department_id 부서아이디,
        de.department_name 부서이름
from employees em left outer join departments de
on em.department_id = de.department_id;

--left outer join약식 (오라클에서만)
select  em.employee_id 직원아이디,
        em.first_name 이름,
        em.department_id 부서아이디,
        de.department_name 부서이름
from employees em, departments de
where em.department_id = de.department_id(+);


--right outer join
select  em.employee_id 직원아이디,
        em.first_name 이름,
        em.department_id 부서아이디,
        de.department_name 부서이름
from employees em right outer join departments de
on em.department_id = de.department_id;


--right outer join약식 (오라클에서만)
select  em.employee_id 직원아이디,
        em.first_name 이름,
        em.department_id 부서아이디,
        de.department_name 부서이름
from employees em, departments de
where em.department_id(+) = de.department_id;


--right outer join --> left outer join으로 변환(테이블 좌우를 바꿔서 기준을 바꿔줌)
select  em.employee_id 직원아이디,
        em.first_name 이름,
        em.department_id 부서아이디,
        de.department_name 부서이름
from departments de left outer join employees em
on de.department_id = em.department_id;


--full outer join
select  em.employee_id 직원아이디,
        em.first_name 이름,
        em.department_id 부서아이디,
        de.department_name 부서이름
from employees em full outer join departments de
on em.department_id = de.department_id;

--full outer join약식 --> (+) 사용불가.
select  em.employee_id 직원아이디,
        em.first_name 이름,
        em.department_id 부서아이디,
        de.department_name 부서이름
from employees em, departments de
where em.department_id(+) = de.department_id(+);


--self join : 자기자신과 join , Alias를 사용할 수 밖에 없음.
--자기자신을 참조하기때문에 명확하게 별명 붙여서 컬럼 앞에 별명 꼭 써줘야함! --> 겹치기 때문!
select  em.employee_id 직원사번,
        em.first_name 직원이름,
        em.manager_id 매니저아이디,
        em.phone_number 직원전화번호,
        ma.manager_id 매니저아이디,
        ma.employee_id 매니저의사번,
        ma.first_name 매니저이름,
        ma.phone_number 매니저전화번호
from employees em, employees ma --> ma는 같은 테이블이지만 매니저 테이블로 사용하겠다는뜻.
where em.manager_id = ma.employee_id;


--말도 안되는 데 값이 같아서 연결되는 경우-->주의!!
select  *
from employees em, locations lo
where em.salary = lo.location_id;   --> 전혀 상관이 없지만 우연히 값이 맞아 떨어졌기때문에 출력이 됨.



/*SubQuery*/
--하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태

--‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
select  *
from employees
where first_name = 'Den'; -->Den의 급여는 11000


--급여가 11000이상인 직원들
select  *
from employees
where salary >= 11000;  --> Den의 급여가 11000일때 알수 있기 때문에 두번 일을 해야함


--SubQuery
--where절에 조건에 맞는 쿼리문을 하나 더 씀
select  first_name 이름,
        salary 급여
from employees
where salary >= (select salary 급여   --조건이 맞아야함
                 from employees
                 where first_name = 'Den')
--위 두개의 지문을 조합해서 사용하는게 subquery                 
/*
* SubQuery 부분은 where 절의 연산자 오른쪽에 위치해야 하며 괄호로 묶어야한다.
* 가급적 order by 를 하지 않는다. 
* 단일행 SubQuery 와 다중행 SubQuery 에 따라 연산자를 잘 선택해야함 
  현재 예제는 단일행  *다중행과 구분해서 사용해야함
*/

