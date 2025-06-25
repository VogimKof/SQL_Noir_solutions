--Intro
--Set in the gritty 1980s, a valuable briefcase has disappeared from the Blue Note Lounge. 
--A witness reported that a man in a trench coat was seen fleeing the scene. 
--Investigate the crime scene, review the list of suspects, and examine interview transcripts to reveal the culprit.

--Objectives
--1. Retrieve the correct crime scene details to gather the key clue.
--2. Identify the suspect whose profile matches the witness description.
--3. Verify the suspect using their interview transcript.


Select * from crime_scene
where location = 'Blue Note Lounge'
--id	date	type	location	description
--76	19851120	theft	Blue Note Lounge	A briefcase containing sensitive documents vanished. A witness reported a man in a trench coat with a scar on his left cheek fleeing the scene.

Select * from suspects
inner join interviews on suspects.id = interviews.suspect_id
where attire = 'trench coat'

--id	name	attire	scar	suspect_id	transcript
--3	Frankie Lombardi	trench coat	left cheek	3	NULL
--183	Vincent Malone	trench coat	left cheek	183	I wasn’t going to steal it, but I did.

--SOLUTION -> Vincent Malone
