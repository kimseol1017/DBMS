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

--���̺� ������ Ȯ���ϱ�  desc ���̺��; , ���� �÷���, null ��뿩��, �ڷ���(number : ���� �Ǽ�, varchar2 : ���ڿ�)
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


