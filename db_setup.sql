DROP DATABASE IF EXISTS coursework;

CREATE DATABASE coursework;

USE coursework;

-- This is the Department table

DROP TABLE IF EXISTS Department;

CREATE TABLE Department(
DEPARTMENT_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
Department_Name VARCHAR(512) NOT NULL UNIQUE,

PRIMARY KEY (DEPARTMENT_ID));


INSERT INTO Department (Department_Name) VALUES
('Computer Science'),
('Information Technology'),
('Electrical Engineering'),
('Physics');


-- This is the Course table
 
DROP TABLE IF EXISTS Course;

CREATE TABLE Course (
Crs_Code 	INT UNSIGNED NOT NULL,
Crs_Title 	VARCHAR(255) NOT NULL,
Crs_Enrollment INT UNSIGNED,
Crs_Department INT UNSIGNED NOT NULL,

PRIMARY KEY (Crs_code),
FOREIGN KEY (Crs_Department) REFERENCES Department(DEPARTMENT_ID)
ON DELETE CASCADE);


INSERT INTO Course VALUES 
(100, 'BSc Computer Science', 150, 1),
(101, 'BSc Computer Information Technology', 20, 2),
(200, 'MSc Data Science', 100, 1),
(201, 'MSc Security', 30, 2),
(210, 'MSc Electrical Engineering', 70, 3),
(211, 'BSc Physics', 100, 4);


-- This is the Student table

DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
URN INT UNSIGNED NOT NULL,
Stu_FName 	VARCHAR(255) NOT NULL,
Stu_LName 	VARCHAR(255) NOT NULL,
Stu_DOB 	DATE,
Stu_Phone 	VARCHAR(12),
Stu_Course	INT UNSIGNED NOT NULL,
Stu_Type 	ENUM('UG', 'PG'),
PRIMARY KEY (URN),
FOREIGN KEY (Stu_Course) REFERENCES Course(Crs_Code)
ON DELETE CASCADE);


INSERT INTO Student VALUES
(612345, 'Sara', 'Khan', '2002-06-20', '01483112233', 100, 'UG'),
(612346, 'Pierre', 'Gervais', '2002-03-12', '01483223344', 100, 'UG'),
(612347, 'Patrick', 'O-Hara', '2001-05-03', '01483334455', 100, 'UG'),
(612348, 'Iyabo', 'Ogunsola', '2002-04-21', '01483445566', 100, 'UG'),
(612349, 'Omar', 'Sharif', '2001-12-29', '01483778899', 100, 'UG'),
(612350, 'Yunli', 'Guo', '2002-06-07', '01483123456', 100, 'UG'),
(612351, 'Costas', 'Spiliotis', '2002-07-02', '01483234567', 100, 'UG'),
(612352, 'Tom', 'Jones', '2001-10-24',  '01483456789', 101, 'UG'),
(612353, 'Simon', 'Larson', '2002-08-23', '01483998877', 101, 'UG'),
(612354, 'Sue', 'Smith', '2002-05-16', '01483776655', 101, 'UG'),
(612355, 'James', 'Potter', '1999-01-01', '01483553344', 200, 'PG'),
(612356, 'Sirius', 'Black', '2000-03-07', '01483007733', 210, 'PG'),
(612357, 'Lily', 'Evans', '2000-06-06', '01483117744', 201, 'PG'),
(612358, 'Marlene', 'McKinnon', '1999-08-09', '01483226699', 211, 'PG'),
(612359, 'Mary', 'McDonald', '2001-07-14', '01473225555', 200, 'PG');

DROP TABLE IF EXISTS Undergraduate;

CREATE TABLE Undergraduate (
UG_URN 	INT UNSIGNED NOT NULL,
UG_Credits   INT NOT NULL,
CHECK (60 <= UG_Credits <= 150),
PRIMARY KEY (UG_URN),
FOREIGN KEY (UG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);

INSERT INTO Undergraduate VALUES
(612345, 120),
(612346, 90),
(612347, 150),
(612348, 120),
(612349, 120),
(612350, 60),
(612351, 60),
(612352, 90),
(612353, 120),
(612354, 90);

DROP TABLE IF EXISTS Postgraduate;

CREATE TABLE Postgraduate (
PG_URN 	INT UNSIGNED NOT NULL,
Thesis  VARCHAR(512) NOT NULL,
PRIMARY KEY (PG_URN),
FOREIGN KEY (PG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);

INSERT INTO Postgraduate VALUES
(612355, 'Solar Explosion'),
(612356, 'Small Peanut'),
(612357, 'Life Cycle of a Cactus'),
(612358, 'Black Holes'),
(612359, 'Jupiter is Rising');


-- This is the Hobbies table

DROP TABLE IF EXISTS Hobbies;

CREATE TABLE Hobbies (
HOBBY_ID INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
Hobby_Name VARCHAR(512) NOT NULL,

PRIMARY KEY (HOBBY_ID));

INSERT INTO Hobbies (Hobby_Name) VALUES
('reading'),
('hiking'),
('chess'),
('knitting'),
('ballroom dancing'),
('football'),
('tennis'),
('rugby'),
('climbing'),
('rowing'),
('music');


-- This is the Equipment table

DROP TABLE IF EXISTS Equipment;

CREATE TABLE Equipment (
HOBBY_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
Equipment VARCHAR(512) NOT NULL,

PRIMARY KEY (HOBBY_ID, Equipment),
FOREIGN KEY (HOBBY_ID) REFERENCES Hobbies(HOBBY_ID)
ON DELETE CASCADE);

INSERT INTO Equipment VALUES
('1', 'book'),
('2', 'hiking pack'),
('3', 'chess board'),
('4', 'needles'),
('4', 'yarn'),
('4', 'scissors'),
('4', 'crochet hook'),
('5', 'ballroom dresses'),
('6', 'football ball'),
('7', 'tennis ball'),
('8', 'rugby clothes'),
('8', 'head guard'),
('8', 'rugby ball'),
('9', 'climbing kit'),
('10', 'rowing boat'),
('11', 'headphones');


-- This is the StuHob table

DROP TABLE IF EXISTS StuHob;

CREATE TABLE StuHob (
URN INT UNSIGNED NOT NULL,
HOBBY_ID INT UNSIGNED NOT NULL,

PRIMARY KEY (URN, HOBBY_ID),
FOREIGN KEY (URN) REFERENCES Student(URN)
ON DELETE CASCADE,
FOREIGN KEY (HOBBY_ID) REFERENCES Hobbies(HOBBY_ID)
ON DELETE CASCADE);

INSERT INTO StuHob VALUES
('612345', '1'),
('612346', '2'),
('612347', '3'),
('612348', '2'),
('612348', '3'),
('612349', '8'),
('612350', '4'),
('612351', '10'),
('612356', '5'),
('612358', '6'),
('612357', '7'),
('612359', '9');


-- This is the Societies table

DROP TABLE IF EXISTS Societies;

CREATE TABLE Societies (
SOCIETY_ID INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
Society_Name VARCHAR(512) NOT NULL UNIQUE,
Society_Leader INT UNSIGNED NOT NULL,
Society_Website VARCHAR(512) NOT NULL UNIQUE,

PRIMARY KEY (SOCIETY_ID),
FOREIGN KEY (Society_Leader) REFERENCES Student(URN)
ON DELETE CASCADE);

INSERT INTO Societies (Society_Name, Society_Leader, Society_Website) VALUES
('Book Club Society', '612345', 'www.bookclubsoc.com'),
('HikingSoc', '612346', 'www.hikingsoc.com'),
('ChessSoc', '612347', 'www.chesssoc.com'),
('CRAFTsoc', '612350', 'www.craftsoc.com'),
('Ballroom and Latin Dance', '612356', 'www.ballroomandlatindance.com'),
('Football Society', '612358', 'www.footballsociety.com'),
('Tennis Society', '612357', 'www.tennissoc.com'),
('Rugby Society', '612349', 'www.rugbysociety.com'),
('Climbing Society', '612359', 'www.climbingsoc.com'),
('Boat (Rowing) Society', '612351', 'www.rowingsoc.com');



-- This is the Activities table

DROP TABLE IF EXISTS Activities;

CREATE TABLE Activities (
ACTIVITY_ID INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
Activity_Name VARCHAR(512) NOT NULL,
Activity_Date DATE NOT NULL,
Activity_Time TIME NOT NULL,
Activity_Location VARCHAR(512) NOT NULL,
Activity_Society INT UNSIGNED NOT NULL,

PRIMARY KEY (ACTIVITY_ID),
FOREIGN KEY (Activity_Society) REFERENCES Societies(SOCIETY_ID)
ON DELETE CASCADE);

INSERT INTO Activities (Activity_Name, Activity_Date, Activity_Time, Activity_Location, Activity_Society) VALUES
('Hiking day', '2024-03-02', '12:10', 'SSP2', '2'),
('Chess competition', '2023-12-01', '14:00', 'SSP1', '3'),
('Ballroom', '2024-07-06', '13:30', 'USSU1', '5'),
('Mountain Climbing', '2023-12-11', '15:00', 'SSP3', '9'),
('Rowing competition', '2024-01-02', '12:20', 'SSP4', '10'),
('Knitting Day', '2023-12-12', '16:00', 'USSU2', '4'),
('Origami', '2023-12-13', '15:30', 'USSU2', '4');

-- This is the StuSoc table

DROP TABLE IF EXISTS StuSoc;

CREATE TABLE StuSoc (
URN INT UNSIGNED NOT NULL,
SOCIETY_ID INT UNSIGNED NOT NULL,

PRIMARY KEY (URN, SOCIETY_ID),
FOREIGN KEY (URN) REFERENCES Student(URN)
ON DELETE CASCADE,
FOREIGN KEY (SOCIETY_ID) REFERENCES Societies(SOCIETY_ID)
ON DELETE CASCADE);

INSERT INTO StuSoc VALUES
('612345', '1'),
('612346', '2'),
('612347', '3'),
('612350', '4'),
('612345', '4'),
('612356', '5'),
('612358', '6'),
('612352', '6'),
('612357', '7'),
('612349', '8'),
('612359', '9'),
('612351', '10');


-- This is the SocHob table

DROP TABLE IF EXISTS SocHob;

CREATE TABLE SocHob (
SOCIETY_ID INT UNSIGNED NOT NULL,
HOBBY_ID INT UNSIGNED NOT NULL,

PRIMARY KEY (SOCIETY_ID, HOBBY_ID),
FOREIGN KEY (SOCIETY_ID) REFERENCES Societies(SOCIETY_ID)
ON DELETE CASCADE,
FOREIGN KEY (HOBBY_ID) REFERENCES Hobbies(HOBBY_ID)
ON DELETE CASCADE);

INSERT INTO SocHob VALUES
('1', '1'),
('1', '11'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5'),
('6', '6'),
('7', '7'),
('8', '8'),
('9', '9'),
('10', '10');