-- @block
CREATE DATABASE fit_track2;
USE fit_track2;


-- @block
CREATE TABLE `departments` (
    `department_ID` int NOT NULL AUTO_INCREMENT,
    `department_name` varchar(50) NOT NULL,
    `location` varchar(100) NOT NULL,
    PRIMARY KEY (`department_ID`)
);

-- @block
CREATE TABLE `trainers` (
    `trainer_ID` int NOT NULL AUTO_INCREMENT,
    `First_name` varchar(50) NOT NULL,
    `Last_name` varchar(50) NOT NULL,
    `specialization` varchar(50) NOT NULL,
    `department_ID` int DEFAULT NULL,
    PRIMARY KEY (`trainer_ID`),
    KEY `fk_department_ID` (`department_ID`),
    CONSTRAINT `fk_department_ID` FOREIGN KEY (`department_ID`) REFERENCES `departments` (`department_ID`)
);

-- @block
CREATE TABLE `members` (
    `member_ID` int NOT NULL AUTO_INCREMENT,
    `First_name` varchar(50) NOT NULL,
    `Last_name` varchar(50) NOT NULL,
    `Gender` enum('Male', 'Female') DEFAULT NULL,
    `Date_Of_Birth` date DEFAULT NULL,
    `Phone_number` varchar(15) NOT NULL,
    `Email` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`member_ID`)
);

-- @block
CREATE TABLE `rooms` (
    `room_ID` int NOT NULL AUTO_INCREMENT,
    `room_number` varchar(10) NOT NULL,
    `room_type` enum('cardio', 'weights', 'Studio') NOT NULL,
    `capacity` int NOT NULL,
    PRIMARY KEY (`room_ID`)
);

-- @block
CREATE TABLE `workout_plans` (
    `plan_ID` int NOT NULL AUTO_INCREMENT,
    `member_ID` int NOT NULL,
    `trainer_ID` int NOT NULL,
    `instructions` varchar(255) NOT NULL,
    PRIMARY KEY (`plan_ID`),
    KEY `fk_member_ID_workout_plan` (`member_ID`),
    KEY `fk_trainer_ID_workout_plan` (`trainer_ID`),
    CONSTRAINT `fk_member_ID_workout_plan` FOREIGN KEY (`member_ID`) REFERENCES `members` (`member_ID`) ON DELETE CASCADE,
    CONSTRAINT `fk_trainer_ID_workout_plan` FOREIGN KEY (`trainer_ID`) REFERENCES `trainers` (`trainer_ID`) ON DELETE CASCADE
);

-- @block
CREATE TABLE `memberships` (
    `membership_ID` int NOT NULL AUTO_INCREMENT,
    `member_ID` int NOT NULL,
    `room_ID` int,
    `start_date` date NOT NULL,
    PRIMARY KEY (`membership_ID`),
    KEY `fk_member_id` (`member_ID`),
    KEY `fk_room_ID` (`room_ID`),
    CONSTRAINT `fk_member_id` FOREIGN KEY (`member_ID`) REFERENCES `members` (`member_ID`) ON DELETE CASCADE,
    CONSTRAINT `fk_room_ID` FOREIGN KEY (`room_ID`) REFERENCES `rooms` (`room_ID`)
);

-- @block
CREATE TABLE `appointments` (
    `appointment_ID` int NOT NULL AUTO_INCREMENT,
    `appointment_date` date NOT NULL,
    `appointment_time` time NOT NULL,
    `trainer_ID` int NOT NULL,
    `member_ID` int NOT NULL,
    PRIMARY KEY (`appointment_ID`),
    KEY `fk_member_ID_appointment` (`member_ID`),
    CONSTRAINT `fk_member_ID_appointment` FOREIGN KEY (`member_ID`) REFERENCES `members` (`member_ID`) ON DELETE CASCADE,
    CONSTRAINT `fk_trainer_ID_appointment` FOREIGN KEY (`trainer_ID`) REFERENCES `trainers` (`trainer_ID`) ON DELETE CASCADE
);
-- @block
INSERT INTO departments (department_name, location)
VALUES
    ('Fitness', 'New York'),
    ('Marketing', 'Los Angeles'),
    ('Yoga', 'San Francisco');  

-- @block
INSERT INTO trainers (First_name, Last_name, specialization, department_ID)
VALUES
    ('John', 'Smith', 'Cardio', 1),
    ('Emily', 'Johnson', 'Yoga Instructor', 3),
    ('Michael', 'Brown', 'Marketing', 2),
    ('Alice', 'Johnson', 'Musculation', 1),
    ('Bob', 'Smith', 'Cardio', 2),
    ('Eva', 'Martinez', 'Studio', 3);

-- @block
INSERT INTO members (First_name, Last_name, Date_Of_Birth, Gender, Phone_number, Email)
VALUES
    ('Alex', 'Johnson', '1990-07-15', 'Male', '1234567890', 'alex.johnson@example.com'),
    ('Nora', 'Hall', '2000-09-15', 'Female', '1234567890', 'nora.hall@example.com'),
    ('Ahmed', 'Ahmed', '1995-11-20', 'Male', '1234567890', 'ahmed.ahmed@example.com'),
    ('Adam', 'Davids', '1990-07-14', 'Male', '1234567890', 'adam.davids@example.com');

-- @block
INSERT INTO rooms (room_number, room_type, capacity)
VALUES
    ('101', 'cardio', 30),
    ('102', 'weights', 25),
    ('103', 'Studio', 20),
    ('104', 'cardio', 30),
    ('105', 'weights', 25),
    ('106', 'Studio', 20);

-- @block
INSERT INTO workout_plans (member_ID, trainer_ID, instructions)
VALUES
    (1, 1, 'Focus on strength training and cardio.'),
    (2, 2, 'Yoga exercises for flexibility and strength.'),
    (3, 3, 'Marketing strategies and team management.'),
    (4, 1, 'Focus on muscle building with weights.');

-- @block
INSERT INTO memberships (member_ID, room_ID, start_date)
VALUES
    (1, 1, '2024-01-01'),
    (2, 2, '2024-06-15'),
    (3, 3, '2024-11-20'),
    (4, 1, '2024-02-10');

-- @block
INSERT INTO appointments (appointment_date, appointment_time, trainer_ID, member_ID)
VALUES
    ('2024-12-10', '10:00:00', 1, 1),
    ('2024-12-11', '14:30:00', 2, 2),
    ('2024-12-12', '16:00:00', 3, 3),
    ('2024-12-13', '09:00:00', 4, 4);

-- @block
-- EX 1
INSERT INTO members (
        First_name,
        Last_name,
        Date_Of_Birth,
        Gender,
        Phone_number
    )
VALUES(
        'Adam',
        'Davids',
        '1990-07-14',
        'Male',
        '1234567890'
    );
-- @block
-- EX 2
SELECT *
FROM members;
-- @block
-- EX 3
SELECT *
FROM members
ORDER BY Date_Of_Birth;
-- @block
-- EX 4
SELECT DISTINCT Gender
FROM members;
-- @block
SELECT COUNT(DISTINCT Gender)
FROM members;
-- @block
-- EX 5
SELECT *
FROM trainers
LIMIT 3;
-- @block
-- EX 6
SELECT *
FROM members
WHERE Date_Of_Birth > '2000-01-01';
-- @block
-- EX 7
SELECT * FROM trainers WHERE specialization IN('Musculation','Cardio');

-- @block
--EX 8
SELECT * FROM memberships WHERE start_date BETWEEN '2024-12-01' AND '2024-12-07';

-- @block
-- EX 9
ALTER TABLE members
ADD  age_category VARCHAR(50);
-- @block
UPDATE members
SET age_category = CASE
  WHEN Date_Of_Birth > DATE_SUB(CURDATE(), INTERVAL 18 YEAR) THEN 'Junior'
  WHEN Date_Of_Birth > DATE_SUB(CURDATE(), INTERVAL 50 YEAR) THEN 'Adulte'
  ELSE 'Senior'
END;

-- @block

SELECT COUNT(*) AS number_of_appointments
FROM appointments;

-- @block
SELECT d.department_name, COUNT(t.trainer_ID) AS nombre_entraineurs
FROM departments d
LEFT JOIN trainers t ON d.department_ID = t.department_ID
GROUP BY d.department_name;

-- @block
SELECT AVG(TIMESTAMPDIFF(YEAR, Date_Of_Birth, CURDATE())) AS age_moyen
FROM members;

-- @block
SELECT MAX(CONCAT(appointment_date, ' ', appointment_time)) AS dernier_rendez_vous
FROM appointments;


-- @block
SELECT r.room_number, r.room_type, COUNT(m.membership_ID) AS total_abonnements
FROM rooms r
LEFT JOIN memberships m ON r.room_ID = m.room_ID
GROUP BY r.room_ID;

-- @block
SELECT * FROM members WHERE Email IS NULL;

-- @block
SELECT
    appointments.appointment_ID,
    appointments.appointment_date,
    appointments.appointment_time,
    trainers.First_name AS trainer_first_name,
    trainers.Last_name AS trainer_last_name,
    members.First_name AS member_first_name,
    members.Last_name AS member_last_name
FROM
    appointments
JOIN trainers ON appointments.trainer_ID = trainers.trainer_ID
JOIN members ON appointments.member_ID = members.member_ID;


-- @block
DELETE FROM appointments
WHERE appointment_date < '2024-12-12';

-- @block
SELECT * FROM appointments;

-- @block
UPDATE departments
SET department_name = 'Musculation'
WHERE department_name = 'Marketing';

-- @block
UPDATE departments
SET department_name = 'Force et Conditionnement'
WHERE department_name = 'Musculation';

-- @block
SELECT * FROM departments;
