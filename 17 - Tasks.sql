
ALTER SESSION SET nls_date_format='dd-mm-yyyy hh24:mi:ss';

--созд таблицы куда копир д-е
 create table teacher_backup (
  teacher      char(10),
  teacher_name nvarchar2(50),
  pulpit       char(10),
  salary      number
);

create table teacher_backup2 (
  teacher      char(10),
  teacher_name nvarchar2(50),
  pulpit       char(10),
  salary      number
);

create table job_status (
  status   nvarchar2(50),
  datetime timestamp default current_timestamp
);

--копирование части д-х по усл.из 1 табл в другую из первой табл д-е удаляются
--провер.выполнено ли задание + сохран.сведения о попытках выполения (успешн и нет)
create or replace procedure jobprocedure is
  cursor teachercursor is select * from teacher where salary > 450;
  begin
    for n in teachercursor
      loop
        insert into teacher_backup (teacher, teacher_name, pulpit, salary)
        values (n.teacher, n.teacher_name, n.pulpit, n.salary); 
      end loop;
    delete from teacher where salary > 450;
    insert into job_status (status) values ('SUCCESS');
    commit;
    exception when others then insert into job_status (status) values ('FAIL');
end;

begin
  jobprocedure();
end;

select * from teacher_backup;
select * from teacher;
select * from job_status;

--создать задание (задание выполняется в опред.время (через неделю))
declare v_job number;
begin
  SYS.dbms_job.submit(
      job => v_job,
      what => 'BEGIN jobprocedure(); END;',
      next_date => trunc(sysdate+7) + 3 / 24,
      interval => 'trunc(sysdate + 7) + 60/86400');
  commit;
end;

select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

--запустить немедленно
begin
  dbms_job.run(63);
end;
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

--разрешение задания
begin
  dbms_job.broken(63, broken => true);
end;
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

--удалить задание из очереди
begin
  dbms_job.remove(63);
end;
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

--создать задание с номером
begin
  dbms_job.isubmit(1, 'BEGIN jobprocedure(); END;', sysdate, 'sysdate + 60/86400');
  commit;
end;
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;






--выполняется копирование из 1 табл в другую
--раз в неделю в определенное время
create or replace procedure jobprocedure2 is
  cursor teachercursor2 is select * from teacher where salary < 450;
  begin
    for n in teachercursor2
      loop
        insert into teacher_backup2 (teacher, teacher_name, pulpit, salary)
        values (n.teacher, n.teacher_name, n.pulpit, n.salary); 
      end loop;
    delete from teacher where salary < 450;
    insert into job_status (status) values ('SUCCESS');
    commit;
    exception when others then insert into job_status (status) values ('FAIL');
end;

begin
  jobprocedure2();
end;

select * from teacher_backup2;
select * from teacher;
select * from job_status;

begin
  dbms_scheduler.create_job(
      job_name => 'jsh_2',
      job_type => 'STORED_PROCEDURE',
      job_action => 'procedure',
      start_date => sysdate,
      repeat_interval => 'FREQ=DAILY; INTERVAL=7;BYHOUR=10; BYMINUTE=10;BYSECOND=30',
      enabled => true
  );
end;

select job_name, job_type, job_action, start_date, repeat_interval, next_run_date, enabled from user_scheduler_jobs;
select job_name, state from  user_scheduler_jobs;

begin
  dbms_scheduler.set_attribute('jsh_2', attribute => 'job_action', value => 'jobprocedure');
end;

begin
  dbms_scheduler.drop_job('jsh_2', true);
end;

begin
  dbms_scheduler.create_schedule(
      schedule_name => 'Sch_2',
      start_date => sysdate,
      repeat_interval => 'FREQ=DAILY;',
      comments => 'Sch_2 DAILY at 12:00'
  );
end;
select * from user_scheduler_schedules;

begin
  dbms_scheduler.create_program(
      program_name => 'Pr_2',
      program_type => 'STORED_PROCEDURE',
      program_action => 'up_job',
      number_of_arguments => 0,
      enabled => false,
      comments => 'Sch_2 DAILY at 12:00'
  );
end;
select * from user_scheduler_programs;