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

--테이블 구조를 확인하기  desc 테이블명; , 실제 컬럼명, null 허용여부, 자료형(number : 정수 실수, varchar2 : 문자열)
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


