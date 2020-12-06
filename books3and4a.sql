drop table Books;
drop table Authors;
drop sequence authorID_seq;

create table Authors (
   authorID number,
   firstName varchar2(15),
   lastName varchar2(15),
   city varchar2(20),
   state char(2),
   Constraint Authors_PK Primary Key (authorID)
);

create sequence authorID_seq
start with 1
increment by 1;

insert into Authors values (authorID_seq.nextval, 'Robert', 'Silverberg', 'Brooklyn', 'NY');
insert into Authors values (authorID_seq.nextval, 'Anne', 'McCaffrey', 'Cambridge', 'MA');
insert into Authors values (authorID_seq.nextval, 'Robert', 'Heinlein', 'Kansas City', 'MO');
insert into Authors values (authorID_seq.nextval, 'Stephen', 'Donaldson', 'Cleveland', 'OH');
insert into Authors values (authorID_seq.nextval, 'Arthur', 'Clarke', 'Minehead', 'UK');
insert into Authors values (authorID_seq.nextval, 'Isaac', 'Asimov', 'New York City', 'NY');
insert into Authors values (authorID_seq.nextval, 'John', 'Varley', 'Austin', 'TX');
insert into Authors values (authorID_seq.nextval, 'Kurt', 'Vonnegut', 'Indianapolis', 'IN');

select * from Authors;

create table Books (
   ISBN char(10),
   authorID number,
   title varchar2(30) Not Null,
   copyright number(4),
   price number(6,2),
   Constraint Books_PK Primary Key (ISBN),
   Constraint Books_UQ Unique(Title),
   Constraint Books_authorID_FK Foreign Key (authorID) References Authors (authorID)
	On Delete Cascade,
   Constraint Books_copyrightVal check(copyright > 1800)
);

insert into Books values('0553144286', 1, 'Lord Valentines Castle', 1979, 23.99);
insert into Books values('0345284267', 2, 'Dragonflight', 1968, 14.75);
insert into Books values('0345281950', 3, 'Tunnel in the Sky', 1955, 2.32);
insert into Books values('0450005739', 3, 'Starship Troopers', 1959, 0.88);
insert into Books values('0345305507', 4, 'The One Tree', 1982, 41);
insert into Books values('0345291972', 5, 'Rendezvous With Rama', 1973, 75.02);
insert into Books values('0380009145', 6, 'Foundation', 1951, 1316.84);
insert into Books values('0345315715', 6, 'The Robots of Dawn', 1983, 33.5);
insert into Books values('0553288091', 6, 'The End of Eternity', 1955, 17.85);
insert into Books values('0425086704', 7, 'Titan', 1979, 50);
insert into Books values('0440111498', 8, 'Cats Cradle', 1963, 89.25);

select * from Books;
