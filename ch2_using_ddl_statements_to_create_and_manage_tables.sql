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