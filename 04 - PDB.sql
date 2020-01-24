--1. ������ ���� PDB � ������ ORA12W
select name,open_mode from v$pdbs; 

--2.�������� �������� �����������
select INSTANCE_NAME from v$instance;


--3.�������� ��������.��������� + ������ � ������
select * from PRODUCT_COMPONENT_VERSION;

--4. ������� ������.��������� (CJA_PDB)
--ORACLE DATABASE CONFIGURATION ASSISTANT (screenshot)

--5. �����.������ ���� ���-��� PDB � ������ ORA12W + ���� ���-��
select name,open_mode from v$pdbs;



--6. �������.� ���.Developer + ������� �����������.�������
--LR4 -> PROP
CREATE TABLESPACE TS_CJA
DATAFILE 'D:\����\3 ����\5 �������\��\����\4\TS_CJA.dbf' 
size 7M
AUTOEXTEND ON NEXT 5M 
MAXSIZE 20M
LOGGING
ONLINE;
commit;

select TABLESPACE_NAME, BLOCK_SIZE, MAX_SIZE from sys.dba_tablespaces order by tablespace_name;

CREATE TEMPORARY TABLESPACE TS_CJA_TEMP_1
TEMPFILE 'D:\����\3 ����\5 �������\��\����\4\TS_CJA_TEMP1.dbf' size 5M
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
password_life_time 180 -- ���-�� ���� ����� ������
sessions_per_user 3 -- ���-�� ������ ��� ������������
FAILED_LOGIN_ATTEMPTS 7 -- ���-�� ������� �����
PASSWORD_LOCK_TIME 1 -- ���-�� ���� ���������� ����� ������
PASSWORD_Reuse_time 10 -- ����� ������� ���� ����� ��������� ������
password_grace_time default -- ���-�� ���� �������������� � ����� ������
connect_time 180 -- ����� ����������
idle_time 30; -- �������
commit;


create user U1_CJA_PDB identified by 12345678
default tablespace TS_CJA quota unlimited on TS_CJA
profile PF_CJA
account unlock;

grant RL_CJA to U1_CJA_PDB;
commit;

--8
select * from ALL_USERS;  --��� ������������
select * from DBA_TABLESPACES;  --��� ���. ������
select * from DBA_DATA_FILES;   --������ ������ 
select * from DBA_TEMP_FILES;  --������ ������
select * from DBA_ROLES; --����
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;  --��������
select * from DBA_PROFILES;  --������ ���.

--9
create user C##CJA identified by 12345678
account unlock;
grant create session to  C##CJA

select * from v$session where USERNAME is not null;
