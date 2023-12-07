-- 오라클의 다양한 함수 사용하기
/* 
1. 문자 처리
2. 숫차 처리
3. 날짜 처리
4. 변환 함수
5. 일반 함수

*/

-- 1. 문자를 처리 : UPPER : 소문자 ->  대문자
--                LOWER : 대문자 ->  소문자
--                INITCAP: 첫 글자만 대문자
--                  LENGTH : 글자수를 반환 (영문 : 1byte)
--                  LENGTHB : 긐자수 반환 
--                  CONCAT : 문자열 열결
--                    SUBSTR : 글자를 잘라오는 함수
--                    INSTR :  특정 문자의 위치값
--                    LPAD : 글자 자릿수를 입력받아서 나머지는 특정 기호로 채움( 왼쪽 )
--                    RPAD : 글자 자릿수를 입력받아서 나머지는 특정 기호로 채움( 오른쪽 )
--                    RTRIM : 오른쪽의 공백 제거
--                    LTRIM : 왼쪽의 공백 제거
-- dual : 가상의 테이블 (테스트 용으로 사용)
select UPPER('Oracle')from dual;

select * from employee;

select ename 원본이름, UPPER (ename)대문자,LOWER(ename)소문자,INITCAP(ename)
from employee;

-- 검색이 안됨 :  컴럼의 값은 대소문자를 구분함

select *
from employee
where ename = UPPER('smith');
where LOWER(ename) = 'smith';

select LENGTH ('Oracle mania') from dual; --12
select LENGTH ('오라클 메니아') from dual; --7

select LENGTHb ('Oracle mania') from dual; --12
select LENGTHb ('오라클 메니아') from dual; --19 한글 1자 :3byte 처리

select ename 원본 , LENGTH(ename) 글자수 
from employee
order by LENGTH(ename)DESC ;

-- concat
-- || 컬럼을 연결해주는 연산자
select 'Oraclr' ,'Mania'
from dual;

select concat ('Oraclr' ,' Mania') as 연결명 
from dual;

select concat(ename,job)
from employee;

select ename || job from employee;

select ename || '    '  || job as "이름과 직책"
from  employee;

--substr 글자 잘라옴
        -- substr(컬럼,4,3) <-- 컴럼에 있는 문자열 중 , 4번때 자리에서 3자를 잘라와서 출력
        
select substr ('Oracle mania', 4,3) from dual;  -- 방 번호 1번부터 시작

select ename 원본이름 ,substr( ename ,2,3)잘라온이름 from employee;

select ename as 사원이름, substr ( hiredate,4,2 ) 입사월
from employee
where substr ( hiredate,4,2 ) = '02';

-- 81 년도에 입사한 사원의 이름, 입사년 ,입사월, 입사일

select ename as 이름, substr( hiredate, 1,2 ) 입사년, substr( hiredate, 4,2 ) 입사월,substr( hiredate, 7,2 ) 입사일
from employee
where substr ( hiredate,1,2 ) = '81';

-- instr : 특정 문자의 인덱스 번호 출력  1번 부터
        --instr(컬럼명,'A')  : 컬럼에서 문자열 중 A가 있는 index번호를 출력
        --instr(컬럼명,'A',4) : 컬럼에서 index 4번 부터 오른쪽 으로 A 가 포함 인덱스 번호를 출력
        -- 검색이 되지 않을 시 0을 출력
select (instr('Oracle mania','a')) from dual;  -- 3  a가 들어가는 index 번호

select (instr('Oracle mania','a',4)) from dual; --9 인덱스 4번 이후부터 존재하는 a의 인덱스 번호

select ename 이름, instr(ename,'M') as "M의 위치"
from employee;

-- LPAD     LPAD(컴럼명,늘릴릿수,'특수문자')  : 공백 자리에 특수문자 를 채움 왼쪽
--RPAD      반대쪽

select '770824-123456' 주민번호, LPAD('770824-1',20,'*') as "LPAD" from dual;
select '770824-123456' 주민번호, RPAD('770824-1',20,'*') as "RPAD" from dual;

select * from employee

--년도만 출력 월일은 별표
select RPAD(substr(hiredate,1,2),10,'*')
from employee;

-- ROUND : 특정 자릿수에서 반올림 ,  5이상 반올림,  5미만 은 잘라내 버림. 
/*
    ROUND (실수)  :   소숫점 뒷자리에서 반올림
    ROUND (실수, 소수점자릿수) : 
        - 소숫점 자리 (양수) : 소숫점 기준으로 오른쪽으로 이동해서 , 그 뒷자리에서 반올림됨   <== 주의
        - 소숫점 자리 (음수) : 소숫점 기준으로 왼쪽으로 이동해서 , 그 자리에서 반올림됨
*/ 

select 98.7654 as 원본 , 
            round (98.7654)  as R1,           -- 소숫점 뒤에서 반올림 
            round (98.7654, 2) as R2,        -- 소숫점 오른쪽으로 2자리 이동후 그 뒤에서 반올림   <== 주의 
            round (98.7654, -1) as R3,       -- 소숫점 왼쪽으로 1자리이동후 그 자리에서 반올림  
            round (98.7654, -2) as R3, 
            round (98.7654, -3) as R3
from dual ; 

-- 근로 소득세  : 월급의 3.3 ,     salary * 0.033  소득세 

select salary 월급 , salary * 0.033 소득세 , Round ( salary * 0.033) R1, Round( (salary * 0.033), 2 ) R2 , 
        Round(salary  - ( salary * 0.033 ) , 2 ) 실수령액
from employee; 

-- TRUNC : 특정 자리에서 잘라내 버림.   <== 특정 날짜 를 연산  , 오늘 날짜에서 100 이후의 날짜가 언제냐? 
select trunc (98.7654) T1, 
            trunc (98.7654 , 2) T2,
            trunc (98.7654, -1) T3, 
            trunc (98.7654, -2) T4 
from dual ; 

-- MOD   :   나머지 값만 출력  , MOD ( 인자1, 인자2 ) 
-- TRUNC : 몫 만 출력 할때 
select MOD ( 3, 2 ),            -- 나머지 
            TRUNC ( 31 / 2 )        -- 몫만 출력       
from dual ; 


-- 날짜함수 
        --sysdate : 현재 시스템의 날짜
        -- months_between : 두 날짜 사이의 개월 수 를 출력
        -- add_months : 특정날짜에서 개월 수 를 더해서 출력
        -- next_day : 특정 날짜에서 다음에 도래하는 요일을 인자로 받아서 도래하는 날짜를 출력
        -- last_day :  달의 마지막 날짜를 출력
        -- round(날짜) : 15일 이상 반올림 ,15일 이하 삭제
        -- trunc(날짜) : 날짜를 잘라내는 함수
        
        
select sysdate from dual; --23/12/07

--날짜에 연산이 가능
select sysdate -1 어제날짜 ,  sysdate +1 오늘날짜
from dual;
-- 오늘에서 100 일 전 날짜, 1000일 후 날짜
select sysdate -100 "100일전날짜" ,  sysdate +1000 "1000일후날짜"
from dual;


-- 입사일 부터 오늘 까지 총 근무일수를 구함 , date 타입 컬럼,  trunc( sysdate - hiredate)
select ename 이름 ,trunc( sysdate - hiredate )총근무일수 -- trunc 소수점 아랫자리 잘라냄
from employee;


-- 입사일에서 1000일 시점의 날짜
select ename 이름 ,( hiredate  + 1000 ) as "1000일 뒤"
from employee;

-- 특정 날짜에서 월을 기준으로 출력 : TRUNC(날짜,'MONTH'), ROUND(날짜,'MONTH')
select hiredate 원본날짜, TRUNC(hiredate,'MONTH'), ROUND(hiredate,'MONTH') from employee;

-- 현재까지의  근무 개월수를 출력: month_between(날짜,날짜)  : 두 날짜 사이의 개월수 출력
select ename 이름 , hiredate 입사날짜, trunc(months_between(sysdate , hiredate)) from employee;

-- 오늘날짜에서 100개월 이후의 날짜 (add_months) , 100일 후의 날짜
-- 컬럼이 DATE 타입일 때 가능

select sysdate 오늘날짜 , add_months(sysdate,100) "100개월 후" , sysdate + 100 "100일 후" from dual;

--last_day  : 그 날짜의 마지막 날짜를 출력함
select last_day(sysdate)from dual;

--모든 사원의 입사한 날의 마지막 날짜가 무엇인지 출력
select hiredate 입사날짜 , last_day(hiredate)마지막날짜 from employee;



-- 형식 변환 함수
    -- TO_CHAR : 날짜,숫자 ===> 문자형
    -- TO_DATE : 문자 ===> 날짜
    -- TO_NUMBER : 문자 ===> 숫자
select sysdate 오늘날짜 from dual;

-- TO_CHAR  날짜 --> 문자
--YYYY :년도 ,MM , MON: 월 , DD: 일, HH : 시, MI: 분, SS : 초  DAY  :  요일 , DY 요일(축약형)
select TO_CHAR (sysdate,'YYYY-MM-DD HH:MI:SS') from dual;  --'YYYYMMDD' 형식 지정

select To_char (hiredate, 'YYYY-MM-DD HH:MI:SS') "입사날짜2"
from employee; 
select TO_CHAR (sysdate,'YYYY"년"MM-DD MON DAY  DY HH:MI:SS') from dual; 

-- TO_CHAR 숫자 --->  문자
 -- 0 : 자릿수를 처리함 , 자릿수가 많으면 0 으로 처리함
 -- 9 : 자릿수를 처리함 , 자릿수가 많으면 공백으로 처리함
 -- L : 각 지역의 통화를 기호로 표시함
 
    -- . : 소수점으로 처리함
    -- , : 천단위 구분자
    
select TO_Char ( 9876, 'L000,000') from dual;
select TO_Char ( 9876, '999,999') from dual;

-- 월급을 그 나라의 통화 기혹으로 출력 1000 단위로 출력

select salary 월급 , TO_CHAR(salary,'L999,999')"월급 (한국 통화)"
from employee;

-- TO_DATE  : 문자, 숫자 ==> 날짜

select to_DATE ('1998-10-10','YYYY-MM-DD')from dual; --  문자형식을 식별 (형태를 똑같이 맞춰서 지정) 후 변환
select to_DATE ('1998 10월-10','YYYY MON-DD')from dual;
-- 1981 년 01월 01일 에서 100일,100개월(add_months)지난시점의 날짜 
select to_date('1981 - 01 - 01', 'YYYY - MM - DD')기준날짜 , to_date('1981 - 01 - 01', 'YYYY - MM - DD') + 100 "100일후" , add_months( to_date('1981 - 01 - 01', 'YYYY - MM - DD') ,100 ) "100개월후"
from dual;

select to_date( 770814,'YYMMDD') from dual;

-- 자신의 생일에서 현재까지 몇개월 살았는지 <== months_btewwn, 몇일 살았는지 출력 
select to_date( 20040604,'YYYYMMDD')생일
,trunc(sysdate - to_date( 20040604,'YYYYMMDD')) 일
,trunc(months_between(sysdate,to_date( 20040604,'YYYYMMDD'))) 개월
from dual;

-- employee 테이블에서 2050년 12월 24일 까지 의 일수 를 출력
