CREATE TABLE ORDRS(
	ORDER_NUM INTEGER PRIMARY KEY,
	ORDER_DATE DATE,
	PRODUCT VARCHAR2(10),
	AMOUNT NUMBER,
    text CLOB,
    img BLOB,
    f_name VARCHAR2(30),
    i_name VARCHAR2(30) );

--update ordrs set text = upper(text);

select * from ordrs;

--1.txt
--ordrs.ctl
--cmd
--cd 3\ад\18
--sqlldr CJACORE/12345678 CONTROL=ORDRS.ctl

--ctrl+enter
--export
select /*xml*/ * from ordrs;