select initcap('angelo') from dual;
select last_name, initcap(last_name) from online_subscribers;

select employee_id
from employee
where uppler(employee_name) = 'MCGILLICUTTY'

--SELECT INITCAP('O'Hearn') from dual; -- ORA-20001: Error at line 1, col24: PL/SQL Lexer error: Unterminated string

SELECT INITCAP('napoleon'), INITCAP('RED OBRIEN'), INITCAP('McDonald''S') from dual;

SELECT CONCAT('Hellow ', 'World!') from dual;               

SELECT 'Hellow, ' || 'World!' || 'Great to' || ' see you' from dual;               

SELECT RPAD('Chapter One - I am Born', 40, '.'), rpad('Chapter One - I am Born', 40) from dual;

SELECT  RPAD(CHAPTER_TITLE, 30, '.') || 
               LPAD(' ' || PAGE_NUMBER, 30, '.') FROM(               
    SELECT 'Introduction' CHAPTER_TITLE, 1 PAGE_NUMBER  from dual               
    UNION               
    SELECT 'Chapter 1' CHAPTER_TITLE, 5 PAGE_NUMBER  from dual
    UNION               
    SELECT 'Chapter 2' CHAPTER_TITLE, 23 PAGE_NUMBER  from dual               
    UNION
    SELECT 'Chapter 3' CHAPTER_TITLE, 57 PAGE_NUMBER  from dual               
    UNION
    SELECT 'Index' CHAPTER_TITLE, 79 PAGE_NUMBER  from dual               
) BOOK_CONTENTS
ORDER BY PAGE_NUMBER ;

SELECT RTRIM('Seven thousand----------', '-') FROM DUAL;
SELECT LTRIM('----------Seven thousand', '-'), ltrim('        angelo') FROM DUAL;

SELECT TRIM(LEADING '-' FROM '----------Seven thousand') FROM DUAL;
SELECT TRIM(TRAILING '-' FROM 'Seven thousand----------') FROM DUAL;
SELECT TRIM(BOTH '-' FROM '----------Seven thousand----------') FROM DUAL;
SELECT TRIM(BOTH FROM '          Seven thousand          ') FROM DUAL;
SELECT TRIM('-' FROM '----------Seven thousand----------') FROM DUAL;
SELECT TRIM( FROM '----------Seven thousand----------') FROM DUAL; -- ORA-30000: especificação de redução ou expressão de caractere não encontrada em TRIM
SELECT TRIM('         ''Seven thousand''        ') FROM DUAL;               

SELECT LENGTH('         ''Seven thousand''        ') FROM DUAL;

SELECT INSTR('MISSISSIPPI', 'SI', 1, 2) FROM DUAL;               
SELECT INSTR('MISSISSIPPI', 'SI', 5) FROM DUAL;               
SELECT INSTR('MISSISSIPPI', 'SI',-1, 2) FROM DUAL;
SELECT INSTR('MISSISSIPPI', 'SI') FROM DUAL;               
               
SELECT SUBSTR('MISSISSIPPI', 1, 2) FROM DUAL;
SELECT SUBSTR('MISSISSIPPI', 3) FROM DUAL;               

SELECT SOUNDEX('Angelo'), soundex('angelica') from dual;               


-- NUMERIC FUNCTION
SELECT CEIL(4.01) FROM DUAL;               
select floor(3.99) from dual;	

select round(12.355234, 2), round(259, -1), round(259.99), round(254,-1), round(259, -2) from dual;               
select trunc(12.355143, 2), trunc(259.99, -1), trunc(259.99) from dual;      

select remainder(9,3), remainder(10,3), remainder(11,3), remainder(23, 5) from dual; --remainder(x, y) retorna (x-múltiplo de y mais próximo de x). resultado negativo se múltiplo de y maior que x
select mod(9,3), mod(10,3), mod(11,3), mod(23, 5) from dual;


select sysdate from dual;

select sysdate from dual;
select sysdate, round(sysdate, 'MM'), round(to_date('16/09/20', 'dd/mm/yy'), 'MM'), round(to_date('14/09/20', 'dd/mm/yy'), 'MM')  from dual;
select round(sysdate, 'RR') from dual;
select to_char(sysdate, 'dd/mm/yy hh24:mi:ss'), to_char(round(sysdate), 'dd/mm/yy hh24:mi:ss') from dual;
select to_char(to_date('01/09/20 12:00:00', 'dd/mm/yy hh24:mi:ss'), 'dd/mm/yy hh24:mi:ss') data_meio_dia, 
       to_char(round(to_date('01/09/20 12:00:00', 'dd/mm/yy hh24:mi:ss')), 'dd/mm/yy hh24:mi:ss') data_meio_dia_round from dual;

-- TRUNC FAZ PARECIDO COM O ROUND MAS SEMPRE ARREDONDANDO PARA PARA BAIXO
select sysdate 
, to_char(sysdate, 'dd/mm/yy hh24:mi:ss') 
, to_char(trunc(sysdate, 'mi'), 'dd/mm/yy hh24:mi:ss' ) trunc_mi
, to_char(trunc(sysdate, 'hh'), 'dd/mm/yy hh24:mi:ss' ) trunc_hh
, to_char(trunc(sysdate, 'dd'), 'dd/mm/yy hh24:mi:ss') trunc_dd
, trunc(sysdate, 'MM') trunc_mm
, trunc(sysdate, 'RR') trunc_yy from dual;


select to_char(to_date('01/09/20 12:00:00', 'dd/mm/yy hh24:mi:ss'), 'dd/mm/yy hh24:mi:ss') data_meio_dia, 
       to_char(trunc(to_date('01/09/20 12:00:00', 'dd/mm/yy hh24:mi:ss')), 'dd/mm/yy hh24:mi:ss') data_meio_dia_trunc from dual;

SELECT NEXT_DAY('01/09/20', 'sábado') from dual;

select last_day('01/02/20'), last_day('01/02/21') from dual;

select add_months('31/JAN/17', 1), add_months('01/NOV/17', 4), ADD_MONTHS('28/FEV/17', -1), ADD_MONTHS('01/FEV/17', -1) FROM DUAL;

-- PRIMEIRO MES MENOS O SEGUNDO
SELECT MONTHS_BETWEEN('01-01-17', '01-02-17') FROM DUAL;
SELECT MONTHS_BETWEEN('01-01-17', '01-03-17') FROM DUAL;
SELECT MONTHS_BETWEEN('10-08-17', '10-07-17') FROM DUAL;
SELECT MONTHS_BETWEEN('12-06-14', '03-10-13') FROM DUAL;

-- SEGUNDO PARAMETRO NÃO É CASE SENSITIV
SELECT NUMTOYMINTERVAL(27, 'month'), NUMTOYMINTERVAL(27, 'YEAR') from dual;

SELECT NUMTODSINTERVAL(27, 'DAY'), NUMTODSINTERVAL(27, 'HOUR'), NUMTODSINTERVAL(27, 'MINUTE'), NUMTODSINTERVAL(27, 'SECOND') FROM DUAL;

SELECT substr(NUMTODSINTERVAL(24, 'DAY'), 7), NUMTODSINTERVAL(25, 'HOUR'), NUMTODSINTERVAL(25*60+1, 'MINUTE'), NUMTODSINTERVAL((25*60+1)*60+1, 'SECOND') FROM DUAL;

-- OVER, PARTITION BY , ORDER BY

create table ship_cabins_2(
    ship_cabin_id number,
    room_number number,
    window varchar2(20),
    sq_ft number
);

alter table ship_cabins_2 add constraint pk_ship_cabins primary key(ship_cabin_id);

insert into ship_cabins_2 values(1,102, 'Ocean',533);
insert into ship_cabins_2 values(2,103, 'Ocean',160);
insert into ship_cabins_2 values(3,104, 'None',533);
insert into ship_cabins_2 values(4,105, 'Ocean',205);
insert into ship_cabins_2 values(5,106, 'None',586);
insert into ship_cabins_2 values(6,107, 'None',1524);
commit;


select sum(sq_ft) from ship_cabins_2; 

select window, room_number, sq_ft, sum(sq_ft) --	ORA-00937: não é uma função de grupo de grupo simples
from ship_cabins_2
order by sq_ft;


select window, room_number, sq_ft, 
    sum(sq_ft) over (order by sq_ft) "running total",
    sum(sq_ft) over (order by sq_ft rows between 1 preceding and 1 following) subset
from
ship_cabins_2
order by
    sq_ft;

select window, room_number, sq_ft, 
    sum(sq_ft) over (partition by window order by sq_ft) "running total",
    sum(sq_ft) over (partition by window order by sq_ft rows between 1 preceding and 1 following) subset
from
ship_cabins_2
order by
    sq_ft;
	
select window, room_number, sq_ft, 
    sum(sq_ft) over (partition by window order by sq_ft) "running total",
    sum(sq_ft) over (partition by window order by sq_ft rows between 1 preceding and 1 following) subset
from
ship_cabins_2
order by
    room_number;	

--LAG , LEAD
select window, room_number, sq_ft, 
    lag(sq_ft) over (order by window, sq_ft) lag,
    lead(sq_ft) over (order by window, sq_ft) lead
from
ship_cabins_2
order by
    window, sq_ft;

select window, room_number, sq_ft, 
    lag(sq_ft) over (partition by window order by room_number) lag,
    lead(sq_ft) over (partition by window order by room_number) lead
from
ship_cabins_2
order by
    room_number;
	
	
select window, room_number, sq_ft, 
    lag(sq_ft) over (order by window, sq_ft) lag,
    lead(sq_ft) over (order by window, sq_ft) lead
from
ship_cabins_2
order by
    room_number;
	
select window, room_number, sq_ft, 
    lag(sq_ft,2) over (order by window, sq_ft) lag,
    lead(sq_ft) over (order by window, sq_ft) lead
from
ship_cabins_2
order by
    window, sq_ft;

--STDDEV
select avg(sq_ft), median(sq_ft), stddev(sq_ft), variance(sq_ft)
from ship_cabins_2;

select window, room_number, sq_ft,
    variance(sq_ft) over(order by sq_ft) "variance",
    stddev(sq_ft) over(order by sq_ft) "std_dev"
from ship_cabins_2
order by sq_ft;    	

select window, room_number, sq_ft,
    percentile_cont(.6)
        within group(order by sq_ft) over(partition by window)
from ship_cabins_2
order by sq_ft;