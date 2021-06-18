-- explicit and implicit conversion
select 'Chapter ' || 1 || '. . . I am Born.' from dual;

select sysdate , add_months(sysdate, substr('plus 3 months', 6, 1)) from dual;

select 'true' from dual where '3' > '20';

select 'true' from dual where '3' > 20; -- comparando texto e número. o texto é convertido para número.

create table call(
   call_id number,
   call_date_tz timestamp with time zone
);

insert into call values(1, '24-05-12 10:15:30'); --ORA-01840: valor de entrada não é longo o suficiente para formato de data
insert into call values(1, to_timestamp_tz('24-05-12 10:15:30', 'dd-mm-yy hh24:mi:ss'));

--to_number
select to_number('9,999.12', '9,999.99') from dual;
select to_number('$9,999.12', '$9,999.99') from dual;
select to_number('$99,999.12', '$99,999.99') from dual;
select to_number('$99,999.12', '$9,999.99') from dual; --ORA-01722: número inválido
select to_number('$099,999.12', '$099,999.99') from dual;

select to_number('007,3', '009D9') from dual;
select to_number('07,3', '009D9') from dual; --ORA-01722: número inválido

--B
select to_number(' 12', '99') from dual; --?
select to_number('2', 'B999') from dual; --?
select to_number('  12', '99') from dual; --?

--C
select to_number('BRL200', 'C999') from dual;
select to_number('USD200', 'C999') from dual;                                           
select to_number('BRL200', 'C999', 'nls_iso_currency=''BRAZIL''') from dual;
select to_number('USD200', 'C999', 'nls_iso_currency=''AMERICA''') from dual;

--D
select to_number('123.1234', '999D9999') from dual;--ORA-01722: número inválido (Se o separador de decimal for "," e o agrupador for ".")

--EEE
select to_number('1.2E-33') from dual;
select to_number('1.2E-33', 'EEEE') from dual;
select to_number('1.2E-33','9.9EEE') from dual; -- ORA-01481: modelo inválido para formato de número
select to_number('1.2E-33','9.9EEEE') from dual

--G
select to_number('444,123.1234', '999G999D9999', 'nls_numeric_characters=''.,''' ) from dual;
select to_number('444;123.1234', '999G999D9999', 'nls_numeric_characters=''.;''' ) from dual;

--L
select to_number('R$4','L99') from dual; -- se nls_currency for R$
select to_number('$4', 'L99') from dual; -- se nls_currency for $
select to_number('$4','L9', 'nls_currency=''$''') from dual; --funciona independemente do nls_currency local                                           
select to_number('R$4','L9', 'nls_currency=''R$''') from dual;
select to_number('#4','L9', 'nls_currency=''#''') from dual;

--MI
select to_number('1-') from dual; --ORA-01722: invalid number
select to_number('1-', '9MI') from dual;
select to_number('1 ', '9MI') from dual;
select to_number('1 ') from dual;
select to_number('1 ', '9') from dual; --ORA-01722: número inválido

--pr
select to_number('<1>', '99PR') from dual;
select to_number('1', '99PR') from dual;
select to_number('<12,4>', '99D9pr') from dual;

--RN 
-- formato apenas de saída. só funciona com to_char. (https://www.orafaq.com/forum/t/199599/)
select to_char(10, 'RN') from dual;

--S
select to_number('5', 'S9') from dual;
select to_number('5-', '9S') from dual;

--TM
-- formato apenas de saída. só funciona com to_char
select to_char('500000000' ,'TME') from dual;
select to_char('500000000' ,'TM9') from dual;
select to_char('500000000' ,'TM') from dual;
select to_char('5000000000000' ,'TME') from dual;

--U
select to_number('Cr$19', 'U99') from dual;

--V
select to_char(10, '99V99') from dual -- só consegue encontrar aplicação na função to_char

-- XXXX
select to_number('123', 'XX') from dual; --	ORA-01722: invalid number
select to_number('12', 'XX') from dual;
select to_number('12', 'X') from dual; --	ORA-01722: invalid number
select to_number('1', 'X') from dual; 
select to_number('123', 'XXX') from dual; 

--NLS parameter
select to_number('#40.000,9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters='',.''') from dual;
select to_number('#40,000.9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,''') from dual;
select to_number('#40,000.9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,'' nls_iso_currency=''BRAZIL''') from dual;
select to_number('BRL40,000.9','C999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,'' nls_iso_currency=''BRAZIL''') from dual;


     ---------------------
----------TO_CHAR--------------
     ---------------------
-- character parameter	 
select to_char('hello') from dual;	

--number parameter
select to_char(10000.4, '$99.999,00') from dual; -- error invalid number format model
select to_char(10000.4, '$99G999D00', 'nls_numeric_characters='',.''') from dual;
select to_char(10000.4, '$99G999D00', 'nls_numeric_characters=''.,''') from dual;
select to_char(10000.4, '$99,999.00') from dual;

select to_char(9999.12, '9,999.99') from dual;
select to_char(9999.12, '$9,999.99') from dual;
select to_char(99999.12, '$999,999.99') from dual;
select to_char(99999.12, '$9,999.99') from dual; --retorna a string ########## quando a entrada tem mais digitos do que o especificado no formato.
select to_char(99999.12, '$099,999.99') from dual;

select to_char('007,3', '009D9') from dual; --ORA-01722: invalid number se D for igual a .
select to_char('007,3', '009D9', 'nls_numeric_characters='',.''') from dual; --ORA-01722: invalid number se D for igual a .
select to_char('07.3', '009D9') from dual;
select to_char('07.3', '000000000000009D9') from dual; -- se D for igual  a ,
select to_char(to_number('007,3', '009D9', 'nls_numeric_characters='',.''' ), '009D9') from dual;
select to_char(to_number('007,3', '009D9', 'nls_numeric_characters='',.''' ), '009D9', 'nls_numeric_characters='',.''') from dual;
select to_char(123.01, '99999999D9999') from dual;
select to_char(123.01, '099999999D9999') from dual;



--B
?????????????????????????????

--C
select to_char(200, 'C999') from dual;
select to_char(200, 'C999', 'nls_iso_currency=''BRAZIL''') from dual;

--D
select to_char('123', '999D9999') from dual;
select to_char(123.01, '999D9999') from dual;
select to_char('123.1234', '999D9999') from dual;
select to_char('123.1234', '999D9999', 'nls_numeric_characters='',.''') from dual;
select to_char('123.1234', '999D9999', 'nls_numeric_characters='';.''') from dual;

--EEEE
select to_char(.00000000000000000000000000000000129, '99D9EEEE') from dual;
select to_char(.00000000000000000000000000000000129, '99D9') from dual;
select to_char(.00000000000000000000000000000000129, '99D9EEE') from dual; 	--ORA-01481: invalid number format model

--G
select to_char(10000.4, '$99G999D00', 'nls_numeric_characters='',.'''), 
	   to_char(10000.4, '$99G999D00', 'nls_numeric_characters=''.,''') from dual;
select to_char('78', '9G9'), 
       to_char('00078', '09999G9999'), 
       to_char('00078', '9999G9999'),
	   to_char('78000', '99999G9') from dual;

--L/
select to_char('4','L99') from dual;
select to_char('4','L9', 'nls_currency=''$''') from dual;
select to_char('4','L9', 'nls_currency=''R$''') from dual;
select to_char('4','L9', 'nls_currency=''#''') from dual;

--MI
select to_CHAR('-1', '9MI') from dual;
select to_CHAR('1', '9MI') from dual;

--pr
select to_char('1', '99PR') from dual;
select to_char('-1', '99PR') from dual;
select to_char('12.4', '99D9pr') from dual;
select to_char('-12.4', '99D9pr') from dual;

--RN 
-- formato apenas de saída. só funciona com to_char. (https://www.orafaq.com/forum/t/199599/)
select to_char(10, 'RN') from dual;

--S
select to_char('5', 'S9') from dual;
select to_char('-5', '9S') from dual;
select to_char('-5', 'S9') from dual;

--TM
-- formato apenas de saída. só funciona com to_char
select to_char('500000000' ,'TME') from dual;
select to_char('500000000' ,'TM9') from dual;
select to_char('500000000' ,'TM') from dual;
select to_char('5000000000000' ,'TME') from dual;
select to_char('00000000005000000000000.00001' ,'TM') from dual;

--U
select to_char(19, 'U99') from dual;

--V
select to_char(10, '99V99') from dual -- só consegue encontrar aplicação na função to_char

-- XXXX
select to_char('1', 'X') from dual;
select to_char('1', 'XX') from dual;
select to_char('1', 'XXX') from dual;
select to_char('1', 'XXXX') from dual;
select to_char('12', 'X') from dual;
select to_char('123', 'X') from dual;

--NLS parameter
select to_char(to_number('#40.000,9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters='',.'''), 'L999G999D99', 'nls_currency=''&''') from dual;
select to_char(to_number('#40,000.9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,''')) from dual;
select to_char(to_number('#40,000.9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,'' nls_iso_currency=''BRAZIL''')
          , 'L999G999D99', 'nls_iso_currency=''BRAZIL''') from dual;
select to_char(to_number('BRL40,000.9','C999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,'' nls_iso_currency=''BRAZIL''')
          , 'C999G999D99', 'nls_numeric_characters='',.''') from dual;


-- date parameter
select sysdate,  to_char(sysdate, 'DAY "THE" DD "OF" MONTH, RRRR') from dual;
select sysdate,  to_char(sysdate, 'FMDAY "THE" DD "OF" MONTH, RRRR') from dual; -- remove espaços após o valor retornado em cada modelo de formato
select sysdate,  to_char(sysdate, 'FMDay, "the" Dd "of" Month, RRRR') from dual;
select sysdate,  to_char(sysdate, 'FMDay, "the" Ddth "of" Month, RRRR') from dual;
select to_char(sysdate, 'HH24:MI:SS PM') from dual

SELECT to_char(TO_DATE('01-JAN-49', 'DD-MON-YY'), 'YYYY'),
       TO_CHAR(TO_DATE('01-JAN-50', 'DD-MON-YY'), 'YYYY'),
       to_char(TO_DATE('01-JAN-49', 'DD-MON-YY'), 'RRRR'),
       TO_CHAR(TO_DATE('01-JAN-50', 'DD-MON-YY'), 'RRRR'),
       TO_CHAR(TO_DATE('01-JAN-49', 'DD-MON-RR'), 'RRRR'),
       TO_CHAR(TO_DATE('01-JAN-50', 'DD-MON-RR'), 'RRRR'),
       TO_CHAR(TO_DATE('01-JAN-49', 'DD-MON-RR'), 'YYYY'),
       TO_CHAR(TO_DATE('01-JAN-50', 'DD-MON-RR'), 'YYYY') 
FROM DUAL;

SELECT TO_CHAR(TO_DATE('01-JUL-16 00-00-00','DD-MON-YY HH24-MI-SS'),'DD-MON-YY HH24-MI-SS PM'),
       TO_CHAR(TO_DATE('01-JUL-16 00-00-00','DD-MON-YY HH24-MI-SS'),'DD-MON-YY HH12-MI-SS PM')
       FROM DUAL; 
	   

select to_char(sysdate, 'dd-mm-rrrr hh24:mi:ss') from dual;

-- AD/BC
select to_char(to_date('1-JUL-16 00-00-00 BC','DD-MON-YY HH24-MI-SS ad'), 'dd-mm-rrrr hh24:mi:ss BC') from dual;
select to_char(to_date('1-JUL-16 00-00-00 AD','DD-MON-YY HH24-MI-SS ad'), 'dd-mm-rrrr hh24:mi:ss BC') from dual;

-- AM/PM
exemplo acima

--CC/SCC
select
    to_char(sysdate, 'CC'),
    to_char(sysdate, 'SCCth'), 
    to_char(to_date('01-01-1985', 'dd-mm-rrrr'), 'dd-mm-rrrr CCth'), 
    to_char(to_date('01-01-2101', 'dd-mm-rrrr'), 'dd-mm-rrrr CCth') from dual;
	
-- D
select to_char(sysdate, ' "The" Dth " day of the week"') from dual;

-- DAY
select to_char(sysdate, '" Day of the week" Day' ) from dual;
	   
-- DD
exemplo acima

-- DDD
select to_char(sysdate, 'DDDth "Day of the year"') from dual;

--DL
select to_char(sysdate, 'DL', 'nls_date_language=Portuguese' ) from dual;
select to_char(sysdate, 'DL', 'nls_date_language=''Portuguese''' ) from dual;
select to_char(sysdate, 'DL', 'nls_date_language=''English''') from dual;

Não podem ser usados em função:
NLS_LANGUAGE
NLS_TERRITORY
NLS_DATE_FORMAT

--DS definido pelos parametros acima
select to_char(sysdate, 'DS' ) from dual;

--DY
select to_char(sysdate, 'DY') from dual;
select to_char(sysdate, '"day of the week" DY') from dual;
select to_char(sysdate, 'DY', 'nls_date_language=''Portuguese''') from dual;
select to_char(sysdate, 'DY', 'nls_date_language=Portuguese') from dual;

-- E
select to_char(sysdate, '"Era atual é" E') from dual;--ORA-01822

-- EE
select to_char(sysdate, '"Era atual é" EE') from dual;--ORA-01822	

-- FF
select to_char(sysdate, 'DD-MM-YYYY HH24:MI:SS:FF') from dual; --ORA-01821: date format not recognized
select to_char(cast (sysdate as timestamp), 'DD-MM-YYYY HH24:MI:SS:FF') from dual;

-- FM 
exemplo acima

--FX 
select to_date('10-06-2021', 'dd/mm/yyyy') from dual;
select to_date('10-06-2021', 'fxdd/mm/yyyy') from dual; --	ORA-01861: literal does not match format string
select to_date('10/06/2021', 'dd-mm-yyyy') from dual;
select to_date('10/06/2021', 'fxdd-mm-yyyy') from dual; --	ORA-01861: literal does not match format string

--HH/HH12
exemplo acima

--HH24
exemplo acima

--IW
select to_char(sysdate, 'IW') from dual;

-- I/IY/IYY
select to_char(sysdate, 'I') from dual;
select to_char(sysdate, 'IY') from dual;
select to_char(sysdate, 'IYY') from dual;

-- J
select to_char(sysdate, 'J') from dual;

-- MI
exemplo acima

-- MM
exemplo acima

--MON
exemplo acima

--MONTH
exemplo acima

--PR
exemplo em to_char e to_number

--Q
select to_char(sysdate, 'Q') from dual;

--RM
select to_char(sysdate, 'RM') from dual;

--RR
exemplo acima

-- RRRR
exemplo acima

--SS
exemplo acima

--SSSS
select to_char(sysdate, 'SSSS') from dual;

--TS
select to_char(sysdate, 'TS') from dual;

-- TZD / TZH / TZM / TZR
valido apenas com timestamp ou interval
select to_char( cast (sysdate as timestamp), 'TZD') from dual;
select to_char( cast (sysdate as timestamp), 'TZH') from dual;--	ORA-01821: date format not recognized
select to_char( cast (sysdate as timestamp), 'TZR') from dual;
select to_char( cast (sysdate as timestamp), 'TZM') from dual;--	ORA-01821: date format not recognized

-- WW
mesma coisa do IW
select to_char( sysdate, 'WWth "week of the year"') from dual;

-- W
select to_char( sysdate, 'Wth "week of the month"') from dual;

--X
select to_char(cast(sysdate as timestamp), 'SSXFF3') from dual;

-- Y,YYY
select to_char( sysdate, 'y,yyy') from dual;

-- year/SYEAR
select to_char( sysdate, 'year'), to_char( sysdate, 'SYEAR') from dual;

--YYYY/SYYYY
select to_char( sysdate, 'YYYY'), to_char( sysdate, 'SYYYY') from dual;

-- YYY/YY/Y
select to_char( sysdate, 'YYY'), to_char( sysdate, 'YY'), to_char( sysdate, 'Y') from dual;

-- -/,.;:
pontuação aceita e passada do mesmo jeito que aparece

-----------------
---- to_date ----
-----------------

select to_date('2016-01-31', 'RRRR-MM-DD') FROM DUAL;

--DL
select to_date('Friday, June 18, 2021', 'DL') from dual;

--J
select to_date('2459384', 'J') from dual;

--ww
select to_date('25', 'ww') from dual; --ORA-01820: format code cannot appear in date input format



-- to_timestamp
select to_timestamp('2020-JAN-01 13:34:00.093423') from dual;

--to_timestamp_tz
select to_timestamp_tz('2021-06-18 00:40:01', 'YYYY-MM-DD HH24:MI:SS') from dual;

--to_yminterval
select to_yminterval('06-05') from dual;