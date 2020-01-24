--1. список всех PDB в рамках ORA12W
select name,open_mode from v$pdbs; 

--2.получить перечень экземпляров
select INSTANCE_NAME from v$instance;


--3.перечень установл.компонент + версии и статус
select * from PRODUCT_COMPONENT_VERSION;

--4. создать собств.экземпляр (CJA_PDB)
--ORACLE DATABASE CONFIGURATION ASSISTANT (screenshot)

--5. получ.список всех сущ-щих PDB в рамках ORA12W + наша сущ-ет
select name,open_mode from v$pdbs;



--6. подключ.с пом.Developer + создать инфраструкт.объеткы
--LR4 -> PROP
CREATE TABLESPACE TS_CJA
DATAFILE 'D:\БГТУ\3 курс\5 семестр\БД\лабы\4\TS_CJA.dbf' 
size 7M
AUTOEXTEND ON NEXT 5M 
MAXSIZE 20M
LOGGING
ONLINE;
commit;

select TABLESPACE_NAME, BLOCK_SIZE, MAX_SIZE from sys.dba_tablespaces order by tablespace_name;

CREATE TEMPORARY TABLESPACE TS_CJA_TEMP_1
TEMPFILE 'D:\БГТУ\3 курс\5 семестр\БД\лабы\4\TS_CJA_TEMP1.dbf' size 5M
AUTOEXTEND ON NEXT 3M 
MAXSIZE 30M;
commit;

--alter session set "_ORACLE_SCRIPT"=true;
create role RL_CJA;
commit;

GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE PROCEDURE TO  RL_CJA;

create profile PF_CJA limit
password_life_time 180 -- кол-во дней жизни пароля
sessions_per_user 3 -- кол-во сессий для пользователя
FAILED_LOGIN_ATTEMPTS 7 -- кол-во попыток входа
PASSWORD_LOCK_TIME 1 -- кол-во дней блокировки после ошибки
PASSWORD_Reuse_time 10 -- через сколько дней можно повторить пароль
password_grace_time default -- кол-во дней предупреждения о смене пароля
connect_time 180 -- время соединения
idle_time 30; -- простой
commit;


create user U1_CJA_PDB identified by 12345678
default tablespace TS_CJA quota unlimited on TS_CJA
profile PF_CJA
account unlock;

grant RL_CJA to U1_CJA_PDB;
commit;

--8
select * from ALL_USERS;  --все пользователи
select * from DBA_TABLESPACES;  --все таб. простр
select * from DBA_DATA_FILES;   --перман данные 
select * from DBA_TEMP_FILES;  --времен данные
select * from DBA_ROLES; --роли
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;  --привилег
select * from DBA_PROFILES;  --профил без.

--9
create user C##CJA identified by 12345678
account unlock;
grant create session to  C##CJA

select * from v$session where USERNAME is not null;
