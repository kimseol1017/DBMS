/*
    JOIN 실습 
        member10 : 회원정보를 저장하는 테이블 
        zipcode10 : 우편번호를 저장하는 테이블 
        product10 : 제품 정보를 저장하는 테이블 
        order10 : 주문 정보를 저장하는 테이블 
*/
-- 테이블 삭제 ㅣ Foreign Key 가 참조하는 테이블은 삭제되지 않는다 .  CASCADE CONSTRAINTS
        -- 1. 참조하는 테이블을 먼저 삭제 후 삭제
        -- 2. 강제삭제 CASCADE CONSTRAINTS 옵션 사용
-- member10 테이블에서 찹조되는 테이블이므로 삭제가 안됨
drop table zipcode10;
-- order10 table 에서 참조되기 때문에 삭제 할 수 없다
drop table member10;

-- SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'MEMBER10';
drop TABLE order10;
drop TABLE product10;
-- 2. CASCADE CONSTRAINTS 사용
    --zipcode10 테이블을 강제 삭제
drop table zipcode10 CASCADE CONSTRAINTS; 
drop table member10 CASCADE CONSTRAINTS;
drop TABLE order10 CASCADE CONSTRAINTS;
drop TABLE product10 CASCADE CONSTRAINTS;



create table zipcode10 (
        zipcode number(6) not null constraint PK_ZIPCODE10_ZIPCODE Primary key, 
        si_do varchar2(200) not null, 
        gu_gun varchar2(200) not null, 
        bungi varchar2(200) not null
) ; 

create table member10 (
        m_id number(4) not null constraint PK_MEMBER10_M_ID primary key, 
        pass varchar2(200) not null , 
        name varchar2(200) not null, 
        email varchar2(200) not null , 
        zipcode number(6) null , 
        -- Foreign Key 제약 조건 추가함. : member10(zipcode)  ===> zipcode10(zipcode) 
            constraint FK_MEMBER10_ZIPCODE foreign key (zipcode) references ZIPCODE10(zipcode) 
); 

create table product10 (
        pro_id number(6) not null constraint PK_PRODUCT10_PRO_ID primary key , 
        pro_name varchar2(200) not null, 
        pro_price number(7,2) not null , 
        pro_cnt number(4) default 0 not null 
);

create table order10 (
    ord_id number(6) not null constraint PK_ORDER10_ORD_ID primary key, 
    m_id  number(4) not null,      -- FK  : MEMBER10(m_id)
    pro_id number(6) not null,    -- FK  : PRODUCT10 (pro_id) 
        -- Foreign Key 2개 
        constraint FK_ORDER10_M_ID foreign key (m_id) references member10(m_id), 
        constraint FK_ORDER10_PRO_ID foreign key (pro_id) references product10(pro_id)   
);

-- 각 테이블에 레코드 5개씩 넣습니다. 


    
insert into zipcode10 (zipcode,si_do,gu_gun,bungi)
VALUES (10, '서울', '종로구' , '관철동 100번지');
insert into zipcode10 (zipcode,si_do,gu_gun,bungi)
VALUES (20, '부산', '진구' , '관철동 100번지');
insert into zipcode10 (zipcode,si_do,gu_gun,bungi)
VALUES (30, '대구', '종로구' , '관철동 100번지');
insert into zipcode10 (zipcode,si_do,gu_gun,bungi)
VALUES (40, '대전', '대덕구' , '관철동 100번지');
insert into zipcode10 (zipcode,si_do,gu_gun,bungi)
VALUES (50, '울산', '중구' , '관철동 100번지');
    
desc member10;    

insert into member10 (m_id , pass, name , email,zipcode)
values (1,'1234', '홍길동', 'aaa@aaa.com',10); -- 서울에 삼
insert into member10 (m_id , pass, name , email,zipcode)
values (2,'1234', '김길동', 'bbb@aaa.com',20);
insert into member10 (m_id , pass, name , email,zipcode)
values (3,'1234', '최길동', 'ccc@aaa.com',30);
insert into member10 (m_id , pass, name , email,zipcode)
values (4,'1234', '황길동', 'eee@aaa.com',40);
insert into member10 (m_id , pass, name , email,zipcode)
values (5,'1234', '성길동', 'zzz@aaa.com',50);
commit;

insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (100,'사과',25000,100);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (200,'바나나',20000,50);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (300,'파인애플',33000,40);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (400,'귤',22000,470);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (500,'오렌지',15000,50);
commit;


desc product10;

desc order10;
insert into order10(ord_id,m_id,pro_id)
values (1000,1,100); -- 홍길동이 사과를 주문함 
insert into order10(ord_id,m_id,pro_id)
values (1100,2,200);
insert into order10(ord_id,m_id,pro_id)
values (1200,3,300);
insert into order10(ord_id,m_id,pro_id)
values (1300,4,400);
insert into order10(ord_id,m_id,pro_id)
values (1400,5,500);
commit;

select * from zipcode10
select * from member10;
select * from product10;
select * from order10;



-- member10 에만 존재하는 테이블 (주문정보 없음)   <== LEFT OUTER JOIN

insert into member10 (m_id , pass, name , email,zipcode)
values (6,'1234', '양길동', 'eee@aaa.com',40);
insert into member10 (m_id , pass, name , email,zipcode)
values (7,'1234', '우길동', 'zzz@aaa.com',50);
commit;  --> DML 구문에선 트렌젝션 발생 = commit 사용 ( insert, update, delete )

-- 주문 정보없는 제품  < == RIGHT OUTER JOIN  
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (600,'망고',22000,470);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (700,'용과',15000,50);
commit;


    
-- ANSI JOIN 문을 사용해서 주문정보(Order10)테이블을 기준으로 
     -- 주문자명, 주문자메일주소, 주문자번지(시도), 주문제품명, 제품의 가격을 출력 합니다.   , 
     --order10, member10, zipcode10, product10
     
select name, email, si_do, pro_name, pro_price
from order10 o 
join member10 m
    on o.m_id = m.m_id
join product10 p
    on o.pro_id = p.pro_id
join zipcode10 z
    on m.zipcode = z.zipcode
    
-- 모델링 되지 않은 주문 테이블 <-- order11
create table order11 (
o_id number(6) not null primary key,

m_name varchar2(200) not null ,  --주문자이름
m_phone varchar2(200) not null,  -- 주문자 폰번호
m_addr varchar2(200) not null, --주문자 주소
m_email varchar2(200) null, --주문자 이메일

p_id number(6) not null, --제품 번호
p_name varchar2(200) not null, --제품이름
p_price number(7,2) not null, --제품 가격
p_cnt number(6) null --제품수량
);

insert into order11 (o_id , m_name, m_phone, m_addr, m_email, p_id,p_name,p_price,p_cnt)
values (10,'홍길동','010-1111-1111','서울','aaa@aaa.com',100,'사과',12000,100);
insert into order11 (o_id , m_name, m_phone, m_addr, m_email, p_id,p_name,p_price,p_cnt)
values (20,'김길동','010-1111-1111','서울','aaa@aaa.com',100,'사과',12000,100);
commit;

select * from order11;

-- join : ANSI JOIN 
    -- INNER JOIN : ON절의 공통값만 출력 
    -- LEFT OUTER JOIN : 왼쪽 테이블의 모든 내용 출력
    -- RIGHT OUTER JOIN : 오른쪽의 모든 내용 출력
    
-- member10 (다) , zipcode (1) 테이블 : 
select  *
from member10 m
    join zipcode10 z
        on m.zipcode = z.zipcode;
        
    -- RIGHT OUTER JOIN : 오른쪽의 모든 내용 출력

select * 
from member10 m
    right outer join zipcode10 z
        on m.zipcode = z.zipcode

-- 주문 테이블 (order10),주문자 정보 (member10) <=== on m_id
select * from order10;

select *
    from order10 o
         join member10 m
            on o.m_id = m.m_id
            
-- 주문정보에 업는 사용자 출력 (주문하지 않는 사용자) : RIGHT OUTER JOIN
select * 
    from order10 o
        RIGHT OUTER JOIN member10 m
            on o.m_id = m.m_id
            
select * 
    from member10 m
        LEFT OUTER JOIN  order10 o
            on m.m_id = o.m_id
            
-- 3개 테이블 join : order10, member10, zipcode10

select *
    from order10 o
        join member10 m
            on o.m_id = m.m_id
        join zipcode10 z
            on m.zipcode = z.zipcode;
            
-- 4개 테이블 JOIN : order10, member10, zipcode10, product10
-- INNER JOIN
select *
    from order10 o
        join member10 m
            on o.m_id = m.m_id
        join zipcode10 z
            on m.zipcode = z.zipcode
        join product10 p
            on o.pro_id = p.pro_id
            
--주문하지 않는 사용자 정보 출력 , 주문되어 있지 않은 제품 출력 OUTER JOIN

select *
    from order10 o
        join member10 m
            on o.m_id = m.m_id
         join zipcode10 z
            on m.zipcode = z.zipcode
       right outer join product10 p
            on o.pro_id = p.pro_id
    
-- LEFT OUTER JOIN  member10 , order10 , zipcode10, product10
select *
    from member10 m
      left outer join order10 o
            on o.m_id = m.m_id
         join zipcode10 z
            on m.zipcode = z.zipcode
       left outer join product10 p
            on o.pro_id = p.pro_id
            
            