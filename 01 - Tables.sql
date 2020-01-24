--9. ���� �������
create table CJA_t (x number(3) primary key, s varchar2(50));

--11. ����� ������
insert into CJA_t values (3, 'Julia');
insert into CJA_t values (5, 'Mihail');
insert into CJA_t values (12, 'Natasha');
insert into CJA_t values (67, 'Umnik');
insert into CJA_t values (70, 'Guga');
commit;

--12. ����� 2 ������
update CJA_t set x=5,  s='Kulich' where x=3;
update CJA_t set x=6, s='Prohor' where s='Mihail';
commit;

--13. select �� ��� + ���. �-�
select * from CJA_t where x=12;
select sum(x) from CJA_t;

--14. ���� 1 ������
delete from CJA_t where x=12;
commit;



--15. ���� ����, ���� ����. ������
create table CJA_t1 (x1 number(3), s1 varchar2(50) primary key, foreign key (x1) references CJA_t(x));
insert into CJA_t1 values (5, 'Polyak');
insert into CJA_t1 values (6, 'Russak');
insert into CJA_t1 values (67, 'Zaka');
commit;

--16. select (����� � ������ ����)
--�����-> ��� ������, ���.�����.���.
select x, s, x1 , s1
    from CJA_t inner join CJA_t1 on x = x1;
    
--�����-> ��� ������ ����� �� ON � �� �� ������, ��� ���� �����
select x, s, x1 , s1
    from CJA_t left outer join CJA_t1 on x = x1;

--������ �����
select x, s, x1 , s1
    from CJA_t right outer join CJA_t1 on x = x1;
    
--������ �����
select x, s, x1 , s1
    from CJA_t full outer join CJA_t1 on x = x1;

--18. ���� �������
drop table CJA_t1;
drop table CJA_t;
