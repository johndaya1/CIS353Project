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
  SEX CHAR(1) NOT NULL,
  major CHAR(30)
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
  CONSTRAINT a2 CHECK (NOT (condition = 'poor' AND availability = 'open'))
 );
   ------------------
   
 CREATE TABLE maintenanceRequest    /*Grant*/
 (
   resID INTEGER,
   day INTEGER, /*fix this*/
   PRIMARY KEY (resID, day)/*FIX THIS, foreign key*/,
   maintenanceType CHAR(15),
   mgrID INTEGER,
   requestID INTEGER,
  /*TO DO: INSERT CONSTRAINTS*/
   CONSTRAINT m1 CHECK (maintenanceType IN ('plumbing', 'electrical', 'mechanical', 'furniture'))        
  );
   ---------------------
  CREATE TABLE buildingManager    /*Grant*/
  (
    mgrID INTEGER PRIMARY KEY,
    isLandlord CHAR(3) NOT NULL,
    name CHAR(32) NOT NULL,
    pay INTEGER NOT NULL
    /*TO DO: INSERT CONSTRAINTS*/
    CONSTRAINT bm1 CHECK (NOT (pay < 55000)),
    CONSTRAINT bm2 CHECK (NOT (pay > 100000))
   );
    -------------------
   CREATE TABLE employee        /*DJ*/
   (
     eId INTEGER PRIMARY KEY,
     name CHAR(32) NOT NULL,
     pay INTEGER,
     mgrID INTEGER NOT NULL,
     /*TO DO: INSERT CONTRAINTS*/
     CONSTRAINT e1 CHECK (NOT (eId = mgrID)),
     CONSTRAINT e2 CHECK (NOT (pay > 55000)),
     CONSTRAINT e3 CHECK (NOT (pay < 25000))
    );
     ----------------
   CREATE TABLE certification   /*DJ*/
   (
     eID INTEGER,
     cert CHAR(15),
     /*TO DO: INSERT CONSTRAINTS*/
     CONSTRAINT c1 CHECK (cert IN ('plumbing', 'electrical', 'mechanical', 'furniture'))
    );
     
     ----------------
    CREATE TABLE worksOn      /*Jack*/
    (
      eID INTEGER,
      requestID INTEGER
      /*TO DO: INSERT CONSTRAINTS*/
     );
    
   /*--------------------------------------------------       Jack
   Populate Database
   ----------------------------------------------------*/
   
   --alter session set;
   
   
   insert into resident values (1234, 01, 2, 'John Doe', 'M', 'Computer Science');
   
   insert into buildingManager values(123, 'No', 'Bill', 55000);
   insert into buildingManager values(124, 'No', 'Tammy', 55000);
   
   insert into employee values (12, 'Tom', 30000, 123);
   insert into employee values (18, 'David', 30000, 123);
   insert into employee values (24, 'John', 30000, 123);
   insert into employee values (30, 'Guy', 30000, 124);
   
   insert into worksOn values (12, 444);
   insert into worksOn values (18, 444);
   insert into worksOn values (24, 455);
   insert into worksOn values (30, 455);
   
   insert into maintenanceRequest values (1234, 3, 'electrical', 123, 444);
   insert into maintenanceRequest values (1234, 4, 'electrical', 124, 455);
   
   insert into certification values (12, 'electrical');
   insert into certification values (18, 'plumbing');
   insert into certification values (24, 'electrical');
   insert into certification values (30, 'electrical');
   
   /* select the name and employee ID of each employee who has a certification matching the maintenance type of a maintenance request managed by their own manager */
   SELECT e.name, e.eid
   FROM   employee e, maintenanceRequest m, worksOn w, certification c
   WHERE e.eid = w.eid AND 
	 c.cert = m.maintenanceType AND
	 e.eid = c.eid AND
	 e.mgrId = m.mgrId AND
	 w.requestId = m.requestId
  ORDER BY eid;
  
  SELECT DISTINCT r1.name, r2.name, r1.sex, r2.sex, r1.collegeYear, r2.collegeYear
  FROM resident r1, resident r2
  WHERE r1.sex = r2.sex AND
  	r1.collegeYear = r2.collegeYear AND
	(NOT r1.name = r2.name)
  ORDER BY r1.collegeYear ASC;
   --insert into apartmentUnit values
    
    COMMIT;
