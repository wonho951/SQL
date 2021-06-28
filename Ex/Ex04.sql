/*join*/
--EQUI join. --> 가장 많이 씀
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
