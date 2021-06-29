/*from절 select절*/
--모든 컬럼 조회
select *
from employees;

select *
from departments;


--원하는 컬럼(세로값)만 조회하기
select employee_id, first_name, last_name
from employees;

--예제 사원이름 전화번호 입사일 연봉출력
select first_name, phone_number, hire_date, salary
from employees;

--예제 사원이름 성 급여 전화번호 이메일 입사일
select first_name, 
       last_name, 
       salary, 
       phone_number, 
       email, 
       hire_date    --실제로 이렇게 들여쓰기해서 맞춰서 씀. 마지막에 , 붙이는거 주의
from employees;

--출력할때 컬럼에 별명 사용하기
SELECT employee_id as empNo,    --as 사용 거의 안함. 없어도 됨. 
       first_name  "f-name",
       salary as "급 여"
from employees;


--예제 사원 이름 전화번호 입사일 급여로 표시
select first_name "이름",
       phone_number "전화번호",
       hire_date "입사일",
       salary "급여"
from employees;

--예제 사원번호 이름 성 급여 전화번호 이메일 입사일로 표시
SELECT employee_id "사원번호",  --as사용시 사용할꺼면 다 사용하고 빼려면 다 빼셈.
       first_name "이름",
       last_name "성",
       salary "급여",
       phone_number "전화번호",
       email "이메일",
       hire_date "입사일"
from employees;


--연결 연산자(Concatenation)로 컬럼들 붙이기
SELECT first_name,
       last_name    
FROM employees;

--||사용했을때
SELECT first_name || last_name    --데이터 붙여버리는디?
FROM employees;


SELECT first_name || ' ' || last_name 
FROM employees;

SELECT first_name || ' hire date is ' || hire_date as "입사일"
FROM employees;


--산술 연산자 사용하기
SELECT first_name,
       salary
FROM employees;

--연봉계산
select  first_name,
        salary,
        salary*12
from employees;

--급여에 300원 추가
select  first_name,
        salary,
        salary*12,
        (salary+300)*12
from employees;

--예제 오류이유 찾기
select job_id*12
from employees;
--문자라서 계산이 안됨.


--예제 전체직원의 정보 출력
select  first_name ||'-'|| last_name as 성명,
        salary as 급여,
        salary*12 as 연봉,
        salary*12+5000 as 연봉2,
        phone_number as 전화번호
from employees;




/*where절*/
SELECT  first_name    
FROM employees
where department_id = 10;

--예제
--연봉 15000이상인 사원의 이름,월급 출력
select  first_name,
        salary
from employees
where salary >= 15000;

--07/01/01이후 입사 사원들 이름 입사일 출력
select  first_name,
        hire_date
from employees
where hire_date >= '07/01/01';

--이름 lex인 직원 연봉 출력
select salary
from employees
where first_name = 'Lex'; /* >=Lex했을때 알파벳 L보다 큰거 출력되는듯*/

--예제 조건이 2개 이상일때 한꺼번에 조회하기
select  first_name,
        salary
from employees
where  salary >= 14000
and salary <= 17000;

--연봉이 14000이하,17000이상 사원 이름 연봉 출력
select  first_name,
        salary
from employees
where  salary <= 14000
or salary >= 17000;

--입사일 04/01/01 에서 05/12/31 사이 사원 이름 입사일 출력
select  first_name,
        hire_date
from employees
where  hire_date >= '04/01/01'
and hire_date <= '05/12/31';


--between 연산자로 값 출력하기
select  first_name,
        salary
from employees
where  salary between 14000 and 17000;

--IN 연산자로 여러 조건 검사하기
select  first_name,
        last_name,
        salary
from employees
where first_name in ('Neena', 'Lex', 'John');

--위를 풀어쓰면 이렇게됨, and쓰면 포함이고 or 써야 이렇게 나옴. 항상 고려해야함.
select  first_name,
        last_name,
        salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';


--between 예제
select  first_name,
        salary
from employees
where salary in (2100,3100,4100,5100);

select  first_name,
        salary
from employees
where salary = 2100
or salary = 3100
or salary = 4100
or salary = 5100;


--Like 연산자로 비슷한 것들 모두 찾기
select  first_name,
        last_name,
        salary
from employees
where first_name like'L%';


--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '%am%';


--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '_a%';
	

--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select  first_name,
        salary
from employees
where first_name like '____a%';


--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select  first_name,
        salary
from employees
where first_name like '__a_';