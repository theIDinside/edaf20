
-- 7.c List all movies that are shown
select * from Performance;
-- List days when a movie is shown
select day from Performance where Performance.title='Prometheus';
-- list all data concerning a movie show
select * from Performance where Performance.id=2;

-- show currently showing movies
select title from Performance;

-- list days when movies are shown
select day, title from Performance;

-- Duplicate theater check
insert into Theater (name, seats)
values('SF', 105); -- => DUPLICATE ENTRY FOR 'SF'
-- Insertion into non-existing theater
insert into Performance (day, title, name)
values('2011-11-11', 'Prometheus', 'Test'); -- => Cannot add or upday a child row: a foreign key constraint fails (`base`.`Performance`, CONSTRAINT `Performance_ibfk_1` FOREIGN KEY (`name`) REFERENCES `Theater` (`name`))

insert into Movie(title)
values('Prometheus'); -- =>> ERROR 1062 (23000): Duplicate entry 'Prometheus' for key 'PRIMARY'

-- insertion of existing movie on day
insert into Performance(day, title, name)
values('2017-01-23', 'Prometheus', 'Filmstaden Linköping'); -- => ERROR 1062 (23000): Duplicate entry '2017-01-23' for key 'PRIMARY'

insert into Performance(day, title, name)
values('2016-02-02', 'Fuckyou', 'SF'); -- => ERROR 1452 (23000): Cannot add or upday a child row: a foreign key constraint fails (`base`.`Performance`, CONSTRAINT `Performance_ibfk_2` FOREIGN KEY (`title`) REFERENCES `Movie` (`title`))

insert into Reservation(username, day)
values ('Adolph', '2011-11-11'); -- => ERROR 1452 (23000): Cannot add or upday a child row: a foreign key constraint fails (`base`.`Reservation`, CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`username`) REFERENCES `User` (`username`))


