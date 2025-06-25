--Intro
--A body was found floating near the docks of Coral Bay Marina in the early hours of August 14, 1986. 
--Your job detective is to find the murderer and bring them to justice. 
--This case might require the use of JOINs, wildcard searches, and logical deduction. Get to work, detective.

--Objectives
--1. Find the murderer. ( Start by finding the crime scene and go from there )

Select * from crime_scene
where location = "Coral Bay Marina"
and date = 19860814

--id	date	location	description
--43	19860814	Coral Bay Marina	The body of an unidentified man was found near the docks. Two people were seen nearby: one who lives on 300ish "Ocean Drive" and another whose first name ends with "ul" and his last name ends with "ez".

SELECT * FROM person
WHERE (substr(name, 1, instr(name, ' ') - 1) LIKE '%ul' AND substr(name, instr(name, ' ') + 1) LIKE '%ez')
OR address LIKE '%Ocean Drive' and Cast(substr(address ,1, instr(address, ' ') - 1) AS INTEGER) between 300 and 400

--id	name	alias	occupation	address
--101	Carlos Mendez	Los Ojos	Fisherman	369 Ocean Drive
--102	Raul Gutierrez	The Cobra	Nightclub Owner	45 Sunset Ave

Select * from interviews
where person_id in(101,102)

--id	person_id	transcript
--101	101	I saw someone check into a hotel on August 13. The guy looked nervous.
--103	102	I heard someone checked into a hotel with "Sunset" in the name.

Select * from hotel_checkins
inner join surveillance_records on hotel_checkins.id = surveillance_records.hotel_checkin_id
where hotel_name Like '%Sunset%'
and suspicious_activity not null

--id	person_id	hotel_name	check_in_date	id	person_id	hotel_checkin_id	suspicious_activity
--2	      27	Sunset Bay Hotel	19860813	8	  8	         2	    Left suddenly at 3 AM
--34	39	Sunset Coast Inn	19860813	6	6	     34	 Spotted entering late at night

Select * from person
inner join interviews on person.id = interviews.person_id
inner join confessions on confessions.person_id = person.id
where person.id = 8

--id	name	alias	occupation	address	id	person_id	transcript	id	person_id	confession
--8	Thomas Brown	The Fox	Dock Worker	234 Port Street	113	8	NULL	73	8	Alright! I did it. I was paid to make sure he never left the marina alive.

--SOLUTION -> Thomas Brown