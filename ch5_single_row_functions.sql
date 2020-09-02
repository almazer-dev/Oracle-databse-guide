select initcap('angelo') from dual;
select last_name, initcap(last_name) from online_subscribers;

select employee_id
from employee
where uppler(employee_name) = 'MCGILLICUTTY'

--SELECT INITCAP('O'Hearn') from dual; -- ORA-20001: Error at line 1, col24: PL/SQL Lexer error: Unterminated string

SELECT INITCAP('napoleon'), INITCAP('RED OBRIEN'), INITCAP('McDonald''S') from dual;

SELECT CONCAT('Hellow ', 'World!') from dual;               

SELECT 'Hellow, ' || 'World!' || 'Great to' || ' see you' from dual;               

SELECT RPAD('Chapter One - I am Born', 40, '.') from dual;

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
SELECT LTRIM('----------Seven thousand', '-') FROM DUAL;

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

select round(12.355234, 2), round(259, -1), round(259.99), round(254,-1) from dual;               
select trunc(12.355143, 2), trunc(259.99, -1), trunc(259.99) from dual;      

select remainder(9,3), remainder(10,3), remainder(11,3) from dual; -- retorna -1 se múltiplo mais próximo de n1 for maior que n1
select mod(9,3), mod(10,3), mod(11,3) from dual;


select sysdate from dual;

select sysdate from dual;
select sysdate, round(sysdate, 'MM'), round(to_date('16/09/20', 'dd/mm/yy'), 'MM'), round(to_date('14/09/20', 'dd/mm/yy'), 'MM')  from dual;
select round(sysdate, 'RR') from dual;
select to_char(sysdate, 'dd/mm/yy hh24:mi:ss'), to_char(round(sysdate), 'dd/mm/yy hh24:mi:ss') from dual;
select to_char(to_date('01/09/20 12:00:00', 'dd/mm/yy hh24:mi:ss'), 'dd/mm/yy hh24:mi:ss') data_meio_dia, 
       to_char(round(to_date('01/09/20 12:00:00', 'dd/mm/yy hh24:mi:ss')), 'dd/mm/yy hh24:mi:ss') data_meio_dia_round from dual;

select sysdate, trunc(sysdate, 'MM'), trunc(sysdate, 'RR') from dual;
select to_char(to_date('01/09/20 12:00:00', 'dd/mm/yy hh24:mi:ss'), 'dd/mm/yy hh24:mi:ss') data_meio_dia, 
       to_char(trunc(to_date('01/09/20 12:00:00', 'dd/mm/yy hh24:mi:ss')), 'dd/mm/yy hh24:mi:ss') data_meio_dia_trunc from dual;

SELECT NEXT_DAY('01/09/20', 'sábado') from dual;

select last_day('01/02/20'), last_day('01/02/21') from dual;

select add_months('31/JAN/17', 1), add_months('01/NOV/17', 4), ADD_MONTHS('28/FEV/17', -1), ADD_MONTHS('01/FEV/17', -1) FROM DUAL;
