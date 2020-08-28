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