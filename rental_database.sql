/* =====================================================================
   CAR RENTAL DATABASE  (Rent-a-Car)
   Oracle Database / Oracle SQL Developer
   Author: Sava Alexandru-Ionut
   ---------------------------------------------------------------------
   Relational database for a multi-region car-rental company.
   Tracks fleet, clients, rentals and revenue.

   NOTE: Table and column names are in Romanian (academic project).
   Comments are in English for readability.
   Normalized up to 3NF.
   Run top to bottom in a clean schema.
   ===================================================================== */


/* =====================================================================
   1. TABLE CREATION (DDL)
   ===================================================================== */

CREATE TABLE RC_LOCATII (
    ID_LOCATIE    NUMBER(5) PRIMARY KEY,
    NUME_AGENTIE  VARCHAR2(50),
    ORAS          VARCHAR2(30),
    TARA          VARCHAR2(30),
    REGIUNE       VARCHAR2(30)
);

CREATE TABLE RC_CATEGORII (
    ID_CATEGORIE        NUMBER(5) PRIMARY KEY,
    DENUMIRE_CATEGORIE  VARCHAR2(30),
    PRET_ZILNIC         NUMBER(10, 2)
);

CREATE TABLE RC_CLIENTI (
    ID_CLIENT      NUMBER(5) PRIMARY KEY,
    NUME           VARCHAR2(30),
    PRENUME        VARCHAR2(30),
    EMAIL          VARCHAR2(50),
    DATA_NASTERII  DATE
);

CREATE TABLE RC_MASINI (
    ID_MASINA      NUMBER(5) PRIMARY KEY,
    MARCA          VARCHAR2(30),
    MODEL          VARCHAR2(30),
    AN_FABRICATIE  NUMBER(4),
    ID_CATEGORIE   NUMBER(5),
    ID_LOCATIE     NUMBER(5),
    CONSTRAINT FK_RC_MAS_CAT FOREIGN KEY (ID_CATEGORIE) REFERENCES RC_CATEGORII(ID_CATEGORIE),
    CONSTRAINT FK_RC_MAS_LOC FOREIGN KEY (ID_LOCATIE)  REFERENCES RC_LOCATII(ID_LOCATIE)
);

CREATE TABLE RC_INCHIRIERI (
    ID_INCHIRIERE  NUMBER(10) PRIMARY KEY,
    DATA_START     DATE DEFAULT SYSDATE,
    DATA_FINAL     DATE,
    ID_CLIENT      NUMBER(5),
    ID_MASINA      NUMBER(5),
    CONSTRAINT FK_RC_INC_CLI FOREIGN KEY (ID_CLIENT)  REFERENCES RC_CLIENTI(ID_CLIENT),
    CONSTRAINT FK_RC_INC_MAS FOREIGN KEY (ID_MASINA)  REFERENCES RC_MASINI(ID_MASINA),
    CONSTRAINT CHK_RC_DATE   CHECK (DATA_FINAL >= DATA_START)
);


/* =====================================================================
   2. STRUCTURE CHANGES (ALTER) + INTEGRITY CONSTRAINTS
   ===================================================================== */

ALTER TABLE RC_CLIENTI ADD TELEFON VARCHAR2(15);
ALTER TABLE RC_CLIENTI ADD CONSTRAINT UK_EMAIL UNIQUE (EMAIL);
ALTER TABLE RC_CATEGORII MODIFY DENUMIRE_CATEGORIE VARCHAR2(50);


/* =====================================================================
   3. SEED DATA (DML - INSERT)
   ===================================================================== */

-- Locations
INSERT INTO RC_LOCATII VALUES (10,  'Bucharest Airport',   'Bucuresti', 'Romania',   'Europe');
INSERT INTO RC_LOCATII VALUES (20,  'JFK Rentals',         'New York',  'SUA',       'America');
INSERT INTO RC_LOCATII VALUES (30,  'Tokyo Central',       'Tokyo',     'Japonia',   'Asia');
INSERT INTO RC_LOCATII VALUES (40,  'Cairo Wheels',        'Cairo',     'Egipt',     'Orientul mijlociu si Africa');
INSERT INTO RC_LOCATII VALUES (50,  'Berlin Hauptbahnhof', 'Berlin',    'Germania',  'Europe');
INSERT INTO RC_LOCATII VALUES (60,  'Paris CDG',           'Paris',     'Franta',    'Europe');
INSERT INTO RC_LOCATII VALUES (70,  'Madrid Barajas',      'Madrid',    'Spania',    'Europe');
INSERT INTO RC_LOCATII VALUES (80,  'Rome Fiumicino',      'Roma',      'Italia',    'Europe');
INSERT INTO RC_LOCATII VALUES (90,  'Dubai Intl',          'Dubai',     'UAE',       'Asia');
INSERT INTO RC_LOCATII VALUES (110, 'Sydney Kingsford',    'Sydney',    'Australia', 'Asia');

-- Categories
INSERT INTO RC_CATEGORII VALUES (1,  'Economy',     100);
INSERT INTO RC_CATEGORII VALUES (2,  'Compact',     150);
INSERT INTO RC_CATEGORII VALUES (3,  'SUV',         300);
INSERT INTO RC_CATEGORII VALUES (4,  'Luxury',      500);
INSERT INTO RC_CATEGORII VALUES (5,  'Van',         400);
INSERT INTO RC_CATEGORII VALUES (6,  'Electric',    450);
INSERT INTO RC_CATEGORII VALUES (7,  'Convertible', 600);
INSERT INTO RC_CATEGORII VALUES (8,  'Pickup 4x4',  350);
INSERT INTO RC_CATEGORII VALUES (9,  'Limousine',   1000);
INSERT INTO RC_CATEGORII VALUES (10, 'Hypercar',    2500);

-- Clients
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (100, 'Popescu',   'Ion',     'ion.pop@email.com',    TO_DATE('1990-05-12', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (101, 'Ionescu',   'Maria',   'maria.i@email.com',    TO_DATE('1985-10-20', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (102, 'Smith',     'John',    'john.s@email.com',     TO_DATE('1980-01-15', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (103, 'Tanaka',    'Ken',     'ken.t@email.com',      TO_DATE('1995-03-30', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (104, 'Muller',    'Hans',    'hans.m@email.com',     TO_DATE('1988-07-19', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (105, 'Doe',       'Jane',    'jane.doe@email.com',   TO_DATE('1992-12-05', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (106, 'Vasilescu', 'Dan',     'dan.v@email.com',      TO_DATE('1975-06-25', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (107, 'Brown',     'Charlie', 'charlie.b@email.com',  TO_DATE('1999-09-09', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (108, 'Garcia',    'Sofia',   'sofia.g@email.com',    TO_DATE('1991-02-14', 'YYYY-MM-DD'));
INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII) VALUES (109, 'Ahmed',     'Omar',    'omar.a@email.com',     TO_DATE('1983-11-30', 'YYYY-MM-DD'));

-- Cars  (ID_CATEGORIE, ID_LOCATIE)
INSERT INTO RC_MASINI VALUES (501, 'Dacia',      'Logan',        2022, 1, 10);
INSERT INTO RC_MASINI VALUES (502, 'BMW',        'X5',           2023, 4, 50);
INSERT INTO RC_MASINI VALUES (503, 'Ford',       'Mustang',      2021, 3, 20);
INSERT INTO RC_MASINI VALUES (504, 'Toyota',     'Corolla',      2020, 2, 30);
INSERT INTO RC_MASINI VALUES (505, 'Toyota',     'Land Cruiser', 2019, 3, 40);
INSERT INTO RC_MASINI VALUES (506, 'Renault',    'Clio',         2021, 1, 60);
INSERT INTO RC_MASINI VALUES (507, 'Mercedes',   'V-Class',      2022, 5, 50);
INSERT INTO RC_MASINI VALUES (508, 'Audi',       'A6',           2023, 4, 10);
INSERT INTO RC_MASINI VALUES (509, 'Volkswagen', 'Golf',         2020, 2, 50);
INSERT INTO RC_MASINI VALUES (510, 'Hyundai',    'Tucson',       2022, 3, 30);

-- Rentals  (ID_CLIENT, ID_MASINA)
INSERT INTO RC_INCHIRIERI VALUES (1001, TO_DATE('2023-12-01','YYYY-MM-DD'), TO_DATE('2023-12-06','YYYY-MM-DD'), 100, 501);
INSERT INTO RC_INCHIRIERI VALUES (1002, TO_DATE('2023-12-01','YYYY-MM-DD'), TO_DATE('2023-12-11','YYYY-MM-DD'), 102, 503);
INSERT INTO RC_INCHIRIERI VALUES (1003, TO_DATE('2023-12-05','YYYY-MM-DD'), TO_DATE('2023-12-07','YYYY-MM-DD'), 103, 504);
INSERT INTO RC_INCHIRIERI VALUES (1004, TO_DATE('2023-12-10','YYYY-MM-DD'), TO_DATE('2023-12-14','YYYY-MM-DD'), 101, 505);
INSERT INTO RC_INCHIRIERI VALUES (1005, TO_DATE('2023-12-15','YYYY-MM-DD'), TO_DATE('2023-12-20','YYYY-MM-DD'), 104, 502);
INSERT INTO RC_INCHIRIERI VALUES (1006, TO_DATE('2023-12-18','YYYY-MM-DD'), TO_DATE('2023-12-19','YYYY-MM-DD'), 105, 506);
INSERT INTO RC_INCHIRIERI VALUES (1007, TO_DATE('2023-12-20','YYYY-MM-DD'), TO_DATE('2023-12-25','YYYY-MM-DD'), 106, 508);
INSERT INTO RC_INCHIRIERI VALUES (1008, TO_DATE('2023-12-22','YYYY-MM-DD'), TO_DATE('2023-12-30','YYYY-MM-DD'), 107, 509);
INSERT INTO RC_INCHIRIERI VALUES (1009, TO_DATE('2024-01-05','YYYY-MM-DD'), TO_DATE('2024-01-10','YYYY-MM-DD'), 108, 510);
INSERT INTO RC_INCHIRIERI VALUES (1010, TO_DATE('2024-01-02','YYYY-MM-DD'), TO_DATE('2024-01-04','YYYY-MM-DD'), 109, 501);

COMMIT;


/* =====================================================================
   4. RECORD UPDATES (DML - UPDATE)
   ===================================================================== */

-- +10% price increase for Luxury category
UPDATE RC_CATEGORII SET PRET_ZILNIC = PRET_ZILNIC * 1.10 WHERE DENUMIRE_CATEGORIE = 'Luxury';
UPDATE RC_CLIENTI   SET TELEFON = '0722123456'           WHERE ID_CLIENT = 100;
COMMIT;


/* =====================================================================
   5. DROP & RECOVER A TABLE (FLASHBACK)
   ===================================================================== */

CREATE TABLE RC_TEST_STERGERE (ID NUMBER, NUME VARCHAR2(20));
INSERT INTO RC_TEST_STERGERE VALUES (1, 'Test');
COMMIT;
DROP TABLE RC_TEST_STERGERE;
FLASHBACK TABLE RC_TEST_STERGERE TO BEFORE DROP;


/* =====================================================================
   6. QUERIES (20+)
   ===================================================================== */

/* ---- A. Single-row functions (dates, strings, numbers) ---- */

-- 1. Brand, model and year for cars built in 2021 or later
SELECT marca, model, an_fabricatie
FROM rc_masini
WHERE an_fabricatie >= 2021;

-- 2. Clients whose email is on the 'email.com' domain (LIKE)
SELECT nume, email
FROM rc_clienti
WHERE email LIKE '%email.com%';

-- 3. Rental duration in days per transaction
SELECT id_inchiriere, data_start, data_final, data_final - data_start AS diferenta
FROM rc_inchirieri;

-- 4. Client surname in uppercase + its length, for first names 'Ion' or 'Maria'
SELECT UPPER(nume), LENGTH(nume)
FROM rc_clienti
WHERE prenume IN ('Ion', 'Maria');

-- 5. Cars older than 3 years (using SYSDATE vs AN_FABRICATIE)
SELECT id_masina, marca, model
FROM rc_masini
WHERE (EXTRACT(YEAR FROM SYSDATE) - an_fabricatie) > 3;


/* ---- B. Joins ---- */

-- 6. Car brand/model + its category name
SELECT m.marca, m.model, c.denumire_categorie
FROM rc_masini m, rc_categorii c
WHERE m.id_categorie = c.id_categorie;

-- 7. Client name, rented car brand and start date for all rentals
SELECT c.nume, m.marca, i.data_start
FROM rc_clienti c, rc_masini m, rc_inchirieri i
WHERE c.id_client = i.id_client
  AND i.id_masina = m.id_masina;

-- 8. Car details + the city where each car is allocated
SELECT m.marca, m.model, l.oras
FROM rc_masini m, rc_locatii l
WHERE m.id_locatie = l.id_locatie;

-- 9. Client name, car model, pickup city and daily price per rental
SELECT cl.nume, m.model, l.oras, c.pret_zilnic
FROM rc_masini m, rc_locatii l, rc_categorii c, rc_clienti cl, rc_inchirieri i
WHERE m.id_locatie  = l.id_locatie
  AND m.id_categorie = c.id_categorie
  AND cl.id_client  = i.id_client
  AND i.id_masina   = m.id_masina;

-- 10. All categories and their cars, including categories with no cars (outer join)
SELECT c.denumire_categorie, m.marca, m.model
FROM rc_categorii c, rc_masini m
WHERE c.id_categorie = m.id_categorie (+);


/* ---- C. Group functions (COUNT, SUM, AVG, MAX, MIN) + HAVING ---- */

-- 11. Number of cars per location
SELECT COUNT(m.id_masina) AS nr_masini, l.nume_agentie
FROM rc_masini m, rc_locatii l
WHERE m.id_locatie = l.id_locatie
GROUP BY l.nume_agentie;

-- 12. Estimated total revenue per category (daily price * number of cars)
SELECT c.denumire_categorie, c.pret_zilnic * COUNT(m.id_masina) AS val_estimata
FROM rc_categorii c, rc_masini m
WHERE c.id_categorie = m.id_categorie
GROUP BY c.denumire_categorie, c.pret_zilnic;

-- 13. Category id + average daily price, only where avg price > 200
SELECT id_categorie, AVG(pret_zilnic) AS pret_mediu
FROM rc_categorii
GROUP BY id_categorie
HAVING AVG(pret_zilnic) > 200;

-- 14. Oldest (MIN) and newest (MAX) manufacturing year in the fleet
SELECT MIN(an_fabricatie) AS cea_mai_veche, MAX(an_fabricatie) AS cea_mai_noua
FROM rc_masini;

-- 15. Clients with at least 2 rentals
INSERT INTO RC_INCHIRIERI VALUES (1099, SYSDATE, SYSDATE + 3, 100, 505);
COMMIT;

SELECT id_client, COUNT(id_inchiriere) AS nr_inchirieri
FROM rc_inchirieri
GROUP BY id_client
HAVING COUNT(id_inchiriere) >= 2;


/* ---- D. CASE, DECODE and expressions ---- */

-- 16. Age label per car using CASE
SELECT marca, model, an_fabricatie,
       CASE
           WHEN an_fabricatie = 2023               THEN 'Noua'
           WHEN an_fabricatie BETWEEN 2020 AND 2022 THEN 'Standard'
           WHEN an_fabricatie < 2020                THEN 'Veche'
           ELSE 'Altceva'
       END AS tip_vechime
FROM rc_masini;

-- 17. Continent code per agency using DECODE
SELECT nume_agentie, tara,
       DECODE(regiune, 'Europe', 'EU', 'Asia', 'AS', 'America', 'US/CA', 'Global') AS continent
FROM rc_locatii;


/* ---- E. Subqueries and set operators (UNION, MINUS, INTERSECT) ---- */

-- 18. Cars newer than the fleet's average manufacturing year (subquery)
SELECT marca, model, an_fabricatie
FROM rc_masini
WHERE an_fabricatie > (SELECT AVG(an_fabricatie) FROM rc_masini);

-- 19. Clients who rented a car from the 'SUV' category (nested subquery)
SELECT nume, prenume
FROM rc_clienti
WHERE id_client IN (
    SELECT i.id_client
    FROM rc_inchirieri i, rc_masini m, rc_categorii c
    WHERE i.id_masina   = m.id_masina
      AND m.id_categorie = c.id_categorie
      AND c.denumire_categorie = 'SUV'
);

-- 20. Locations with allocated cars MINUS locations involved in rentals
SELECT id_locatie FROM rc_masini
MINUS
SELECT m.id_locatie
FROM rc_inchirieri i, rc_masini m
WHERE i.id_masina = m.id_masina;

-- 21. Unique alphabetical list of brands and category names (UNION)
SELECT marca AS termen_auto FROM rc_masini
UNION
SELECT denumire_categorie FROM rc_categorii;

-- 22. Car ids built in 2022 that were ever rented (INTERSECT)
SELECT id_masina FROM rc_masini WHERE an_fabricatie = 2022
INTERSECT
SELECT id_masina FROM rc_inchirieri;

-- 23. Hierarchical query: next 7 days, simulating a rental planning calendar
SELECT LEVEL AS zi_programare, SYSDATE + LEVEL AS data_calendaristica
FROM dual
CONNECT BY LEVEL <= 7;


/* =====================================================================
   7. OTHER DATABASE OBJECTS: views, indexes, sequences, synonyms
   ===================================================================== */

-- View: cars joined with their location
CREATE VIEW v_masini_locatii AS
SELECT m.marca, m.model, m.an_fabricatie, l.oras, l.tara
FROM rc_masini m, rc_locatii l
WHERE m.id_locatie = l.id_locatie;

SELECT * FROM v_masini_locatii;

-- Index: speed up lookups by client surname
CREATE INDEX idx_nume_client ON rc_clienti(nume);

-- Sequence: auto-generate client ids, plus a sample insert
CREATE SEQUENCE seq_clienti START WITH 200 INCREMENT BY 1;

INSERT INTO RC_CLIENTI (ID_CLIENT, NUME, PRENUME, EMAIL, DATA_NASTERII)
VALUES (seq_clienti.NEXTVAL, 'nou', 'alex', 'alex.nou@test.com', SYSDATE);
COMMIT;

-- Synonym: alternative name for the cars table
CREATE SYNONYM flota FOR rc_masini;

SELECT * FROM flota;
