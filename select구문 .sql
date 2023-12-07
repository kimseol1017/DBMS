/* 
    select : ���̺��� ���� �˻�
    
    select �÷��� frome ���̺��&�� ��
    
    select * from employee;
    
*/

-- employee ���̺��� ��� �÷��� ����ϱ�

select * from employee;  -- * �� ����÷��� ����϶�� ��

-- Ư�� �÷��� ���
select eno,ename,job 
from employee;

--Ư�� �ķ��� ������ ��� , �÷��� ������ �� �� �ִ�

select eno, ename, salary, ename, ename, salary * 12
from employee;

--�÷� �̸��� ��ġ���� �ٲٰ� ���
select eno as "�����ȣ",ename �����, salary as ����, salary * 12 as ����
from employee;

--employee ���̺� �� �÷��� �ǹ�

select * 
from employee;
--as �� ���� ���� , Ư�����ڳ�, ������ "" �� ����

select eno as "��� ��ȣ", ename �����, job ��å, manager ���ӻ��, hiredate �Ի糯¥,
salary ����, commission ���ʽ�, dno �μ���ȣ
from employee;

--���̺� ������ Ȯ���ϱ�  desc ���̺��; , ���� �÷���, null ��뿩��, �ڷ���(number : ���� �Ǽ�,char, varchar2 : ���ڿ�)
desc employee; -- insert �� �ķ��� �ڷ��� , NULL ��뿩�� Ȯ�� �� ������ ����

select * from employee;

--������ ��� : ���� : null ���� ������ ����� null 
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�
from employee;

-- ���� = ���� * 12 + ���ʽ�
    --null ���� ������ ��� null �� �� ����
    
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�, --����
    salary * 12 + commission ����--�ϳ��� �÷��� �߰������� ����
from employee;

-- nvl (�ķ���, 0) ; null �� ó���ϴ� �Լ�
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�, --����
    nvl(commission, 0) ��ó����, salary * 12 + nvl(commission, 0) ����--�ϳ��� �÷��� �߰������� ����
from employee;

-- �÷��� �÷��� ���� �� �� �ִ� : +,-,*,/ <== ����, ���) Ÿ��
-- number : ����
-- number(7,2) : �Ǽ�  ��ü 7�ڸ�, �Ҽ��� ���� 2�ڸ�

select * from employee;
desc employee;

select ename , salary + salary "+����", salary * salary "*����" , salary * 0.1 as "������ 10%"
from employee;

--�ߺ� ó�� �� ��� : distinct �÷��� , �÷����� �ߺ��� ���� �� ���

select * from employee;

-- �츮ȸ���� �μ� �� ���
select distinct dno 
from employee;

-- �츮ȸ���� ��å�� �ߺ����� �� ��� 
    -- ��ҹ��� ���� ���� ���� : ���� ( select ,  create, from , group by, order by ) , �÷��� ,  ���̺��
    -- ��ҹ��� ���� : ���̺� ���� ���ڵ� �� (��) �� ��ҹ��� ����
/*
CLERK : �繫��
SALESMAN : �������
MANAGER : ������
ANALYST : �켮��
PRESIDENT : ����
*/

select distinct job
from employee;

select * from employee;

-- job (��å) �� MANAGER (������) �� ����� ������ ���

select ename ����� , job ��å 
from employee 
where job = 'MANAGER';

-- �μ�  ���̺� Ȯ��
select * from department;

select dno �μ���ȣ , dname �μ���, loc �μ���ġ
from department;

-- salgrade : ������ ����� �����ϴ� ���̺� <== JOIN
select * from salgrade;

select grade �����ǵ�� , losal ��������, hisal �ְ���
from salgrade;

-- SELECT ���� ��ü ���� , SQL : ����ȭ�� ����

/*  ������ �����ϳ� ������ ����Ǹ� �ȵ�
SELECT �÷��� 
FROM ���̺�� (���)
WHERE ����
GROUP BY �׷��� ó���� �÷���    <== �÷��� ������ ���� �׷����ؼ� ó����.
HAVING ����               <== GROUP BY ����� ���� ����
ODER BY �÷��� ASC[DESC]   <== �÷��� �����ؼ� ��� , ASC : �������� ����, DESC : �������� ����
*/

--WHERE ���� ����ϱ� , = : ����, >,<,>=,<=
    -- ���� �ʴ� : <> , !=, ^=
    -- OR         -- ln(��, ��, ��)
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

-- or ������

select *
from employee
where salary = 1500 or salary = 800 or salary = 1600;

-- in  Ű���� : in (��, ��, ��) 

select *
from employee
where salary in(1500,800,1600);

-- AND ������  : �μ���ȣ�� 10���� ����� ������ 1500 �̻��� ����ڸ� ���
select *
from employee
where dno = 10 and salary > 1500;

--��å�� manager �̸鼭 ������ 2000 �̻��� ����� �����ȣ , ��� ��, ����
select eno �����ȣ,ename �����,salary ���� -- disrinct Ư�� �÷��� ��� select distinct eno �����ȣ,ename �����,salary ����
from employee
where job = 'MANAGER' and salary >= 2000;  -- ''�� ���ڿ� ���ڵ尪 ����

-- �� �����ڸ� date,varchar,char Ÿ�Կ��� �� �� �ִ�
--81�⵵ �Ի��� ��� ���

select *
from employee 
where hiredate > '81/01/01' and  hiredate < '81/02/28';

-- ���ڿ� : char, varchar , nvarchar , nchar : ���ڿ�, ''
select *
from employee
where ename < 'D';      -- ù�ڰ� D ���� ������ (A,B,C)

select *
from employee
where ename > 'D';    -- ù�ڰ� D ���� ū��

-- like  : ���ڿ����� Ư�� ���� �˻� : %: ������ �͵� �������. , _ : �� ���ڰ� ����� �͵� �������
-- �÷��� Ư������ �˻��� ����.

select * from employee
where ename like '%LA%';

select * from employee
where ename like '_CO%';

-- null �˻�  - is null , is not null

select * from employee;

-- Ŀ�̼� �÷��� ���� null
select * from employee
where commission is null;


select * from employee
where commission is not null;

-- count () : ���ڵ��� ������ ��� : ����¡ ó��  <== 
    -- null �� ī��Ʈ ���� �ʴ´�
    
 select count(*) "�ѷ��ڵ� ��"
 from employee;
 
 select ename
 from employee;
 
 select count(commission)  -- ���ڵ� �� : null �÷��� ������� �ʴ´�.
 from employee;
 
 select count(commission)
 from employee;
 
 select commission �������� -- null : ����ִ� ���� , 0��
 from employee
 
 desc employee;
 
 -- ���̺��� ��ü ���ڵ帣�� ��Ȯ�ϰ� ��� : not null �÷��� count(�ķ���) ,count(*)
 
 -- Ư�� �÷��� �����ؼ� ��� :  order by �ķ��� ASC(DESC)
 --ASC : �������� ���� :  A ==> Z ��������
 -- DESC : �������� ���� : Z ==> A
 
 -- ���� �÷��� �������� ����
 select *
 from employee
 order by salary ASC;
 
  -- ���� �÷��� �������� ����
 select *
 from employee
 order by salary desc;
 
 --�̸� �÷��� �������� ����
  select *
 from employee
 order by ename ASC;
 
  
 --�̸� �÷��� �������� ����
  select *
 from employee
 order by ename DESC;

-- ��å �÷��� �������� ����
  select *
 from employee
 order by job DESC;
 
 -- ������ �÷��� Where �� ���� �� �� order by �� ���� �������� ��
 
 select *
 from employee
 where salary >= 1500
 order by salary desc;
 
 -- order by ���� ���� �÷��� �����Ѵ� ���� �÷��� ��� �����ϰ� , ���� ���� ������ ��, ���� ���� ���ص� ���� �÷��� ����
    -- �亯�� �Խ����� ���� �� ����
    
    select dno, ename
    from employee
    order by dno asc, ename desc;
 
     select job, dno, ename
    from employee
    order by job asc ,dno asc, ename desc;