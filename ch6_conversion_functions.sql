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
select to_char(19, 'U99') from dual;
select to_number('Cr$19', 'U99') from dual;

--V

-- XXXX
select to_number('123', 'XX') from dual; --	ORA-01722: invalid number
select to_number('123', 'XXX') from dual; 

--NLS parameter
select to_number('#40.000,9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters='',.''') from dual;
select to_number('#40,000.9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,''') from dual;
select to_number('#40,000.9','L999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,'' nls_iso_currency=''BRAZIL''') from dual;
select to_number('BRL40,000.9','C999G999D99', 'nls_currency=''#'' nls_numeric_characters=''.,'' nls_iso_currency=''BRAZIL''') from dual;
