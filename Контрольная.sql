-- процедура для обновления сотрудника + ошибки 
  
    create or replace procedure pr_update_salesreps(
    iempl_num in integer,
    iname in varchar
    ) as
    begin
        update salesreps 
            set name=iname
            where empl_num=iempl_num;
    exception
        when others then
        dbms_output.put_line(sqlerrm);
    end;

    begin
        pr_update_salesreps(106, 'Julia Clark');
    end;
    select * from salesreps;
    

  
-- функция для нахожд суммы заказов для офиса
-- парам - код офиса + ошибки

    create or replace function f_summ_office(fcode offices.office%TYPE)
        return number is tSum decimal;
    begin
        select sum(sales) into tSum from offices where office=fcode;
        return tSum;
    exception
        when others then
        dbms_output.put_line(sqlerrm);
        return -1;
    end;
    
    begin
        dbms_output.put_line(f_summ_office(21));
    end;
    select * from offices;

 

-- процедура для выбора сотрудников, д/р в месяц N + отсотр по дате
-- парам - N + ошибки

    create or replace procedure get_salesreps(N integer) is
        cursor my_curs is
            select name, hire_date from salesreps 
                where MOD((TO_CHAR(hire_date,'mm') - TO_CHAR(N)), 10)=0
                order by hire_date;

        t_name salesreps.name%type;
        t_hire_date salesreps.hire_date%type;

    begin
        open my_curs;
        loop
            dbms_output.put_line(t_name||' '||t_hire_date);
            fetch my_curs into t_name, t_hire_date;
            exit when my_curs%notfound;
        end loop;
    exception
        when others then dbms_output.put_line(sqlerrm);
    end;
        
    begin get_salesreps(10); end;





-- функция, самый дорогой товар <с описанием>
-- парам - часть имени + ошибки
-- alter session set nls_date_format = 'DD-MM-YYYY';

    create or replace function get_max_price(des products.description%type)
        return number is tMax number;
    begin
        select max(price) into tMax from products where description like '%'||des||'%';
        return tMax;
    exception
        when others then dbms_output.put_line(sqlerrm);
        return -1;
    end;
    
    begin dbms_output.put_line(get_max_price('ing')); end;
    select * from products;





-- все в пакет
    create or replace package orderss as
        iempl_num integer;
        i_name varchar(20);
        fcode offices.office%TYPE;
        N integer;
        des products.description%type;
         procedure pr_update_salesreps(iempl_num in integer,
                                        iname in varchar
                                        );
        function f_summ_office(fcode offices.office%TYPE) return number;
        procedure get_salesreps(N integer);
        function get_max_price(des products.description%type) return number;
    end orderss;
    
    create or replace package body orderss as
        procedure pr_update_salesreps(
            iempl_num in integer,
            iname in varchar
            ) as
            begin
            update salesreps set name=iname where empl_num=iempl_num;
            exception
            when others then dbms_output.put_line(sqlerrm);
        end pr_update_salesreps;
        
        function f_summ_office(fcode offices.office%TYPE)
            return number is tSum decimal;
            begin
            select sum(sales) into tSum from offices where office=fcode;
            return tSum;
            exception
            when others then dbms_output.put_line(sqlerrm);
            return -1;
        end f_summ_office;
        
        procedure get_salesreps(N integer) is
            cursor my_curs is
            select name, hire_date from salesreps 
            where MOD((TO_CHAR(hire_date,'mm') - TO_CHAR(N)), 10)=0
            order by hire_date;
            t_name salesreps.name%type;
            t_hire_date salesreps.hire_date%type;
            begin
            open my_curs;
            loop
            dbms_output.put_line(t_name||' '||t_hire_date);
            fetch my_curs into t_name, t_hire_date;
            exit when my_curs%notfound;
            end loop;
            exception
            when others then dbms_output.put_line(sqlerrm);
        end get_salesreps;
        
        function get_max_price(des products.description%type)
        return number is tMax number;
        begin
        select max(price) into tMax from products where description like '%'||des||'%';
        return tMax;
        exception
        when others then dbms_output.put_line(sqlerrm);
        return -1;
        end;
    end orderss;
    
   -- drop package orderss ;
    begin
         orderss.pr_update_salesreps(106, 'Julia Clark');
         dbms_output.put_line(orderss.f_summ_office(21));
         orderss.get_salesreps(10);
         dbms_output.put_line(orderss.get_max_price('ing'));
    end;
    