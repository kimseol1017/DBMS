-- view(뷰) : 가상의 테이블 , 값은 가지지 않고, 코드만 가짐
    -- 1. 실제 테이블의 특정 컬럼만 출력 할 때 <== 보안
    -- 2. 복잡한 쿼리를 한번 만들어서 실행 . <== 복잡한 join 쿼리를 단순화 할 수 있다.


--view 실습을 위한 샘플테이블 : emp02
create table EMP02
as
select eno, ename , salary,commission, job, hiredate,dno
from employee
where salary > 1500;

--drop table emp02 cascade CONSTRAINTS;

select * from emp02;

create TABLE dept02
as
select * from department;

-- 기존의 원본테이블 ㅣ employee , department ==> emp02, dept02 
    -- 필드명과 값 만 복사됨
    -- 컬럼에 부여된 제약조건을 복사되지 않음 <== alter table울  사용해서 제약조건 추가
select * from user_constraints where table_name in ('EMPLOYEE','DEPARTMENT');
select * from user_constraints where table_name in ('EMP02','DEPT02');
-- DEPT02 테이블의 dno 컬럼의 Primary Key를 부여해야 함
-- EMP01 테이블의 eno(PK), dno(FK) ==> dept02 (dno)

alter table DEPT02
add constraint PK_DEPT02_DNO primary key (dno) ;

alter table emp02
add constraint PK_EMP02_ENO primary key (eno);

alter table emp02
add CONSTRAINT FK_EMP02_DNO FOREIGN key (dno) REFERENCES dept02(dno);


-- view 생성 1. 실제 테이블의 중요 정보를 감추고 출력, 보안을 향상할 수 있다
        -- as 다음에 select 코드를 가지고 있음
select * from emp02; --실제 테이블 : emp02

-- 뷰 생성 : 실제 테이블의 값을 가지는 것이 아니라 실행  코드만 가진다.
create view v_emp02 
as
select ename,job,dno
from emp02;

--뷰 실행:
--select 컬럼명 from 테이블명 & 뷰명
select * from v_emp02;

-- 데이터 사전 user_테이블  <== 시스템의 정보를 저장되어있는 테이블

select * from user_views;
            --2. 사용의 편리성. 복잡한 구분을 view 를 생성해서 저장시켜 두고 실행 <==JOIN 
            -- 두 테이블을 join 해서 월급이 2500 이상인 사원정보를 출력
            create view v_join
            as
            select ename,job,salary,dname,loc
            from emp02 e
                join dept02 d
                    on d.dno = e.dno
                where salary >= 2500;
                
    select * from v_join;
    
    -- employee, department 테이블의 부서별로 최소 월급을 받는 사원 이름, 사원의 직책, 부서명, 부서위치를 출력하되 최소월급이 1500이상인 사원만
        --join , gruop by , 20번 부서 제외
        
    create view v_MinSalary  
    as
    select ename,job,dname,loc,d.dno
    from employee e
        join department d
            on e.dno = d.dno
    where salary in (
    select min(salary) 
    from employee 
    where dno <> 20 
    GROUP by dno 
    having min(salary)>=900);
-- 부서별 최소월급을 받는 사원 정보를 출력하는 view 20 부서 제외
 select * from v_MinSalary;
 
 
 -- view에 as 블락에 select 문이 옴
    -- 실제 값을 가지고 있지 않음 . select 코드만 들어있음
    --실제 테이블의 컬럼에 잘 매칭 될 경우
    -- insert, update, delete 를 view를 통해서 할 수 있다, 단 실제 테이ㅡㅂㄹ에 각 칼럼의 제약 조건에 맞을 때 가능
    
    
-- view 생성
    select * from emp02;
    
    CREATE view v_test01
    as
    select eno,ename,dno
    from emp02;
-- view 삭제
 drop view v_test01;
 
-- view실행  
    select * from v_test01;
   
-- view 에 값을 넣을 수 있다 ==> 실제 테이블에 값이 들어감.
 insert into v_test01(eno,ename,dno)
 VALUES(8080,'홍',30);
 
 select * from emp02;
 commit;
    
-- view를 사용해서 값을 수정 :  update , del은 반드시 조건(where)이 들어가야함 
update v_test01
set ename = 'KIM'
where eno = 8080;
commit;

select * from emp02;

-- view를 사용해서 값을 삭제 : delete : where 조건(반드시 primary Key 컬럼이어야 함)을 반드시 사용해야함
DELETE v_test01
where eno = 8080;
commit;

select * from emp02;


-- v_test02 : insert 안됨 , update - del 가능 ==> 실제 테이블의 제약 조건에 잘 맞아야 한다
create view v_test02
as
select eno,ename, salary
from emp02;

insert into v_test02(eno,ename,salary)
VALUES(9090,'hong',3500);

select * from user_constraints;

delete v_test02
where eno =9090;
commit;

--특정 컬럼에 not null 제약조건 추가

alter table emp02
MODIFY dno not null; 