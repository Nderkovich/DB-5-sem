--1. список всех табличных пространств
select tablespace_name, contents from DBA_TABLESPACES;

--2. создать табл.пр-во
create tablespace CJA_QDATA
  datafile 'D:\3\БД\5\CJA_QDATA.dbf'
  size 10 M
  offline;

 --переведите пр-во в сост online 
alter tablespace CJA_QDATA online;


--созд роль (чтобы дать юзеру, к-му надо выдел квоту)
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


--созд профиль
create profile myprofile limit
    password_life_time 180      --кол-во дней жизни пароля
    sessions_per_user 3         --кол-во сессий для юзера
    failed_login_attempts 7     --кол-во попыток ввода
    password_lock_time 1        --кол-во дней блока после ошибок
    password_reuse_time 10      --через скок дней можно повторить пароль
    password_grace_time default --кол-во дней предупрежд.о смене пароля
    connect_time 180            --время соед (мин)
    idle_time 30 ;              --кол-во мин простоя 


--созд юзера
create user CJA identified by 1111
default tablespace CJA_QDATA quota unlimited on CJA_QDATA
profile myprofile
account unlock;


--выдел юзеру квоту 2м в CJA_QDATA
alter user CJA quota 2 m on CJA_QDATA;
grant myrole to CJA;


--от имени юзера CJA(1111) в CJA_QDATA созд таблицу CJA_T1
--Connection...
--lr5
create table CJA_T1(
id number(15) PRIMARY KEY,
name varchar2(10))
tablespace CJA_QDATA;

insert into CJA_T1 values(1, 'BAZ');
insert into CJA_T1 values(2, 'IBS');
insert into CJA_T1 values(3, 'SRG');



--3. список сегментов табл.пр-ва CJA_QDATA
--cja
select segment_name, segment_type from DBA_SEGMENTS where tablespace_name='CJA_QDATA';


--4.
--lr5 (удалить таблицу)
drop table CJA_T1;
--cja (список сегментов)
select segment_name from DBA_SEGMENTS where tablespace_name='CJA_QDATA';
--lr5 (запрос к предст)
select * from user_recyclebin;


--lr5

--5. восстановить удал.табл
flashback table CJA_T1 to before drop;

--6. выполнить PL/SQL-скрипт, заполн CJA_T1 10000 строк
BEGIN
  FOR k IN 4..10004
  LOOP
    insert into CJA_T1 values(k, 'A');
  END LOOP;
  COMMIT;
END;
commit;


--cja       !!!

--7. опред.сколько в сегменте CJA_T1 экстентов, из размер
select extent_id, blocks, bytes from DBA_EXTENTS where SEGMENT_NAME='CJA_T1';


--8. удалить CJA_QDATA и его файл
drop tablespace CJA_QDATA including contents and datafiles;

--9.получить перечень груп журналов повтора + опр текущую
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;

--10.перечень файлов журнала повтора инстанса
SELECT * FROM V$LOGFILE;


--12. создать группу журналов повтора с 3 файламя журнала
alter database add logfile group 4 'D:\app\USER\oradata\orcl\REDO04.LOG' 
                                                size 50 m blocksize 512;
alter database add logfile member 'D:\app\USER\oradata\orcl\REDO041.LOG'  to group 4;
alter database add logfile member 'D:\app\USER\oradata\orcl\REDO042.LOG'  to group 4;

SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;


--11. полный цикл переключений журналов 
ALTER SYSTEM SWITCH LOGFILE;
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;


--13. удалить созданную группу журналов повтора
alter database clear logfile group 4;
alter database drop logfile group 4;
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;


--14. убедитесь, что архимирование не выполняется (stopped)
SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;


--включить архивирование
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

--созд архивный файл
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=D:\app\USER\oradata\orcl\archive'

ALTER SYSTEM SWITCH LOGFILE;
SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

--откл архивирование
--shutdown immediate;
--startup mount;
--alter database noarchivelog;
--select name, log_mode from v$database;
--alter database open;


--получить список упр-щих файлов
select name from v$controlfile;

--получите содержимое упр-щего файла
show parameter control;

--опр место файла параметров инстанса
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
show parameter spfile ;

--созд PFILE, исслед содержимео
--CREATE PFILE='user_pf.ora' FROM SPFILE;
--показать в папке D:\app\USER\product\11.2.0\dbhome_2\database


--опр место файла паролей, содержимое
SELECT * FROM V$PWFILE_USERS;
SELECT * FROM V$DIAG_INFO;
show parameter remote_login_passwordfile;
