-- LAB2 EDAF20 --

-- tables we need; User, Show, Reservation, Theater
--
--  |user| --- book ---- |Show|--- shows in
-- 	        | 		      |
--	        |      		      |
--	  |Reservation|		  |Theater|



-- (a)
set foreign_key_checks = 0;
drop table if exists User 
create table User
(username varchar(20),
addr varchar(30) not null,
phone varchar(9),
name varchar(20),
primary key(username));

drop table if exists Show
create table Show
(movieTitle varchar(50),
dayOfShow date not null, 
freeSeats integer not null,
theaterName varchar(30) not null,
primary key(movieTitle, dayOfShow),
foreign key(theaterName) references Theater(name));

drop table if exists Theater
create table Theater (
name varchar(30)
seats integer not null,
primary key(name));

drop table if exists Reservation 
create table Theater 
(nbr integer not null auto_increment 
username varchar(20) not null,
movieTitle varchar(50) not null,
dayOfshow date not null,
theaterName varchar(30) not null,
primary key(nbr),
foreign key (username) references User(username),
foreign key (movieTitle, dayOfShow) references Show(movieTitle, dayOfShow),
foreign key (theaterName) references Theater(name)
);

set foreign_key_checks = 1;




-- (a)
set foreign_key_checks = 0;
-- Table setup, drop if exists, then recreate

drop table if exists Movie;
create table Movie
(title varchar (100) not null unique,
primary key (title));

drop table if exists User;
create table User
(username varchar (30) not null unique,
name varchar (30) not null,
tel varchar (10),
address varchar (30),
primary key (username));

drop table if exists Theater;
create table Theater
(name varchar (30),
seats integer not null,
primary key (name));

drop table if exists Performance;
create table Performance
(id integer primary key not null auto_increment,
day date not null,
name varchar (30),
title varchar (100),
foreign key (name) references Theater(name),
foreign key (title) references Movie(title),
constraint unique(day, name, title));

drop table if exists Reservation;
create table Reservation
(reservationID integer auto_increment,
MovieShowingid integer not null,
username varchar (30),
primary key (reservationID),
foreign key(username) references User(username),
foreign key(MovieShowingid) references Performance(id),
constraint UNIQUE (MovieShowingid, username)
);

-- End of table setup


-- Values setup
set foreign_key_checks = 1;
insert into Movie (title)
values ('Hateful Eight');
insert into Movie (title)
values ('Pandorum');
insert into Movie (title)
values ('Prometheus');
insert into Movie (title)
values ('Sun');
insert into Movie (title)
values ('Event Horizon');

insert into User (username, name, tel, address)
values ('Caesar', 'Julius Caesar', '0733', 'Palaseum Rome');
insert into User (username, name, tel, address)
values ('TheCrab', 'Cancer', '666', 'Hell, level 9');
insert into User (username, name, tel, address)
values ('Spartacus', 'Spartacus', '01011', 'Colloseum Arena');
insert into User (username, name, tel, address)
values ('Cicero', 'Cicero', '1337', 'Senate of Rome');

insert into Theater (name, seats)
values ('Filmstaden Jönköping', 120);
insert into Theater (name, seats)
values ('SF', 85);
insert into Theater (name, seats)
values ('Filmstaden Helsingborg', 200);
insert into Theater (name, seats)
values ('Filmstaden Linköping', 300);

-- duplicate test
insert into Theater (name, seats)
values ('Filmstaden Linköping', 300);
-- gives ... bla bla duplicate



-- (b) Create Performance
insert into Performance (day, title, name)
values ('2012-12-24', 'Event Horizon', 'Filmstaden Jönköping');
insert into Performance (day, title, name)
values ('2017-01-23', 'Prometheus', 'SF');
insert into Performance (day, title, name)
values ('2013-03-06', 'Hateful Eight', 'Filmstaden Linköping');
insert into Performance (day, title, name)
values ('2013-03-06', 'Sun', 'SF');



-- duplicate test
insert into Performance (day, title, name)
values ('2013-03-06', 'Hateful Eight', 'Filmstaden Linköping');
-- gives = ERROR 1062 (23000): Duplicate entry '2013-03-06-FilMovieShowingidtaden Linköping-Hateful Eight' for key 'day'

-- Create reservation 
insert into Reservation(MovieShowingid, username)
select Performance.id, User.username
from Performance, User, Movie where Performance.day='2013-03-06'
and Performance.title='Prometheus' and username="Cicero";


insert into Reservation(MovieShowingid, username) 
select Performance.id, User.username 
from Performance, User, Movie 
where Performance.day='2017-01-23' and User.username='Spartacus' and Movie.title='Prometheus';

select * from Reservation left join Performance on Performance.id=Reservation.MovieShowingid;


-- Question 9
-- Ett data-race uppstår, en hazard som gör att range over flow av värden kan ske, tex att 
-- det blir för många bokningar. 

-- Övn. 10 
