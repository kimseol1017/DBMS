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
add (sido varchar2(30),gugum varchar2(30),
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
pro_id varchar2(16),
    constraint FK_ORDER1_PRODUCT_CODE foreign key (product_code) REFERENCES products1(product_code), 
    constraint FK_ORDER1_PRO_ID foreign key (pro_id) REFERENCES member1(mid) 
);


