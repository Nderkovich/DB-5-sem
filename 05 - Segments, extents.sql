--1. ������ ���� ��������� �����������
select tablespace_name, contents from DBA_TABLESPACES;

--2. ������� ����.��-��
create tablespace CJA_QDATA
  datafile 'D:\3\��\5\CJA_QDATA.dbf'
  size 10 M
  offline;

 --���������� ��-�� � ���� online 
alter tablespace CJA_QDATA online;


--���� ���� (����� ���� �����, �-�� ���� ����� �����)
create role myrole;
grant create session,
      create table, 
      create view, 
      create procedure,
      drop any table,
      drop any view,
      drop any procedure to myrole;    
grant create session to myrole;
commit;


--���� �������
create profile myprofile limit
    password_life_time 180      --���-�� ���� ����� ������
    sessions_per_user 3         --���-�� ������ ��� �����
    failed_login_attempts 7     --���-�� ������� �����
    password_lock_time 1        --���-�� ���� ����� ����� ������
    password_reuse_time 10      --����� ���� ���� ����� ��������� ������
    password_grace_time default --���-�� ���� ����������.� ����� ������
    connect_time 180            --����� ���� (���)
    idle_time 30 ;              --���-�� ��� ������� 


--���� �����
create user CJA identified by 1111
default tablespace CJA_QDATA quota unlimited on CJA_QDATA
profile myprofile
account unlock;


--����� ����� ����� 2� � CJA_QDATA
alter user CJA quota 2 m on CJA_QDATA;
grant myrole to CJA;


--�� ����� ����� CJA(1111) � CJA_QDATA ���� ������� CJA_T1
--Connection...
--lr5
create table CJA_T1(
id number(15) PRIMARY KEY,
name varchar2(10))
tablespace CJA_QDATA;

insert into CJA_T1 values(1, 'BAZ');
insert into CJA_T1 values(2, 'IBS');
insert into CJA_T1 values(3, 'SRG');



--3. ������ ��������� ����.��-�� CJA_QDATA
--cja
select segment_name, segment_type from DBA_SEGMENTS where tablespace_name='CJA_QDATA';


--4.
--lr5 (������� �������)
drop table CJA_T1;
--cja (������ ���������)
select segment_name from DBA_SEGMENTS where tablespace_name='CJA_QDATA';
--lr5 (������ � ������)
select * from user_recyclebin;


--lr5

--5. ������������ ����.����
flashback table CJA_T1 to before drop;

--6. ��������� PL/SQL-������, ������ CJA_T1 10000 �����
BEGIN
  FOR k IN 4..10004
  LOOP
    insert into CJA_T1 values(k, 'A');
  END LOOP;
  COMMIT;
END;
commit;


--cja       !!!

--7. �����.������� � �������� CJA_T1 ���������, �� ������
select extent_id, blocks, bytes from DBA_EXTENTS where SEGMENT_NAME='CJA_T1';


--8. ������� CJA_QDATA � ��� ����
drop tablespace CJA_QDATA including contents and datafiles;

--9.�������� �������� ���� �������� ������� + ��� �������
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;

--10.�������� ������ ������� ������� ��������
SELECT * FROM V$LOGFILE;


--12. ������� ������ �������� ������� � 3 ������� �������
alter database add logfile group 4 'D:\app\USER\oradata\orcl\REDO04.LOG' 
                                                size 50 m blocksize 512;
alter database add logfile member 'D:\app\USER\oradata\orcl\REDO041.LOG'  to group 4;
alter database add logfile member 'D:\app\USER\oradata\orcl\REDO042.LOG'  to group 4;

SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;


--11. ������ ���� ������������ �������� 
ALTER SYSTEM SWITCH LOGFILE;
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;


--13. ������� ��������� ������ �������� �������
alter database clear logfile group 4;
alter database drop logfile group 4;
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;


--14. ���������, ��� ������������� �� ����������� (stopped)
SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;


--�������� �������������
--sql plus
--connect /as sysdba
--shutdown immediate;
--startup mount;
--alter database archivelog;
--alter database open;

--
SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;
--select * from V$LOG;

--���� �������� ����
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=D:\app\USER\oradata\orcl\archive'

ALTER SYSTEM SWITCH LOGFILE;
SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

--���� �������������
--shutdown immediate;
--startup mount;
--alter database noarchivelog;
--select name, log_mode from v$database;
--alter database open;


--�������� ������ ���-��� ������
select name from v$controlfile;

--�������� ���������� ���-���� �����
show parameter control;

--��� ����� ����� ���������� ��������
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
show parameter spfile ;

--���� PFILE, ������ ����������
--CREATE PFILE='user_pf.ora' FROM SPFILE;
--�������� � ����� D:\app\USER\product\11.2.0\dbhome_2\database


--��� ����� ����� �������, ����������
SELECT * FROM V$PWFILE_USERS;
SELECT * FROM V$DIAG_INFO;
show parameter remote_login_passwordfile;
