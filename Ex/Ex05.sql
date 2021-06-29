/*EQUI join --> null은 포함 안됨.*/
--Outer join (left right full) --> null 포함시켜야 할때
--(+)<--오라클에서만 가능. null이 오는쪽에 사용한다.
--self join

/*SubQuery*/
--단일행 SubQuery
select  *
from employees
where first_name = 'Den';   -->Den의 급여 확인

select  salary,
        first_name
from employees
where salary >= 11000; -->Den의 급여 11000보다 급여가 많은 사람

--위 두개의 조건을 사용해서 한번에 쿼리문 만들기 --> SubQuery
select  first_name,
        salary
from employees
where salary > (select  salary
                from employees
                where first_name = 'Den');
                
                
/*예제)급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?*/
--1. 급여를 가장 적게 받는 사람의 급여-->2100
select  min(salary)        
from employees;

--2. 2100을 받는 사람의 이름 급여 사원번호
select  first_name 이름,
        salary 급여, 
        employee_id 사번
from employees
where salary = 2100;

--3. 두개의 식을 조합
select  first_name 이름,
        salary 급여,
        employee_id 사번
from employees
where salary = (select  min(salary)
                from employees);
                
--예제) 평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1. 평균급여 구함 --> 6461
select  avg(salary) 평균급여
from employees;

--2. 6461 보다 적게 돈받는 사람 구함
select  first_name 이름,
        salary 급여
from employees
where salary < 6461;

--3. 두개의 식을 조합
select  first_name 이름,
        salary 급여
from employees
where salary < (select avg(salary)
                from employees);
                

                
/*다중행 SubQuery*/
--1. 부서번호 110인 직원의 급여 리스트 구한다. --> shelley 12008, william 8300
select  salary 이름
from employees
where department_id = 110;

--2. 급여가 12008, 8300인 직원 리스트를 구한다.
select  first_name 이름,
        salary 급여
from employees
where salary = 12008
or salary = 8300;
/* 위 식을 다르게 표현 하는 법. --> 까먹고 있지 말자
select  first_name 이름,
        salary 급여
from employees
where salary in(12008, 8300);
*/

--3. 두개의 식을 조합
select  employee_id 사번,
        first_name 이름,
        salary 급여
from employees
where salary in (select  salary
                 from employees
                 where department_id = 110);
                 
                 
                 
--예제)각 부서별로 최고급여를 받는 사원을 출력하세요
--1.최고 급여 받는 사람 찾는다.(부서별로 묶어야함) --> 부서별로 최고급여는 알 수 있지만 이름은 모름.
select  department_id 부서명,
        max(salary) 급여
from employees
group by department_id;

--2.사원테이블에서 그룹번호 와 급여가 같은 직원의 정보를 구한다.
select  first_name 이름,
        department_id 부서,
        salary 급여
from employees
where (department_id, salary) in (select  department_id 부서명,    --비교값이 맞아야함.(동시에 같아야한다.)
                                          max(salary) 급여
                                  from employees
                                  group by department_id);


/*ANY*/--> or

--예제)부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
--1. 부서번호가 110인 직원 리스트 -->2명(급여는 12008, 8300)
select  salary 급여
from employees
where department_id = 110;

--2. 부서번호가 110인 직원급여(12008, 8300)보다 급여가 큰 직원리스트(사번, 이름, 급여)를 구하시오
select  first_name 이름,
        employee_id 사번,
        salary 급여
from employees
where salary > 12008    --> 급여가 12008보다 높음
or salary > 8300;   --> 급여가 8300보다 높음

--3. 두개의 식 조합
select  employee_id 사번,
        first_name 이름,
        salary 급여
from employees
where salary > any (select  salary 급여
                    from employees
                    where department_id = 110);


/*ALL*/--> and
--> 위의 any와 비교
--예제)부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)
select  employee_id 사번,
        first_name 이름,
        salary 급여
from employees
where salary > all (select  salary 급여
                    from employees
                    where department_id = 110);


--예제(where절로 비교)
--각 부서별로 최고급여를 바받는 사원을 출력하세요
--1. 각 부서별 최고 급여 리스트 구하기
select  department_id,
        max(salary)
from employees
group by department_id;
--2. 직원테이블 부서코드, 급여가 동시에 같은 직원 리스트 출력하기
select  first_name 이름,
        department_id 부서,
        salary 급여
from employees
where (department_id,salary) in (select  department_id,
                                         max(salary)
                                 from employees
                                 group by department_id);

/*테이블에 join*/
--예제(join절로 비교)
--각 부서별로 최고급여를 바받는 사원을 출력하세요
--1. 각부서별 최고 급여 테이블 s
select  department_id 부서번호,
        max(salary) 최고급여
from employees
group by department_id;

--2. 직원 테이블과 조인한다. e
    --> e.의 부서번호 = s.의 부서번호     e.의 급여 = s.의 급여(최고급여)
select  e.department_id,
        e.first_name,
        e.department_id,
        e.salary,
        s.department_id, --> 추가된 컬럼
        s.msalary        --> 추가된 컬럼
from employees e, (select  department_id,
                           max(salary) mSalary
                   from employees
                   group by department_id) s
where e.department_id = s.department_id
and e.salary = s.msalary;



/**********************
rownum
**********************/
--예) 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--정렬을 하면 rownum이 섞인다.
select  rownum, --> 컬럼명에 쓰면 번호를 매겨줌(일련번호처럼)
        employee_id 사번,
        first_name 이름,
        salary 급여
from employees
order by salary desc;
        
        
        
select  *
from employees
order by salary desc;
        
                     
                     
-->정렬을 하고 rownum을 한다. --> 정렬이 되어있는 가상의 테이블을 만들어버린다.
select  rownum 번호,     -- 이미 테이블영역이 정렬되어있기 때문에 rownum을 사용해도 섞이지 않는다.
        ot.employee_id 사번,
        ot.fname 이름,
        ot.salary 급여,
        hire_date
from (  select  employee_id,            -- 실제로는 테이블에서 * 사용 잘 안함.
                first_name fName,       -- 테이블 취급이기 때문에 여기에 별명 써주면 셀렉트문에 별명 써줘야함.
                salary,
                hire_date
        from employees
        order by salary desc) ot  --정렬되어 있는 테이블.? --> 보통 이 테이블은 별명 붙여줌.
where rownum >= 1
and rownum <=5;

--rownum은 항상 1부터 시작임.

--rownum 1이 아닌 다른숫자로 시작할때
select  rownum 번호,
        ot.employee_id 사번,
        ot.fname 이름,
        ot.salary 급여,
        hire_date
from (  select  employee_id,
                first_name fName,
                salary,
                hire_date
        from employees
        order by salary desc) ot
where rownum >= 1 -->rownum 2--> 데이터가 없다.
and rownum <=5;
--===========================================

--->> 1.정렬을 한다. 2.rownum을 멕인다. 3.where절을 한다.
select  ort.rn,
        ort.employee_id,
        ort.first_name,
        ort.salary
from (select  rownum rn,
              ot.employee_id,
              ot.first_name,
              ot.salary
        from (select    employee_id,
                        first_name,
                        salary
              from employees
              order by salary desc) ot      --1번. ot라는 가상의 테이블을 만들어서 정렬을 함.
        ) ort                               --2번. ort라는 가상의 테이블을 만들어서 rownum을 멕임.
where rn >= 2                               -->3번. where절을 사용하면 rownum이 2번부터 출력가능
and rn <= 5;



--예제) 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 급여 입사일은?
select  nht.ron,
        nht.hire_date,
        nht.salary
from (select  rownum ron,
              ht.rn,
              ht.hire_date,
              ht.salary
       from (select  rownum rn,
                     t.hire_date,
                     t.salary
              from (select  hire_date,
                            salary
                    from employees
                    order by salary desc) t
             ) ht
        where hire_date >= '07/01/01'
        and hire_date <= '07/12/31'
        ) nht
where ron >= 3
and ron <= 7;
