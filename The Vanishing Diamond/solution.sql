--Intro
--At Miami’s prestigious Fontainebleau Hotel charity gala, the famous “Heart of Atlantis” diamond necklace suddenly disappeared from its display.

--Objectives
--1. Find who stole the diamond.

Select * from crime_scene
where location like "%Fontainebleau Hotel%"

--id	date	location	description
--48	19870520	Fontainebleau Hotel	The Heart of Atlantis necklace disappeared. Many guests were questioned but only two of them gave valuable clues. One of them is a really famous actor. The other one is a woman who works as a consultant for a big company and her first name ends with "an".

Select * from guest
where occupation = "Actor"
or substr(name, 1, instr(name, ' ') - 1) LIKE '%an'

--id	name	occupation	invitation_code
--116	Ethan Taylor	Financial Analyst	VIP-B
--129	Clint Eastwood	Actor	VIP-G

select guest.id, name, clue, confession from guest 
inner join witness_statements as ws on guest.id = ws.guest_id
inner join final_interviews as fi on guest.id = fi.guest_id
where guest.id = 116 or guest.id = 129

--id	name	clue	confession
--116	Vivian Nair	I saw someone holding an invitation ending with "-R". He was wearing a navy suit and a white tie.	Check my work computer logs. I would never commit such a horrible act.
--129	Clint Eastwood	I overheard someone say, "Meet me at the marina, dock 3.	I was taking care of my sick mother. I would never commit murder.


select guest.id, name, note ,dock_number, rental_date, boat_name from guest 
inner join attire_registry as ar on guest.id = ar.guest_id
inner join marina_rentals as mr on guest_id = mr.renter_guest_id
where (invitation_code like "%-R" and  note like "%navy suit%" and note like"%white tie%")
and dock_number = 3 

--id	name	note	dock_number	rental_date	boat_name
--105	Mike Manning	navy suit, white tie	3	19870520	Coastal Spirit

select * from guest
inner join final_interviews as fi on guest.id = fi.guest_id
where guest.id = 105

--id	name	occupation	invitation_code	id	guest_id	confession
--105	Mike Manning	Wealth Reallocation Expert	VIP-R	105	105	I was the one who took the crystal. I guess I need a lawyer now?

--SOLUTION -> Mike Manning