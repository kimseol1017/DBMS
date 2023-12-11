create user C##Shoppging_DB IDENTIFIED BY 1234
default tablespace USERS
temporary tablespace TEMP;

grant resource , connect to  C##Shoppging_DB

ALTER USER C##Shoppging_DB quota unlimited on USERS;

create user C##Shoppging_DBre IDENTIFIED BY 1234
default tablespace USERS
temporary tablespace TEMP;

grant resource , connect to  C##Shoppging_DBre

ALTER USER C##Shoppging_DBre quota unlimited on USERS;