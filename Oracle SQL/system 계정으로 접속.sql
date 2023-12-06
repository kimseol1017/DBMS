create user C##hr identified by 1234
default tablespace USERS
temporary tablespace TEMP;

grant resource , connect to C##hr

alter user C##hr quota unlimited on USERS;

