SPOOL aptDB.txt
SET ECHO ON


--Authors: Dayaseh Johnson, Priscila Ontiveros, , ,


-------------------------------------------


DROP TABLE resident CASCADE CONSTRAINTS;
DROP TABLE apartmentUnit CASCADE CONSTRAINTS;
DROP TABLE maintenanceRequest CASCADE CONSTRAINTS;
DROP TABLE buildingManager CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE worksOn CASCADE CONSTRAINTS;
DROP TABLE certification CASCADE CONSTRAINTS;

----------

CREATE TABLE resident (         /* Priscilla*/
  resID INTEGER PRIMARY KEY,
  unitNum INTEGER NOT NULL,
  collegeYear INTEGER NOT NULL,
  name CHAR(50) NOT NULL,
  sex CHAR(1) NOT NULL,
  major CHAR(30),
  CONSTRAINT r1 CHECK (sex in ('M', 'F')),
  CONSTRAINT r2 CHECK (major in('Computer Science')),
  CONSTRAINT r3 CHECK (NOT(collegeYear > 6))
 );
  
  ------------------
  
CREATE TABLE apartmentUnit    /*priscilla*/
(
  roomNum INTEGER PRIMARY KEY,
  style CHAR(12) NOT NULL,
  condition CHAR(12) NOT NULL,
  price INTEGER NOT NULL,
  availability CHAR(12) NOT NULL,
  CONSTRAINT a1 CHECK (availability IN ('open', 'not open')),
  CONSTRAINT a2 CHECK (NOT (condition = 'poor' AND availability = 'open')),
  CONSTRAINT a3 CHECK (style IN ('Style 1', 'Style 2', 'Style 3', 'Style 4','Style 5', 'Style 6')),
  CONSTRAINT a4 CHECK (condition IN ('poor', 'ok', 'great', 'perfect'))
 );
   ------------------

   CREATE TABLE buildingManager    /*Grant*/
  (
    mgrId INTEGER PRIMARY KEY,
    isLandlord CHAR(3) NOT NULL,
    name CHAR(32) NOT NULL,
    pay INTEGER NOT NULL
    /*TO DO: INSERT CONSTRAINTS*/
    CONSTRAINT bm1 CHECK (NOT (pay < 55000) OR (pay > 100000)),
    CONSTRAINT bm2 CHECK (isLandlord IN ('yes', 'no', 'Yes', 'No')),
    CONSTRAINT bm3 CHECK (NOT (pay < 80000 AND isLandlord = 'yes'))
   );

   -------------------

 CREATE TABLE maintenanceRequest    /*Grant*/
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
    -------------------
   CREATE TABLE employee        /*DJ*/
   (
     eId INTEGER PRIMARY KEY,
     name CHAR(32) NOT NULL,
     pay INTEGER,
     mgrID INTEGER NOT NULL,
     CONSTRAINT e1 CHECK (NOT (eId = mgrID)),
     CONSTRAINT e2 CHECK (NOT (pay < 25000) OR (pay > 55000))
    );
     ----------------
   CREATE TABLE certification   /*DJ*/
   (
     eId INTEGER,
     cert CHAR(15),
     FOREIGN KEY (eId) REFERENCES employee(eId),
     CONSTRAINT c1 CHECK (cert IN ('plumbing', 'electrical', 'mechanical', 'furniture'))
    );
     
     ----------------
    CREATE TABLE worksOn      /*Jack*/
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
    
   /*--------------------------------------------------       Jack
   Populate Database
   ----------------------------------------------------*/
   
   alter session set NLS_DATE_FORMAT = 'MM-DD-YY';
    insert into resident values (1234, 01, 2, 'John Doe', 'M', 'Computer Science');
    insert into resident values (1235, 02, 3, 'Jane Doe', 'F', 'Computer Science');
    insert into resident values (1236, 03, 4, 'Beyonce Knowles', 'F', 'Computer Science');
    insert into resident values (1237, 04, 1, 'Michael Jackson', 'M', 'Computer Science');
    insert into resident values (1238, 05, 2, 'Elvis Presley', 'M', 'Computer Science');
        --## IC Testing ##-- WORKS
        -- r1 (Gender constraint)
        insert into resident values (0001, 10, 1, 'Mike Mike', 'm', 'Computer Science');
        insert into resident values (0001, 10, 1, 'Mike Mike', 'f', 'Computer Science');
        -- r2 (Major constraint)
        insert into resident values (0001, 10, 1, 'Mike Mike', 'M', 'Business');
        insert into resident values (0001, 10, 1, 'Mike Mike', 'F', 'Gender Studies');

    -------------------

    insert into buildingManager values(123, 'No', 'Bill', 55000);
    insert into buildingManager values(124, 'Yes', 'Tammy', 55000);
        --## IC Testing ##-- WORKS
        -- bm1 (between 55000 and 100000 pay)
        insert into buildingManager values(999, 'No', 'Bob', 25000);
        -- bm2 (Landlord value constraint)
        insert into buildingManager values(999, '??', 'Bob', 55000);
        -- bm3 (is NOT a Landlord and pay is higher than or equal to 80000)
        --NOT WORKING
        insert into buildingManager values(999, 'No', 'Bob', 100000);

    -------------------

    insert into employee values (12, 'Tom', 30000, 123);
    insert into employee values (18, 'David', 30000, 123);
    insert into employee values (24, 'John', 30000, 123);
    insert into employee values (30, 'Guy', 30000, 124);
        --## IC Testing ##--
        -- e1 (check if employee is not a manager)
        --NOT WORKING
        insert into employee values (36, 'Timothy', 30000, 123);
        --e2 (check if pay is not less than 25000 and higher than 55000)
        insert into employee values (36, 'Timothy', 10000, 123);

    -------------------

    insert into maintenanceRequest values (1234, '01-01-22', 'electrical', 123);
    insert into maintenanceRequest values (1234, '03-29-21', 'electrical', 124);
    insert into maintenanceRequest values (1235, '03-05-22', 'plumbing', 124);
    insert into maintenanceRequest values (1236, '02-07-21', 'furniture', 124);
        --## IC Testing ##--
        -- m1 (check for a valid maintenance type)
        insert into maintenanceRequest values (1235, '02-04-22', 'flooring', 124);
        -- Foreign Key
        insert into maintenanceRequest values (1000, '01-01-22', 'furniture', 124);

    -------------------

    insert into worksOn values (12, 1234, '01-01-22', 5);

    -------------------

    insert into certification values (12, 'electrical');
    insert into certification values (18, 'plumbing');
    insert into certification values (24, 'electrical');
    insert into certification values (30, 'electrical');
        --## IC Testing ##--
        -- c1 (check for a valid maintenance type)
        insert into certification values (36, 'flooring');
        
    ---------------------------------------------------
  
-- QUERY 3
/*Find the resDd's and names of residents whose year is 3 and is a female.*/
SELECT r.resId, r.name
FROM resident r
WHERE collegeYear = 3
MINUS
SELECT r.resId, r.name
FROM resident r
WHERE sex = 'F';

-- QUERY 4
/* Select the highest paid employee from the employee table*/
SELECT MAX(e.pay)
FROM employee e;
