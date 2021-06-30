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
--not null
--primary key
create table author(
    author_id   number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(50),
    primary key(author_id)
);


create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key (book_id),
    constraint book_fk foreign key (author_id)
    references author(author_id)
);  

----컬럼 내용들
/*등록*/
--insert into author value(); --> 기본형
insert into author values(1, '박경리', '토지 작가'); --재실행시 1의 위치는 book_id의 위치인데 pk이므로 안됨.

select *
from author;


insert into author(author_id, author_name) 
values(2, '이문열', '삼국지작가');          --> 2개의 컬럼에만 추가하는데 3개넣으면 오류남.


insert into author(author_id, author_name) 
values('이문열', 2);                       --> 추가되는 갯수는 맞지만 자료형이 다르기때문에 오류남.


insert into author(author_id) 
values(2);                      --> pk라서?



insert into author(author_id, author_name) 
values(2, '이문열');



/*수정*/
update author               --> 수정시 update 사용 set으로 어떤 컬럼 바꿀건지
set author_name = '기안84',
    author_desc = '웹툰작가'
where author_id = 1;        --> 어디를 바꿀건지


select *
from author;

update author
set author_name = '최원호'
where author_id < 2;       --> where절이기때문에 이런식으로도 사용 가능


--where절이 없는경우
update author
set author_name = '강풀',
    author_desc = '인기작가';   
--*****************************where절이 없을 경우 전체가 다 바뀐다. *필히 주의할것



/*삭제*/  
delete from author     
where author_id = 1;    


select *
from author;


delete from author ;     --> 조건이 없으면 아예 지우는거기 때문에 **********주의**********해야함


--선생님 스토리  0에서 시작
insert into author values(1, '박경리', '토지 작가');
commit;     --> 이전까지했던 작업 반영. insert  update  delete  세가지만 해당됨.
            --> 업무단위때문에 쓰는놈임.

insert into author values(2, '기안84', '웹툰작가');
insert into author values(3, '이문열', '인기작가');



update author
set author_desc = '나혼자 산다 출연'
where author_id = 2;


delete from author
where author_id = 1;


select *
from author;


insert into author values(3, '최원호', '웹툰작가');

rollback;   --> 남용하면 안됨. 다시 되돌릴때 이전에 commit 한 시점까지만 돌아감.





/*시퀀스*/
--  연속적인 일렬번호 생성->pk에 적용

create sequence seq_author_id   --> 기계임. 툭치면 번호표 나옴.
increment by 1      --> 1씩증가
start with 1        --> 1부터 시작
nocache;    --> 속도때문에 번호표 미리 뽑아둠. 번호 한개씩 뽑는거 에너지 많이 들어가기때문에 써준거.


delete from author;
commit;


insert into author values(seq_author_id.nextval, '기안84', '웹툰작가');
insert into author values(seq_author_id.nextval, '이문열', '작가');
insert into author values(seq_author_id.nextval, '박경리', '작가');
seq_author_id.nextval;  --한번 넘어감. 일렬번호에 너무 목메지 않아도 됨.


select *
from author;


--시퀀스 조회
select *
from user_sequences;

--현재 시퀀스 조회
select seq_author_id.currval from dual; -->의미없는 테이블명 써줌

select seq_author_id.nextval from dual; -->다음 시퀀스로 넘김.--> 번호표 --> 오지게 누른 다음에 1행 추가하면 그 다음 번호로 됨ㅋ

insert into author values(seq_author_id.nextval, '최원호', '백수');

--시퀀스 삭제
drop sequence seq_author_id;



--sysdate -> 현재시간 입력
