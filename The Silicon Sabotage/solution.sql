--Intro
--QuantumTech, Miami’s leading technology corporation, was about to unveil its groundbreaking microprocessor called “QuantaX.” 
--Just hours before the reveal, the prototype was destroyed, and all research data was erased. Detectives suspect corporate espionage.

--Objectives
--1. Find who sabotaged the microprocessor.

select * from incident_reports
where location like "%QuantumTech%"

--id	date	location	description
--74	19890421	QuantumTech HQ	Prototype destroyed; data erased from servers.

select * from witness_statements
where incident_id = 74

--id	incident_id	employee_id	statement
--40	74	145	I heard someone mention a server in Helsinki.
--59	74	134	I saw someone holding a keycard marked QX- succeeded by a two-digit odd number.

select er.id, employee_name, keycard_code, department,occupation, home_address, kal.access_date, kal.access_time, cal.access_date, cal.access_time from employee_records as er
inner join keycard_access_logs AS kal on kal.employee_id = er.id 
inner join computer_access_logs as cal on er.id = cal.employee_id
WHERE substr(keycard_code, 1, instr(keycard_code, '-') - 1) = 'QX'
AND CAST(substr(keycard_code, instr(keycard_code, '-') + 1) AS INTEGER) % 2 == 1 
AND CAST(substr(keycard_code, instr(keycard_code, '-') + 1) AS INTEGER) < 100 
AND server_location = "Helsinki"

--id	employee_name	keycard_code	department	occupation	home_address	access_date	access_time	access_date	access_time
--99	Elizabeth Gordon	QX-035	Engineering	Solutions Architect	147 Coastal Pine Rd, Doral, FL	19890421	08:30	19890421	09:00

select * from email_logs
where sender_employee_id = 99 or recipient_employee_id = 99

--id	sender_employee_id	recipient_employee_id	email_date	email_subject	email_content
--126	263	99	19890421	Alarm System Concern	I noticed something strange with the alarm system. There might be a potential malfunction near the chip. Thought you should check it out to be safe.

select * from email_logs
where sender_employee_id = 263 or recipient_employee_id = 263

--id	sender_employee_id	recipient_employee_id	email_date	email_subject	email_content
--126	263	99	19890421	Alarm System Concern	I noticed something strange with the alarm system. There might be a potential malfunction near the chip. Thought you should check it out to be safe.
--138	NULL	263	19890421	Realign Asset Trajectory	L’s schedule puts her close enough, but we need her inside F18 before 9. Trigger a minor alert or routine checkup to send her in by 8:30. Make sure she logs the visit. That part matters.
--140	NULL	263	19890421	Execute Phase Window	Unlock 18 quietly by 9. He’ll use his own credentials to access it shortly after L leaves. No questions. Just ensure the timing lines up. The trail will lead exactly where it needs to.

select * from employee_records as er
inner join facility_access_logs as fal on er.id = fal.employee_id 
where facility_name like "%F%18%"
and  Cast( REPLACE(fal.access_time, ":", "" ) as INTEGER) < 1000

--id	employee_name	department	occupation	home_address	id	employee_id	facility_name	access_date	access_time
--99	Elizabeth Gordon	Engineering	Solutions Architect	147 Coastal Pine Rd, Doral, FL	74	99	Facility 18	19890421	08:55
--297	Hristo Bogoev	Engineering	Principal Engineer	901 Quantum Ocean Way, Key Biscayne, FL	81	297	Facility 18	19890421	09:01

--SOLUTION -> Hristo Bogoev