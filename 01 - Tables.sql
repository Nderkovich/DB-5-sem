--9. созд таблицу
create table CJA_t (x number(3) primary key, s varchar2(50));

--11. добав строки
insert into CJA_t values (3, 'Julia');
insert into CJA_t values (5, 'Mihail');
insert into CJA_t values (12, 'Natasha');
insert into CJA_t values (67, 'Umnik');
insert into CJA_t values (70, 'Guga');
commit;

--12. измен 2 строки
update CJA_t set x=5,  s='Kulich' where x=3;
update CJA_t set x=6, s='Prohor' where s='Mihail';
commit;

--13. select по усл + агр. ф-я
select * from CJA_t where x=12;
select sum(x) from CJA_t;

--14. удал 1 строку
delete from CJA_t where x=12;
commit;



--15. созд табл, связ внеш. ключом
create table CJA_t1 (x1 number(3), s1 varchar2(50) primary key, foreign key (x1) references CJA_t(x));
insert into CJA_t1 values (5, 'Polyak');
insert into CJA_t1 values (6, 'Russak');
insert into CJA_t1 values (67, 'Zaka');
commit;

--16. select (левое и правое соед)
--внутр-> все строки, кот.удовл.усл.
select x, s, x1 , s1
    from CJA_t inner join CJA_t1 on x = x1;
    
--левое-> все строки слева от ON и те из другой, где поля равны
select x, s, x1 , s1
    from CJA_t left outer join CJA_t1 on x = x1;

--правое внешн
select x, s, x1 , s1
    from CJA_t right outer join CJA_t1 on x = x1;
    
--полное внешн
select x, s, x1 , s1
    from CJA_t full outer join CJA_t1 on x = x1;

--18. удал таблицы
drop table CJA_t1;
drop table CJA_t;
