-- ��������

create user C##hr identified by 1234
default tablespace USERS
temporary tablespace TEMP;

--���� �ο�
grant resource,connect to C##hr

--���̺� �����̽� ��뷮 �Ҵ�
alter user C##hr quota unlimited on USERS;


create user C##hr2 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

--���� �ο�
grant resource,connect to C##hr2
grant create view to C##hr;

--���̺� �����̽� ��뷮 �Ҵ�
alter user C##hr2 quota unlimited on USERS;

--�������� �׽�Ʈ 
drop user C##hr2

create user C##hr3 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

grant resource,connect to C##hr3

alter user C##hr3 quota unlimited on USERS;

create user C##hr4 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

grant resource,connect to C##hr4

alter user C##hr4 quota unlimited on USERS;

drop user C##hr4 cascade
/*
    CRUD
        Create : ����
        Resd : �˻�
        Update : ����
        Delete : ����
*/