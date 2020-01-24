--1. определить общий размер область SGA
select sum(value) from v$sga;

--2.определить текущие размеры основных пулов SGA
select * from v$sga_dynamic_components where current_size > 0;

--3.определить гранулы дл€ каждого пула
select component, granule_size from v$sga_dynamic_components where current_size > 0;

--4.определить объем доступной свободной пам€ти в SGA
select current_size from v$sga_dynamic_free_memory;

--5.определить размеры пулов KEEP, DEFAULT, RECYCLE буферного кэша
select component, current_size, min_size from v$sga_dynamic_components where component ='KEEP buffer cache' or component = 'DEFAULT buffer cache' or component = 'RECYCLE buffer cache';

--6.создайте таблицу, котора€ будет помешатьс€ в пул KEEP. продемонстрируйте сегмент таблицы
create table Mytable(x int) storage(buffer_pool keep);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where lower(segment_name)='mytable';

--7.создайте таблицу, котора€ будет кэшироватьс€ в пуле default. ѕродемонстрировать семент таблицы
create table Mytable2(x int) cache storage(buffer_pool default);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where lower(segment_name)='mytable2';

--8.найдите размер буфера журналов повтора
show parameter log_buffer;

--9.найти 10 самых больших объектов в раздел€емом пуле
select *from (select pool, name, bytes from v$sgastat where pool = 'shared pool' order by bytes desc) where rownum <=10;

--10. найдите размер свободной пам€ти в большом пуле
select pool, name, bytes from v$sgastat where pool = 'large pool' and name = 'free memory';

--11.получить перечень текущих соединений с инстансом
select * from v$session;

--12. определите режимы текущих оединений с инстансом
select username, server from v$session;

