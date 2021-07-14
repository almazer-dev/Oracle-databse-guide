create table ship_shop(
    id number,
    item varchar2(20) ,
    price number ,
    primary key (id)
);

insert into ship_shop values(1, 'Towel', 21.99);
insert into ship_shop values(2, 'Postcard', 2.49);
insert into ship_shop values(3, 'Mug', 7.19);

select item, price, round(price) from ship_shop;

select avg(price) from ship_shop;

select round(price), avg(price) from ship_shop; --ORA-00937: not a single-group group function

select round(avg(price)) from ship_shop;
select avg(round(price)) from ship_shop;

group functions podem ser chamadas em 4 partes do select: 
1 - lista do select
2 - order by
3 - group by
4 - having

create table vendors(
    vendor_id number primary key,
    vendor_name varchar2(20),
    status number(3),
    category varchar2(10)
);

insert into vendors values(1, 'Acme Steaks', 17, null);
insert into vendors values(2, 'Acme Poker Ships', null, null);

select count(*), count(vendor_name), count(status), count(category) from vendors;

-- count nunca retorna null. diferente de outras funções de grupo
-- count(*) retorna o total de linhas mesmo que todas as colunas sejam nulas

select count(distinct vendor_name), count(all vendor_name) from vendors;

--DISTINCT e ALL não podem ser usados com *

select sum(subtotal) from orders;
select sum(subtotal) 
from orders 
where to_char(order_date, 'MON-RR') = 'APR-17' 

--numeric: valores pequenos são MIN e valores maiores são MAX
--dates: datas mais recentes são menores que datas mais antigas
--char: A é menor que Z. Z é menor que a. a string 2 é maior que a string 100. o caracter 1 é menor que os caracteres 10
select min(last_name), max(last_name) from employees;


select round(avg(price),2) from ship_shop;

select to_char(round(avg(price),2), '$99,999.99') from ship_shop;
