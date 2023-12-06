-- 한라인 주석 공백 넣어주기
/*
	주석
*/

-- 1. 사용자 Database 생성
create database myDB;

-- 2. 해당 사용자 DataBase 에 접속 
use myDB;

-- 3. 접속한 DB에서 테이블 생성
create table member (
idx int not null,
name varchar(50) not null,
addr varchar(50) not null
);

-- 4. 테이블의 내용을 출력 : select
select * from member;

-- 5. 생성된 테이블에 값 넣기 (레코드) : 자동커밋
insert into member ( idx, name, addr)
values (1, '홍길동', '서울');

insert into member ( idx, name, addr)
values (2, '김길동', '부산');
