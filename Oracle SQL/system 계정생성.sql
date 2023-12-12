-- 계정생성

create user C##hr identified by 1234
default tablespace USERS
temporary tablespace TEMP;

--권한 부여
grant resource,connect to C##hr

--테이블 스페이스 사용량 할당
alter user C##hr quota unlimited on USERS;


create user C##hr2 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

--권한 부여
grant resource,connect to C##hr2
grant create view to C##hr;

--테이블 스페이스 사용량 할당
alter user C##hr2 quota unlimited on USERS;

--계정삭제 테스트 
drop user C##hr2

create user C##hr3 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

grant resource,connect to C##hr3

alter user C##hr3 quota unlimited on USERS;

create user C##hr4 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

grant resource,connect to C##hr4

alter user C##hr4 quota unlimited on USERS;

drop user C##hr4 cascade
/*
    CRUD
        Create : 생성
        Resd : 검색
        Update : 수정
        Delete : 삭제
*/