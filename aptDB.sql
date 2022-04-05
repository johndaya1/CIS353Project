SPOOL apartmentDB.txt
SET ECHO ON


--Authors: Dayaseh Johnson, , , ,


-------------------------------------------


DROP TABLE resident
DROP TABLE apartmentUnit
DROP TABLE maintenanceRequest
DROP TABLE buildingManager
DROP TABLE employee
DROP TABLE works_on

------

CREATE TABLE resident
(
  resID INTEGER PRIMARY KEY,
  unitNum INTEGER NOT NULL,
  collegeYear INTEGER NOT NULL,
  name CHAR(50) NOT NULL,
  SEX CHAR(1) NOT NULL,
  major CHAR(30),
  
  /* TO DO: INSERT CONSTRAINTS */
  );
  
  ------  
  
CREATE TABLE apartmentUnit
(
  roomNum INTEGER PRIMARY KEY,
  style CHAR(12) NOT NULL,
  condition CHAR(12) NOT NULL,
  price INTEGER NOT NULL,
  availaility CHAR(12) NOT NULL,

  /*TO DO: INSERT CONSTRAINTS*/
  );
    
   -------
 CREATE TABLE maintenanceRequest
 (
   resID INTEGER,
   date INTEGER /*FIX THIS*/ ,
   PRIMARY KEY (resID, date),
   roomNum INTEGER,
   maintenanceType CHAR(15),
   mgrID INTEGER,
   
  /*TO DO: INSERT CONSTRAINTS*/
   );
   
    
