SPOOL aptDB.txt
SET ECHO ON


--Authors: Dayaseh Johnson, , , ,


-------------------------------------------


DROP TABLE resident;
/*
DROP TABLE apartmentUnit;
DROP TABLE maintenanceRequest;
DROP TABLE buildingManager;
DROP TABLE employee;
DROP TABLE works_on;

----------
*/
CREATE TABLE resident (
  resID INTEGER PRIMARY KEY
);
--unitNum INTEGER NOT NULL,
  --collegeYear INTEGER NOT NULL,
  --name CHAR(50) NOT NULL,
  --SEX CHAR(1) NOT NULL,
  --major CHAR(30)
 
  /*
  ------------------
  
CREATE TABLE apartmentUnit
(
  roomNum INTEGER PRIMARY KEY,
  style CHAR(12) NOT NULL,
  condition CHAR(12) NOT NULL,
  price INTEGER NOT NULL,
  availability CHAR(12) NOT NULL,

  /*TO DO: INSERT CONSTRAINTS*/
  CONSTRAINT a1 CHECK (availability IN ('open', 'not open'),
  CONSTRAINT a2 CHECK (NOT (condition = 'poor' AND availability = 'open')
 );
    
   ------------------
 CREATE TABLE maintenanceRequest
 (
   resID INTEGER,
   date INTEGER /*FIX THIS*/ ,
   PRIMARY KEY (resID, date)/*FIX THIS, foreign key*/,
   roomNum INTEGER,
   maintenanceType CHAR(15),
   mgrID INTEGER,
   
  /*TO DO: INSERT CONSTRAINTS*/
   CONSTRAINT m1 CHECK (maintenanceType IN ('plumbing', 'electrical', 'mechanical', 'furniture')
                        
  );
   ---------------------
  CREATE TABLE buildingManager
  (
    mgrID INTEGER PRIMARY KEY,
    isLandlord CHAR(3) NOT NULL,
    name CHAR(32) NOT NULL,
    pay INTEGER NOT NULL
    
    /*TO DO: INSERT CONSTRAINTS*/
   );
    -------------------
   CREATE TABLE employee
   (
     eId INTEGER PRIMARY KEY,
     name CHAR(32) NOT NULL,
     pay INTEGER NOT NULL,
     mgrID INTEGER NOT NULL,
     
     /*TO DO: INSERT CONTRAINTS*/
     CONSTRAINT e1 CHECK (NOT (eId = mgrID)),
     CONSTRAINT e2 CHECK (NOT (pay > 55,000 OR pay < 25,000))
     
    );
     ----------------
   CREATE TABLE certification
   (
     eID INTEGER,
     certLevel INTEGER
    
     /*TO DO: INSERT CONSTRAINTS*/
    );
     
     ----------------
    CREATE TABLE worksOn
    (
      eID INTEGER,
      requestID INTEGER
      
      /*TO DO: INSERT CONSTRAINTS*/
     );
      */
   /*--------------------------------------------------
   Populate Database
   ----------------------------------------------------*/
   
   --alter session set;
   
   
   insert into resident values (1234, 01, 2, 'John Doe', 'M', 'Computer Science');
   
   
   --insert into apartmentUnit values
    
    COMMIT;
   
    