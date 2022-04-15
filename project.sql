SPOOL project.txt
SET ECHO ON
/*
CIS 353 - Database Design Project
<One line per team member name; in alphabetical order>
Johnson, Dasayeh
Kleitch, Jack
Ontiveros, Priscila
Spears, Grant
*/
--< The SQL/DDL code that creates your schema >
--In the DDL, every IC must have a unique name; e.g. IC5, IC10, IC15, etc.

DROP TABLE resident CASCADE CONSTRAINTS;
DROP TABLE apartmentUnit CASCADE CONSTRAINTS;
DROP TABLE maintenanceRequest CASCADE CONSTRAINTS;
DROP TABLE buildingManager CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE worksOn CASCADE CONSTRAINTS;
DROP TABLE certification CASCADE CONSTRAINTS;

----------

CREATE TABLE resident (         
  resID INTEGER PRIMARY KEY,
  unitNum INTEGER UNIQUE,
  collegeYear INTEGER NOT NULL,
  name CHAR(50) NOT NULL,
  sex CHAR(1) NOT NULL,
  major CHAR(30),
  CONSTRAINT r1 CHECK (sex in ('M', 'F')),
  CONSTRAINT r2 CHECK (major in('Computer Science')),
  CONSTRAINT r3 CHECK (NOT(collegeYear > 6))
 );
  ------------------
CREATE TABLE apartmentUnit    
(
  roomNum INTEGER PRIMARY KEY,
  style CHAR(12) NOT NULL,
  condition CHAR(12) NOT NULL,
  price INTEGER UNIQUE,
  availability CHAR(12) NOT NULL,
  CONSTRAINT a1 CHECK (availability IN ('open', 'not open')),
  CONSTRAINT a2 CHECK (NOT (condition = 'poor' AND availability = 'open')),
  CONSTRAINT a3 CHECK (style IN ('Style 1', 'Style 2', 'Style 3', 'Style 4','Style 5', 'Style 6')),
  CONSTRAINT a4 CHECK (condition IN ('poor', 'ok', 'great', 'perfect'))
 );
   ------------------
   CREATE TABLE buildingManager    
  (
    mgrId INTEGER PRIMARY KEY,
    isLandlord CHAR(3) NOT NULL,
    name CHAR(32) NOT NULL,
    pay INTEGER NOT NULL
    CONSTRAINT bm1 CHECK (NOT (pay < 55000) OR (pay > 100000)),
    CONSTRAINT bm2 CHECK (isLandlord IN ('yes', 'no', 'Yes', 'No')),
    CONSTRAINT bm3 CHECK (NOT (pay < 100000 AND isLandlord = 'yes'))
   );
   -------------------
 CREATE TABLE maintenanceRequest    
 (
   resId INTEGER,
   day DATE,
   maintenanceType CHAR(15),
   mgrId INTEGER,
   PRIMARY KEY (resId, day),
   FOREIGN KEY (resId) REFERENCES resident(resId),
   FOREIGN KEY (mgrId) REFERENCES buildingManager(mgrId),
   CONSTRAINT m1 CHECK (maintenanceType IN ('plumbing', 'electrical', 'mechanical', 'furniture'))
  );
   ---------------------
   CREATE TABLE employee        
   (
     eId INTEGER PRIMARY KEY,
     name CHAR(32) NOT NULL,
     pay INTEGER,
     mgrID INTEGER NOT NULL,
     CONSTRAINT e1 CHECK (NOT (eId = mgrID)),
     CONSTRAINT e2 CHECK (NOT (pay > 55000) OR (pay < 25000))
    );
     ----------------
   CREATE TABLE certification   
   (
     eId INTEGER,
     cert CHAR(15),
     FOREIGN KEY (eId) REFERENCES employee(eId),
     CONSTRAINT c1 CHECK (cert IN ('plumbing', 'electrical', 'mechanical', 'furniture'))
    );
     ----------------
    CREATE TABLE worksOn      
    (
      eId INTEGER,
      resId INTEGER,
      day DATE,
      hours INTEGER,
      FOREIGN KEY (eId) REFERENCES employee(eId),
      FOREIGN KEY (resId, day) REFERENCES maintenanceRequest(resId, day),
      PRIMARY KEY(resId, day),
      CONSTRAINT w1 CHECK(NOT (hours < 0) OR (hours > 50));
     );
--
SET FEEDBACK OFF
< The INSERT statements that populate the tables>
Important: Keep the number of rows in each table small enough so that the results of your
queries can be verified by hand. See the Sailors database as an example.
SET FEEDBACK ON
COMMIT;
--
< One query (per table) of the form: SELECT * FROM table; in order to display your database >
--
SELECT *
FROM resident;

SELECT *
FROM apartmentUnit;

SELECT *
FROM maintenance;

SELECT *
FROM buildingManager;

SELECT *
FROM employee;

SELECT *
FROM worksOn;

SELECT *
FROM certification;
--
--< The SQL queries>
--Q1 - A Join involving 4 relations
--Select the name and employee ID of each employee who has a certification matching the maintenance type of a maintenance request managed by their own manager
   SELECT e.name, e.eid
   FROM   employee e, maintenanceRequest m, worksOn w, certification c
   WHERE e.eid = w.eid AND 
	 c.cert = m.maintenanceType AND
	 e.eid = c.eid AND
	 e.mgrId = m.mgrId AND
	 w.day = m.day
  ORDER BY eid;
  
  --Q2 - A self-join
  --Find pairs of students that are the same sex and 1 year apart in school. Select their name, sex, and current year
  SELECT DISTINCT r1.name, r2.name, r1.sex, r2.sex, r1.collegeYear, r2.collegeYear
  FROM resident r1, resident r2
  WHERE r1.sex = r2.sex AND
  	r1.collegeYear = r2.collegeYear + 1 AND
	(NOT r1.name = r2.name)
  ORDER BY r1.collegeYear ASC;
  
  -- Q3 - UNION, INTERSECT, and/or MINUS.
  -- Find the resDd's and names of residents whose year is 3 and is a female.
  SELECT r.resId, r.name
  FROM resident r
  WHERE collegeYear = 3
  MINUS
  SELECT r.resId, r.name
  FROM resident r
  WHERE sex = 'M';

  -- Q4 - SUM, AVG, MAX, and/or MIN.
  -- Select the highest paid employee from the employee table.
  SELECT MAX(e.pay) AS maxPay
  FROM employee e;
  
  --Q5 - A GROUP BY, HAVING, and ORDER BY
  --Find the residents who are freshmen (college year = 1)
  SELECT r.name,r.resId, r.sex, count(*)
  FROM resident r
  WHERE r.collegeYear = 1
  GROUP BY r.name, r.resId, r.sex
  HAVING count(*) >= 1
  ORDER BY r.collegeYear;
  
  --Q6 - A correlated subquery
  --Find reseidents whose college year is 1 and do not have maintenance requests
  SELECT r.resID, r.name
  FROM resident r
  WHERE
  r.collegeYear = 1 AND
    NOT EXISTS(
      SELECT *
      FROM maintenanceRequest M
      WHERE m.resID = r.resID
    );
    
  --Q7 - A non-correlated subquery
  --Find the resId of every student that is past their 1st year and has not submitted a maintenance request
  SELECT DISTINCT r.resId
  FROM resident r
  WHERE collegeYear > 1 AND
      r.resId NOT IN (SELECT m.resId
		       FROM maintenanceRequest m);
		       
  --Q8 - A relational division query
  --Select the resId of every resident that has submitted a maintenance request that was electrical
  SELECT DISTINCT mr1.resId
  FROM maintenanceRequest mr1
  WHERE NOT EXISTS ((SELECT mr2.maintenanceType
		     FROM maintenanceRequest mr2
		     WHERE maintenanceType = 'electrical')
		    MINUS
		    (SELECT maintenanceType 
		     FROM maintenanceRequest mr3
		     WHERE mr1.resID = mr3.resID AND
		     	   mr3.maintenanceType = 'electrical'
		     ));
		     
  --Q9 - An Outer Join Query
  --f=Select the name, resident Id, and unit number of every resident. Also show their maintenance request date
  SELECT DISTINCT r.name, r.resId, r.unitNum, m.day
  FROM resident r
  LEFT OUTER JOIN maintenanceRequest m
  ON r.resId = m.resId
  ORDER BY r.resId;
		     
< The insert/delete/update statements to test the enforcement of ICs >
Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs you need to test).
− A comment line stating: Testing: < IC name>
− A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;
--
SPOOL OFF
