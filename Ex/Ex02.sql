/*null*/ --0이 아님 값이 정해지지 않았을뿐임.
select  first_name, 
        salary, 
        commission_pct, 
        salary*commission_pct
from employees
where salary between 13000 and 15000;


--null인것만 뽑을때 is사용
select  first_name, 
        salary, 
        commission_pct
from employees
where commission_pct is null;


--null이 아닌것만 뽑을때 is not 사용
select  first_name, 
        salary, 
        commission_pct
from employees
where commission_pct is not null;


--예제 -커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name, 
        salary, 
        commission_pct
from employees
where commission_pct is not null;

--예제 -담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select  first_name
from employees
where manager_id is null
and commission_pct is null;


--order by(정렬) - 내림차순
select  first_name, 
        salary
from employees
order by salary desc;


--order by(정렬) - 오름차순
select  first_name, 
        salary
from employees
order by salary asc, first_name desc; --순서 중요할때 꼭 써줘야함

--여러개 오름차순정할때
select  first_name, 
        salary
from employees
order by salary asc, first_name desc; --1순위 급여 그 후에 이름.급여가 동률일때 이름을 오름차순으로 해준다.

--select from where order by절 위치
select  first_name, 
        salary
from employees
where salary >= 9000
order by salary desc;


--예제 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc;

--예제 급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name,
        salary
from employees
where salary >= 10000
order by salary desc;


--예제 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select  department_id,
        salary,
        first_name
from employees
where department_id = department_id
order by salary desc;



/*함수 빨리 테스트해보기*/
select initcap('asdasd')
from dual;  --가상의 테이블


/*단일행 함수*/
--initcap 첫 글자만 대문자로 변경
select  email, 
        initcap(email),    --첫 글자만 대문자로 변경 
        department_id 
from employees
where department_id = 100;


--문자 대문자(upper) 소문자(lower) 함수
select  first_name,
        lower(first_name),
        upper(first_name)
from employees
where department_id = 100;

--substr()
--SUBSTR(컬럼명, 시작위치, 글자수)
--주어진 문자열에서 특정길이의 문자열을 구함
select  substr('abcdefg', 3, 3)
from dual;


select  first_name,
        substr(first_name, 1, 3),
        substr(first_name, -3, 4)   --끌에서부터 왼쪽으로 3칸이동 그때부터 4글자 찍음.
from employees
where department_id = 100;


select substr('900214-1234234', 8, 1)
from dual;

--lpad()  rpad()    '공백' 에 문자 또는 기호 추가
select  first_name,
        lpad(first_name, 10, '*'),
        rpad(first_name, 10, '*')    
from employees;


--replace() 한글자를 네개의 기호로 바꿔도 바뀜 말그대로 치환.
select  first_name,
        replace(first_name, 'a', '*')
from employees;


--조금 더 복잡한 방식
select  first_name,
        replace(first_name, 'a', '*'),
        replace(first_name, substr(first_name, 2, 3), '***')
from employees;


/*숫자함수*/
--round(숫자,출력을 원하는 자리수) -> 주어진 숫자의 반올림을 하는 함수.
select  round(123.346, 2) r2, -- 소수점 두자리까지 표시하고 반올림한다.
        round(123.346, 0) as r0, -- 소수점 표시하지 않고 반올림.
        round(123.346, -1) as "r-1"    --소수점 기준 바로 왼쪽 한자리만 반올림. 
from dual;


--trunc() -> 주어진 숫자의 버림을 하는 함수
select  trunc(123.456, 2),   --맨뒤가 6인경우에도 불구하고 '버림'
        trunc(123.456, 0),  --소수점 아래 다 버림
        trunc(123.456, -1)  --소수점 위에 버림
from dual;

--abs() -->  절대값
select abs(-5)
from dual;


/*날짜 함수*/
--sysdate -> 현재 날짜 알려줌
select  sysdate --현재 날짜 알려줌.
from dual;

--MONTH_BETWEEN(d1,d2)
select  sysdate,
        hire_date,
        MONTHS_BETWEEN(SYSDATE,hire_date),
        round(MONTHS_BETWEEN(SYSDATE,hire_date), 0)
from employees;



/*변환함수*/
-- to_char()  숫자 -> 문자열로 바꾸기
select  first_name,
        salary*12,
        to_char(salary*12, '$999,999,99' )
from employees
where department_id = 110;

--숫자가 모자라면 #으로 표기됨.
select  to_char(9876, '99999'),
        to_char(9876, '099999'), --빈자리를 0으로 채우기 
        to_char(9876, '$9999'), --앞에 달러표시 붙여서 표시
        to_char(9876, '9999.99'),    --소수점 나타냄
        to_char(9876, '99,999'),    --3자리마다 ',' 붙임.
        to_char(987654321, '999,999,999')    --3자리마다 ',' 붙임.
from dual;

-- to_char()  날짜 -> 문자열로 바꾸기
--yyyy-> 년도  MM -> 월  DD-> 일
select  sysdate,
        to_char(sysdate, 'YY.MM.DD HH24:MI:SS'),        
        to_char(sysdate, 'YYYY"년"MM"월"DD"일"'),
        to_char(sysdate, 'YYYY'),
        to_char(sysdate, 'YY'),
        to_char(sysdate, 'MM'),
        to_char(sysdate, 'MONth'),
        to_char(sysdate, 'DD'),
        to_char(sysdate, 'DAY'),
        to_char(sysdate, 'HH'), --12시간 기준
        to_char(sysdate, 'HH24'),    --24시 표시할때
        to_char(sysdate, 'MI'),  --몇분인지 표시
        to_char(sysdate, 'SS')  --초 표시        
from dual;


--nvl()  nvl2()
select  first_name,
        commission_pct,
        nvl(commission_pct, 0),  --null의 값을 0으로 표시
         nvl2(commission_pct, 100, 0),    --null의 값을 0으로 표기, null이 아니면 100으로 표기
        nvl2(commission_pct, '값있음', '널')  --null의 값을 널으로 표기, null이 아니면 '값있음'으로 표기
from employees;


/* 
select  first_name, 
        avg(salary)
from employees;
*/