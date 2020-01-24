create type TypeTestObject as object
(
    object_name varchar2(500),
    object_id number,
    object_type varchar2(10)
);

-- Создаем коллекцию типа nested table
/*таблица д-х, которую можно вкл в другие выборки*/
create type TypeTestList as table of TypeTestObject;

/*с nested tables могут работать и обычные функции
  но pipelined позвол. получить макс быстродействие*/
create or replace function testFunction(obj_type in varchar2)
    return TypeTestList pipelined as
    begin
        for i in (select tao.OBJECT_NAME, tao.OBJECT_ID, tao.OBJECT_TYPE
                    from all_objects tao
                    where tao.OBJECT_TYPE=obj_type)
        loop
            pipe row (TypeTestObject(i.OBJECT_NAME, i.OBJECT_ID, i.OBJECT_TYPE));
        end loop;
        return;
    end;  
/*Открывается неявный курсор, извлекаются записи, из них создаются 
объекты типа TypeTestObject и помещаются в коллекцию.*/  

select * from table(testFunction('TABLE')) t where t.object_id=20;
  
    
    -------------------------
 -- A S K   T O M    
    
create table Emplyees
(   empno number(4),
    ename varchar2(10)
);
insert into Emplyees values (7499, 'ALLEN');
insert into Emplyees values (7521, 'WARD');
insert into Emplyees values (7654, 'MARTIN');
    
create or replace type emp_type as object
(    empno number(4),
     ename varchar2(10)
);
create or replace type emp_table_type as table of emp_type;

--после этого внизу наш код работает как ТАБЛИЦА
create or replace function emp_etl(cur in sys_refcursor)
    return emp_table_type
    PIPELINED as
    rec Emplyees%rowtype;
    begin
        loop
        fetch cur into rec;
        exit when (cur%notfound);
        pipe row (emp_type(rec.empno, rec.ename));
        end loop;
        return;
    end;
select empno, ename from TABLE(emp_etl(cursor( select * from Emplyees)));
   

---- ORACLE.DOCS
/*табличные ф-ции - ф., кот. возвращают набор столбцов (nested table) 
    к кот. м делать запросы как в физ. таблице
    м. принимать набор столбцов как параметр (тип коллеции или ref cursor)
    столбцы, кот. возвр. табл.ф. могут быт pipelined - итеративно возвр-мые
    позв. табл. ф-ям возвр. столбцы быстрее и уменьш. необх. память для кэшиирования результатов табл. ф-й
*/


 create table Students
    (   s_id        integer,
        first_name  varchar2(50),
        last_name   varchar2(50)
    );
  insert into students values (1, 'Юлия', 'Чистякова');
  insert into students values (1, 'Анна', 'Сабурова');
  insert into students values (1, 'Наталья', 'Козик');

create or replace type st_type as object
(   s_id        integer,
    first_name  varchar2(50),
    last_name   varchar2(50)
);

create or replace type st_table_type as table of st_type;


/*в функции мы получаем набор по ученикам, каждую строчку этого набора анализируем
на предмет того, что имя начинается на А, то фамилию устанавливаем Антонов,
дальше каждая строчка не дожидаясь окончания наполнения всей коллекции, отдается в вызывающую обработку 

т.о., с пом. конвейерных табл. ф-й мы получаем возможность сделать выборку,
наполненную сколько угодно сложной логикой за счет исп. pl/sql кода и не просесть в плане произв-сти,
а в ряде случаев даже ее увеличить*/

create or replace function st_fun(cur in sys_refcursor)
    return st_table_type
    PIPELINED
    as
    rec Students%rowtype;
    begin
        loop
        fetch cur into rec;
        exit when (cur%notfound);
        if (rec.first_name like 'А%')
            then rec.last_name := 'Антонов';
            end if;
        pipe row (st_type(rec.s_id, rec.first_name, rec.last_name));
        end loop;
        return;
    end;   
select * from TABLE(st_fun(cursor( select * from Students)));
select * from Students;   
    
    
    
    
    
    
    
    
    
    
    
    
    
    