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
select cast(0.000123 as number(2,6)) from dual;
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




                           
                            
