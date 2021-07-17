-- SELECT statement problems

-- 1.	For event requests, list the event number, event date (eventrequest.dateheld), and count of the event plans.  
-- Only include event requests in the result if the event request has more than one related event plan with a work date in 
-- December 2018

select EVENTREQUEST.EVENTNO, DATEHELD, count(*) from EVENTREQUEST 
inner join EVENTPLAN on EVENTREQUEST.EVENTNO = EVENTPLAN.EVENTNO
where WORKDATE between '2018-12-01' and '2018-12-31'
group by EVENTREQUEST.EVENTNO
having count(*) > 1;

-- 2.	List the plan number, event number, work date, and activity of event plans meeting the following two conditions: 
-- (1) the work date is in December 2018 and 
-- (2) the event is held in the “Basketball arena”.  
-- Your query must not use the facility number (“F101”) of the basketball arena in the WHERE clause. 
-- Instead, you should use a condition on the FacName column for the value of “Basketball arena”.

select EVENTPLAN.PLANNO, EVENTNO, WORKDATE, ACTIVITY
	from EVENTPLANLINE inner join EVENTPLAN on EVENTPLANLINE.PLANNO = EVENTPLAN.PLANNO  
		inner join LOCATION on EVENTPLANLINE.LOCNO = LOCATION.LOCNO
        inner join FACILITY on FACILITY.FACNO = LOCATION.FACNO
where WORKDATE between '2018-12-01' and '2018-12-31'
and FACNAME = 'Basketball Arena';

-- 3. List the event number, event date, status, and estimated cost of events where there is an event plan managed by Mary Manager 
-- and the event is held in the basketball arena in the period October 1 to December 31, 2018.  
-- Your query must not use the facility number (“F101”) of the basketball arena or the employee number (“E101”) of “Mary Manager” 
-- in the WHERE clause. Thus, the WHERE clause should not have conditions involving the facility number or employee number compared 
-- to constant values. 

select EVENTPLAN.EVENTNO, DATEHELD, STATUS, ESTCOST
	from EVENTPLANLINE inner join EVENTPLAN on EVENTPLANLINE.PLANNO = EVENTPLAN.PLANNO
		inner join LOCATION on EVENTPLANLINE.LOCNO = LOCATION.LOCNO
        inner join FACILITY on FACILITY.FACNO = LOCATION.FACNO
        inner join EMPLOYEE on EVENTPLAN.EMPNO = EMPLOYEE.EMPNO
        inner join EVENTREQUEST on EVENTREQUEST.EVENTNO = EVENTPLAN.EVENTNO
where WORKDATE between '2018-10-01' and '2018-12-31'
and FACNAME = 'Basketball Arena'
and EMPNAME = 'Mary Manager';

-- 4. List the plan number, line number, resource name, number of resources (eventplanline.number), 
-- location name, time start, and time end where the event is held at the basketball arena, the event plan has activity of 
-- activity of “Operation”, and the event plan has a work date in the period October 1 to December 31, 2018.  
-- Your query must not use the facility number (“F101”) of the basketball arena in the WHERE clause. 
-- Instead, you should use a condition on the FacName column for the value of “Basketball arena”. 

select EVENTPLAN.PLANNO, LINENO, RESOURCETBL.RESNAME, NUMBERFLD, LOCNAME, TIMESTART, TIMEEND
	from EVENTPLANLINE inner join RESOURCETBL on EVENTPLANLINE.RESNO = RESOURCETBL.RESNO
    inner join EVENTPLAN on EVENTPLANLINE.PLANNO = EVENTPLAN.PLANNO
    inner join LOCATION on EVENTPLANLINE.LOCNO = LOCATION.LOCNO
    inner join FACILITY on LOCATION.FACNO = FACILITY.FACNO
where
	ACTIVITY = 'Operation' and
    FACNAME = 'Basketball Arena' and
    WORKDATE between '2018-10-01' and '2018-12-31';
    
-- Data Modification Problems

-- 1.	Insert a new row into the Facility table with facility name “Swimming Pool”.
insert into FACILITY (FACNO,FACNAME) values ('F104','Swimming Pool'); 

-- 2. Insert a new row in the Location table related to the Facility row in modification problem 1. 
-- The new row should have “Door” for the location name. 
insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L107','F104','Door');

-- 3. Insert a new row in the Location table related to the Facility row in modification problem 1. 
-- The new row should have “Locker Room” for the location name.
insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L108', 'F104', 'Locker Room');

-- 4. Change the location name of “Door” to “Gate” for the row inserted in modification problem 2. 
update LOCATION set LOCNAME = 'Gate' where LOCNO = 'L107';

-- 5. Delete the row inserted in modification problem 3. 
delete from LOCATION
where LOCNO = 'L108';

