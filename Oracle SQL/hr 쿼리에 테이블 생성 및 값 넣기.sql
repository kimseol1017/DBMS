/*
    CRUD
        Create : ����
        Resd : �˻�
        Update : ����
        Delete : ����
*/

--������ ���̺� ���� : create

create Table  member ( --member ���̺�
    idx number not null ,  --idx �� number(����) �ڷ������� �ְڴٴ� ��
    name varchar2(50) not null, --name �� ���ڿ� not null �� ������ ���� �־�� ��
    id varchar(50) not null,
    pw varchar(50) not null,
    addr varchar(50) null
    );
    
    --�˻� : select
select * from member ;

-- �Է� : ���̺� ���� ����.
insert into member ( idx, name, id, pw ,addr)
values (1, 'ȫ�浿' , 'pqq','1234','����');
commit; --DB�� ������ ����

insert into member ( idx, name, id, pw ,addr)
values (2, '��浿' , 'pq1q','1234','�λ�');
commit; --DB�� ������ ����

insert into member ( idx, name, id, pw ,addr)
values (1, '��巹��' , 'sam','1234','����');
commit; --DB�� ������ ����



-- hr3 ��������, hr3 �������� ���� �� ������̺� ���� �� ���ڵ� 2�� �ֱ�

