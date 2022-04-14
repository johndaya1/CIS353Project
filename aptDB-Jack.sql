/*--------------------------------------------------
            Populate Database/IC Testing - Jack
    ----------------------------------------------------*/
    alter session set NLS_DATE_FORMAT = 'MM-DD-YY';

    -------------------

    insert into resident values (1234, 01, 2, 'John Doe', 'M', 'Computer Science');
    insert into resident values (1235, 02, 3, 'Jane Doe', 'F', 'Computer Science');
    insert into resident values (1236, 03, 4, 'Beyonce Knowles', 'F', 'Computer Science');
    insert into resident values (1237, 04, 1, 'Michael Jackson', 'M', 'Computer Science');
    insert into resident values (1238, 05, 2, 'Elvis Presley', 'M', 'Computer Science');
        --## IC Testing ##--
        -- r1 (Gender constraint)
        insert into resident values (0001, 10, 1, 'Mike Mike', 'male', 'Computer Science');
        insert into resident values (0001, 10, 1, 'Mike Mike', 'female', 'Computer Science');
        -- r2 (Major constraint)
        insert into resident values (0001, 10, 1, 'Mike Mike', 'M', 'Business');
        insert into resident values (0001, 10, 1, 'Mike Mike', 'F', 'Gender Studies');

    -------------------

    insert into buildingManager values(123, 'No', 'Bill', 55000);
    insert into buildingManager values(124, 'No', 'Tammy', 55000);
        --## IC Testing ##--
        -- bm1 (between 55000 and 100000 pay)
        insert into buildingManager values(999, 'No', 'Bob', 25000);
        -- bm2 (Landlord value constraint)
        insert into buildingManager values(999, 'Y', 'Bob', 55000);
        -- bm3 (is NOT a Landlord and pay is higher than or equal to 80000)
        insert into buildingManager values(999, 'No', 'Bob', 100000);

    -------------------

    insert into employee values (12, 'Tom', 30000, 123);
    insert into employee values (18, 'David', 30000, 123);
    insert into employee values (24, 'John', 30000, 123);
    insert into employee values (30, 'Guy', 30000, 124);
        --## IC Testing ##--
        -- e1 (check if employee is not a manager)
        insert into employee values (123, 'Tomothy', 30000, 123);
        --e2 (check if pay is not less than 25000 and higher than 55000)
        insert into employee values (36, 'Timothy', 10000, 123)

    -------------------

    insert into maintenanceRequest values (1234, '01-01-22', 'electrical', 123);
    insert into maintenanceRequest values (1234, '03-29-21', 'electrical', 124);
    insert into maintenanceRequest values (1235, '03-05-22', 'plumbing', 124);
    insert into maintenanceRequest values (1240, '01-01-22', 'furniture', 124);
        --## IC Testing ##--
        -- m1 (check for a valid maintenance type)
        insert into maintenanceRequest values (1235, '02-04-22', 'flooring', 124);
        
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
