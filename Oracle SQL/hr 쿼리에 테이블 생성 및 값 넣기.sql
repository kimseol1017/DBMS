/*
    CRUD
        Create : 생성
        Resd : 검색
        Update : 수정
        Delete : 삭제
*/

--간단한 테이블 생성 : create

create Table  member ( --member 테이블
    idx number not null ,  --idx 에 number(숫자) 자료형으로 넣겠다는 뜻
    name varchar2(50) not null, --name 에 문자열 not null 은 무조건 값을 넣어야 함
    id varchar(50) not null,
    pw varchar(50) not null,
    addr varchar(50) null
    );
    
    --검색 : select
select * from member ;

-- 입력 : 테이블에 값을 넣음.
insert into member ( idx, name, id, pw ,addr)
values (1, '홍길동' , 'pqq','1234','서울');
commit; --DB에 영구히 저장

insert into member ( idx, name, id, pw ,addr)
values (2, '김길동' , 'pq1q','1234','부산');
commit; --DB에 영구히 저장

insert into member ( idx, name, id, pw ,addr)
values (1, '재드레곤' , 'sam','1234','서울');
commit; --DB에 영구히 저장



-- hr3 계정생성, hr3 계정으로 접속 후 멤버테이블 생성 후 레코드 2개 넣기

