/* 
join : Database 에는 많은 테이블이 존재. 모델링을 통해서 테이블이 분리되어 있다  (R - DBMS)
            각 테이블은 연관관계를 가지고 있다
    employee테이블과department 테이블은 본래 하나의 테이블 이나, 모델링을 통해서 (1,2,3정규화 ) 테이블을 분리
    모델링을 하는 이유 : 중복제거 , 성능향상
    
    제약조건: 테이블의 컬럼에 들어가는 키 . 데이터의 무결성(결함없는 데이터 - 원하는 값만)
        Primary Key: 테이블의 컬럼에 1번만 넣을 수 있다. - 특정 컬럼에 중복된 값을 넣지 못하게 함.
            - 반드시  Not Null 컬럼이어야 함  null을 지정하면 오류
            - 테이블 생성시 반드시 PK 가 존재해야한다, - Update,Delete 구문에서 PK 컬럼을 where 조건으로 사용해야함
            - 테이블의 컬럼에 1번만 넣을 수 있다
            - 2개의 컬럼을 묶어어서  PK 를 넣을 수 있다
            - index가 자동으로 생성된다. 컬럼의 검색을 빠르게 함
            - JOIN 시 ON 절에서 많이 사용하는 key 컬럼
        Foreign Key:
            - 다른 테이블 (부모테이블) 의 특정 컬럼을 참조해서 값을 넣도록 함.
            - FK가 참조하는 컬럼은 부모테이블의 PK, UK 를 참조
            -  
            
            
        Unique Key:
            - PK 와 동일하게 컬럼에 중복된 값을 넣지 못하도록 함
            - Null을 단 한번 넣을 수 있다 (중복불가) - Not null / Null 상관 없음
            - 하나의 테이블에 여러번 unique key 를 넣을 수 있다
            - index 가 자동으로 생성됨, JOIN 시 ON절 에 사용됨

        NOT NULL : 컬럼에 Null 을 허용하지 않음 =>pk
        
        cheak
            - 컬럼에 조건을 걸어서 내가 원하는 값만 넣을 수 있도록 함
            
        default 
            - 제약조건은 아니지만, 제약 조건처럼 사용됨
            - 컬럼에 값을 넣지 않으면 default로 설정된 값이 등로됨
*/

select * from employee;     -- employee 테이블의 DNO 컬럼은 참조한다(Foreign Key ) department 테이블의 DNO 컬럼을 참조한다

SELECT  * from  department;


---------테이블 복사 : 원본 테이블의 제약조건은 복사 되지 않음 Alter Table 을 사용해서 제약조건 부여

create table emp01
as 
select * from employee;

create table dep01
as 
select * from department;


/*
    테이블의 제약조건을 확인하는 명령어 
        : user_ conestraints : 데이터 사전 <== 테이블의 각종 정보를 알려주는 테이블
*/
select * from user_constraints;

select * from user_constraints
where table_name in ('EMPLOYEE', 'DEPARTMENT');

-- 테이블 복사시 테이블의 컬럼에 부여된 제약조건은 복사되어 오지 않는다 .  컬럼의 값만 복사되어온다
-- alter table 을 통해서 제약 조건을 부여해야함
    --  alter table : 생성된 테이블을 수정
select * from user_constraints
where table_name in ('EMP01', 'DEP01');

-- DEP01 테이블에 PK제약조건을 추가
ALTER TABLE DEP01
add CONSTRAINT PK_DEP01_DNO PRIMARY KEY (dno);  -- > dno컬럼에 PK 제약조건을 넣는다   PK_DEP01_DNO = CONSTRAINT NAME

---emp01 테이블의 eno 컬럼에 PK 제약조건 추가
alter table emp01
add constraint PK_EMP01_ENO primary key (eno);

--emp01 테이블의 dno 컬럼에 FK 부여 , 참조(REFERENCES)할 테이블의 컬럼은 DEP01테이블의 dno 컬럼을 참조 dep01 (dno)

alter table emp01
add CONSTRAINT FK_EMP01_DNO FOREIGN KEY (dno) REFERENCES dep01 (dno);


-- PK 컬럼을 확인 
desc emp01;

select * from emp01 ;

-- 값을 넣을 때 컬럼에 부여된 제약 조건을 잘 확인하고 값을 insert 
-- eno: PK 가 등록되어 있어, 중복된 값을 넣으면 제약조건 위배로 오류가 발생
-- dno: FK 가 등록되어 있어, DEP01 테이블의 DNO컬럼에 존재하는 값만 넣어야 함

insert into emp01(eno,ename,job,manager,hiredate,salary,commission,dno)
VALUES(7777,'CHJ','MANAGER',7785,'23/12/11',5000,null,10);
commit ; -- DML(insert , update , delete ) 레코드 값 조정하는 명령들 을 수행한 뒤 DB에 영구히 적용되도록 하는 commit 을 해주어야함


select * from emp01;
select * from dep01;

-- dep01 테이블에 값 넣기 : dep01 테이블의 dno 컬럼에 PK 가 있음 = 중복값 insert 안됨
desc dep01;

insert into dep01 (dno, dname,loc)
VALUES (1,'CEO','SEOUL');
commit;

UPDATE emp01
    set dno = 1
    ,manager = 7717
    ,job = 'CEO'
where eno = 7777;
commit;


select * from emp01
order by dno ASC;


---------join : 여러 테이블의 컬럼을 출력할 때 join을 사용하여 하나의 테이블처럼 출력함
            -- 두 테이블의 공통 키 컬럼을 확인.
            -- emp01 , dep01 테이블의 공통 키 컬럼은 dno 이다
            -- equi join : 오라클에서만 작동되는 JOIN 구문
            -- ANSI JOIN : 모든 DBMS에서 사용되는 JOIN 구문
-- equi join 구문으로 두 테이블 join
    -- from 절에서 join할 테일블을 명시(,)
    -- 테이블 이름은 병칭 이름으로 줌
    -- where 절에서 두 테이블의 공통 키 컬럼을 명시
    -- and절에서 조건을 처리
    -- 공통 키 컬럼을 출력 시 반드시 테이블명.컬럼명
    
select eno , ename , job, d.dno,dname,loc
from emp01 e, dep01 d -- e ,d 는 두 테이블의 별칭 (알리아스) 
where e.dno = d.dno -- 공통 키컬럼 명시
and d.dno = 10;  -- 조건명시

-- ANSI JOIN : 모든 DBMS에서 공통으로 사용되는 JOIN 구문
    -- INNER JOIN :두 테이블에서 키 컬럼의 공통되는 부분만 출력
    --OUTER JOIN :
        -- LEFT OUTER JOIN
        -- RIGHT OUTTER JOIN
        -- FULL OUTER JOIN
    -- SELF JOIN
    -- CLOSE JOIN
    
    
-- INNER JOIN : ANSI JOIN : 모든 DBMS 에서 공통으로 사용되는 SQL쿼리 
    --from 절에 JOIN 테이블 이름을 명시
    -- INNER 키는 생략될 수 있다 ( JOIN 기본값 )
    -- on 절의 두 테이블의 공통 키 컬럼을 명시,  두 테이블의 공통인 것만 출력
    
    
--(알리아스 안시킬 때)
select eno, ename , salary , dep01.dno, dname , loc
from emp01 INNER JOIN dep01 
on emp01.dno = dep01.dno;

--(알리아스 시킬 때)
select eno, ename , salary , d.dno, dname , loc
from emp01 e JOIN dep01 d
on e.dno = d.dno
where e.dno = 20 or e.dno = 1
order by ename DESC;

-- INNEER JOIN : ANSI SQL : 모든 DBMS 에서 공통으로 사용되는 SQL쿼리 
        -- ON절의 에 두 테이블의 공통분모만 출력
select * 
from emp01 e join dep01 d
on e.dno = d.dno;

-- OUTER JOIN : 
    -- LEFT OUTER JOIN : 왼쪽 테이블의 모든 내용을 출력함
    -- RIGHT OUTER  JOIN : 오른쪽 테이블의 모든 내용을 출력함
    -- FULL OUTER  JOIN : 왼쪽, 오른쪽 모든 내용을 다 출력함
select * from dep01;

insert into dep01 (dno, dname,loc)
VALUES(60,'MANAGE','BUSAN');
commit;

-- RIGHT OUTER JOIN : 두 테이블의 공통부분과 오른쪽 (dep01) 테이블의 모든 값을 출력
select *
from emp01 e right outer join dep01 d
on e.dno = d.dno;

-- FULL OUTER JOIN : 두 테이블의 모든 부분(양쪽)을 출력
select *
from emp01 e FULL OUTER JOIN dep01 d
on e.dno = d.dno;


-- self join : 자신의 테이블을 join , 반드시 자신의 테이블을 별칭이름으로 가상으로 생성해서 join 
    -- 조직도 출력, 직급 상사를 바로 출력 할 때 사용 됨

select e.eno 사원번호, e.ename 사원이름, e.manager 직속상관번호 , m.eno 직속상관사번 ,m.ename 직속상관명
from emp01 e join emp01 m
on e.manager = m.eno;

select eno , ename , manager , eno , ename 
from employee

-----
select '