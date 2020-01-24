--1. полный список фоновых процессов
select name, description from v$bgprocess order by 1;

--2.	Определите фоновые процессы, которые запущены и работают в настоящий момент.
SELECT *FROM v$process ; 

--3.	Определите, сколько процессов DBWn работает в настоящий момент.
show parameter db_writer_processes;

--4. перечень текущих соединений с экземпляром.
SELECT * FROM V$INSTANCE;

--5.	Определите сервисы.
select * from V$SERVICES ;  

--6.	Получите известные вам параметры диспетчера и их значений.
SELECT * FROM V$DISPATCHER;
show parameter DISPATCHERS;

--7.	Получите перечень текущих соединений с инстансом. (dedicated, shared). 
SELECT USERNAME,SERVER FROM V$SESSION;

--8.	Продемонстрируйте и поясните содержимое файла LISTENER.ORA. 
--D:\app\ora_natasha\product\12.1.0\dbhome_1\NETWORK\ADMIN

--9-10.	Запустите утилиту lsnrctl и поясните ее основные команды. 
--Получите список служб инстанса, обслуживаемых процессом LISTENER. 
--lsnrctl status, start, stop

