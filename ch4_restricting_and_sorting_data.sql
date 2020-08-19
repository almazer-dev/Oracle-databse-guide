SELECT ADDRESS_ID, STREET_ADDRES, CITY, STATE ,COUNTRY
FROM ADDRESSES
ORDER BY STATE;

SELECT ADDRESS_ID, STREET_ADDRES, CITY, STATE ,COUNTRY
FROM ADDRESSES
ORDER BY STATE, CITY;

SELECT STATE, CITY, ADDRESS_ID, STREET_ADDRES ,COUNTRY
FROM ADDRESSES
ORDER BY STATE, CITY;

SELECT ADDRESS_ID, STREET_ADDRES ,COUNTRY
FROM ADDRESSES
ORDER BY STATE, CITY;

-- ASC DESC

SELECT SHIP_ID, PROJECT_COST, PROJECT_NAME, DAYS
FROM PROJECTS
ORDER BY SHIP_ID ASC; -- asc é o valor default

SELECT SHIP_ID, PROJECT_COST, PROJECT_NAME, DAYS
FROM PROJECTS
ORDER BY SHIP_ID ASC, PROJECT_COST DESC; 

-- EXPRESSIONS

SELECT *
FROM PROJECTS
ORDER BY PROJECT_COST / DAY;

SELECT PROJECT_ID, PROJECT_NAME, PROJECT_COST, DAYS, PROJECT_COST/DAYS
FROM PROJECTS
ORDER BY PROJECT_COST / DAYS;

-- ALIAS
SELECT PROJECT_ID, PROJECT_NAME, PROJECT_COST, DAYS, PROJECT_COST/DAYS AS PER_DAY_COST
FROM PROJECTS
ORDER BY PER_DAY_COST;

SELECT PROJECT_ID, PROJECT_NAME, PROJECT_COST, DAYS, PROJECT_COST/DAYS AS "Cost per Day"
FROM PROJECTS
ORDER BY "Cost per Day";

select port_id "Port ID" from ports
order by "Port id"; -- ORA-00904: "Port id": identificador inválido

-- reference by position

SELECT PROJECT_ID, PROJECT_NAME, PROJECT_COST, DAYS, PROJECT_COST/DAYS
FROM PROJECTS
ORDER BY 5;

select port_id "Port ID" from ports
order by 2; --ORA-01785: o item ORDER BY deve ser o número de uma expressão SELECT -list

-- COMBINATIONS

SELECT SHIP_ID, PROJECT_COST, PROJECT_NAME "The Project", DAYS
FROM PROJECTS
ORDER BY SHIP_ID DESC, "The Project", 2;

-- WHERE CLAUSE

SELECT EMPLOYEE_ID
FROM WORK_HISTORY
WHERE SHIP_ID = 3;

SELECT PORT_NAME, CAPACITY
FROM PORTS
WHERE CAPACITY >= 5;

-- Comparing data types

SELECT * FROM EMPLOYEES
WHERE LAST_NAME = 'Smith';

SELECT * FROM EMPLOYEES
WHERE LAST_NAME = 'SMITH';

SELECT PORT_NAME
FROM PORTS
WHERE PORT_NAME LIKE 'San ____';

SELECT PORT_NAME
FROM PORTS
WHERE PORT_NAME LIKE 'San%';

SELECT PORT_NAME
FROM PORTS
WHERE PORT_NAME LIKE '_o%';

SELECT PORT_NAME
FROM PORTS
WHERE'G_and%' LIKE PORT_NAME;

SELECT PORT_NAME
FROM PORTS
WHERE PORT_NAME LIKE 'G_and%';

-- BOOLEAN OPERATORS

SELECT EMPLOYEE_ID
FROM WORK_HISTORY
WHERE SHIP_ID = 3
AND
STATUS = 'Pending'

SELECT EMPLOYEE_ID
FROM WORK_HISTORY
WHERE SHIP_ID = 3
AND
NOT STATUS = 'Pending'

SELECT EMPLOYEE_ID
FROM WORK_HISTORY
WHERE NOT SHIP_ID = 3

SELECT EMPLOYEE_ID
FROM WORK_HISTORY
WHERE SHIP_ID <> 3

SELECT EMPLOYEE_ID
FROM WORK_HISTORY
WHERE SHIP_ID != 3

--- PRECEDENCE: NOT, AND, OR nessa ordem. a menos que parenteses sejam utilizados, eles tem maior precedencia.

create table SHIP_CABINS(
    ROOM_NUMBER NUMBER(3),
    STYLE VARCHAR2(30),
    WINDOW VARCHAR2(30)
);

ALTER TABLE SHIP_CABINS MODIFY ROOM_NUMBER CONSTRAINT PK_ROOM_NUMBER PRIMARY KEY;
ALTER TABLE SHIP_CABINS ADD CHECK(WINDOW IN ('Ocean', 'None'));

insert into ship_cabins values(102, 'Suite', 'Ocean');
insert into ship_cabins values(103, 'State', 'Ocean');
insert into ship_cabins values(104, 'Suite', 'None');
insert into ship_cabins values(105, 'State', 'Ocean');
insert into ship_cabins values(106, 'Suite', 'None');
commit;

SELECT * 
FROM
    SHIP_CABINS
WHERE
    STYLE = 'Suite'
OR  STYLE = 'State'
AND WINDOW = 'Ocean';

SELECT * 
FROM
    SHIP_CABINS
WHERE
    (STYLE = 'Suite'
OR  STYLE = 'State')
AND WINDOW = 'Ocean';

SELECT PORT_NAME
FROM PORTS
WHERE COUNTRY IN ('UK', 'USA', 'Bahamas');

SELECT PORT_NAME
FROM PORTS
WHERE COUNTRY NOT IN ('UK', 'USA', 'Bahamas');

SELECT PORT_NAME
FROM PORTS
WHERE NOT COUNTRY IN ('UK', 'USA', 'Bahamas');

SELECT PORT_NAME
FROM PORTS
WHERE CAPACITY BETWEEN 3 AND 4; --IGUAL A CAPACITY >= 3 AND CAPACITY <= 4

SELECT PORT_NAME
FROM PORTS
WHERE NOT CAPACITY BETWEEN 3 AND 4; --IGUAL A CAPACITY < 3 AND CAPACITY > 4

SELECT PORT_NAME
FROM PORTS
WHERE CAPACITY NOT BETWEEN 3 AND 4; --IGUAL A CAPACITY < 3 AND CAPACITY > 4

SELECT PORT_NAME
FROM PORTS
WHERE CAPACITY = NULL; -- SEMPRE RETORNA FALSE

SELECT PORT_NAME
FROM PORTS
WHERE CAPACITY IS NULL;

SELECT PORT_NAME
FROM PORTS
WHERE CAPACITY IS NOT NULL;

-- SQL PLUS COMMANDS

SELECT ROOM_NUMBER, STYLE, WINDOW
FROM SHIP_CABINS
WHERE ROOM_NUMBER = &NRO
ORDER BY ROOM_NUMBER;

SELECT ROOM_NUMBER, STYLE, WINDOW
FROM SHIP_CABINS
WHERE WINDOW = '&WNDW'
ORDER BY win;

SELECT &COLUMNS --ROOM_NUMBER, STYLE, WINDOW
FROM SHIP_CABINS
;

DEFINE
DEFINE WNDW = Ocean
undefine wndw

show all
show define 
show verify
set verify off
set ver on

-- script
prompt welcome to our script. This report will look up data
prompt using the room number you provide
accept vRoomNumber prompt "Enter the room number"
SELECT ROOM_NUMBER, STYLE, WINDOW
FROM SHIP_CABINS
WHERE ROOM_NUMBER = &vRoomNumber
ORDER BY ROOM_NUMBER;
prompt Remenber you asked for information for roomm number &vRoomNumber

show echo
set echo on
-- script
set echo on
set verify off

set define off
show define
set define *
show define

SELECT ROOM_NUMBER, STYLE, WINDOW
FROM SHIP_CABINS
WHERE window = '&vWin';

SELECT ROOM_NUMBER, STYLE, WINDOW
FROM SHIP_CABINS
WHERE window = '*vWin';

set define ## -- apenas um caracter permitido

-- ROW LIMITING CLAUSE

SELECT * FROM ORDERS
FETCH FIRST ROWS ONLY; -- retorna apenas uma linha

SELECT * FROM ORDERS
FETCH FIRST 8 ROWS ONLY;

SELECT * FROM ORDERS
FETCH 50 PERCENT ROWS ONLY;

select * from ship_cabins
fetch next  percent rows only; --	ORA-00904: "PERCENT": identificador inválido

insert into ship_cabins values(107, 'Suite', 'Ocean');
insert into ship_cabins values(108, 'Suite', 'Ocean');
insert into ship_cabins values(109, 'Suite', 'Ocean');
insert into ship_cabins values(110, 'Suite', 'Ocean');
insert into ship_cabins values(111, 'Suite', 'Ocean');
insert into ship_cabins values(112, 'Suite', 'Ocean');
insert into ship_cabins values(113, 'Suite', 'Ocean');
insert into ship_cabins values(114, 'Suite', 'Ocean');

select * from ship_cabins
order by window
fetch first 50 percent rows only;

select * from ship_cabins
order by window
fetch first 50 percent rows with ties;

select * from ship_cabins
fetch first 50 percent rows with ties;

select * from ship_cabins
order by room_number
offset -1 rows fetch first 5 rows only;

select * from ship_cabins
order by room_number
offset 5 rows fetch first 5 rows only;

select * from ship_cabins
order by room_number
offset 10 rows fetch first 5 rows only;

select * from ship_cabins
order by room_number
offset 15 rows fetch first 5 rows only;
