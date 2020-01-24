
GRANT CREATE DATABASE LINK TO CJACORE;
GRANT CREATE PUBLIC DATABASE LINK TO CJACORE;

drop database link con1;

CREATE DATABASE LINK con1
  CONNECT TO KNV_USER
  IDENTIFIED BY natasha   --пароль
  USING 'DESKTOP-4K3JN12:1521/orcl';        --сетевое имя удал. БД
  
    select * from B@con1;
    insert into B@con1 values(4,'UMPA');
    update B@con1 set NAME='BIS' where id=2;
    delete B@con1 where ID=4;
    begin
    dbms_output.put_line(TEACHERSS.GET_NUM_TEACHERS@con1('ИДиП'));
    end;
    

select * from dba_db_links;
drop public database link con2;


CREATE PUBLIC DATABASE LINK con2
  CONNECT TO KNV_USER
  IDENTIFIED BY natasha   
  USING 'DESKTOP-4K3JN12:1521/orcl';
 
    select * from B@con2;
    insert into B@con2 values(4,'UMPA');
    update B@con2 set NAME='LUKA' where id=4;
    delete B@con2 where ID=4;
    begin
    dbms_output.put_line(TEACHERSS.GET_NUM_TEACHERS@con2('ИДиП'));
    end;
    

