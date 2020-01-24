--1. ���� ����.��-�� ��� ���� �-�
create tablespace TS_CJA
  datafile 'D:\3\��\2\TS_CJA.dbf'  --���
  size 7m                       --��� ������
  autoextend on next 5m         --���� ����������
  maxsize 20m;                  --���� ������
  
  
--2. ���� ����.��-�� ��� ������ �-�
create temporary tablespace TS_CJA_TEMP
  tempfile 'D:\3\��\2\TS_CJA_TEMP.dbf'
  size 5m
  autoextend on next 3m
  maxsize 30m;
  
  
--3. ��� ���� ��-�� + ��� �����
--select ������ � �������
select TABLESPACE_NAME, contents logging from SYS.DBA_TABLESPACES;


--4. ���� ���� (������ ���� � �������� + ���� � ���� ����, ������, ���������, �-���)
create role RL_CJACORE;
commit;
grant create session, create table, create view, create procedure to RL_CJACORE;
grant drop any table, drop any view, drop any procedure to RL_CJACORE;


--5. ����� � ������� ����, ��� ����. ���������� � ����
select * from DBA_ROLES where role='RL_CJACORE';
select * from DBA_SYS_PRIVS where grantee='RL_CJACORE';


--6. ���� ������� �����. (����� ��� � ������)
create profile PF_CJACORE limit
  password_life_time 180        --���-�� ���� ����� ������
  sessions_per_user 3           --���-�� ������ ��� �����
  failed_login_attempts 7       --���-�� ������� �����
  password_lock_time 1          --���-�� ���� ������������ ����� ������
  password_reuse_time 10        --����� �� ���� ����� ��������� ������
  password_grace_time default   --���-�� ���� �������������� � ����� ������
  connect_time 180              --����� ���� � ���
  idle_time 30;                 --���-�� ����� �������


--7. ������ �������� + ��������� ����� ������� + ��������� default
select * from DBA_PROFILES;
select * from DBA_PROFILES where profile='PF_CJACORE';  
select * from DBA_PROFILES where profile='DEFAULT';


--8. ���� �����
create user CJACORE identified by 1111
  default tablespace TS_CJA         --�� �� �����
        quota unlimited on TS_CJA   --������ �����
  temporary tablespace TS_CJA_TEMP  --�� ��� ����. �-�
  profile PF_CJACORE                --������� �����
  account unlock                    --��.������ �������
  password expire;                  --���� ������ �����

grant RL_CJACORE to CJACORE;
grant CREATE TABLESPACE, ALTER TABLESPACE to CJACORE;

--9. sql plus
--CJACORE -> 1111 -> 12345678 ->12345678



--10. ���� ���������� ��� CJACORE
--���� ������� � �������������

--CJACORE
create tablespace CJAQDATA OFFLINE
  datafile 'D:\3\��\2\CJA_QDATA.txt'
  size 10M reuse
  autoextend on next 5M
  maxsize 20M;

--��������� � ����.online
alter tablespace CJAQDATA online;

--�������� �����.����� 2� � �� CJAQDATA         CJA!!!
ALTER USER CJACORE QUOTA 2M ON CJAQDATA;

--������� ������� � �������� � ��� 3 ������.
CREATE TABLE t (c NUMBER);

INSERT INTO t(c) VALUES(3);
INSERT INTO t(c) VALUES(1);
INSERT INTO t(c) VALUES(2);

SELECT * FROM t;

