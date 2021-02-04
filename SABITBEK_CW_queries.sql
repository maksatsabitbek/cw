create database cw;
use cw;
/* [a] Create the tables defined in Question 1 */
CREATE TABLE Ward ( wName VARCHAR(122) NOT NULL,CONSTRAINT pk_ward PRIMARY KEY (wName)); 

CREATE TABLE Doctor (dName VARCHAR(122) NOT NULL, dateB VARCHAR(20) NOT NULL, numYear INT,wName VARCHAR(122) NOT NULL,
 CONSTRAINT pk_doc PRIMARY KEY (dName), CONSTRAINT fk_docW FOREIGN KEY (wName) REFERENCES Ward(wName)); 

CREATE TABLE Nurse ( nName VARCHAR(122) NOT NULL, dateB VARCHAR(20) NOT NULL, numYear INT,wName VARCHAR(122) NOT NULL,
 CONSTRAINT pk_nurse PRIMARY KEY (nName), CONSTRAINT fk_nurseW FOREIGN KEY (wName) REFERENCES Ward(wName)); 

CREATE TABLE Patient(adNumber INT NOT NULL, name VARCHAR(122) NOT NULL, dateB VARCHAR(20) NOT NULL, Gender VARCHAR(122) NOT NULL,
 Address VARCHAR(150) NOT NULL, telNumber VARCHAR(9) NOT NULL, wName VARCHAR(122) NOT NULL, dName VARCHAR(122) NOT NULL,
 CONSTRAINT pk_patient PRIMARY KEY (adNumber), CONSTRAINT fk_patientWard FOREIGN KEY (wName) REFERENCES Ward (wName),
 CONSTRAINT fk_patientDoc FOREIGN KEY (dName) REFERENCES Doctor(dName)); 
 
 CREATE TABLE List (adNumber INT NOT NULL, nName VARCHAR(122) NOT NULL,
 CONSTRAINT pk_list PRIMARY KEY (adNumber, nName),CONSTRAINT fk_list1 FOREIGN KEY (adNumber) REFERENCES Patient (adNumber),
 CONSTRAINT fk_list2 FOREIGN KEY (nName) REFERENCES Nurse (nName)); 
 
 /* [b] Populate the database with 6 doctors and 10 nurses, making sure that each of the 5 wards is covered by at least a doctor and a nurse */
 
 INSERT INTO Ward VALUE ('Accident and Emergency'), ('Cardiology'),('Oncology'),('Orthopaedic'),('Urology');
 
  INSERT INTO Doctor VALUE ('Abesto Kalde', '12.09.1987', 6,'Accident and Emergency'), ('Akaman Salmador', '12.09.1956', 18,'Cardiology'),
('Kalkaman Ata', '12.09.1965', 15,'Cardiology'), ('Sara Ravenson', '12.09.1990', 4,'Oncology'), ('James Adams', '12.09.1988', 10,'Orthopaedic'), ('Petr Qaz', '12.09.1989', 5,'Urology');
   
 INSERT INTO Nurse VALUE ('Sara Ckacher', '25.07.1990',2, 'Accident and Emergency'), ('Jeni Caller', '24.03.1991', 6 , 'Accident and Emergency'),
 ('Klinford Benius', '24.05.1989', 4 , 'Cardiology'),  ('Ford Jenius', '24.05.1995', 2 , 'Cardiology'),
  ('Kate Woods', '20.05.1993', 4 , 'Oncology'), ('Valerie Weiss', '20.05.1990', 7 , 'Oncology'),
  ('Gabriel Macht', '05.05.1991', 3 , 'Orthopaedic'), ('Julian Holmes', '02.05.1986', 3 , 'Orthopaedic'),
   ('Erica Lipez', '08.08.1998', 2 , 'Urology'), ('Karla Nappi', '07.07.1997', 2 , 'Urology');
  
 /* [c] Populate the database with 3 patients in each ward. Also assign a nurse to each patient */
 INSERT INTO Patient VALUE 
(1001,'Aman Kaster', '25.07.1990', 'Male', 'Abay 45', '87009807','Accident and Emergency','Abesto Kalde'),
(1002,'Samilya Kastl', '25.05.2001', 'Female', 'Abay 47', '87009154','Accident and Emergency','Abesto Kalde'),
(1003,'Asan Zhumashev', '25.07.1990', 'Male', 'Pushkin 67/g', '87009789','Accident and Emergency','Abesto Kalde'),

(1004,'Waman Sater', '25.07.1991', 'Male', 'Palkov 45', '87009809','Cardiology','Akaman Salmador'),
(1005,'Qaman Deq', '26.08.1992', 'Male', 'Beibitshilik 45-87', '87009800','Cardiology','Kalkaman Ata'),
(1006,'Keman Aser', '27.09.1993', 'Male', 'Pushkin 123', '87009801','Cardiology','Akaman Salmador'),

(1007,'Katerina Faser', '28.10.1994', 'Female', 'Marite 31', '87009812','Oncology','Sara Ravenson'),
(1008,'Jambyl Qostanai', '29.11.1995', 'Male', 'Lenina 12', '87009813','Oncology','Sara Ravenson'),
(1009,'Asel Sasenova', '30.12.1996', 'Female', 'Park 987', '87009814','Oncology','Sara Ravenson'),

(1010,'Asel Kasenova', '31.01.1997', 'Female', 'Kosmanavtov 24', '87009816','Orthopaedic','James Adams'),
(1011,'Murat Zhapparov', '01.02.1998', 'Male', 'Park 9', '87009817','Orthopaedic','James Adams'),
(1012,'Kaskelen Zhaskep', '02.03.1999', 'Male', 'Korchagina 12', '87009818','Orthopaedic','James Adams'),

(1013,'Zhaskelen Kaskep', '12.01.1989', 'Male', 'Korchagina 11', '87009820','Urology','Petr Qaz'),
(1014,'Dancho Almasov', '23.05.1979', 'Male', 'Park 11', '87009821','Urology','Petr Qaz'),
(1015,'Erturman Welson', '05.08.1969', 'Male', 'Lenina 12-1', '87009822','Urology','Petr Qaz');

INSERT INTO List VALUE 
(1001,'Jeni Caller'),(1002, 'Sara Ckacher'), (1003, 'Jeni Caller'),
(1004,'Ford Jenius'),(1005, 'Klinford Benius'), (1006, 'Ford Jenius'),
(1007,'Kate Woods'),(1008, 'Valerie Weiss'), (1009, 'Kate Woods'),
(1010,'Gabriel Macht'),(1011, 'Julian Holmes'), (1012, 'Gabriel Macht'),
(1013,'Erica Lipez'),(1014, 'Karla Nappi'), (1015, 'Erica Lipez');

/*[d] Show a list of patient names and their address for those in the Urology ward.*/

SELECT name, Address FROM Patient WHERE wName = 'Urology';

/*[e] Show all the details of those patients born in the 70s */

SELECT * FROM Patient WHERE dateB LIKE '%197_';

/*[f] For those nurses who look after more than one patient, show a list of the nurse’s names and the total number of patients they look after.*/

SELECT nName,COUNT(adNumber) as NUMBER FROM List  GROUP BY nName HAVING COUNT(adNumber) > 1;

/*[g] Show in a single query the doctors’ names, their years in service, the nurses’ names, the nurses’ years in service and the ward 
names for those doctors who have worked longer than the nurses working in the same ward.*/

SELECT  Distinct dName, Doctor.numYear,  Nurse.nName, Nurse.numYear FROM Doctor, Nurse WHERE Nurse.wName = Doctor.wName and Doctor.numYear > Nurse.numYear;

/*[h] Modify the database to store information about the salary of doctors and nurses. Doctors earn a default salary of £60,000 per year, while nurses a default of £35,000. 
Doctors with more than 5 year experience in the hospital should receive an increase of 10% of their salary. Write all the queries needed to represent this scenario.*/

ALTER TABLE DOCTOR ADD Salary INT;
ALTER TABLE NURSE ADD Salary INT;
Update Doctor Set Salary = 60000;
Update NURSE Set Salary = 35000;
Update Doctor Set Salary = Salary + (Salary*0.1) WHERE numYEAR > 5;

/*[i] Show the total/combined number of year experience between doctors and nurses in each ward separately.*/

SELECT SUM(numYear) as Total FROM Doctor;

SELECT SUM(numYear) as Total FROM NURSE;




   

 