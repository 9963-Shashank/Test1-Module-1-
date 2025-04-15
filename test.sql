CREATE TABLE Patient (
      patient_id INT PRIMARY KEY,
	  first_name varchar(100) NOT NULL,
	  last_name varchar(100) NOT NULL,
	  gender varchar(10) NOT NULL,
	  date_of_birth DATE NOT NULL,
	  contact_number varchar(15) NOT NULL
)


CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_name VARCHAR(100),
    appointment_date DATE,
    department VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);


--2.Alter the Appointment table to add a new column status VARCHAR(20).
ALTER TABLE Appointment ADD column status varchar(20);

--3.Insert sample data into both tables for 5 patients and 5 appointments.
INSERT INTO Patient(patient_id, first_name, last_name, gender, date_of_birth, contact_number)
VALUES(1, 'Shashank', 'Royal', 'Male', '2000-08-15', '9515984873'),
(2 , 'Anjali', 'Agarwal' , 'Female', '2001-09-12', '7396374843'),
(3,'Pavan', 'Chowdary', 'Male', '2002-02-03', '9963744335'),
(4, 'Raghu', 'Naidu', 'Male', '2001-08-19', '9963699789'),
(5, 'Rajeswar', 'Reddy', 'Male', '1999-04-20', '9121434561');


INSERT INTO Appointment(appointment_id, patient_id, doctor_name, appointment_date, department, status)
VALUES(11, 1, 'Dr.Agarwal', '2025-04-11', 'General Surgeon', 'Scheduled'),
(12, 2, 'Dr.Thomas', '2025-04-12', 'Neruology', 'Scheduled'),
(13, 3, 'Dr.Mark Shankar', '2025-04-13', 'Cardiology', 'Completed'),
(14, 4, 'Dr.Balakrishna', '2025-04-14', 'Dentist', 'Scheduled'),
(15, 5, 'Dr.Arjun', '2025-04-15', 'Orthopedics', 'Cancelled');


--4.Update the department of an appointment where appointment_id = 2 to 'Neurology'.
UPDATE Appointment SET department = 'Neurology' WHERE appointment_id = 2;

--5.Delete the patient whose name = 'Pavan Chowdary'.
DELETE FROM Appointment WHERE patient_id = 3;
DELETE FROM Patient WHERE first_name = 'Pavan' AND last_name = 'Chowdary';

--6.Retrieve all patient names along with their appointment date and doctor name.
SELECT p.*, a.appointment_date, a.doctor_name FROM patient p
JOIN appointment a
ON p.patient_id = a.patient_id

--7.List all patients who have appointments in the 'Cardiology' department.
SELECT p.*
FROM patient p
JOIN appointment a ON p.patient_id = a.patient_id
WHERE a.department = 'Cardiology'

--8.Get patient details who have an appointment with doctor 'Dr. Agarwal'.
SELECT p.*
FROM patient p 
JOIN appointment a ON p.patient_id = a.patient_id
WHERE a.doctor_name = 'Dr.Agarwal'

--9.Display appointment details where the patient's age is greater than 60.
select a.*,p.date_of_birth from patient p join appointment a on p.patient_id=a.patient_id where p.date_of_birth<'1964-04-15';


--10.Find patients who have more than one appointment (use GROUP BY and HAVING).
select p.patient_id, p.first_name, p.last_name, count(a.appointment_id) as appointment_count
from Patient p
join Appointment a
on p.patient_id = a.patient_id
group by p.patient_id,p.first_name, p.last_name
having count(a.appointment_id) > 1;

--11.Find the patient(s) who have the most number of appointments.
select count(*) from appointment a
left join patient p
on a.patient_id = p.patient_id   xxxx

--12.List patients who do not have any appointments.
SELECT p.*
FROM patient p WHERE(patient_id NOT IN (SELECT patient_id from appointment));

--13.Show the name and age of all patients (calculate age from date_of_birth).
SELECT first_name, last_name,(SELECT DATE_PART('year', CURRENT_DATE) - DATE_PART('year', p.date_of_birth)) AS age FROM patient p;

--14.List appointments made in the last 30 days from today’s date.
SELECT * FROM appointment WHERE appointment_date BETWEEN '2025-04-04' and '2025-05-04';

--15.Count the number of appointments per department.
SELECT department, COUNT(*) as total_appointment
FROM appointment 
GROUP BY department;


-----SQL QUESTIONS 

--1.Find the name(s) of patient(s) who have taken appointments in all departments available in the Appointment table.
select p.first_name, p.last_name
from Patient p
join Appointment a on p.patient_id = a.patient_id
group by p.patient_id, p.first_name, p.last_name
having count(distinct a.department) = (
select count(distinct department)
from Appointment
);

--2.Retrieve the patient(s) who had their first-ever appointment with doctor 'Dr.Agarwal'.
select * from patient where patient_id in(
select patient_id from appointment where doctor_name='Dr.Agarwal' order by appointment_date limit 1);

--3.Find the doctors who have consulted at least 3 different patients across more than one department.
SELECT doctor_name
FROM Appointment
GROUP BY doctor_name
HAVING COUNT(DISTINCT patient_id) >= 3 AND COUNT(DISTINCT department) > 1;

--4.dentify patients who had appointments in the last week of each month for the past 3 months.
SELECT Patient p 





--5.List the top 3 patients who have had the highest number of appointments.
Select p.first_name, p.last_name, p.patient_id
