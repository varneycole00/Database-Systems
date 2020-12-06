-- assignment 1: Thomas Cole Varney, CS 3431

drop table Reservation;
drop table Customer;
drop table Guide;
drop table Tour;


create sequence guideID_seq start with 1;
create sequence customerID_seq start with 1;
create sequence reservationID_seq start with 1;

create table Guide (
	guideID number(3),
	guideFirstName varchar2(15),
	guideLastName varchar2(15),
	phone number(10),
	vehicleType varchar2(15),
	title varchar2(15),
	salary number(5),
	Constraint Guide_PK Primary Key (guideID)
);

insert into Guide values(guideID_seq.nextval, 'Noah', 'Smith', 5082391452, 'bus', 'Junior Guide', 22000);
insert into Guide values(guideID_seq.nextval, 'Liam', 'Johnson', 7812930638, 'bus', 'Guide', 31000);
insert into Guide values(guideID_seq.nextval, 'Mason', 'Williams', 6174920983, 'car', 'Senior Guide', 45000);
insert into Guide values(guideID_seq.nextval, 'Olivia', 'Brown', 6672930684, 'amphibious', 'Guide', 32000);
insert into Guide values(guideID_seq.nextval, 'Sofia', 'Jones', 4150973848, 'bus', 'Senior Guide', 49000);
insert into Guide values(guideID_seq.nextval, 'Emily', 'Miller', 3058442323, 'car', 'Junior Guide', 25000);
insert into Guide values(guideID_seq.nextval, 'Ethan', 'Davis', 4156719583, 'bus', 'Junior Guide', 24000);
insert into Guide values(guideID_seq.nextval, 'Chloe', 'Garcia', 8193291234, 'amphibious', 'Guide', 30000);
insert into Guide values(guideID_seq.nextval, 'Ben', 'Rodriguez', 8458799394, 'bus', 'Junior Guide', 27000);
insert into Guide values(guideID_seq.nextval, 'Mia', 'Wilson', 5088314545, 'car', 'Senior Guide', 47000);

select * from Guide;

create table Customer (
	customerID number(4),
	customerFirstName varchar2(15),
	customerLastName varchar2(15),
	address varchar2(25),
	phone number(10),
	age number(3) Not Null,
	Constraint Customer_PK Primary Key (customerID)
);

insert into Customer values(customerID_seq.nextval, 'Michael',	'Ward',	'143 Cambridge Ave.', 5082328798, 45);
insert into Customer values(customerID_seq.nextval, 'Lisa', 'Gray', '77 Massachusetts Ave.', 6174153059, 68);
insert into Customer values(customerID_seq.nextval, 'Brian', 'Myers', '175 Forest St.', 2123043923, 19);
insert into Customer values(customerID_seq.nextval, 'Nicole', 'Ross', '35 Tremont St.', 7818914567, 42);
insert into Customer values(customerID_seq.nextval, 'Kelly', 'Powell', '100 Main St.', 8915367188, 57);
insert into Customer values(customerID_seq.nextval, 'Madison', 'Martin', '42 Oak St', 1233753684, 16);
insert into Customer values(customerID_seq.nextval, 'Ashley', 'White', '1414 Cedar St.', 6428369619, 18);
insert into Customer values(customerID_seq.nextval, 'Joshua', 'Clark', '42 Elm Place', 1946825344, 22);
insert into Customer values(customerID_seq.nextval, 'Tyler', 'Young', '9 Washington Court', 9864752346, 25);
insert into Customer values(customerID_seq.nextval, 'Anna', 'Powell', '98 Lake Hill Drive', 8946557732, 17);
insert into Customer values(customerID_seq.nextval, 'Justin', 'Allen', '657 Redondo Ave.', 7988641411, 18);
insert into Customer values(customerID_seq.nextval, 'Bruce', 'Sanchez', '5 Jefferson Ave.', 2324648888, 26);
insert into Customer values(customerID_seq.nextval, 'Rachel', 'Lee', '8711 Meadow St.', 2497873464, 67);
insert into Customer values(customerID_seq.nextval, 'Dylan', 'Garcia', '17 Valley Drive', 9865553232, 20);
insert into Customer values(customerID_seq.nextval, 'Austin', 'Davis', '1212 8th St.', 4546667821, 29);

Select * from Customer;


create table Tour (
	tourID number(3),
	tourName varchar2(25),
	description varchar2(40),
	city varchar2(15),
	state char(2),
	vehicleType varchar2(15),
	Constraint Tour_PK Primary KEY (tourID)
);

insert into Tour values(1, 'Duck Tour', 'Amphibious tour of the Charles River', 'Boston', 'MA', 'amphibious');
insert into Tour values(2, 'Freedom Trail', 'Historic tour of Boston',	 'Boston', 'MA', 'bus');
insert into Tour values(3, 'Magnificent Mile Tour',	 'Tour of Michigan Ave', 'Chicago', 'IL', 'car');
insert into Tour values(4, 'City Sights', 'Highlights of New York City', 'New York',  'NY', 'bus');
insert into Tour values(5, 'Golden Gate', 'Tour of Golden Gate Park', 'San Francisco', 'CA', 'bus');
 
select * from tour;

create table Reservation (
	reservationID number(4),
	travelDate date,
	customerID number(4) References Customer (customerID) On Delete Set Null,
	tourID number(3) References Tour(tourID) On Delete Set Null,
	guideID number(3) References Guide(guideID) On Delete Set Null,
	Constraint Reservation_PK Primary Key (reservationID)
);

insert into Reservation values(reservationID_seq.nextval, '15-Mar-16', 5, 2, 5	);
insert into Reservation values(reservationID_seq.nextval, '28-Feb-16', 1, 4, 1	);
insert into Reservation values(reservationID_seq.nextval, '3-Jun-16', 5, 1, 4	);
insert into Reservation values(reservationID_seq.nextval, '17-May-16', 4, 4, 2	);
insert into Reservation values(reservationID_seq.nextval, '11-Apr-16', 3, 2,  9	);
insert into Reservation values(reservationID_seq.nextval, '24-Nov-16', 2, 5,8	);
insert into Reservation values(reservationID_seq.nextval, '3-Aug-16', 4, 3, 3	);
insert into Reservation values(reservationID_seq.nextval, '13-Dec-16', 14, 2, 10);
insert into Reservation values(reservationID_seq.nextval, '9-Nov-16', 5, 5, 7	);
insert into Reservation values(reservationID_seq.nextval, '21-Jan-16', 9, 1, 5	);
insert into Reservation values(reservationID_seq.nextval, '6-Feb-16', 13, 5, 8	);
insert into Reservation values(reservationID_seq.nextval, '31-Aug-16', 8, 1, 2	);
insert into Reservation values(reservationID_seq.nextval, '10-Apr-16', 15, 3, 6	);
insert into Reservation values(reservationID_seq.nextval, '29-Jul-16', 10, 3, 2	);
insert into Reservation values(reservationID_seq.nextval, '15-Oct-16', 6, 2, 10	);
insert into Reservation values(reservationID_seq.nextval, '8-Mar-16', 14, 3, 3	);
insert into Reservation values(reservationID_seq.nextval, '11-Dec-16', 11, 4, 9	);
insert into Reservation values(reservationID_seq.nextval, '12-Aug-16', 7, 4, 7	);
insert into Reservation values(reservationID_seq.nextval, '22-Jun-16', 14, 1, 7	);
insert into Reservation values(reservationID_seq.nextval, '1-Feb-16', 12, 5, 1	);

drop sequence guideID_seq;
drop sequence customerID_seq;
drop sequence reservationID_seq;