--Intro
--On October 31, 1987, at a Coconut Grove mansion masked ball, Leonard Pierce was found dead in the garden. 
--Can you piece together all the clues to expose the true murderer?

--Objectives
--1. Reveal the true murderer of this complex case.

Select * from crime_scene 
where date = 19871031 and location like "%Coconut Grove%"

--id	date	location	description
--75	19871031	Miami Mansion, Coconut Grove	During a masked ball, a body was found in the garden. Witnesses mentioned a hotel booking and suspicious phone activity.

select * from witness_statements
where crime_scene_id = (Select id from crime_scene where date = 19871031 and location like "%Coconut Grove%")

--id	crime_scene_id	witness_id	clue
--83	75	37	I overheard a booking at The Grand Regency.
--89	75	42	I noticed someone at the front desk discussing Room 707 for a reservation made yesterday.

select person_id, check_in_date, note  from hotel_checkins as hc
inner join surveillance_records as sr on hc.id = sr.hotel_checkin_id
where hotel_name like "The Grand Regency" and sr.note not null and check_in_date = 19871030

--person_id	check_in_date	note
--11	19871030	Subject was overheard yelling on a phone: "Did you kill him?"

Select * from person 
inner join phone_records as pr on person.id  = pr.caller_id
where person.id = 11

--id	name	occupation	address	id	caller_id	recipient_id	call_date	call_time	note
--11	Antonio Rossi	Auto Importer	999 Dark Alley	117	11	58	19871030	23:30	Why did you kill him, bro? You should have left the carpenter do it himself!

Select * from phone_records
where caller_id = 58 or recipient_id = 58

--id	caller_id	recipient_id	call_date	call_time	note
--117	11	58	19871030	23:30	Why did you kill him, bro? You should have left the carpenter do it himself!
--163	133	58	19871030	22:15	I will do it. Only if you give me that nice Lambo of yours.

select * from person 
inner join final_interviews as fi on person.id = fi.person_id
where person.id in (11,58,133)

--id	name	occupation	address	id	person_id	confession
--11	Antonio Rossi	Auto Importer	999 Dark Alley	11	11	Im a peaceful person. I wouldnt kill anyone ever.
--58	Victor DiMarco	Jobless	707 Cedarwood Avenue	58	58	I didn’t kill Leo per se. I was just a middleman.
--133	Unknown	Unknown	Unknown	133	133	I was attending a wedding that day. I couldnt have killed anyone.

select * from person 
inner join vehicle_registry as vr on person.id = vr.person_id
inner join final_interviews as fi on person.id = fi.person_id
where occupation = "Carpenter" and  car_make like "%Lambo%" 

--id	name	occupation	address	id	person_id	plate_number	car_make	car_model	id	person_id	confession
--97	Marco Santos	Carpenter	112 Forestwood Way	41	97	EFG901	Lamborghini	Countach	97	97	I ordered the hit. It was me. You caught me.

--SOLUTION -> Marco Santos