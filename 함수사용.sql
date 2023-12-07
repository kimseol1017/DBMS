-- ����Ŭ�� �پ��� �Լ� ����ϱ�
/* 
1. ���� ó��
2. ���� ó��
3. ��¥ ó��
4. ��ȯ �Լ�
5. �Ϲ� �Լ�

*/

-- 1. ���ڸ� ó�� : UPPER : �ҹ��� ->  �빮��
--                LOWER : �빮�� ->  �ҹ���
--                INITCAP: ù ���ڸ� �빮��
--                  LENGTH : ���ڼ��� ��ȯ (���� : 1byte)
--                  LENGTHB : �O�ڼ� ��ȯ 
--                  CONCAT : ���ڿ� ����
--                    SUBSTR : ���ڸ� �߶���� �Լ�
--                    INSTR :  Ư�� ������ ��ġ��
--                    LPAD : ���� �ڸ����� �Է¹޾Ƽ� �������� Ư�� ��ȣ�� ä��( ���� )
--                    RPAD : ���� �ڸ����� �Է¹޾Ƽ� �������� Ư�� ��ȣ�� ä��( ������ )
--                    RTRIM : �������� ���� ����
--                    LTRIM : ������ ���� ����
-- dual : ������ ���̺� (�׽�Ʈ ������ ���)
select UPPER('Oracle')from dual;

select * from employee;

select ename �����̸�, UPPER (ename)�빮��,LOWER(ename)�ҹ���,INITCAP(ename)
from employee;

-- �˻��� �ȵ� :  �ķ��� ���� ��ҹ��ڸ� ������

select *
from employee
where ename = UPPER('smith');
where LOWER(ename) = 'smith';

select LENGTH ('Oracle mania') from dual; --12
select LENGTH ('����Ŭ �޴Ͼ�') from dual; --7

select LENGTHb ('Oracle mania') from dual; --12
select LENGTHb ('����Ŭ �޴Ͼ�') from dual; --19 �ѱ� 1�� :3byte ó��

select ename ���� , LENGTH(ename) ���ڼ� 
from employee
order by LENGTH(ename)DESC ;

-- concat
-- || �÷��� �������ִ� ������
select 'Oraclr' ,'Mania'
from dual;

select concat ('Oraclr' ,' Mania') as ����� 
from dual;

select concat(ename,job)
from employee;

select ename || job from employee;

select ename || '    '  || job as "�̸��� ��å"
from  employee;

--substr ���� �߶��
        -- substr(�÷�,4,3) <-- �ķ��� �ִ� ���ڿ� �� , 4���� �ڸ����� 3�ڸ� �߶�ͼ� ���
        
select substr ('Oracle mania', 4,3) from dual;  -- �� ��ȣ 1������ ����

select ename �����̸� ,substr( ename ,2,3)�߶���̸� from employee;

select ename as ����̸�, substr ( hiredate,4,2 ) �Ի��
from employee
where substr ( hiredate,4,2 ) = '02';

-- 81 �⵵�� �Ի��� ����� �̸�, �Ի�� ,�Ի��, �Ի���

select ename as �̸�, substr( hiredate, 1,2 ) �Ի��, substr( hiredate, 4,2 ) �Ի��,substr( hiredate, 7,2 ) �Ի���
from employee
where substr ( hiredate,1,2 ) = '81';

-- instr : Ư�� ������ �ε��� ��ȣ ���  1�� ����
        --instr(�÷���,'A')  : �÷����� ���ڿ� �� A�� �ִ� index��ȣ�� ���
        --instr(�÷���,'A',4) : �÷����� index 4�� ���� ������ ���� A �� ���� �ε��� ��ȣ�� ���
        -- �˻��� ���� ���� �� 0�� ���
select (instr('Oracle mania','a')) from dual;  -- 3  a�� ���� index ��ȣ

select (instr('Oracle mania','a',4)) from dual; --9 �ε��� 4�� ���ĺ��� �����ϴ� a�� �ε��� ��ȣ

select ename �̸�, instr(ename,'M') as "M�� ��ġ"
from employee;

-- LPAD     LPAD(�ķ���,�ø�����,'Ư������')  : ���� �ڸ��� Ư������ �� ä�� ����
--RPAD      �ݴ���

select '770824-123456' �ֹι�ȣ, LPAD('770824-1',20,'*') as "LPAD" from dual;
select '770824-123456' �ֹι�ȣ, RPAD('770824-1',20,'*') as "RPAD" from dual;

select * from employee

--�⵵�� ��� ������ ��ǥ
select RPAD(substr(hiredate,1,2),10,'*')
from employee;

-- ROUND : Ư�� �ڸ������� �ݿø� ,  5�̻� �ݿø�,  5�̸� �� �߶� ����. 
/*
    ROUND (�Ǽ�)  :   �Ҽ��� ���ڸ����� �ݿø�
    ROUND (�Ǽ�, �Ҽ����ڸ���) : 
        - �Ҽ��� �ڸ� (���) : �Ҽ��� �������� ���������� �̵��ؼ� , �� ���ڸ����� �ݿø���   <== ����
        - �Ҽ��� �ڸ� (����) : �Ҽ��� �������� �������� �̵��ؼ� , �� �ڸ����� �ݿø���
*/ 

select 98.7654 as ���� , 
            round (98.7654)  as R1,           -- �Ҽ��� �ڿ��� �ݿø� 
            round (98.7654, 2) as R2,        -- �Ҽ��� ���������� 2�ڸ� �̵��� �� �ڿ��� �ݿø�   <== ���� 
            round (98.7654, -1) as R3,       -- �Ҽ��� �������� 1�ڸ��̵��� �� �ڸ����� �ݿø�  
            round (98.7654, -2) as R3, 
            round (98.7654, -3) as R3
from dual ; 

-- �ٷ� �ҵ漼  : ������ 3.3 ,     salary * 0.033  �ҵ漼 

select salary ���� , salary * 0.033 �ҵ漼 , Round ( salary * 0.033) R1, Round( (salary * 0.033), 2 ) R2 , 
        Round(salary  - ( salary * 0.033 ) , 2 ) �Ǽ��ɾ�
from employee; 

-- TRUNC : Ư�� �ڸ����� �߶� ����.   <== Ư�� ��¥ �� ����  , ���� ��¥���� 100 ������ ��¥�� ������? 
select trunc (98.7654) T1, 
            trunc (98.7654 , 2) T2,
            trunc (98.7654, -1) T3, 
            trunc (98.7654, -2) T4 
from dual ; 

-- MOD   :   ������ ���� ���  , MOD ( ����1, ����2 ) 
-- TRUNC : �� �� ��� �Ҷ� 
select MOD ( 3, 2 ),            -- ������ 
            TRUNC ( 31 / 2 )        -- �� ���       
from dual ; 


-- ��¥�Լ� 
        --sysdate : ���� �ý����� ��¥
        -- months_between : �� ��¥ ������ ���� �� �� ���
        -- add_months : Ư����¥���� ���� �� �� ���ؼ� ���
        -- next_day : Ư�� ��¥���� ������ �����ϴ� ������ ���ڷ� �޾Ƽ� �����ϴ� ��¥�� ���
        -- last_day :  ���� ������ ��¥�� ���
        -- round(��¥) : 15�� �̻� �ݿø� ,15�� ���� ����
        -- trunc(��¥) : ��¥�� �߶󳻴� �Լ�
        
        
select sysdate from dual; --23/12/07

--��¥�� ������ ����
select sysdate -1 ������¥ ,  sysdate +1 ���ó�¥
from dual;
-- ���ÿ��� 100 �� �� ��¥, 1000�� �� ��¥
select sysdate -100 "100������¥" ,  sysdate +1000 "1000���ĳ�¥"
from dual;


-- �Ի��� ���� ���� ���� �� �ٹ��ϼ��� ���� , date Ÿ�� �÷�,  trunc( sysdate - hiredate)
select ename �̸� ,trunc( sysdate - hiredate )�ѱٹ��ϼ� -- trunc �Ҽ��� �Ʒ��ڸ� �߶�
from employee;


-- �Ի��Ͽ��� 1000�� ������ ��¥
select ename �̸� ,( hiredate  + 1000 ) as "1000�� ��"
from employee;

-- Ư�� ��¥���� ���� �������� ��� : TRUNC(��¥,'MONTH'), ROUND(��¥,'MONTH')
select hiredate ������¥, TRUNC(hiredate,'MONTH'), ROUND(hiredate,'MONTH') from employee;

-- ���������  �ٹ� �������� ���: month_between(��¥,��¥)  : �� ��¥ ������ ������ ���
select ename �̸� , hiredate �Ի糯¥, trunc(months_between(sysdate , hiredate)) from employee;

-- ���ó�¥���� 100���� ������ ��¥ (add_months) , 100�� ���� ��¥
-- �÷��� DATE Ÿ���� �� ����

select sysdate ���ó�¥ , add_months(sysdate,100) "100���� ��" , sysdate + 100 "100�� ��" from dual;

--last_day  : �� ��¥�� ������ ��¥�� �����
select last_day(sysdate)from dual;

--��� ����� �Ի��� ���� ������ ��¥�� �������� ���
select hiredate �Ի糯¥ , last_day(hiredate)��������¥ from employee;



-- ���� ��ȯ �Լ�
    -- TO_CHAR : ��¥,���� ===> ������
    -- TO_DATE : ���� ===> ��¥
    -- TO_NUMBER : ���� ===> ����
select sysdate ���ó�¥ from dual;

-- TO_CHAR  ��¥ --> ����
--YYYY :�⵵ ,MM , MON: �� , DD: ��, HH : ��, MI: ��, SS : ��  DAY  :  ���� , DY ����(�����)
select TO_CHAR (sysdate,'YYYY-MM-DD HH:MI:SS') from dual;  --'YYYYMMDD' ���� ����

select To_char (hiredate, 'YYYY-MM-DD HH:MI:SS') "�Ի糯¥2"
from employee; 
select TO_CHAR (sysdate,'YYYY"��"MM-DD MON DAY  DY HH:MI:SS') from dual; 

-- TO_CHAR ���� --->  ����
 -- 0 : �ڸ����� ó���� , �ڸ����� ������ 0 ���� ó����
 -- 9 : �ڸ����� ó���� , �ڸ����� ������ �������� ó����
 -- L : �� ������ ��ȭ�� ��ȣ�� ǥ����
 
    -- . : �Ҽ������� ó����
    -- , : õ���� ������
    
select TO_Char ( 9876, 'L000,000') from dual;
select TO_Char ( 9876, '999,999') from dual;

-- ������ �� ������ ��ȭ ��Ȥ���� ��� 1000 ������ ���

select salary ���� , TO_CHAR(salary,'L999,999')"���� (�ѱ� ��ȭ)"
from employee;

-- TO_DATE  : ����, ���� ==> ��¥

select to_DATE ('1998-10-10','YYYY-MM-DD')from dual; --  ���������� �ĺ� (���¸� �Ȱ��� ���缭 ����) �� ��ȯ
select to_DATE ('1998 10��-10','YYYY MON-DD')from dual;
-- 1981 �� 01�� 01�� ���� 100��,100����(add_months)���������� ��¥ 
select to_date('1981 - 01 - 01', 'YYYY - MM - DD')���س�¥ , to_date('1981 - 01 - 01', 'YYYY - MM - DD') + 100 "100����" , add_months( to_date('1981 - 01 - 01', 'YYYY - MM - DD') ,100 ) "100������"
from dual;

select to_date( 770814,'YYMMDD') from dual;

-- �ڽ��� ���Ͽ��� ������� ��� ��Ҵ��� <== months_btewwn, ���� ��Ҵ��� ��� 
select to_date( 20040604,'YYYYMMDD')����
,trunc(sysdate - to_date( 20040604,'YYYYMMDD')) ��
,trunc(months_between(sysdate,to_date( 20040604,'YYYYMMDD'))) ����
from dual;

-- employee ���̺��� 2050�� 12�� 24�� ���� �� �ϼ� �� ���
