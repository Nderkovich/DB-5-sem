
ALTER SESSION SET nls_date_format='dd-mm-yyyy hh24:mi:ss';

GRANT CREATE TABLESPACE TO CJACORE;
ALTER USER CJACORE QUOTA UNLIMITED ON t1;
ALTER USER CJACORE QUOTA UNLIMITED ON t2;
ALTER USER CJACORE QUOTA UNLIMITED ON t3;
ALTER USER CJACORE QUOTA UNLIMITED ON t4;
GRANT ALTER ANY TABLESPACE TO CJACORE;


CREATE TABLESPACE t1 DATAFILE 'D:\3\БД\16\t1.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;
CREATE TABLESPACE t2 DATAFILE 'D:\3\БД\16\t2.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;  
CREATE TABLESPACE t3 DATAFILE 'D:\3\БД\16\t3.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;  
CREATE TABLESPACE t4 DATAFILE 'D:\3\БД\16\t4.DAT'
  SIZE 10M REUSE AUTOEXTEND ON NEXT 2M MAXSIZE 20M;


--1.------------------ T _ R A N G E ------------------------------------

    create table T_Range( id number, time_id date)
    partition by range(id)
    (
    Partition p1 values less than (100) tablespace t1,
    Partition p2 values less than (200) tablespace t2,
    Partition p3 values less than (300) tablespace t3,
    Partition pmax values less than (maxvalue) tablespace t4
    );
    
    insert into T_range(id, time_id) values(50,'01-02-2018');
    insert into T_range(id, time_id) values(105,'01-02-2017');
    insert into T_range(id, time_id) values(205,'01-02-2016');
    insert into T_range(id, time_id) values(305,'01-02-2015');
    insert into T_range(id, time_id) values(405,'01-02-2015');
    
    
    select * from T_range partition(p1);
    select * from T_range partition(p2);
    select * from T_range partition(p3);
    select * from T_range partition(pmax);
    --select * from T_range partition(p5);



--2.------------------ T _ I N T E R V A L ------------------------------------
 
    create table T_Interval(id number, time_id date)
    partition by range(time_id)
    interval (numtoyminterval(1,'month'))
    (
    partition p0 values less than  (to_date ('1-12-2009', 'dd-mm-yyyy')),
    partition p1 values less than  (to_date ('1-12-2015', 'dd-mm-yyyy')),
    partition p2 values less than  (to_date ('1-12-2018', 'dd-mm-yyyy'))
    );
    
    insert into T_Interval(id, time_id) values(50,'01-02-2008');
    insert into T_Interval(id, time_id) values(105,'01-01-2009');
    insert into T_Interval(id, time_id) values(105,'01-01-2014');
    insert into T_Interval(id, time_id) values(205,'01-01-2015');
    insert into T_Interval(id, time_id) values(305,'01-01-2016');
    insert into T_Interval(id, time_id) values(405,'01-01-2018');
    insert into T_Interval(id, time_id) values(505,'01-01-2019');
    
    select * from T_Interval partition(p0)
    select * from T_Interval partition(p1)
    select * from T_Interval partition(p2)



--3.------------------- T _ H A S H ------------------------------------

    create table T_hash (str varchar2 (50), id number)
    partition by hash (str)
    (partition k1 tablespace t1,
    partition k2 tablespace t2,
    partition k3 tablespace t3,
    partition k4 tablespace t4
    );
    
    insert into T_hash (str,id) values('asdssawesd', 1);
    insert into T_hash (str,id) values('gxdghghffdh', 2);
    insert into T_hash (str,id) values('/.....,,,,', 3);
    insert into T_hash (str,id) values('oiouuuoiu', 4);
    insert into T_hash (str,id) values('a', 7);
    
    select * from T_hash partition(k1)
    select * from T_hash partition(k2)
    select * from T_hash partition(k3)
    select * from T_hash partition(k4)



--4.------------------ T _ L I S T ------------------------------------

    create table T_list(obj char(3))
    partition by list (obj)
    (
    partition p1 values ('a'),
    partition p2 values ('b'),
    partition p3 values ('c')
    );
    insert into  T_list(obj) values('a' );
    insert into  T_list(obj) values('b' );
    insert into  T_list(obj) values('c' );
    insert into  T_list(obj) values('d' );
    
    select * from T_list partition (p1);
    select * from T_list partition (p2);
    select * from T_list partition (p3);
---------------------------------------------------------------------------------
--6. Покаж процесс перемещ строк м/секциями при UPDATE ключа
    alter table T_list enable row movement;
    update T_list
    set obj='a' where obj='b';

--7. ALTER TABLE MERGE
    alter table t_range merge partitions
    p1,p2 into partition p5;

--9. ALTER TABLE EXCHANGE
    create table T_list1(obj char(3));
    alter table T_list exchange partition  p3 
        with table T_list1 without validation;
    select * from T_list partition (p3);
    select * from T_list1;

--8. ALTER RABLE SPLIT
    alter table t_interval split partition p2 at (to_date ('1-06-2018', 'dd-mm-yyyy')) 
    into (partition p6 tablespace t4, partition p5 tablespace t2);
    
    select * from t_interval partition (p5);
    select * from t_interval partition (p6);

drop table T_RANGE;
drop table T_INTERVAL;
drop table T_HASH;
drop table T_LIST;
drop table T_LIST1;
