-- view(��) : ������ ���̺� , ���� ������ �ʰ�, �ڵ常 ����
    -- 1. ���� ���̺��� Ư�� �÷��� ��� �� �� <== ����
    -- 2. ������ ������ �ѹ� ���� ���� . <== ������ join ������ �ܼ�ȭ �� �� �ִ�.


--view �ǽ��� ���� �������̺� : emp02
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

-- ������ �������̺� �� employee , department ==> emp02, dept02 
    -- �ʵ��� �� �� �����
    -- �÷��� �ο��� ���������� ������� ���� <== alter table��  ����ؼ� �������� �߰�
select * from user_constraints where table_name in ('EMPLOYEE','DEPARTMENT');
select * from user_constraints where table_name in ('EMP02','DEPT02');
-- DEPT02 ���̺��� dno �÷��� Primary Key�� �ο��ؾ� ��
-- EMP01 ���̺��� eno(PK), dno(FK) ==> dept02 (dno)

alter table DEPT02
add constraint PK_DEPT02_DNO primary key (dno) ;

alter table emp02
add constraint PK_EMP02_ENO primary key (eno);

alter table emp02
add CONSTRAINT FK_EMP02_DNO FOREIGN key (dno) REFERENCES dept02(dno);


-- view ���� 1. ���� ���̺��� �߿� ������ ���߰� ���, ������ ����� �� �ִ�
        -- as ������ select �ڵ带 ������ ����
select * from emp02; --���� ���̺� : emp02

-- �� ���� : ���� ���̺��� ���� ������ ���� �ƴ϶� ����  �ڵ常 ������.
create view v_emp02 
as
select ename,job,dno
from emp02;

--�� ����:
--select �÷��� from ���̺�� & ���
select * from v_emp02;

-- ������ ���� user_���̺�  <== �ý����� ������ ����Ǿ��ִ� ���̺�

select * from user_views;
            --2. ����� ����. ������ ������ view �� �����ؼ� ������� �ΰ� ���� <==JOIN 
            -- �� ���̺��� join �ؼ� ������ 2500 �̻��� ��������� ���
            create view v_join
            as
            select ename,job,salary,dname,loc
            from emp02 e
                join dept02 d
                    on d.dno = e.dno
                where salary >= 2500;
                
    select * from v_join;
    
    -- employee, department ���̺��� �μ����� �ּ� ������ �޴� ��� �̸�, ����� ��å, �μ���, �μ���ġ�� ����ϵ� �ּҿ����� 1500�̻��� �����
        --join , gruop by , 20�� �μ� ����
        
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
-- �μ��� �ּҿ����� �޴� ��� ������ ����ϴ� view 20 �μ� ����
 select * from v_MinSalary;
 
 
 -- view�� as ����� select ���� ��
    -- ���� ���� ������ ���� ���� . select �ڵ常 �������
    --���� ���̺��� �÷��� �� ��Ī �� ���
    -- insert, update, delete �� view�� ���ؼ� �� �� �ִ�, �� ���� ���̤Ѥ����� �� Į���� ���� ���ǿ� ���� �� ����
    
    
-- view ����
    select * from emp02;
    
    CREATE view v_test01
    as
    select eno,ename,dno
    from emp02;
-- view ����
 drop view v_test01;
 
-- view����  
    select * from v_test01;
   
-- view �� ���� ���� �� �ִ� ==> ���� ���̺� ���� ��.
 insert into v_test01(eno,ename,dno)
 VALUES(8080,'ȫ',30);
 
 select * from emp02;
 commit;
    
-- view�� ����ؼ� ���� ���� :  update , del�� �ݵ�� ����(where)�� ������ 
update v_test01
set ename = 'KIM'
where eno = 8080;
commit;

select * from emp02;

-- view�� ����ؼ� ���� ���� : delete : where ����(�ݵ�� primary Key �÷��̾�� ��)�� �ݵ�� ����ؾ���
DELETE v_test01
where eno = 8080;
commit;

select * from emp02;


-- v_test02 : insert �ȵ� , update - del ���� ==> ���� ���̺��� ���� ���ǿ� �� �¾ƾ� �Ѵ�
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

--Ư�� �÷��� not null �������� �߰�

alter table emp02
MODIFY dno not null; 