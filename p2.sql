--Problem 1
create view NoCurator as
    select O.locationID,S.accountName
    from Location L join Office O
    on L.locationID = O.locationID join Staff S
    on O.locationID = S.locationID join StaffPosition SP
    on S.accountName = SP.accountName
    where SP.positionID <> 'CURATOR';
   
drop view NoCurator;
   
select locationID, count(accountName)as CNT
from NoCurator
group by locationID;

--Problem 2
create procedure StaffInOffice (LocationID varchar2) Is
    tempLoc varchar2(20);
    tempOcc number(2);
    tempLocCnt number(2);

    Begin
        select count(S.locationID), S.locationID, o.maxOccupancy into tempLocCnt,tempLoc,tempOcc
        from Staff S join Office O
        on S.locationID = O.locationID
        where S.locationID = StaffInOffice.LocationID
        group by S.locationID, maxOccupancy;
        dbms_output.put_line('Office '||LocationID|| ': '||tempLocCnt || ' assigned,' || tempOcc || ' max occupancy');
    End;
/

set serveroutput on;
exec StaffInOffice('205');
drop procedure StaffInOffice;

--Problem 3

create or replace trigger NoSameStartEnd
before insert on Edge
for each row
    Begin
        if (:new.startingID = :new.endingID)
        then
            RAISE_APPLICATION_ERROR(-20001, 'INSERTED ROW ERROR: startingID and endingID are the same');
   
        end if;
    End;
/

Insert into Edge(startingID, endingID) values ('H308', 'H308');

drop trigger NoSameStartEnd;


--Problem 4
-- substr(string, start, length)
create or replace trigger OnlyStaircases
before insert on Edge
for each row
declare 
	beginFloor number;
	endFloor number;
	startType varchar2;
	endType varchar2;
begin 
	select floor
	into beginFloor
	from Location
	where :new.startID = locationID;
	
	select floor
	into endFloor
	from Location 
	where :new.endId = LocationID;
	
	select locationType
	into startType
	from Location 
	where :new.startId = LocationID;
	
	select locationType
	into endType
	from Location
	where :new.endID = LocationID;
	
	if(beginType != 'Stairs' or endType != 'Stairs') 
    then
        if(beginFloor != endFloor) then
            RAISE_APPLICATION_ERROR(-20001, 'INSERTED ROW ERROR: Only stairs can have edges on different floors')
        else
            insert values into Edge (new.startingLoc, new.endingLoc);
    if(beginType = 'Stairs' and endType = 'Stairs')
    then
        if(beginFloor = endFloor)
        then
            RAISE_APPLICATION_ERROR(-20001, 'INSERTED ROW ERROR: Stair edges must connect to different floors')
        else    
            insert values into Edge (new.startingLoc, new.endingLoc);
	
end;
/

--determine how to we can get sql to tell us the floor for starting and ending location


select *
from Edge E join Location L
on E.startingID = L.locationID;


drop trigger OnlyStaircases;
Insert into Edge(startingID, endingID) values ('S3', 'S3');

-- Problem 5

create or replace trigger MustBeOffice
before insert or update on Office
for each row
declare
		
		officeLocationType varchar2(30);
		
		
        select L.locationType 
		into locationType
        from Office O join Location L
        on O.locationID = L.locationID
		where L.locationID = :new.locationID;
       
    Begin
       if(officeLocationType != 'Office') 
		then	
			RAISE_APPLICATION_ERROR(-20006, 'INSERTED ROW ERROR: Inserted office is not valid')
    End;
/

drop trigger MustBeOffice;

Insert into OFFICE (LOCATIONID, MAXOCCUPANCY) values('309', 1);

select *
from Office join Location
on Office.locationID = Location.locationID;

--Problem 6
--statement level trigger, staff cannot have more than 3 pos

create or replace tigger JobLimit
before insert or update on Staff
declare
    accountCount varchar2(50);
   
    Cursor counter is
        select count(positionID) as CNT, accountName into accountCount
        from StaffPosition
        group by accountName;
    Begin
        if (accountCount > 4) then
            RAISE_APPLICATION_ERROR(-20006, 'EXISTING ROW ERROR: Staff members cannot have more than 3 positions ');
        end if;
        for counterRow in counter
            if (counteRow.CNT > 4) then
                RAISE_APPLICATION_ERROR(-20006, 'EXISTING ROW ERROR: Staff members cannot have more than 3 positions ');
            end if;
        end loop;
    End;
/

drop trigger JobLimit;


create or replace trigger JobLimit
after insert or update on Staff
for each statement
declare     
    Cursor counter is 
        select count(positionID) as CNT, accountName
        from StaffPosition
        group by accountName;
    Begin
        for counterRow in counter
            if (counterRow.CNT > 4) then
                RAISE_APPLICATION_ERROR(-20006, 'EXISTING ROW ERROR: Staff members cannot have more than 3 positions ');
            end if;
        end loop;
    End;
/ 






