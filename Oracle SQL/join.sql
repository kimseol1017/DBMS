/* 
join : Database ���� ���� ���̺��� ����. �𵨸��� ���ؼ� ���̺��� �и��Ǿ� �ִ�  (R - DBMS)
            �� ���̺��� �������踦 ������ �ִ�
    employee���̺��department ���̺��� ���� �ϳ��� ���̺� �̳�, �𵨸��� ���ؼ� (1,2,3����ȭ ) ���̺��� �и�
    �𵨸��� �ϴ� ���� : �ߺ����� , �������
    
    ��������: ���̺��� �÷��� ���� Ű . �������� ���Ἲ(���Ծ��� ������ - ���ϴ� ����)
        Primary Key: ���̺��� �÷��� 1���� ���� �� �ִ�. - Ư�� �÷��� �ߺ��� ���� ���� ���ϰ� ��.
            - �ݵ��  Not Null �÷��̾�� ��  null�� �����ϸ� ����
            - ���̺� ������ �ݵ�� PK �� �����ؾ��Ѵ�, - Update,Delete �������� PK �÷��� where �������� ����ؾ���
            - ���̺��� �÷��� 1���� ���� �� �ִ�
            - 2���� �÷��� ����  PK �� ���� �� �ִ�
            - index�� �ڵ����� �����ȴ�. �÷��� �˻��� ������ ��
            - JOIN �� ON ������ ���� ����ϴ� key �÷�
        Foreign Key:
            - �ٸ� ���̺� (�θ����̺�) �� Ư�� �÷��� �����ؼ� ���� �ֵ��� ��.
            - FK�� �����ϴ� �÷��� �θ����̺��� PK, UK �� ����
            -  
            
            
        Unique Key:
            - PK �� �����ϰ� �÷��� �ߺ��� ���� ���� ���ϵ��� ��
            - Null�� �� �ѹ� ���� �� �ִ� (�ߺ��Ұ�) - Not null / Null ��� ����
            - �ϳ��� ���̺� ������ unique key �� ���� �� �ִ�
            - index �� �ڵ����� ������, JOIN �� ON�� �� ����

        NOT NULL : �÷��� Null �� ������� ���� =>pk
        
        cheak
            - �÷��� ������ �ɾ ���� ���ϴ� ���� ���� �� �ֵ��� ��
            
        default 
            - ���������� �ƴ�����, ���� ����ó�� ����
            - �÷��� ���� ���� ������ default�� ������ ���� ��ε�
*/

select * from employee;     -- employee ���̺��� DNO �÷��� �����Ѵ�(Foreign Key ) department ���̺��� DNO �÷��� �����Ѵ�

SELECT  * from  department;


---------���̺� ���� : ���� ���̺��� ���������� ���� ���� ���� Alter Table �� ����ؼ� �������� �ο�

create table emp01
as 
select * from employee;

create table dep01
as 
select * from department;


/*
    ���̺��� ���������� Ȯ���ϴ� ��ɾ� 
        : user_ conestraints : ������ ���� <== ���̺��� ���� ������ �˷��ִ� ���̺�
*/
select * from user_constraints;

select * from user_constraints
where table_name in ('EMPLOYEE', 'DEPARTMENT');

-- ���̺� ����� ���̺��� �÷��� �ο��� ���������� ����Ǿ� ���� �ʴ´� .  �÷��� ���� ����Ǿ�´�
-- alter table �� ���ؼ� ���� ������ �ο��ؾ���
    --  alter table : ������ ���̺��� ����
select * from user_constraints
where table_name in ('EMP01', 'DEP01');

-- DEP01 ���̺� PK���������� �߰�
ALTER TABLE DEP01
add CONSTRAINT PK_DEP01_DNO PRIMARY KEY (dno);  -- > dno�÷��� PK ���������� �ִ´�   PK_DEP01_DNO = CONSTRAINT NAME

---emp01 ���̺��� eno �÷��� PK �������� �߰�
alter table emp01
add constraint PK_EMP01_ENO primary key (eno);

--emp01 ���̺��� dno �÷��� FK �ο� , ����(REFERENCES)�� ���̺��� �÷��� DEP01���̺��� dno �÷��� ���� dep01 (dno)

alter table emp01
add CONSTRAINT FK_EMP01_DNO FOREIGN KEY (dno) REFERENCES dep01 (dno);


-- PK �÷��� Ȯ�� 
desc emp01;

select * from emp01 ;

-- ���� ���� �� �÷��� �ο��� ���� ������ �� Ȯ���ϰ� ���� insert 
-- eno: PK �� ��ϵǾ� �־�, �ߺ��� ���� ������ �������� ����� ������ �߻�
-- dno: FK �� ��ϵǾ� �־�, DEP01 ���̺��� DNO�÷��� �����ϴ� ���� �־�� ��

insert into emp01(eno,ename,job,manager,hiredate,salary,commission,dno)
VALUES(7777,'CHJ','MANAGER',7785,'23/12/11',5000,null,10);
commit ; -- DML(insert , update , delete ) ���ڵ� �� �����ϴ� ��ɵ� �� ������ �� DB�� ������ ����ǵ��� �ϴ� commit �� ���־����


select * from emp01;
select * from dep01;

-- dep01 ���̺� �� �ֱ� : dep01 ���̺��� dno �÷��� PK �� ���� = �ߺ��� insert �ȵ�
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


---------join : ���� ���̺��� �÷��� ����� �� join�� ����Ͽ� �ϳ��� ���̺�ó�� �����
            -- �� ���̺��� ���� Ű �÷��� Ȯ��.
            -- emp01 , dep01 ���̺��� ���� Ű �÷��� dno �̴�
            -- equi join : ����Ŭ������ �۵��Ǵ� JOIN ����
            -- ANSI JOIN : ��� DBMS���� ���Ǵ� JOIN ����
-- equi join �������� �� ���̺� join
    -- from ������ join�� ���Ϻ��� ���(,)
    -- ���̺� �̸��� ��Ī �̸����� ��
    -- where ������ �� ���̺��� ���� Ű �÷��� ���
    -- and������ ������ ó��
    -- ���� Ű �÷��� ��� �� �ݵ�� ���̺��.�÷���
    
select eno , ename , job, d.dno,dname,loc
from emp01 e, dep01 d -- e ,d �� �� ���̺��� ��Ī (�˸��ƽ�) 
where e.dno = d.dno -- ���� Ű�÷� ���
and d.dno = 10;  -- ���Ǹ��

-- ANSI JOIN : ��� DBMS���� �������� ���Ǵ� JOIN ����
    -- INNER JOIN :�� ���̺��� Ű �÷��� ����Ǵ� �κи� ���
    --OUTER JOIN :
        -- LEFT OUTER JOIN
        -- RIGHT OUTTER JOIN
        -- FULL OUTER JOIN
    -- SELF JOIN
    -- CLOSE JOIN
    
    
-- INNER JOIN : ANSI JOIN : ��� DBMS ���� �������� ���Ǵ� SQL���� 
    --from ���� JOIN ���̺� �̸��� ���
    -- INNER Ű�� ������ �� �ִ� ( JOIN �⺻�� )
    -- on ���� �� ���̺��� ���� Ű �÷��� ���,  �� ���̺��� ������ �͸� ���
    
    
--(�˸��ƽ� �Ƚ�ų ��)
select eno, ename , salary , dep01.dno, dname , loc
from emp01 INNER JOIN dep01 
on emp01.dno = dep01.dno;

--(�˸��ƽ� ��ų ��)
select eno, ename , salary , d.dno, dname , loc
from emp01 e JOIN dep01 d
on e.dno = d.dno
where e.dno = 20 or e.dno = 1
order by ename DESC;

-- INNEER JOIN : ANSI SQL : ��� DBMS ���� �������� ���Ǵ� SQL���� 
        -- ON���� �� �� ���̺��� ����и� ���
select * 
from emp01 e join dep01 d
on e.dno = d.dno;

-- OUTER JOIN : 
    -- LEFT OUTER JOIN : ���� ���̺��� ��� ������ �����
    -- RIGHT OUTER  JOIN : ������ ���̺��� ��� ������ �����
    -- FULL OUTER  JOIN : ����, ������ ��� ������ �� �����
select * from dep01;

insert into dep01 (dno, dname,loc)
VALUES(60,'MANAGE','BUSAN');
commit;

-- RIGHT OUTER JOIN : �� ���̺��� ����κа� ������ (dep01) ���̺��� ��� ���� ���
select *
from emp01 e right outer join dep01 d
on e.dno = d.dno;

-- FULL OUTER JOIN : �� ���̺��� ��� �κ�(����)�� ���
select *
from emp01 e FULL OUTER JOIN dep01 d
on e.dno = d.dno;


-- self join : �ڽ��� ���̺��� join , �ݵ�� �ڽ��� ���̺��� ��Ī�̸����� �������� �����ؼ� join 
    -- ������ ���, ���� ��縦 �ٷ� ��� �� �� ��� ��

select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ , m.eno ���ӻ����� ,m.ename ���ӻ����
from emp01 e join emp01 m
on e.manager = m.eno;

select eno , ename , manager , eno , ename 
from employee

-----
select '