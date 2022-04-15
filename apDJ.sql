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
    CONSTRAINT bm3 CHECK (isLandlord IN ('yes', 'no', 'Yes', 'No')),
    CONSTRAINT bm4 CHECK (NOT (pay < 100000 AND isLandlord = 'yes'))
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
     CONSTRAINT e2 CHECK (NOT (pay > 55000) OR (pay < 25000))
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
   
   insert into buildingManager values(123, 'No', 'Bill', 55000);
   insert into buildingManager values(124, 'No', 'Tammy', 55000);
   
   insert into employee values (12, 'Tom', 30000, 123);
   insert into employee values (18, 'David', 30000, 123);
   insert into employee values (24, 'John', 30000, 123);
   insert into employee values (30, 'Guy', 30000, 124);
   
   insert into maintenanceRequest values (1234, '01-01-22', 'electrical', 123);
   insert into maintenanceRequest values (1234, '03-29-21', 'electrical', 124);
   insert into maintenanceRequest values (1235, '03-05-22', 'plumbing', 124);
   insert into maintenanceRequest values (1240, '01-01-22', 'furniture', 124);
   
   insert into worksOn values (12, 1234, '01-01-22', 5);
 
   insert into certification values (12, 'electrical');
   insert into certification values (18, 'plumbing');
   insert into certification values (24, 'electrical');
   insert into certification values (30, 'electrical');
	   
   --QUERY 1
   /* select the name and employee ID of each employee who has a certification matching the maintenance type of a maintenance request managed by their own manager*/
   SELECT e.name, e.eid
   FROM   employee e, maintenanceRequest m, worksOn w, certification c
   WHERE e.eid = w.eid AND 
	 c.cert = m.maintenanceType AND
	 e.eid = c.eid AND
	 e.mgrId = m.mgrId AND
	 w.day = m.day
  ORDER BY eid;
	   
  --QUERY 2
  /*find pairs of students that are the same sex and 1 year apart in school. Get their name, sex, and current year*/
  SELECT DISTINCT r1.name, r2.name, r1.sex, r2.sex, r1.collegeYear, r2.collegeYear
  FROM resident r1, resident r2
  WHERE r1.sex = r2.sex AND
  	r1.collegeYear = r2.collegeYear + 1 AND
	(NOT r1.name = r2.name)
  ORDER BY r1.collegeYear ASC;
  
	   --QUERY 8
  /*find the resId of every resident that has submitted a maintenance request that was electrical*/
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
	   --QUERY 7
/*Find the resId of every student that is past their 1st year and has not submitted a maintenance request*/	   
SELECT DISTINCT r.resId
FROM resident r
WHERE collegeYear > 1 AND
      r.resId NOT IN (SELECT m.resId
		       FROM maintenanceRequest m);
	
  --Query 9
  /*find the name, resident Id, and unit number of every resident. Also show their maintenance requests*/
  SELECT DISTINCT r.name, r.resId, r.unitNum
  FROM residents r
  LEFT OUTER JOIN maintenanceRequests m
  ON r.resId = m.resId
  ORDER BY r.resId
    
    COMMIT;
