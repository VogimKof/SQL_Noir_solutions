--Intro
--In the neon glow of 1980s Los Angeles, the West Hollywood Records store was rocked by a daring theft. 
--A prized vinyl record, worth over $10,000, vanished during a busy evening, leaving the store owner desperate for answers. 
--Vaguely recalling the details, you know the incident occurred on July 15, 1983, at this famous store. 
--Your task is to track down the thief and bring them to justice.

--Objectives
--1. Retrieve the crime scene report for the record theft using the known date and location.
--2. Retrieve witness records linked to that crime scene to obtain their clues.
--3. Use the clues from the witnesses to find the suspect in the suspects table.
--4. Retrieve the suspect's interview transcript to confirm the confession.

Select * from crime_scene 
inner join witnesses on crime_scene.id = witnesses.crime_scene_id
where location = "West Hollywood Records"

--id	type	location	description	clue
--65	theft	West Hollywood Records	A prized vinyl record was stolen from the store during a busy evening.	I saw a man wearing a red bandana rushing out of the store.
--65	theft	West Hollywood Records	A prized vinyl record was stolen from the store during a busy evening.	The main thing I remember is that he had a distinctive gold watch on his wrist.

Select * from suspects
inner join interviews on suspects.id = interviews.suspect_id
where accessory ="gold watch"
and bandana_color = "red"

--id	name	bandana_color	accessory	suspect_id	transcript
--35	Tony Ramirez	red	gold watch	35	I wasn't anywhere near West Hollywood Records that night.
--44	Mickey Rivera	red	gold watch	44	I was busy with my music career; I have nothing to do with this theft.
--97	Rico Delgado	red	gold watch	97	I couldn't help it. I snapped and took the record.

--SOLUTION -> Rico Delgado