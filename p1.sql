
/*
Schema According to the ERD
 
Strong Entities:
 
Location(locationID PK, locationName, locationType, xcoord UQ,ycoord UQ,floor UQ)
StaffMem(accountName PK, firstName, lastName, phone, positionID FK, locationID FK references Office)
Position(positionID PK, title, payGrade)
 
Weak Entities: This will take the primary key of the relation it connects to
 
Office(locationID PK, maxOccupancy)
directedEdge(edgeID PK, startingLoc - locID FK, endingLoc - locID FK)
path(pathID PK, edgeID FK,edgeOrder)


Updated Code + Notes
So in Chris’ office hours, he said:
Since office isA location, then that means that Office must have locations primaryID, and the way that we determine which office a staff member works in is by obtaining the location ID through the office (which has the primary key for the location)
What is left: DATA
Need to calculate the floor data (for Location), DirectedEdge, and EdgePath
*/

DROP TABLE EdgePath;
DROP TABLE DirectedEdge;
DROP TABLE Staff;
DROP TABLE Office;
DROP TABLE Locations;
DROP TABLE Positions;

create table Locations (
    locationID varchar2(4) NOT NULL ,
    locationName varchar2(20) NOT NULL,
    locationType varchar(20),
    xcoord number(4),
    ycoord number(4),
    floorVal varchar2(10),
    CONSTRAINT Locations_PK PRIMARY KEY (locationID),
    CONSTRAINT Locations_compositeUQ UNIQUE (xcoord,ycoord,floorVal)

);

--Inserts 

insert into Locations values(	'201A', '201A', 'Office', 640, 200, 2);
insert into Locations values(	'201B', '201B', 'Office', 575, 200, 2);
insert into Locations values(	'201C', '201C', 'Office', 465, 200, 2);
insert into Locations values(	'202', '202', 'Gallery', 395, 270, 2);
insert into Locations values(	'202A', '202A', 'Office', 70, 405, 2);
insert into Locations values(	'202B', '202B', 'Office', 170, 405, 2);
insert into Locations values(	'202C', '202C', 'Office', 275, 405, 2);
insert into Locations values(	'202D', '202D', 'Office', 380, 405, 2);
insert into Locations values(	'202E', '202E', 'Office', 465, 405, 2);
insert into Locations values(	'203', '203', 'Gallery', 885, 340, 2);
insert into Locations values(	'204', '204 Lovecraft Room', 'Conference Room', 980, 340, 2);
insert into Locations values(	'205', '205', 'Office', 465, 340, 2);
insert into Locations values(	'206', '206', 'Office', 1380, 200, 2);
insert into Locations values(	'207', '207', 'Office', 1250, 200, 2);
insert into Locations values(	'208', '208', 'Closet', 1075, 200, 2);
insert into Locations values(	'209', '209 Museum Guides', 'Office', 1015, 200, 2);
insert into Locations values(	'S2', '2nd Floor Stairs', 'Stairs', 815, 160, 2);
insert into Locations values(	'H201', 'Hallway 201', 'Hallway', 70, 350, 2);
insert into Locations values(	'H202', 'Hallway 202', 'Hallway', 170, 350, 2);
insert into Locations values(	'H203', 'Hallway 203', 'Hallway', 275, 350, 2);
insert into Locations values(	'H204', 'Hallway 204', 'Hallway', 380, 350, 2);
insert into Locations values(	'H205', 'Hallway 205', 'Hallway', 465, 350, 2);
insert into Locations values(	'H206', 'Hallway 206', 'Hallway', 465, 270, 2);
insert into Locations values(	'H207', 'Hallway 207', 'Hallway', 575, 270, 2);
insert into Locations values(	'H208', 'Hallway 208', 'Hallway', 640, 270, 2);
insert into Locations values(	'H209', 'Hallway 209', 'Hallway', 815, 270, 2);
insert into Locations values(	'H210', 'Hallway 210', 'Hallway', 885, 270, 2);
insert into Locations values(	'H211', 'Hallway 211', 'Hallway', 980, 270, 2);
insert into Locations values(	'H212', 'Hallway 212', 'Hallway', 1015, 270, 2);
insert into Locations values(	'H213', 'Hallway 213', 'Hallway', 1075, 270, 2);
insert into Locations values(	'H214', 'Hallway 214', 'Hallway', 1250, 270, 2);
insert into Locations values(	'H215', 'Hallway 215', 'Hallway', 1380, 270, 2);
insert into Locations values(	'302A', '302A', 'Office', 440, 215, 3);
insert into Locations values(	'302B', '302B', 'Office', 580, 215, 3);
insert into Locations values(	'303', '303', 'Office', 350, 215, 3);
insert into Locations values(	'304', '304', 'Conference Room', 275, 265, 3);
insert into Locations values(	'305A', '305A', 'Office', 340, 425, 3);
insert into Locations values(	'305B', '305B', 'Office', 240, 425, 3);
insert into Locations values(	'305C', '305C', 'Office', 175, 425, 3);
insert into Locations values(	'305D', '305D', 'Office', 30, 425, 3);
insert into Locations values(	'306', '306', 'Gallery', 475, 335, 3);
insert into Locations values(	'307', '307', 'Office', 975, 410, 3);
insert into Locations values(	'308', '308', 'Gallery', 1040, 365, 3);
insert into Locations values(	'309', '309', 'Gallery', 1040, 265, 3);
insert into Locations values(	'M', 'Men''s Restroom', 'Restroom', 960, 215, 3);
insert into Locations values(	'W', 'Women''s Restroom', 'Restroom', 650, 215, 3);
insert into Locations values(	'S3', '3rd Floor Stairs', 'Stairs', 780, 85, 3);
insert into Locations values(	'H301', 'Hallway 301', 'Hallway', 30, 360, 3);
insert into Locations values(	'H302', 'Hallway 302', 'Hallway', 175, 360, 3);
insert into Locations values(	'H303', 'Hallway 303', 'Hallway', 240, 360, 3);
insert into Locations values(	'H304', 'Hallway 304', 'Hallway', 340, 360, 3);
insert into Locations values(	'H305', 'Hallway 305', 'Hallway', 380, 360, 3);
insert into Locations values(	'H306', 'Hallway 306', 'Hallway', 350, 265, 3);
insert into Locations values(	'H307', 'Hallway 307', 'Hallway', 380, 265, 3);
insert into Locations values(	'H308', 'Hallway 308', 'Hallway', 440, 265, 3);
insert into Locations values(	'H309', 'Hallway 309', 'Hallway', 475, 265, 3);
insert into Locations values(	'H310', 'Hallway 310', 'Hallway', 580, 265, 3);
insert into Locations values(	'H311', 'Hallway 311', 'Hallway', 650, 265, 3);
insert into Locations values(	'H312', 'Hallway 312', 'Hallway', 780, 265, 3);
insert into Locations values(	'H313', 'Hallway 313', 'Hallway', 960, 265, 3);
insert into Locations values(	'H314', 'Hallway 314', 'Hallway', 975, 265, 3);
insert into Locations values(	'H315', 'Hallway 315', 'Hallway', 975, 365, 3);

CREATE TABLE Office(
	locationID varchar2(4) NOT NULL,
	maxOccupancy number (5),
	CONSTRAINT Office_PK PRIMARY KEY(locationID)
);

--INSERTS

Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('201A',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('201B',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('201C',2);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('202',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('202A',2);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('202B',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('202C',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('202D',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('202E',2);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('203',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('204',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('205',2);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('206',3);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('207',2);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('208',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('209',5);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('S2',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H201',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H202',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H203',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H204',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H205',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H206',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H207',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H208',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H209',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H210',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H211',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H212',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H213',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H214',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H215',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('302A',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('302B',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('303',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('304',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('305A',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('305B',2);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('305C',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('305D',3);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('306',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('307',1);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('308',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('309',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('M',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('W',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('S3',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H301',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H302',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H303',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H304',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H305',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H306',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H307',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H308',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H309',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H310',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H311',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H312',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H313',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H314',null);
Insert into Office (LOCATIONID,MAXOCCUPANCY) values ('H315',null);

create table Positions (
	positionID varchar2(20),
	title varchar(27),
	paygrade number(2),
	CONSTRAINT Positions_PK PRIMARY KEY (positionID)
);

--Inserts

Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('ASSOCARCHIVIST','Associate Archivist',5);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('DOCENT','Docent',0);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('ASSTCURATOR','Assistant Curator',4);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('ASSTARCHIVIST','Assistant Archivist',3);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('ASSOCCURATOR','Associate Curator',6);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('COORDEXHIBITS','Coordinator of Exhibits',9);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('DEPTHEAD','Department Head',10);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('DIRARTS','Director of Arts',9);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('DIRHISTORY','Director of History',9);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('COORDDESIGN','Coordinator of Design',8);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('ADMIN1','Administrative Assistant I',1);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('ADMIN2','Administrative Assistant II',2);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('CURATOR','Curator',7);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('HISTORIAN','Historian',6);
Insert into Positions (POSITIONID,TITLE,PAYGRADE) values ('ARCHIVIST','Archivist',7);


CREATE TABLE Staff (
	accountName varchar2(15),
	firstName varchar(15) NOT NULL,
	lastName varchar2(15) NOT NULL,
	locationID varchar(4),-- REFERENCES Office (locationID),
	phone varchar2(12),
	positionID varchar(20) DEFAULT 'Curator', -- REFERENCES Positions (positionID),
    CONSTRAINT Staff_location_FK foreign key (locationID) references Office (locationID),
    CONSTRAINT Staff_position_FK foreign key (positionID) references Positions (positionID),
	CONSTRAINT Staff_PK PRIMARY KEY (accountName, firstName, lastName,locationID, phone, positionID)
);

--INSERTS
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Caroline','Fargo','fargo','205',2140,'ASSOCCURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Charles','Rick','rick','305C',2445,'CURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Christine','Arko','arko','209',2178,'DOCENT');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Sam','Shoe','shoe','206',1433,'ASSOCCURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Mark','Williams','williams','207',4357,'CURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Mark','Williams','williams','207',4622,'DEPTHEAD');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Dewayne','Dixon','dixon','305A',2121,'CURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Douglas','Rodriguez','rodriguez','202E',1993,'ASSTARCHIVIST');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Eli','Stein','stein','202A',2315,'CURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Eli','Stein','stein','202A',2315,'DIRARTS');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Amy','Lin','lin','202D',2068,'ASSOCCURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Amy','Lin','lin','202D',2068,'COORDEXHIBITS');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('George','Hirsch','hirsch','305B',2002,'ASSOCCURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Katherine','Pine','pine','201C',1752,'HISTORIAN');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Hugh','Landry','landry','202E',1993,'ARCHIVIST');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Moesha','Simmons','simmons','302B',2322,'ADMIN1');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Eva','Brown','brown','202C',2656,'ASSOCCURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Emily','Fischer','fischer','201B',1618,'CURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Gaurav','Mehta','mehta','202B',3071,'ASSTCURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Mark','Clay','clay','307',1909,'CURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Michelle','Hostra','hofstra','205',3411,'CURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Tom','Haring','haring','201A',1617,'HISTORIAN');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Kiki','Jones','jones','303',3669,'ADMIN2');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Kiki','Jones','jones','303',2674,'ADMIN2');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Mohamed','Isa','isa','207',2921,'ASSOCCURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Neil','Holmes','holmes','206',2069,'CURATOR');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Neil','Holmes','holmes','206',2069,'DIRHISTORY');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Nicole','Ford','ford','209',1857,'DOCENT');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Ralph','Cane','rcane','209',1857,'COORDDESIGN');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('Griffin','Ganoon','ganoon','302A',1857,'ASSOCARCHIVIST');
Insert into Staff (FIRSTNAME,LASTNAME,ACCOUNTNAME,LOCATIONID,PHONE,POSITIONID) values ('William','Tam','tam','305D',2206,'ASSTARCHIVIST');



CREATE TABLE DirectedEdge (
	edgeID varchar2(9),
	startingLoc varchar2(4), -- REFERENCES Locations (locationID),
	endingLoc varchar2(4), -- REFERENCES Locations (locationID),
	CONSTRAINT DirectedEdge_PK PRIMARY KEY (edgeID),
    CONSTRAINT DirectedEdge_start_FK foreign key (startingLoc) REFERENCES Locations(locationID),
    CONSTRAINT DirectedEdge_end_FK foreign key (endingLoc) REFERENCES Locations(locationID)
);

--Inserts

Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('202A_H201','202A','H201');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H201_202A','H201','202A');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H201_H202','H201','H202');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H202_H201','H202','H201');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H202_202B','H202','202B');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('202B_H202','202B','H202');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H202_H203','H202','H203');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H203_H202','H203','H202');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H203_202C','H203','202C');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('202C_H203','202C','H203');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H203_H204','H203','H204');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H204_H203','H204','H203');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H204_202D','H204','202D');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('202D_H204','202D','H204');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H204_H205','H204','H205');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H205_H204','H205','H204');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H205_202E','H205','202E');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('202E_H205','202E','H205');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H205_H206','H205','H206');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H206_H205','H206','H205');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H206_202','H206','202');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('202_H206','202','H206');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H206_201C','H206','201C');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('201C_H206','201C','H206');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H206_H207','H206','H207');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H207_H206','H207','H206');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H207_201B','H207','201B');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('201B_H207','201B','H207');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H207_H208','H207','H208');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H208_H207','H208','H207');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H208_201A','H208','201A');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('201A_H208','201A','H208');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H208_H209','H208','H209');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H209_H208','H209','H208');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H209_S2','H209','S2');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('S2_H209','S2','H209');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H209_H210','H209','H210');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H210_H209','H210','H209');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H210_203','H210','203');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('203_H210','203','H210');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H210_H211','H210','H211');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H211_H210','H211','H210');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H211_204','H211','204');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('204_H211','204','H211');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H211_H212','H211','H212');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H212_H211','H212','H211');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H212_209','H212','209');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('209_H212','209','H212');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H212_H213','H212','H213');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H213_H212','H213','H212');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H213_208','H213','208');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('208_H213','208','H213');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H213_H214','H213','H214');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H214_H213','H214','H213');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H214_207','H214','207');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('207_H214','207','H214');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H214_H215','H214','H215');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H215_H214','H215','H214');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H215_206','H215','206');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('206_H215','206','H215');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H215_205','H215','205');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('205_H215','205','H215');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H301_305D','H301','305D');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('305D_H301','305D','H301');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H301_H302','H301','H302');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H302_H301','H302','H301');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H302_305C','H302','305C');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('305C_H302','305C','H302');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H302_H303','H302','H303');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H303_H302','H303','H302');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H303_305B','H303','305B');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('305B_H303','305B','H303');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H303_H304','H303','H304');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H304_H303','H304','H303');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H304_305A','H304','305A');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('305A_H304','305A','H304');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H304_H305','H304','H305');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H305_H304','H305','H304');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H305_H307','H305','H307');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H307_H305','H307','H305');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H307_H306','H307','H306');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H306_H307','H306','H307');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H306_303','H306','303');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('303_H306','303','H306');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H306_304','H306','304');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('304_H306','304','H306');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H307_H308','H307','H308');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H308_H307','H308','H307');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H308_302A','H308','302A');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('302A_H308','302A','H308');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H308_H309','H308','H309');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H309_H308','H309','H308');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H309_306','H309','306');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('306_H309','306','H309');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H309_H310','H309','H310');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H310_H309','H310','H309');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H310_302B','H310','302B');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('302B_H310','302B','H310');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H310_H311','H310','H311');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H311_H310','H311','H310');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H311_W','H311','W');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('W_H311','W','H311');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H311_H312','H311','H312');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H312_H311','H312','H311');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H312_S3','H312','S3');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('S3_H312','S3','H312');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H312_H313','H312','H313');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H313_H312','H313','H312');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H313_M','H313','M');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('M_H313','M','H313');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H313_H314','H313','H314');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H314_H313','H314','H313');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H314_309','H314','309');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('309_H314','309','H314');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H314_H315','H314','H315');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H315_H314','H315','H314');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H315_308','H315','308');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('308_H315','308','H315');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('H315_307','H315','307');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('307_H315','307','H315');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('S2_S3','S2','S3');
Insert into DirectedEdge (EDGEID,STARTINGLOC,ENDINGLOC) values ('S3_S2','S3','S2');



CREATE TABLE EdgePath (
	pathID varchar2(10),
	--edgeID number(3) REFERENCES DirectedEdge(edgeID),
	edgeOrder varchar2(150),  -- Need to look into how to specify the edgeOrder
	CONSTRAINT EdgePath_PK PRIMARY KEY (pathID)

);

Insert into EdgePath Values('305B_M', '305B_H303, H303_H304, H304_H305, H305_H307, H307_H308, H308_H309, H309_H310, H310_H311, H311_H312, H312_H313, H313_M');
Insert into EdgePath Values('S2_206', 'S2_H209, H209_H210, H210_H211, H211_H212, H212_H213, H213_H214, H214_H215, H215_206');
Insert Into EdgePath Values('202E_307', '202E_H205, H205_H206, H206_H207, H207_H208, H208_H209, H209_S2, S2_S3, S3_H312, H312_H313, H313_H314, H314_H315, H315_307');

Select * From Locations;
Select * From Staff;
Select * From Office;
Select * From DirectedEdge;
Select * From EdgePath;
Select * From Positions;



