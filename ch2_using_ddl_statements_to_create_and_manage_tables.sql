-- 2 QUOTED NAMES

CREATE TABLE "Companies" (company_id NUMBER);

INSERT INTO INVENTORY.Companies VALUES (1); --FAIL
INSERT INTO INVENTORY1."Companies" VALUES (1);
COMMIT;

SELECT * FROM Companies; --FAIL
SELECT * FROM "Companies";

CREATE TABLE "Company Employees" (
    employee_id NUMBER,
    name VARCHAR2(35)
);

SELECT * FROM "Company Employees";
SELECT * FROM "company employees"; --FAIL

-- Data Types for columns

-- Number(n,m)
select cast(0.0001 as number(2,5)) as num, 
       to_char(cast(0.0001 as number(2,5))) as cnum,
       dump(cast(0.0001 as number(2,5))) as dmp from dual;
       
select cast(.0000123 as number(6, 9)) from dual;       
select cast(.000012345 as number(6, 9)) from dual;
select cast(.123456 as number(3, 4)) from dual; -- ERROR
select cast(0.013579 as number(3, 4)) from dual;

select cast(0.000123 as number(2,5)) from dual;
select cast(0.00123 as number(2,5)) from dual; -- ERROR
select cast(0.000123 as number(2,6)) from dual; -- ERROR
select cast(0.000999 as number(2,5)) from dual; -- ERROR

select cast(4.56 as number) from dual;
select cast(4.56 as number(2)) from dual;
select cast(4.56 as number(5,2)) from dual;
select cast(4.5678 as number(5,2)) from dual;
select cast(10.59 as number(4,2)) from dual;
select cast(10.59 as number(4,1)) from dual;
select cast(10.59 as number(3,2)) from dual; -- ERROR

select cast(1059.34 as number(5,-2)) from dual;
select cast(999.34 as number(3,-2)) from dual;

select cast(999.34 as number(3,-1)) from dual;
select cast(9999.34 as number(3,-2)) from dual;
select cast(99999.34 as number(3,-3)) from dual;
select cast(999999.34 as number(3,-3)) from dual; -- Error: valor maior que a precisão especificada usado para esta coluna
select cast(999.34 as number(3,-3)) from dual;
select cast(99.34 as number(3,-3)) from dual;
select cast(999.34 as number(3,-2)) from dual;

-- CONSTRAINT
CREATE TABLE positions (
    position_id NUMBER,
    position VARCHAR2(20),
    exempt CHAR(1),
    CONSTRAINT positions_pk PRIMARY KEY (position_id)
);
                             
  -- CONSTRAINT
CREATE TABLE positions (
    position_id NUMBER,
    position VARCHAR2(20),
    exempt CHAR(1),
    CONSTRAINT positions_pk PRIMARY KEY (position_id)
);

CREATE TABLE PORTS(
    PORT_ID NUMBER PRIMARY KEY,
    PORT_NAME VARCHAR2(20)
);

CREATE TABLE PORTS(
    PORT_ID NUMBER CONSTRAINT PORT_ID_PD PRIMARY KEY,
    PORT_NAME VARCHAR2(20)
);

CREATE TABLE VENDORS(
    VENDOR_ID NUMBER,
    VENDOR_NAME VARCHAR2(20),
    STATUS NUMBER(1) NOT NULL,
    CATEGORY VARCHAR2(5)
);

CREATE TABLE VENDORS(
    VENDOR_ID NUMBER,
    VENDOR_NAME VARCHAR2(20),
    STATUS NUMBER(1) CONSTRAINT STATUS_NN NOT NULL,
    CATEGORY VARCHAR2(5)
);

CREATE TABLE VENDORS(
    VENDOR_ID NUMBER PRIMARY KEY,
    VENDO_NAME VARCHAR2(20),
    STATUS NUMBER(1) CONSTRAINT STATUS_NN NOT NULL,
    CATEGORY VARCHAR2(5)
);

CREATE TABLE PORTS(
    PORT_ID NUMBER,
    PORT_NAME VARCHAR2(20),
    PRIMARY KEY(PORT_ID)
);

CREATE TABLE PORTS(
    PORT_ID NUMBER,
    PORT_NAME VARCHAR2(20),
    CONSTRAINT PORT_ID_PK PRIMARY KEY(PORT_ID)
);

CREATE TABLE PORTS(
    PORT_ID NUMBER,
    PORT_NAME VARCHAR2(20)
);
ALTER TABLE PORTS MODIFY PORT_ID PRIMARY KEY;
ALTER TABLE PORTS MODIFY PORT_ID CONSTRAINT PORT_ID_PK PRIMARY KEY;
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'PORTS';
ALTER TABLE PORTS RENAME CONSTRAINT SYS_C0095400856 TO PORT_ID_PK

ALTER TABLE PORTS ADD PRIMARY KEY (PORT_ID);
ALTER TABLE PORTS ADD CONSTRAINT PORT_ID_PK PRIMARY KEY (PORT_ID)

DROP TABLE PORTS;

-- ERROR(NOT NULL CONSTRAINT OUT OF LINE)                            
CREATE TABLE PORTS (
    PORT_ID NUMBER,
    PORT_NAME VARCHAR2(20),
    NOT NULL (PORT_ID)
);

-- ERROR(NOT NULL CONSTRAINT OUT OF LINE)
CREATE TABLE PORTS(
    PORT_ID NUMBER,
    PORT_NAME VARCHAR2(20),
    CONSTRAINT NN_PORT_ID NOT NULL (PORT_ID)
);

-- ERROR(NOT NULL CONSTRAINT OUT OF LINE)
ALTER TABLE PORTS
    ADD NOT NULL (PORT_NAME);
                             
-- ERROR(NOT NULL CONSTRAINT OUT OF LINE)    
ALTER TABLE PORTS
    ADD CONSTRAINT NN_PORT_NAME NOT NULL (PORT_NAME);

ALTER TABLE PORTS
    MODIFY PORT_NAME NOT NULL;
    
ALTER TABLE PORTS
    MODIFY PORT_NAME CONSTRAINT NN_PORT_NAME NOT NULL;
                             
CREATE TABLE EMPLOYEES (
    employee_id NUMBER,
    ship_id NUMBER,
    first_name VARCHAR2(20),
    last_name VARCHAR2(30),
    position_id NUMBER,
    CONSTRAINT employees_pk PRIMARY KEY (employee_id)
);

CREATE TABLE HelpDesk(
    HD_Category VARCHAR2(8),
    HD_Year NUMBER,
    HD_Ticket_No NUMBER,
    HD_Title VARCHAR2(30),
    CONSTRAINT HelpDesk_PK PRIMARY KEY (HD_Category, HD_Year, HD_Ticket_NO)
);                            

CREATE TABLE PORTS(
    PORT_ID NUMBER,
    PORT_NAME VARCHAR2(20),
    COUNTRY VARCHAR2(40),
    CAPACITY NUMBER,
    CONSTRAINT PORT_PK PRIMARY KEY (PORT_ID)
);

CREATE TABLE SHIPS(
    SHIP_ID NUMBER,
    SHIP_NAME VARCHAR2(20),
    HOME_PORT_ID NUMBER,
    CONSTRAINT SHIPS_PORTS_FK FOREIGN KEY (HOME_PORT_ID) REFERENCES PORTS(PORT_ID)
);
DROP TABLE SHIPS
CREATE TABLE SHIPS(
    SHIP_ID NUMBER,
    SHIP_NAME VARCHAR2(20),
    HOME_PORT_ID NUMBER NOT NULL,
    CONSTRAINT SHIPS_PORTS_FK FOREIGN KEY (HOME_PORT_ID) REFERENCES PORTS(PORT_ID)
);

DESC SHIPS

create tabLE SHIPS(
    SHIP_ID NUMBER,
    SHIP_NAME VARCHAR2(20),
    HOME_PORT_ID NUMBER NOT NULL,
    CONSTRAINT SHIPS_PORTS_FK FOREIGN KEY (HOME_PORT_ID)
               REFERENCES PORTS(PORT_ID)
               ON DELETE SET NULL
);
                             
CREATE TABLE SHIPS(
    SHIP_ID NUMBER,
    SHIP_NAME VARCHAR2(20),
    HOME_PORT_ID NUMBER CONSTRAINT SHIPS_PORTS_FK REFERENCES PORTS (PORT_ID) ON DELETE SET NULL
);    
                             
CREATE TABLE SHIPS(
    SHIP_ID NUMBER,
    SHIP_NAME VARCHAR2(20),
    HOME_PORT_ID NUMBER REFERENCES PORTS (PORT_ID) ON DELETE SET NULL
);                               

CREATE TABLE SHIPS(
    SHIP_ID NUMBER,
    SHIP_NAME VARCHAR2(20),
    HOME_PORT_ID NUMBER REFERENCES PORTS (PORT_ID) ON DELETE SET NULL
);                             
                             
                             
INSERT INTO PORTS VALUES (1, 'TESTE1');
INSERT INTO SHIPS VALUES (1, 'SHIP1', 1);
DELETE FROM PORTS; -- erro se constraint not null  for aplicada na coluna que é foreign key e tem on delete set null
                   -- tirando a constraint not null o delete from ports apaga e a coluna home_port_id é setada para null          

create tabLE SHIPS(
    SHIP_ID NUMBER,
    SHIP_NAME VARCHAR2(20),
    HOME_PORT_ID NUMBER,
    CONSTRAINT SHIPS_PORTS_FK FOREIGN KEY (HOME_PORT_ID)
               REFERENCES PORTS(PORT_ID)
               ON DELETE CASCADE
);
                             
CREATE TABLE VENDORS(
    VENDOR_ID NUMBER,
    VENDOR_NAME VARCHAR2(20),
    STATUS NUMBER(1) CHECK( STATUS IN (4,5)),
    CATEGORY VARCHAR2(5)
);
                           
CREATE TABLE VENDORS(
    VENDOR_ID NUMBER,
    VENDOR_NAME VARCHAR2(20),
    STATUS NUMBER(1),
    CATEGORY VARCHAR2(5),
    CONSTRAINT STATUS_CC CHECK( STATUS IN (4,5)) 
);
                               
ALTER TABLE VENDORS MODIFY STATUS CHECK (STATUS IN (4,5));
ALTER TABLE VENDORS MODIFY STATUS CONSTRAINT STATUS_C CHECK(STATUS IN (4,5));

ALTER TABLE VENDORS ADD CHECK(STATUS IN (4,5));
ALTER TABLE VENDORS ADD CONSTRAINT STATUS_CCCC CHECK(STATUS IN (5,6));
ALTER TABLE VENDORS ADD CONSTRAINT STATUS_CCC CHECK(STATUS IN (4,5));                               
                             
-- DROP COLUMN FROM TABLE
                                                               
ALTER TABLE SHIPS DROP COLUMN SHIP_NAME;
ALTER TABLE SHIPS DROP (SHIP_NAME) ;
ALTER TABLE SHIPS DROP (SHIP_NAME, HOME_PORT_ID);
ALTER TABLE SHIPS DROP (SHIP_ID, SHIP_NAME, HOME_PORT_ID); -- Erro. não pode remover todas as colunas de uma tabela.

CREATE TABLE CRUISE_ORDERS(
    CRUISE_ORDER_ID NUMBER,
    ORDER_DATE DATE,
    CONSTRAINT PK_CO PRIMARY KEY(CRUISE_ORDER_ID)
);
CREATE TABLE ORDER_RETURNS(
    ORDER_RETURN_ID NUMBER,
    CRUISE_ORDER_ID NUMBER,
    CRUISE_ORDER_dATE DATE,
    CONSTRAINT PK_OR PRIMARY KEY(ORDER_RETURN_ID),
    CONSTRAINT FK_OR_CO FOREIGN KEY (CRUISE_ORDER_ID)
               REFERENCES CRUISE_ORDERS(CRUISE_ORDER_ID) 
);

ALTER TABLE CRUISE_ORDERS DROP (CRUISE_ORDER_ID); -- Error ORA-12992: não é possível eliminar uma coluna-chave mãe                                                               
ALTER TABLE CRUISE_ORDERS DROP (CRUISE_ORDER_ID) CASCADE CONSTRAINT;
ALTER TABLE CRUISE_ORDERS DROP COLUMN CRUISE_ORDER_ID CASCADE CONSTRAINT;
                                                               
ALTER TABLE ORDER_RETURNS DROP COLUMN CRUISE_ORDER_ID;
                                                               
CREATE TABLE CRUISE_ORDERS(
    CRUISE_ORDER_ID NUMBER,
    ORDER_DATE DATE,
    CONSTRAINT PK_CO PRIMARY KEY(CRUISE_ORDER_ID, ORDER_DATE)
);
CREATE TABLE ORDER_RETURNS(
    ORDER_RETURN_ID NUMBER,
    CRUISE_ORDER_ID NUMBER,
    CRUISE_ORDER_dATE DATE,
    CONSTRAINT PK_OR PRIMARY KEY(ORDER_RETURN_ID),
    CONSTRAINT FK_OR_CO FOREIGN KEY (CRUISE_ORDER_ID, CRUISE_ORDER_DATE)
               REFERENCES CRUISE_ORDERS(CRUISE_ORDER_ID, ORDER_DATE) 

);                                                               
ALTER TABLE ORDER_RETURNS DROP COLUMN CRUISE_ORDER_ID; -- ERRO ORA-12991: a coluna é indicada em uma restrição de várias colunas
ALTER TABLE ORDER_RETURNS DROP ( CRUISE_ORDER_ID, CRUISE_ORDER_DATE);
ALTER TABLE ORDER_RETURNS DROP ( CRUISE_ORDER_ID) CASCADE CONSTRAINTS;                                                              
                                                               
