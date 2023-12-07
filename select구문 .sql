/* 
    select : 테이블의 값을 검색
    
    select 컬럼명 frome 테이블명&뷰 명
    
    select * from employee;
    
*/

-- employee 테이블의 모든 컬럼을 출력하기

select * from employee;  -- * 는 모든컬럼을 출력하라는 뜻

-- 특정 컬럼만 출력
select eno,ename,job 
from employee;

--특정 컴럼을 여러번 출력 , 컬럼에 연산을 할 수 있다

select eno, ename, salary, ename, ename, salary * 12
from employee;

--컬럼 이름을 별치응로 바꾸고 출력
select eno as "사원번호",ename 사원명, salary as 월급, salary * 12 as 연봉
from employee;

--employee 테이블 각 컬럼의 의미

select * 
from employee;
--as 는 생략 가능 , 특수문자나, 공백은 "" 로 묶기

select eno as "사원 번호", ename 사원명, job 직책, manager 직속상관, hiredate 입사날짜,
salary 월급, commission 보너스, dno 부서번호
from employee;

--테이블 구조를 확인하기  desc 테이블명; , 실제 컬럼명, null 허용여부, 자료형(number : 정수 실수,char, varchar2 : 문자열)
desc employee; -- insert 시 컴럼의 자료형 , NULL 허용여부 확인 후 값으르 넣음

select * from employee;

--연봉을 계산 : 주의 : null 과의 연산은 결과가 null 
select eno 사원번호, ename 사원명, salary 월급, commission 보너스
from employee;

-- 연봉 = 월급 * 12 + 보너스
    --null 과의 연산은 모두 null 값 이 나옴
    
select eno 사원번호, ename 사원명, salary 월급, commission 보너스, --원본
    salary * 12 + commission 연봉--하나의 컬럼을 추가적으로 생성
from employee;

-- nvl (컴럼명, 0) ; null 을 처리하는 함수
select eno 사원번호, ename 사원명, salary 월급, commission 보너스, --원본
    nvl(commission, 0) 널처리됨, salary * 12 + nvl(commission, 0) 연봉--하나의 컬럼을 추가적으로 생성
from employee;

-- 컬럼과 컬럼을 연산 할 수 있다 : +,-,*,/ <== 정수, 상수) 타입
-- number : 정수
-- number(7,2) : 실수  전체 7자리, 소수점 이하 2자리

select * from employee;
desc employee;

select ename , salary + salary "+연산", salary * salary "*연산" , salary * 0.1 as "월급의 10%"
from employee;

--중복 처리 후 출력 : distinct 컬럼명 , 컬럼명의 중복을 제거 후 출력

select * from employee;

-- 우리회사의 부서 만 출력
select distinct dno 
from employee;

-- 우리회사의 직책만 중복제거 후 출력 
    -- 대소문자 구분 하지 않음 : 쿼리 ( select ,  create, from , group by, order by ) , 컬럼명 ,  테이블명
    -- 대소문자 구분 : 테이블 안의 레코드 값 (값) 은 대소문자 구분
/*
CLERK : 사무원
SALESMAN : 영업사원
MANAGER : 관리자
ANALYST : 븐석가
PRESIDENT : 사장
*/

select distinct job
from employee;

select * from employee;

-- job (직책) 이 MANAGER (관리자) 인 사용자 정보만 출력

select ename 사원명 , job 직책 
from employee 
where job = 'MANAGER';

-- 부서  테이블 확인
select * from department;

select dno 부서번호 , dname 부서명, loc 부서위치
from department;

-- salgrade : 연봉의 등급을 적용하는 테이블 <== JOIN
select * from salgrade;

select grade 연봉의등급 , losal 최저연봉, hisal 최고연봉
from salgrade;

-- SELECT 문의 전체 내용 , SQL : 구조화된 질의

/*  생략은 가능하나 순서는 변경되면 안됨
SELECT 컬럼명 
FROM 테이블명 (뷰명)
WHERE 조건
GROUP BY 그룹핑 처리할 컬럼명    <== 컬럼의 동일한 값을 그룹핑해서 처리함.
HAVING 조건               <== GROUP BY 결과에 대한 조건
ODER BY 컬럼명 ASC[DESC]   <== 컬럼을 정렬해서 출력 , ASC : 내림차순 정렬, DESC : 오름차순 정렬
*/

--WHERE 조건 사용하기 , = : 같다, >,<,>=,<=
    -- 같지 않다 : <> , !=, ^=
    -- OR         -- ln(값, 값, 값)
    -- AND
    -- between
  
select * from employee;

select *
from employee
where salary > 1500;

select *
from employee
where salary = 1500;

select *
from employee
where salary <> 1500;

-- or 연산자

select *
from employee
where salary = 1500 or salary = 800 or salary = 1600;

-- in  키워드 : in (값, 값, 값) 

select *
from employee
where salary in(1500,800,1600);

-- AND 연산자  : 부서번호가 10번인 사원의 연봉이 1500 이상인 사용자를 출력
select *
from employee
where dno = 10 and salary > 1500;

--직책이 manager 이면서 월봉이 2000 이상인 사원의 사원번호 , 사원 명, 월급
select eno 사원번호,ename 사원명,salary 월급 -- disrinct 특정 컬럼만 출력 select distinct eno 사원번호,ename 사원명,salary 월급
from employee
where job = 'MANAGER' and salary >= 2000;  -- ''로 문자열 레코드값 지정

-- 비교 연산자를 date,varchar,char 타입에도 쓸 수 있다
--81년도 입사자 모두 출력

select *
from employee 
where hiredate > '81/01/01' and  hiredate < '81/02/28';

-- 문자열 : char, varchar , nvarchar , nchar : 문자열, ''
select *
from employee
where ename < 'D';      -- 첫자가 D 보다 작은것 (A,B,C)

select *
from employee
where ename > 'D';    -- 첫자가 D 보다 큰것

-- like  : 문자열에서 특정 값만 검색 : %: 모든것이 와도 상관없다. , _ : 한 글자가 어떤것이 와도 상관없다
-- 컬럼의 특정값을 검색시 사용됨.

select * from employee
where ename like '%LA%';

select * from employee
where ename like '_CO%';

-- null 검색  - is null , is not null

select * from employee;

-- 커미션 컬럼의 값이 null
select * from employee
where commission is null;


select * from employee
where commission is not null;

-- count () : 레코드의 갯수를 출력 : 페이징 처리  <== 
    -- null 은 카운트 하지 않는다
    
 select count(*) "총레코드 수"
 from employee;
 
 select ename
 from employee;
 
 select count(commission)  -- 레코드 수 : null 컬럼은 출력하지 않는다.
 from employee;
 
 select count(commission)
 from employee;
 
 select commission 수능점수 -- null : 비어있는 상태 , 0점
 from employee
 
 desc employee;
 
 -- 테이블의 전체 레코드르를 정확하게 출력 : not null 컬럼을 count(컴럼명) ,count(*)
 
 -- 특정 컬럼을 정렬해서 출력 :  order by 컴럼명 ASC(DESC)
 --ASC : 오름차순 정렬 :  A ==> Z 생략가능
 -- DESC : 내림차순 정렬 : Z ==> A
 
 -- 월급 컬럼을 오름차순 정렬
 select *
 from employee
 order by salary ASC;
 
  -- 월급 컬럼을 내림차순 정렬
 select *
 from employee
 order by salary desc;
 
 --이름 컬럼을 오름차순 정렬
  select *
 from employee
 order by ename ASC;
 
  
 --이름 컬럼을 내림차순 정렬
  select *
 from employee
 order by ename DESC;

-- 직책 컬럼을 내림차순 정렬
  select *
 from employee
 order by job DESC;
 
 -- 정렬할 컬럼을 Where 와 같이 쓸 때 order by 는 가장 마지막에 옴
 
 select *
 from employee
 where salary >= 1500
 order by salary desc;
 
 -- order by 에서 여러 컬럼을 정렬한다 앞의 컬럼을 모두 정렬하고 , 같은 갚이 존재할 때, 같은 값에 대해뒤 뒤읠 컬럼을 정렬
    -- 답변형 게시판을 만들 때 사용됨
    
    select dno, ename
    from employee
    order by dno asc, ename desc;
 
     select job, dno, ename
    from employee
    order by job asc ,dno asc, ename desc;