/*DCL - 계정 관리*/

--계정 webdb 생성
create user webdb identified by 1234;


--권한 부여
grant resource, connect to webdb;


--계정 비밀번호 바꾸기
alter user webdb identified by webdb;


--계정삭제
drop user webdb cascade;


/*webdb 계정삭제*/
select  sysdate
from dual;

--계정삭제 -> webdb본인이 지울수 있는 권한이 없음. -> 권한이 있던가 상위의 계정에 가서 지워야함
drop user webdb cascade;



--create table book(); -->테이블생성 명령어


create table book(
    book_id number(5),  --> 컬럼명과 자료형은 한세트 ',' 안찍음
    title varchar2(50),
    author varchar2(10),
    pub_date date
);


alter table book add (pubs varchar2(50));


alter table book modify (title varchar2(100));  -->자료형을 수정할때 사용


alter table book rename column title to subject;    --> 컬럼명을 수정할때 사용


alter table book drop(author);  --> 컬럼삭제



rename book to article; --> 테이블명을 바꿈

drop table article; -->테이블 삭제!


------------author 테이블 만들기
create table author(
    author_id   number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(50),
    primary key(author_id)
);