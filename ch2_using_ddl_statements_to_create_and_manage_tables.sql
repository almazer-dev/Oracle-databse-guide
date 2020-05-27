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
