--SET serveroutput ON;
--alter session set nls_date_format = 'DD-MM-YYYY';

--1. Добав в TEACHER столбцы BIRTHDAY, SALARY + заполн
    select * from teacher;


--2. Список преподов в виде Фамилия И.О.
    select teacher_name from TEACHER;
    select regexp_substr(teacher_name,'(\S+)',1, 1)||' '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 2),1, 1)||'. '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 3),1, 1)||'. '
    from teacher;


--3. Список преподов с ДР в ПН
    select * from teacher
    where TO_CHAR((birthday), 'd') = 2;


--4. Предст: список преподов с ДР в след. месяце
    create view NextMonthBirth as
    select * from teacher
    where TO_CHAR(sysdate,'mm')+1 = TO_CHAR(birthday, 'mm');
    
    select * from NextMonthBirth;
    --drop view NextMonthBirth;


--5. Предст: кол-во преподов с ДР в каждом месяце
     create view NumberMonths as
     select to_char(birthday, 'Month') Месяц,
            count(*) Количество
            from teacher
            group by to_char(birthday, 'Month')
            having count(*)>=1;
     
    select * from NumberMonths;
    --drop view NumberTeachersMonths;


--6. Курсор: вывод преподов с юбилеем в след. году
    cursor TeacherBirtday(teacher%rowtype) 
        return teacher%rowtype is
        select * from teacher
        where MOD((TO_CHAR(sysdate,'yyyy') - TO_CHAR(birthday, 'yyyy')+1), 10)=0;
    

--7. Курсор: вывод ср.з/п по кафедрам с округл.вниз
    cursor tAvgSalary(teacher.salary%type,teacher.pulpit%type) 
      return teacher.salary%type,teacher.pulpit%type  is
        select floor(avg(salary)), pulpit
        from teacher
        group by pulpit;
  
--итог значение для к. факультета 
    select round(AVG(T.salary),3),P.faculty
    from teacher T
    inner join pulpit P
    on T.pulpit = P.pulpit
    group by P.faculty
    union
      select floor(avg(salary)), teacher.pulpit
        from teacher
        group by teacher.pulpit
    order by faculty;

-- для всех факультетов в целом
    select round(avg(salary),3) from teacher;


--8. Собств тип записи (record) + влож записи
--структура д-х кот состоит из полей
    declare
        type ADDRESS is record
        (
          town nvarchar2(20),
          country nvarchar2(20)
        );
        type PERSON is record
        (
          name teacher.teacher_name%type,
          pulp teacher.pulpit%type,
          homeAddress ADDRESS
        );
      per1 PERSON;
      per2 PERSON;
    begin
      select teacher_name, pulpit into per1.name, per1.PULP
      from teacher
      where teacher='ЖЛК';
      per1.homeAddress.town := 'Минск';
      per1.homeAddress.country := 'Беларусь';
      per2 := per1;
      dbms_output.put_line( per2.name||' '|| per2.pulp||' из '||
                            per2.homeAddress.town||', '|| per2.homeAddress.country);
    end;
    
    
        