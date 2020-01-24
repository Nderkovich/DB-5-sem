/*1.1*/
SELECT NAME FROM V$DATAFILE;

SELECT NAME FROM V$CONTROLFILE;

SELECT * FROM V$LOGFILE;

SELECT * FROM v$archived_log;

select * from v$sga;

SELECT component, current_size, min_size, max_size
FROM v$sga_dynamic_components;

/*1.2*/
create table First(x number(3), s varchar2(50));

create sequence s1
increment by 2
start with 500
nomaxvalue
NOMINVALUE;

insert into First(x, s) VALUES (s1.nextval, 'string');

select * from First;

/*1.3*/

select * from DBA_SEGMENTS WHERE SEGMENT_NAME = 'TEMP';

select * from USER_SEGMENTS WHERE SEGMENT_NAME = 'TEMP';

select * from DBA_EXTENTS; 
select * from USER_EXTENTS;
select * from DBA_TABLESPACES WHERE TABLESPACE_NAME = 'TEMP'



/*2.1*/

create table AUDITORIUM_TYPE 
(
  AUDITORIUM_TYPE   char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
  AUDITORIUM_TYPENAME  varchar2(30) constraint AUDITORIUM_TYPENAME_NOT_NULL not null         
);

insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛК',   'Лекционная');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛБ-К',   'Компьютерный класс');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛК-К', 'Лекционная с уст. компьютерами');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛБ-X', 'Химическая лаборатория');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛБ-СК', 'Спец. компьютерный класс');

create table AUDITORIUM 
(
 AUDITORIUM           char(10) primary key,  -- код аудитории
 AUDITORIUM_NAME      varchar2(200),          -- аудитория 
 AUDITORIUM_CAPACITY  number(4),              -- вместимость
 AUDITORIUM_TYPE      char(10) not null      -- тип аудитории
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE)  
);

insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('206-1',   '206-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
                       values  ('301-1',   '301-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('236-1',   '236-1', 'ЛК',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('313-1',   '313-1', 'ЛК',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('324-1',   '324-1', 'ЛК',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('413-1',   '413-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('423-1',   '423-1', 'ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('408-2',   '408-2', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('103-4',   '103-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('105-4',   '105-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('107-4',   '107-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('110-4',   '110-4', 'ЛК',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('111-4',   '111-4', 'ЛК',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                      values  ('114-4',   '114-4', 'ЛК-К',  90 );
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('132-4',   '132-4', 'ЛК',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('02Б-4',   '02Б-4', 'ЛК',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('229-4',   '229-4', 'ЛК',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('304-4',   '304-4','ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('314-4',   '314-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('320-4',   '320-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('429-4',   '429-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                        values  ('?',   '???', 'ЛК',  90);
           

declare 
  cursor curs_auditorium(capacity system.auditorium.auditorium%type,capac system.auditorium.auditorium%type)
    is select auditorium, auditorium_capacity
      from auditorium
      where auditorium_capacity >=capacity and AUDITORIUM_CAPACITY <= capac;
begin
  dbms_output.put_line('Кол-во <20 ');
  for aum in curs_auditorium(0,20)
  loop
  dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;  
  dbms_output.put_line('Кол-во 20 and 30');
  for aum in curs_auditorium(21,30)
  loop
  dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;  
   dbms_output.put_line('Кол-во 30 and 60 ');
  for aum in curs_auditorium(31,60)
  loop
  dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;  
   dbms_output.put_line('Кол-во 60 and 80 ');
  for aum in curs_auditorium(61,80)
  loop
  dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;  
   dbms_output.put_line('Кол-во >80 ');
  for aum in curs_auditorium(81,1000)
  loop
  dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;  
 exception
  when others
  then dbms_output.put_line(sqlerrm);
  end;
  
  /*2.2*/
  CREATE TABLE FACULTY
  (
   FACULTY      CHAR(10)      NOT NULL,
   FACULTY_NAME VARCHAR2(50), 
   CONSTRAINT PK_FACULTY PRIMARY KEY(FACULTY) 
  );
     
insert into FACULTY   (FACULTY,   FACULTY_NAME )
             values  ('ИДиП',   'Издателькое дело и полиграфия');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ХТиТ',   'Химическая технология и техника');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ЛХФ',     'Лесохозяйственный факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИЭФ',     'Инженерно-экономический факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТТЛП',    'Технология и техника лесной промышленности');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТОВ',     'Технология органических веществ');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ФИТ',     'Факультет информационных технологий');

--------------------------------------------------------------------------------------------
-- DROP TABLE PULPIT
CREATE TABLE PULPIT 
(
 PULPIT       CHAR(10)      NOT NULL,
 PULPIT_NAME  VARCHAR2(100), 
 FACULTY      CHAR(10)      NOT NULL, 
 CONSTRAINT FK_PULPIT_FACULTY FOREIGN KEY(FACULTY)   REFERENCES FACULTY(FACULTY), 
 CONSTRAINT PK_PULPIT PRIMARY KEY(PULPIT) 
 ); 
 
delete PULPIT;  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('ИСиТ',    'Иформационный систем и технологий ',                         'ИДиП'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('ПОиСОИ', 'Полиграфического оборудования и систем обработки информации ', 'ИДиП'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
              values  ('ЛВ',      'Лесоводства',                                                 'ЛХФ') ;         
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ОВ',      'Охотоведения',                                                 'ЛХФ') ;   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ЛУ',      'Лесоустройства',                                              'ЛХФ');           
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ЛЗиДВ',   'Лесозащиты и древесиноведения',                               'ЛХФ');                
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ЛПиСПС',  'Ландшафтного проектирования и садово-паркового строительства','ЛХФ');                  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ТЛ',     'Транспорта леса',                                              'ТТЛП');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ЛМиЛЗ',  'Лесных машин и технологии лесозаготовок',                      'ТТЛП');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ОХ',     'Органической химии',                                           'ТОВ');            
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                              FACULTY)
             values  ('ТНХСиППМ','Технологии нефтехимического синтеза и переработки полимерных материалов','ТОВ');             
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии ','ХТиТ');                    
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                                         FACULTY)
             values  ('ХТЭПиМЭЕ','Химии, технологии электрохимических производств и материалов электронной техники', 'ХТиТ');
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('ЭТиМ',    'экономической теории и маркетинга',                              'ИЭФ');   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('МиЭП',   'Менеджмента и экономики природопользования',                      'ИЭФ');    
------------------------------------------------------------------------------------------------------------------------        - DROP  TABLE TEACHER
CREATE TABLE TEACHER
 ( 
  TEACHER       CHAR(10) NOT  NULL,
  TEACHER_NAME  VARCHAR2(50), 
  PULPIT        CHAR(10) NOT NULL, 
  BIRTHDAY      DATE,
  SALARY        NUMBER(5),
  CONSTRAINT PK_TEACHER  PRIMARY KEY(TEACHER), 
  CONSTRAINT FK_TEACHER_PULPIT FOREIGN   KEY(PULPIT)   REFERENCES PULPIT(PULPIT)
 ) ;
 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('СМЛВ',    'Смелов Владимир Владиславович',  'ИСиТ','03.07.1960',1000);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('АКНВЧ',    'Акунович Станислав Иванович',  'ИСиТ','04.07.1961',600);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('КЛСНВ',    'Колесников Леонид Валерьевич', 'ИСиТ','05.08.1955',500);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ГРМН',    'Герман Олег Витольдович', 'ИСиТ','06.05.1961',550);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ЛЩНК',    'Лащенко Анатолий Пвалович',  'ИСиТ','01.08.1963',620);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('БРКВЧ',    'Бракович Андрей Игорьевич',  'ИСиТ','03.03.1971',480);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ДДК',     'Дедко Александр Аркадьевич',  'ИСиТ','11.09.1965',490);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('КБЛ',     'Кабайло Александр Серафимович',  'ИСиТ','13.02.1960',530);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('УРБ',     'Урбанович Павел Павлович',  'ИСиТ','21.04.1964',710);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('РМНК',     'Романенко Дмитрий Михайлович',  'ИСиТ','17.07.1973',670);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ПСТВЛВ',  'Пустовалова Наталия Николаевна', 'ИСиТ' ,'13.10.1968',460);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                      values  ('ГРН',     'Гурин Николай Иванович',  'ИСиТ','23.11.1963',580);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ЖЛК',     'Жиляк Надежда Александровна',  'ИСиТ','12.01.1980',490);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('БРТШВЧ',   'Барташевич Святослав Александрович',  'ПОиСОИ','09.04.1972',390);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ЮДНКВ',   'Юденков Виктор Степанович',  'ПОиСОИ','17.02.1974',380);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('БРНВСК',   'Барановский Станислав Иванович',  'ЭТиМ','21.01.1982',440);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('НВРВ',   'Неверов Александр Васильевич',  'МиЭП', '26.10.1975',430);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('РВКЧ',   'Ровкач Андрей Иванович',  'ОВ','19.02.1973',395);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ДМДК', 'Демидко Марина Николаевна',  'ЛПиСПС','26.12.1978',320);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('МШКВСК',   'Машковский Владимир Петрович',  'ЛУ','23.10.1974',750);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ЛБХ',   'Лабоха Константин Валентинович',  'ЛВ','28.03.1968',630);
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ЗВГЦВ',   'Звягинцев Вячеслав Борисович',  'ЛЗиДВ','26.11.1974',410); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('БЗБРДВ',   'Безбородов Владимир Степанович',  'ОХ','05.05.1972',610); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ПРКПЧК',   'Прокопчук Николай Романович',  'ТНХСиППМ','07.08.1968',630); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('НСКВЦ',   'Насковец Михаил Трофимович',  'ТЛ','12.08.1969',465); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('МХВ',   'Мохов Сергей Петрович',  'ЛМиЛЗ','18.10.1973',345); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ЕЩНК',   'Ещенко Людмила Семеновна',  'ТНВиОХТ','28.07.1972',415); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('ЖРСК',   'Жарский Иван Михайлович',  'ХТЭПиМЭЕ','13.04.1955',860); 
---------------------------------------------------------------------------------------------------------------------
CREATE TABLE SUBJECT
    (
     SUBJECT      CHAR(10)     NOT NULL, 
     SUBJECT_NAME VARCHAR2(50)  NOT NULL,
     PULPIT       CHAR(10)     NOT NULL,  
     CONSTRAINT PK_SUBJECT PRIMARY KEY(SUBJECT),
     CONSTRAINT FK_SUBJECT_PULPIT FOREIGN  KEY(PULPIT)  REFERENCES PULPIT(PULPIT)
    );


insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('СУБД',   'Системы управления базами данных',                   'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT)
                       values ('БД',     'Базы данных',                                        'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ИНФ',    'Информацтонные технологии',                          'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОАиП',  'Основы алгоритмизации и программирования',            'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПЗ',     'Представление знаний в компьютерных системах',       'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПСП',    'Пограммирование сетевых приложений',                 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('МСОИ',     'Моделирование систем обработки информации',        'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПИС',     'Проектирование информационных систем',              'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('КГ',      'Компьютерная геометрия ',                           'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПМАПЛ',   'Полиграфические машины, автоматы и поточные линии', 'ПОиСОИ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('КМС',     'Компьютерные мультимедийные системы',               'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОПП',     'Организация полиграфического производства',         'ПОиСОИ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                            PULPIT)
               values ('ДМ',   'Дискретная матеатика',                     'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('МП',   'Математисеское программирование',          'ИСиТ');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('ЛЭВМ', 'Логические основы ЭВМ',                     'ИСиТ');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('ООП',  'Объектно-ориентированное программирование', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ЭП',     'Экономика природопользования',                       'МиЭП');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ЭТ',     'Экономическая теория',                               'ЭТиМ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('БЛЗиПсOO','Биология лесных зверей и птиц с осн. охотов.',      'ОВ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОСПиЛПХ','Основы садовопаркового и лесопаркового хозяйства',  'ЛПиСПС');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ИГ',     'Инженерная геодезия ',                              'ЛУ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ЛВ',    'Лесоводство',                                        'ЛЗиДВ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОХ',    'Органическая химия',                                 'ОХ');   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ТРИ',    'Технология резиновых изделий',                      'ТНХСиППМ'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ВТЛ',    'Водный транспорт леса',                             'ТЛ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ТиОЛ',   'Технология и оборудование лесозаготовок',           'ЛМиЛЗ'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ТОПИ',   'Технология обогащения полезных ископаемых ',        'ТНВиОХТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПЭХ',    'Прикладная электрохимия',                           'ХТЭПиМЭЕ');          
  
  
  CREATE OR REPLACE FUNCTION GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE)
  RETURN NUMBER AS
  CURSOR teacher IS SELECT *
                    FROM TEACHER
                      INNER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
                      INNER JOIN FACULTY ON PULPIT.FACULTY = FACULTY.FACULTY
                    WHERE PULPIT.FACULTY = FCODE;
  teacherItem TEACHER%ROWTYPE;
  BEGIN
    OPEN teacher;
    FETCH teacher INTO teacherItem;
    WHILE teacher%FOUND
    LOOP
      FETCH teacher INTO teacherItem;
    END LOOP;
    RETURN teacher%ROWCOUNT;
  END;
  
CREATE FUNCTION FUN1(PAR FACULTY.FACULTY%TYPE) 
RETURN NUMBER 
IS 
COUNTS NUMBER:=0; 
CURSOR C1 IS SELECT * FROM PULPIT; 
CC PULPIT%ROWTYPE; 
CURSOR C2 IS SELECT * FROM TEACHER; 
CC2 TEACHER%ROWTYPE; 
BEGIN 
OPEN C1; 
FETCH C1 INTO CC; 
WHILE C1%FOUND 
LOOP 
IF CC.FACULTY=PAR THEN 
OPEN C2; 
FETCH C2 INTO CC2; 
WHILE C2%FOUND 
LOOP 
IF CC2.PULPIT=CC.PULPIT THEN 
COUNTS:=COUNTS+1; 
END IF; 
FETCH C2 INTO CC2; 
END LOOP; 
CLOSE C2; 
END IF; 
FETCH C1 INTO CC; 
END LOOP; 
CLOSE C1; 
RETURN COUNTS; 
END FUN1; 

DECLARE 
I NUMBER; 
BEGIN 
I:=FUN1('ИСиТ'); 
DBMS_OUTPUT.PUT_LINE('COUNTS='|| I); 
END;

  declare
  x number;
  begin
  x := GET_NUM_TEACHERS('ХТиТ');
  SYS.DBMS_OUTPUT.PUT_LINE(x);
  end;
  
  select GET_NUM_TEACHERS('ХТиТ') from dual;
  
  
  /*2.3*/
  create table T1(x number(3), y varchar(50));
 
 insert into t1(x,y) values(3,'str');
  
  create table t2(x1 number(3),y1 varchar(50));
  
  insert into t2(x1,y1) select x,y from t1;
  
  drop trigger replace_data
  
  create or replace trigger replace_data
  after delete on T1
  begin
  delete t2;
  insert into t2(x1,y1) select x,y from t1;
  dbms_output.put_line('Delete trigger ACTIVATED!');
  end;
  
 DELETE FROM t1 WHERE x=2
 
 /*2.4*/
 create or replace procedure DelAud(in_par in auditorium.AUDITORIUM_TYPE%type) as
  cursor curs_auditorium(capacity system.auditorium.auditorium%type,capac system.auditorium.auditorium%type)
    is select auditorium, auditorium_capacity, AUDITORIUM_TYPE
      from auditorium
      where auditorium_capacity >=capacity and AUDITORIUM_CAPACITY <= capac and auditorium_type = in_par for update;
  aum system.auditorium.auditorium%type;
  cty system.auditorium.auditorium_capacity%type;
  typ system.auditorium.auditorium_type%type;
begin
  open curs_auditorium(0,40);
  fetch curs_auditorium into aum, cty,typ;
  while(curs_auditorium%found)
  loop
  delete auditorium
  where current of curs_auditorium;
  fetch curs_auditorium into aum, cty,typ;
  end loop;
  close curs_auditorium;
  
  for pp in curs_auditorium(0,120)
  loop
  dbms_output.put_line(' '||pp.auditorium||
                       ' '||pp.auditorium_capacity||
                       ' '||pp.auditorium_type);
  end loop;
  rollback;
exception
  when others
  then dbms_output.put_line(sqlerrm);
  end;
  
  begin
  DelAud('ЛК');
  end;
  
  
  
  