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
   day INTEGER/*FIX THIS*/,
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
   --insert into resident values (1234, 01, 2, 'John Doe', 'M', 'Computer Science');
   
   
   --insert into apartmentUnit values
    
    COMMIT;
