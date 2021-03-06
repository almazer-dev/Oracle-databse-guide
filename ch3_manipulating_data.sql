-- TRUNCATE

CREATE TABLE PORTS(
    PORT_ID NUMBER,
    PORT_NAME VARCHAR2(20),
    COUNTRY VARCHAR2(40),
    CAPACITY NUMBER,
    CONSTRAINT PORT_PK PRIMARY KEY(PORT_ID)
);
CREATE TABLE SHIPS(
    SHIP_ID NUMBER,
    SHIP_NAME VARCHAR2(20),
    HOME_PORT_ID NUMBER,
    CONSTRAINT SHIPS_PORT_FK FOREIGN KEY(HOME_PORT_ID)
        REFERENCES PORTS(PORT_ID)
);
INSERT INTO PORTS(PORT_ID)VALUES(1);
INSERT INTO SHIPS(SHIP_ID, HOME_PORT_ID)VALUES(1,1);
SELECT * FROM SHIPS;
TRUNCATE TABLE PORTS; ORA-02266: chaves exclusiva/primária na tabela referenciadas por chaves externas ativadas

ALTER TABLE SHIPS DROP CONSTRAINT SHIPS_PORT_FK; 
ALTER TABLE SHIPS MODIFY HOME_PORT_ID REFERENCES PORTS(PORT_ID) ON DELETE CASCADE;
TRUNCATE TABLE PORTS; ORA-02266: chaves exclusiva/primária na tabela referenciadas por chaves externas ativadas

TRUNCATE TABLE PORTS CASCADE;

ALTER TABLE SHIPS DROP CONSTRAINT SHIPS_PORT_FK; 
ALTER TABLE SHIPS MODIFY HOME_PORT_ID REFERENCES PORTS(PORT_ID) ON DELETE set null;
TRUNCATE TABLE PORTS CASCADE; --ORA-14705: chaves exclusiva ou primária na tabela referenciadas por chaves externas ativadas na tabela "ANGELOLMORACLE"."SHIPS"

-- INSERT

create table cruises (
    CRUISE_ID NUMBER NOT NULL,
    CRUISE_TYPE_ID NUMBER,
    CRUISE_NAME VARCHAR2(20),
    CAPTAIN_ID NUMBER NOT NULL,
    START_DATE DATE,
    END_DATE DATE,
    STATUS VARCHAR2(20)
);


DESC CRUISES;

INSERT INTO CRUISES
(CRUISE_ID, CRUISE_TYPE_ID, CRUISE_NAME, CAPTAIN_ID, START_DATE, END_DATE, STATUS)
VALUES
(1, 1, 'Day at Sea', 101, '02-jan-10', '09-jan-10', 'Sched');

-- Enumerated Column List
insert into cruises
(cruise_id, cruise_name, status, captain_id, start_date, end_date)
values
(2, 'Bermuda and Back', 'Done', 101, '07-FEV-08', '14-FEV-08');

-- Data type conversion
insert into cruises
(cruise_id, captain_id)
values
(2, '101');

-- INSERT AND CONSTRAINTS

create table cruises (
    CRUISE_ID NUMBER NOT NULL,
    CRUISE_TYPE_ID NUMBER,
    CRUISE_NAME VARCHAR2(20),
    START_DATE DATE,
    END_DATE DATE,
    CONSTRAINT CRUISE_ID_PK PRIMARY KEY(CRUISE_ID),
    CONSTRAINT CRUISE_NAME_CK CHECK(CRUISE_NAME IN ('Hawaii', 'Bahamas', 'Bermuda', 'Mexico', 'Day at Sea'))
);

insert into cruises(cruise_id, cruise_name)values (1, 'angelo'); --ORA-02290: restrição de verificação (ANGELOLMORACLE.CRUISE_NAME_CK) violada

CREATE SEQUENCE SEQ_CRUISE_ID;

INSERT INTO CRUISES(CRUISE_ID, CRUISE_NAME) VALUES(SEQ_CRUISE_ID.nextval, 'Hawaii');
INSERT INTO CRUISES(CRUISE_ID, CRUISE_NAME) VALUES(SEQ_CRUISE_ID.nextval, 'Hawaii and Back'); --ORA-02290: restrição de verificação (ANGELOLMORACLE.CRUISE_NAME_CK) violada

-- UPDATE

update cruises set cruise_name = 'Bahamas', start_date= '1-12-11' WHERE CRUISE_ID = 1;

update compensation set salary = salary * 1.03, last_changed_date = sysdate where employ_number = 83;

create table projects(
    project_id number primary key,
    project_name varchar(20),
    cost number,
    constraint ck_cost check(cost < 1000000)  
);

insert into projects(project_id, project_name, cost) values (1, '', 340000);
insert into projects(project_id, project_name, cost) values (2, '', 964000);
insert into projects(project_id, project_name, cost) values (3, '', 12000);

update projects set cost = cost * 1.2; -- ORA-02290: restrição de verificação (ANGELOLMORACLE.CK_COST) violada

update projects set cost = cost * 1.2 where cost *1.2 < 1000000; -- duas linhas atualizadas

--  DELETE 

DELETE FROM PROJECT_LISTING WHERE CONSTRUCTION_ID = 1;
DELETE PROJECT_LISTING WHERE CONSTRUCTION_ID = 1;

-- Transaction Control Language (TCL)

COMMIT;
COMMIT WORK;

UPDATE SHIPS SET HOME_PORT_ID=12 WHERE SHIP_ID=31;
ALTER TABLE PORTS ADD AUTHORITY_NOTE VARCHAR2(20);

UPDATE SHIPS SET HOME_PORT_ID=12 WHERE SHIP_ID=31;
commit;

COMMIT;
INSERT INTO PORTS(PORT_ID, PORT_NAME)VALUES(701, 'Chicago');
DELETE FROM PORTS;
ROLLBACK;

COMMIT;
UPDATE SHIPS SET HOME_PORT_ID=21 WHERE SHIP_ID=12;
SAVEPOINT SP_1;
UPDATE SHIPS SET HOME_PORT_ID=22 WHERE SHIP_ID=12;
ROLLRACK WORK TO SP_1;
COMMIT;

COMMIT;
UPDATE SHIPS SET HOME_PORT_ID=21 WHERE SHIP_ID=12;
SAVEPOINT MARK_1;
UPDATE SHIPS SET HOME_PORT_ID=22 WHERE SHIP_ID=12;
SAVEPOINT MARK_2;
UPDATE SHIPS SET HOME_PORT_ID=23 WHERE SHIP_ID=12;
ROLLBACK TO MARK_2;
COMMIT;

COMMIT;
UPDATE SHIPS SET HOME_PORT_ID=21 WHERE SHIP_ID=12;
SAVEPOINT SP_1;
COMMIT;
ROLLRACK WORK TO SP_1; -- ERRO, SAVEPOINT INEXISTENTE


