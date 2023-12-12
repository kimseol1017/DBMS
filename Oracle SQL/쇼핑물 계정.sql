create table member1 (
    mid VARCHAR2(20) not null CONSTRAINT PK_MEMBER1_ID PRIMARY KEY,
    mpwd VARCHAR2(20),
    mname VARCHAR2(50),
    zipcode VARCHAR2(7),
    address varchar(20)
);

alter TABLE member1
add constraint FK_MEMBER1_ZIPCODE FOREIGN key (zipcode) REFERENCES tb_zipcode (zipcode);

create TABLE tb_zipcode(
zipcode VARCHAR2(7) not null constraint PK_tbzipcode_ZIPCODE primary key,
sido varchar2(30),
gugum varchar2(30),
dong varchar2(30),
bungi VARCHAR2(30)
);

alter table tb_zipcode
add (
sido varchar2(30),
gugum varchar2(30),
dong varchar2(30),
bungi VARCHAR2(30));

select * from tb_zipcode;

create table products1(
product_code varchar2(20) not null constraint PK_PRODUCTS1_PRODUCT_CODE primary key,
product_name varchar2(100),
product_kind char(1),
product_price1 varchar2(10),
product_price2 varchar2(10)
);

create table order1 (
o_seq NUMBER(10) not null constraint PK_order1_o_seq primary key,
product_code VARCHAR2(20),
pro_id varchar2(16), -- 주문자 id
    constraint FK_ORDER1_PRODUCT_CODE foreign key (product_code) REFERENCES products1(product_code), 
    constraint FK_ORDER1_PRO_ID foreign key (pro_id) REFERENCES member1(mid) 
);

insert into tb_zipcode(zipcode,sido, gugum, dong, bungi)
VALUES ('11111','서울','종로구','인사동','17');
insert into tb_zipcode(zipcode,sido, gugum, dong, bungi)
VALUES ('22111','서울','광진구','인사동','17');
insert into tb_zipcode(zipcode,sido, gugum, dong, bungi)
VALUES ('33111','서울','구로구','인사동','17');
insert into tb_zipcode(zipcode,sido, gugum, dong, bungi)
VALUES ('44111','서울','동대문구','인사동','17');
insert into tb_zipcode(zipcode,sido, gugum, dong, bungi)
VALUES ('55111','서울','강남구','인사동','17');
commit;
--
insert into member1 (mid, mpwd, mname, zipcode,address)
values ('1','1234','김설',11111,'종로구');
insert into member1
values ('2','1234','김윤',22111,'종로구');
insert into member1
values ('3','1234','김솔',33111,'종로구');
insert into member1
values ('4','1234','김준',44111,'종로구');
insert into member1
values ('5','1234','김희',55111,'종로구');
commit;

insert into products1 (PRODUCT_CODE,product_name,PRODUCT_KIND,product_price1,product_price2)
values ('11','사과','A','1000','10000');
insert into products1 (PRODUCT_CODE,product_name,PRODUCT_KIND,product_price1,product_price2)
values ('12','바나나','B','1200','12000');
insert into products1 (PRODUCT_CODE,product_name,PRODUCT_KIND,product_price1,product_price2)
values ('13','컴퓨터','C','3220000','102000');
insert into products1 (PRODUCT_CODE,product_name,PRODUCT_KIND,product_price1,product_price2)
values ('14','모니터','M','121000','110000');
insert into products1 (PRODUCT_CODE,product_name,PRODUCT_KIND,product_price1,product_price2)
values ('15','키보드','K','11000','120000');
commit;

insert into order1(o_seq,product_code,pro_id)
VALUES (10,'12','1');
insert into order1(o_seq,product_code,pro_id)
VALUES (11,'13','2');
insert into order1(o_seq,product_code,pro_id)
VALUES (12,'14','4');
insert into order1(o_seq,product_code,pro_id)
VALUES (13,'15','2');
insert into order1(o_seq,product_code,pro_id)
VALUES (14,'13','5');
commit;
-- join 하고 view에 넣고 출력
select * from products1;
desc order1;

CREATE VIEW v_order
as
select o.o_seq, o.product_code,o.pro_ID,m.mid,m.mname,m.address,z.zipcode,z.sido,z.gugum,z.dong,z.bungi,p.product_name,p.product_kind,p.product_price1,p.product_price2
from order1 o
    join member1 m
        on o.pro_id = m.mid
    join tb_zipcode z
        on z.zipcode = m.zipcode
    join products1 p
        on p.product_code = o.product_code;
    
select * from v_order;
