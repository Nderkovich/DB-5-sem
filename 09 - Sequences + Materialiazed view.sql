--1. ������ ����� ����������� �����
grant create session to CJACORE;
grant create table to CJACORE;
grant create view to CJACORE;
grant create any sequence to CJACORE;
grant select any sequence to CJACORE;
grant create cluster to CJACORE;
grant create public synonym to CJACORE;
grant create synonym to CJACORE;
grant create materialized view to CJACORE;
grant drop public synonym to CJACORE;
alter user CJACORE quota unlimited on users;

--CJACORE
--2. ���� sequence (S1):
create sequence CJACORE.S1
    increment by 10
    start with 1000
    nomaxvalue
    nominvalue
    nocycle
    nocache
    noorder;
    -- �������� ����. �������� ����-���
    select S1.nextval from dual;    -- +10
    -- �������� ���. �������� ����-���
    select S1.currval from dual;

--3. ���� sequence (S2):
create sequence CJACORE.S2
    increment by 10
    start with 10
    maxvalue 100
    nocycle;
    -- �������� ��� �������� ����-���
    select S2.nextval from dual;
    -- �������� ��������, ���. �� ����
    alter sequence S2 increment by 90;
    select S2.nextval from dual;    --x2
    alter sequence S2 increment by 10;

--5. ���� sequence (S3):
create sequence CJACORE.S3
    increment by -10
    start with 10
    maxvalue 20
    minvalue -100
    nocycle
    order;
    -- ����� ��� �������� ����-���
    select S3.nextval from dual;
    -- �������� �������� ������ min
    alter sequence S3 increment by -90;
    select S3.nextval from dual;    ----x2
    alter sequence S3 increment by -10;

--6. ���� sequence (S4):     
create sequence CJACORE.S4
    increment by 1
    start with 1
    maxvalue 4
    cycle
    cache 2
    noorder;
    -- ����������� �����������
    select S4.nextval from dual;

--7. ����� ������ ��� ����-���� ��, �������� CJACORE
    select * from sys.all_sequences where sequence_owner='CJACORE';
    
--8. ���� ���� �1
    create table T1 (
    N1 number(20),
    N2 number(20),
    N3 number(20),
    N4 number(20)
    );
    alter table T1 cache storage (buffer_pool keep);
    -- ����� 7 ����� � ��� S1...S4
    BEGIN
        FOR i IN 1..7 LOOP
        insert into T1(N1,N2,N3,N4) values (S1.currval, S2.currval, S3.currval, S4.currval);
        END LOOP;
    END;
    select * from T1;

--9. ���� ������� ABC, ��. hash-��� 200
    create cluster CJACORE.ABC
    (
        x number(10),
        v varchar2(12)
    )
    hashkeys 200;

--10-12. ���� ���� �, B, C
    create table A(XA number(10), VA varchar(12), CA char(10)) cluster CJACORE.ABC(XA,VA);
    create table B(XB number(10), VB varchar(12), CB char(10)) cluster CJACORE.ABC(XB,VB);
    create table C(XC number(10), VC varchar(12), CC char(10)) cluster CJACORE.ABC(XC,VC);

--CJA
--13. ����� ������� � ������� � �������
    select cluster_name, owner from DBA_CLUSTERS;
    select * from dba_tables where cluster_name='ABC';        
 
--CJACORE   
--14-15. ���� ����+���� ������� ��� ���� CJA.C (B)
    create synonym SS1 for CJACORE.C;
    create public synonym SS2 for CJACORE.B;
    select * from dba_synonyms where table_owner='CJACORE';

--16. ���� �������� ������� A, B
    create table A (
        X number(20) primary key
        );
    create table B (
        Y number(20),
        constraint fk_column
        foreign key (Y) references A(X)
        );
    --������ �-��
    insert into A(X) values (1);
    insert into A(X) values (2);
    insert into B(Y) values (1);
    insert into B(Y) values (2);
    
    --���� ������, ��� �� select..for A inner join B
    create view V1
    as select X, Y from A inner join B on A.X=B.Y;
    
    select * from V1;

--17. ���� ���.������ MV �� ��� A,B � T=2 ���
    create materialized view MV
    build immediate
    refresh complete
    start with sysdate
    next sysdate + Interval '1' minute
    as
    select A.X, B.Y
    from (select count(*) X from A) a,
         (select count(*) Y from B) b
    
    select * from MV;
    insert into A(X) values (8);
    
    drop materialized view MV;
    
