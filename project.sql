SPOOL project.txt
SET ECHO ON
/*
CIS 353 - Database Design Project
<One line per team member name; in alphabetical order>
*/
< The SQL/DDL code that creates your schema >
In the DDL, every IC must have a unique name; e.g. IC5, IC10, IC15, etc.
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
		     
< The insert/delete/update statements to test the enforcement of ICs >
Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs you need to test).
− A comment line stating: Testing: < IC name>
− A SQL INSERT, DELETE, or UPDATE that will test the IC.
COMMIT;
--
SPOOL OFF
