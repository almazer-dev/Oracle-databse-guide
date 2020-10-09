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

select to_number(' 12', '99') from dual; --?
select to_number('2', 'B999') from dual; --?
select to_number('  12', '99') from dual; --?


select to_number('222', 'C999') from dual;--?

select to_number('1-', '9MI') from dual;
select to_number('1 ', '9MI') from dual;
select to_number('1 ', '9') from dual; --ORA-01722: número inválido

select to_number('<1>', '99PR') from dual;
select to_number('1', '99PR') from dual;
