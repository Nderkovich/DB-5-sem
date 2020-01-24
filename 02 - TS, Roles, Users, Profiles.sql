--1. созд табл.пр-во для пост д-х
create tablespace TS_CJA
  datafile 'D:\3\БД\2\TS_CJA.dbf'  --имя
  size 7m                       --нач размер
  autoextend on next 5m         --авто приращение
  maxsize 20m;                  --макс размер
  
  
--2. созд табл.пр-во для времен д-х
create temporary tablespace TS_CJA_TEMP
  tempfile 'D:\3\БД\2\TS_CJA_TEMP.dbf'
  size 5m
  autoextend on next 3m
  maxsize 30m;
  
  
--3. все табл пр-ва + все файлы
--select запрос к словарю
select TABLESPACE_NAME, contents logging from SYS.DBA_TABLESPACES;


--4. созд роль (разреш соед с сервером + созд и удал табл, предст, процедуры, ф-ции)
create role RL_CJACORE;
commit;
grant create session, create table, create view, create procedure to RL_CJACORE;
grant drop any table, drop any view, drop any procedure to RL_CJACORE;


--5. найти в словаре роль, все сист. привилегии и роли
select * from DBA_ROLES where role='RL_CJACORE';
select * from DBA_SYS_PRIVS where grantee='RL_CJACORE';


--6. созд профиль безоп. (опции как в лекции)
create profile PF_CJACORE limit
  password_life_time 180        --кол-во дней жизни пароля
  sessions_per_user 3           --кол-во сессий для юзера
  failed_login_attempts 7       --кол-во попыток входа
  password_lock_time 1          --кол-во дней блокирования после ошибки
  password_reuse_time 10        --через ск дней можно повторить пароль
  password_grace_time default   --кол-во дней предупреждений о смене пароля
  connect_time 180              --время соед в мин
  idle_time 30;                 --кол-во минут простоя


--7. список профилей + параметры моего профиля + параметры default
select * from DBA_PROFILES;
select * from DBA_PROFILES where profile='PF_CJACORE';  
select * from DBA_PROFILES where profile='DEFAULT';


--8. созд юзера
create user CJACORE identified by 1111
  default tablespace TS_CJA         --тп по умолч
        quota unlimited on TS_CJA   --бескон квота
  temporary tablespace TS_CJA_TEMP  --тп для врем. д-х
  profile PF_CJACORE                --профиль безоп
  account unlock                    --уч.запись разблок
  password expire;                  --срок пароля истек

grant RL_CJACORE to CJACORE;
grant CREATE TABLESPACE, ALTER TABLESPACE to CJACORE;

--9. sql plus
--CJACORE -> 1111 -> 12345678 ->12345678



--10. созд соединение для CJACORE
--созд таблицу и представление

--CJACORE
create tablespace CJAQDATA OFFLINE
  datafile 'D:\3\БД\2\CJA_QDATA.txt'
  size 10M reuse
  autoextend on next 5M
  maxsize 20M;

--перевести в сост.online
alter tablespace CJAQDATA online;

--выделить польз.квоту 2м в тс CJAQDATA         CJA!!!
ALTER USER CJACORE QUOTA 2M ON CJAQDATA;

--создать таблицу и добавить в нее 3 строки.
CREATE TABLE t (c NUMBER);

INSERT INTO t(c) VALUES(3);
INSERT INTO t(c) VALUES(1);
INSERT INTO t(c) VALUES(2);

SELECT * FROM t;

