-- (a) What are the names ( rst name, last name) of all the students? [72]
select firstName, lastName
from Students;

-- b Same as question a) but produce a sorted listing. Sort  rst by last name and then by  first name.
select firstName, lastName
from Students
order by lastName;

select firstName, lastName
from Students
order by firstName;

-- (c) Which students were born in 1975? [2]
select *
from Students
where substr(pNbr, 1,2)=75;

-- (d) what are the names of the female students, and which are their person numbers?
-- The next-to-last digit in the person number is even for females. The MySQL
-- function substr(str,m,n) gives n characters from the string str , starting at character
-- , the function mod(m,n) gives the remainder when m is divided by n . [26]
--


-- (e) How many students are registered in the database?

-- (f) Which courses are offered by the department of Mathematics (course codes FMAxxx )? [24]

select *
from Courses
where substr(courseCode, 1,3)="FMA";


-- (g) Which courses give more than  five credits? [21]
select *
from Courses
where credits>5;

-- (h) Which courses (course codes only) have been taken by the student with person number 790101-1234 ? [7]
select TakenCourses.courseCode
from TakenCourses, Students
where Students.pNbr="790101-1234"
and Students.pNbr=TakenCourses.pNbr;

-- (i) What are the names of these courses, and how many credits do they give?
select courseName, credits
from Courses
where Courses.courseCode in
(select TakenCourses.courseCode
from TakenCourses, Students
where Students.pNbr="790101-1234"
and Students.pNbr=TakenCourses.pNbr)


-- (j) How many credits has the student taken?

select sum(credits)
from Courses
where Courses.courseCode in
(select TakenCourses.courseCode
from TakenCourses, Students
where Students.pNbr="790101-1234"
and Students.pNbr=TakenCourses.pNbr)

 -- (k)  Which is the student's grade average on the courses that he has taken?
select avg(grade)  from TakenCourses, Students where Students.pNbr="790101-1234" and Students.pNbr=TakenCourses.pNbr;

-- (l) Same questions as in questions h-k, but for the student Eva Alm. [5]

	select TakenCourses.courseCode
	from TakenCourses, Students
	where Students.firstName="Eva"
	and Students.lastName="Alm"
	and Students.pNbr=TakenCourses.pNbr;

	
	select courseName, credits
	from Courses
	where Courses.courseCode in
	(select TakenCourses.courseCode
	from TakenCourses, Students
	where Students.firstName="Eva"
	and Students.lastName="Alm"
	and Students.pNbr=TakenCourses.pNbr)

	

	select sum(credits)
	from Courses
	where Courses.courseCode in
	(select TakenCourses.courseCode
	from TakenCourses, Students
	where Students.firstName="Eva"
	and Students.lastName="Alm"
	and Students.pNbr=TakenCourses.pNbr)


	select avg(grade)  
	from TakenCourses, Students 
	where Students.firstName="Eva"
	and Students.lastName="Alm"
    and Students.pNbr=TakenCourses.pNbr;

-- (m) Which students have taken 0 credits? [16]
	select * 
	from Students 
	where pNbr not in
 	(select TakenCourses.pNbr from TakenCourses);

-- (n) Which student has the highest grade average? Advice: de ne and use a view that 
-- gives the person number and grade average for each student.
	för att välja den med högst betyg:
	create or replace view AVGGRADE (PNUM, A) as
	select pNbr, avg(grade) from TakenCourses group by pNbr;

	select Students.pNbr, firstName, lastName, AVGGRADE.A from Students, AVGGRADE where
	Students.pNbr=AVGGRADE.PNUM order by AVGGRADE.A desc limit 1;



-- (o) List the person number and total number of credits for all students. 
-- Students with no credits should be included in the list! [72]
	create or replace view TAKENCOURSES (P, C, N, G) 
	as select TakenCourses.pNbr, Courses.courseCode, courseName, credits
	from Courses
	left join TakenCourses
	on TakenCourses.courseCode=Courses.courseCode;

	select pNbr, sum(G)
   	from Students, TAKENCOURSES
    where pNbr=TAKENCOURSES.P group by pNbr;

-- (p) Same question as in question o but with names instead of person numbers.

	select firstName, lastName, sum(G)
   	from Students, TAKENCOURSES
    where pNbr=TAKENCOURSES.P group by pNbr;


	create view or replace highest as
	select pNbr, avg(grade) from TakenCourses
	group by pNbr;


	create view or replace sumCred as 
	select pNbr, sum(credits) from TakenCourses, Courses
	where Courses.

-- (q) Is there more than one student with the same name? If so, who are these students? [7]
