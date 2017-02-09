-- LAB2 EDAF20 --

-- tables we need; User, Shows, Reservation, Theater
--
--  |user| --- book ----  |Shows|--- shows in
-- 	        | 		      |
--	        |      		      |
--	  |Reservation|		  |Theater|

-- Relational 
-- User(_username_, name, phone, addres)
-- Theater(_theaterName_, seats)
-- Shows(_movieTitle_, _dayOfShow_, freeSeats, FK(theaterName))
-- Reservation(_nbr_, FK(username), FK(movieTitle), FK(dayOfShow), FK(theaterName))

set foreign_key_checks = 0;

drop table if exists User;
create table User
(username varchar(20),
name varchar(20) not null,
phone varchar(9) not null,
address varchar(30) not null,
primary key(username));

drop table if exists Theater;
create table Theater (
	theaterName varchar(30) not null unique, 
	seats integer not null, 
	primary key(theaterName)
);

drop table if exists Shows;
create table Shows (
	movieTitle varchar(50) not null, 
	dayOfShow date not null, 
	freeSeats int not null, 
	theaterName varchar(30) not null,
	primary key(movieTitle, dayOfShow),
	foreign key(theaterName) references Theater(theaterName),
	constraint perDay unique (movieTitle, dayOfShow)
);

drop table if exists Reservation;
create table Reservation (
	nbr integer not null auto_increment, 
	username varchar(20) not null, 
	movieTitle varchar(50) not null,
	dayOfShow date not null, 
	theaterName varchar(30) not null,
       	primary key(nbr),
	foreign key (username) references User(username), 
	foreign key (movieTitle, dayOfShow) references Shows(movieTitle, dayOfShow),
	foreign key (theaterName) references Theater(theaterName)
);


set foreign_key_checks = 1;



-- End of table setup


-- Values setup
-- Create shows

insert into User (username, name, phone, address)
values ('Caesar', 'Julius Caesar', '0733', 'Palaseum Rome');
insert into User (username, name, phone, address)
values ('Crab', 'Cancer', '666', 'Hell, level 9');
insert into User (username, name, phone, address)
values ('Spartacus', 'Spartacus', '01011', 'Colloseum Arena');
insert into User (username, name, phone, address)
values ('Cicero', 'Cicero', '1337', 'Senate of Rome');

insert into Theater (theaterName, seats)
values ('Filmstaden Jönköping', 120);
insert into Theater (theaterName, seats)
values ('SF', 85);
insert into Theater (theaterName, seats)
values ('Filmstaden Helsingborg', 90);
insert into Theater (theaterName, seats)
values ('Filmstaden Linköping', 120);

insert into Shows (movieTitle, dayOfShow, freeSeats, theaterName) values
("Hateful Eight", 				"2017-02-25", 1, "Filmstaden Jönköping"),
("Prometheus", 					"2017-02-05", 0, "Filmstaden Jönköping"),
("Pandorum", 					"2017-02-05", 10, "Filmstaden Jönköping"),
("Alien: Covenant", 				"2017-02-15", 12, "Filmstaden Jönköping"),

("Life",					"2017-03-05", 75, "SF"),
("Ghost In The Shell",				"2017-02-05", 25, "SF"),
("Guardians of the galaxy: vol 2", 		"2017-01-05", 35, "SF"),
("King Arthur: Legend of the Sword", 		"2017-02-05", 45, "SF"),

("Pirates of the Caribbean: Salazar's Revenge", "2017-02-05", 9, "Filmstaden Helsingborg"),
("World War Z 2", 				"2017-04-04", 61, "Filmstaden Helsingborg"),
("The Dark Tower", 				"2017-11-27", 24, "Filmstaden Helsingborg"),
("Blade Runner 2049", 				"2017-02-05", 56, "Filmstaden Helsingborg"),

("God Particle", 				"2017-01-09", 21, "Filmstaden Linköping"),
("Star Wars: Episode VIII - The Last Jedi", 	"2017-02-09", 10, "Filmstaden Linköping"),
("Science Fiction Volume One: The Osiris Child","2017-03-08", 20, "Filmstaden Linköping"),
("Sunshine", 					"2017-04-07", 0, "Filmstaden Linköping"),

-- ROTATE
("Hateful Eight",		 		"2017-11-06", 120, "Filmstaden Linköping"),
("Prometheus", 					"2017-12-06", 120, "Filmstaden Linköping"),
("Pandorum", 					"2017-09-06", 120, "Filmstaden Linköping"),
("Alien: Covenant", 				"2017-07-06", 120, "Filmstaden Linköping"),

("Life", 					"2017-02-06", 120, "Filmstaden Jönköping"),
("Ghost In The Shell", 				"2017-03-06", 120, "Filmstaden Jönköping"),
("Guardians of the galaxy: vol 2", 		"2017-04-06", 120, "Filmstaden Jönköping"),
("King Arthur: Legend of the Sword", 		"2017-05-06", 120, "Filmstaden Jönköping"),

("Pirates of the Caribbean: Salazar's Revenge", "2017-02-06", 85, "SF"),
("World War Z 2", 				"2017-12-06", 85, "SF"),
("The Dark Tower", 				"2017-02-06", 85, "SF"),
("Blade Runner 2049", 				"2017-11-06", 85, "SF"),

("God Particle", 				"2017-09-01", 90, "Filmstaden Helsingborg"),
("Star Wars: Episode VIII - The Last Jedi", 	"2017-02-06", 90, "Filmstaden Helsingborg"),
("Science Fiction Volume One: The Osiris Child","2017-02-06", 90, "Filmstaden Helsingborg"),
("Sunshine", 					"2017-02-06", 90, "Filmstaden Helsingborg"),

-- ROTATE
("Hateful Eight", 				"2017-02-07", 90, "Filmstaden Helsingborg"),
("Prometheus", 					"2017-02-07", 90, "Filmstaden Helsingborg"),
("Pandorum", 					"2017-02-07", 90, "Filmstaden Helsingborg"),
("Alien: Covenant", 				"2017-02-07", 90, "Filmstaden Helsingborg"),

("Life", 					"2017-02-07", 120, "Filmstaden Linköping"),
("Ghost In The Shell", 				"2017-02-07", 120, "Filmstaden Linköping"),
("Guardians of the galaxy: vol 2", 		"2017-02-07", 120, "Filmstaden Linköping"),
("King Arthur: Legend of the Sword", 		"2017-02-07", 120, "Filmstaden Linköping"),

("Pirates of the Caribbean: Salazar's Revenge", "2017-02-07", 120, "Filmstaden Jönköping"),
("World War Z 2", 				"2017-02-07", 120, "Filmstaden Jönköping"),
("The Dark Tower", 				"2017-02-07", 120, "Filmstaden Jönköping"),
("Blade Runner 2049", 				"2017-02-07", 120, "Filmstaden Jönköping"),

("God Particle", 				"2017-02-07", 85, "SF"),
("Star Wars: Episode VIII - The Last Jedi", 	"2017-02-07", 85, "SF"),
("Science Fiction Volume One: The Osiris Child","2017-02-07", 85, "SF"),
("Sunshine", 					"2017-02-07", 85, "SF");


-- duplicate test
insert into Theater (name, seats)
values ('Filmstaden Linköping', 300);
-- gives ... bla bla duplicate

-- duplicate test
insert into Shows (movieTitle, dayOfShow, freeSeats, theaterName)
values("Sunshine", "2017-02-05", 100, "SF");

insert into Shows (movieTitle, dayOfShow, freeSeats, theaterName)
values("Sunshine", "2017-02-05", 100, "SF");
--  should give = ERROR 1062 (23000): Duplicate entry '2013-03-06-FilMovieShowsingidtaden Linköping-Hateful Eight' for key 'day'

-- Create reservation 
insert into Reservation (username, movieTitle, dayOfShow, theaterName)
values("Caesar", "Pirates of the Caribbean: Salazar's Revenge", "2017-02-06", "SF");

insert into Reservation (username, movieTitle, dayOfShow, theaterName)
values("Caesar", "Sunshine", "2017-02-05", "SF");

insert into Reservation (username, movieTitle, dayOfShow, theaterName)
values("Caesar", "Alien: Covenant", "2017-02-15", "Filmstaden Jönköping");
insert into Reservation (username, movieTitle, dayOfShow, theaterName)
values("Caesar", "Alien: Covenant", "2017-02-15", "Filmstaden Jönköping");

-- Question 9
-- Ett data-race uppstår, en hazard som gör att range over flow av värden kan ske, tex att 
-- det blir för många bokningar. Man använder sig av transactions och commit transactions, som fungerar
-- som en typ av mutex (mutual exclusion) teknik. Detta finns på slides för föreläsningar

-- Övn. 10 

