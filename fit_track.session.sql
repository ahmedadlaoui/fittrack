-- @block
CREATE DATABASE fit_track2;
USE fit_track2;
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
CREATE TABLE `trainers` (
    `trainer_ID` int PRIMARY KEY AUTO_INCREMENT,
    `First_name` varchar(50) NOT NULL,
    `Last_name` varchar(50) NOT NULL,
    `specialization` varchar(50) NOT NULL,
    `department_ID` int DEFAULT NULL,
    PRIMARY KEY (`trainer_ID`),
    KEY `fk_department_ID` (`department_ID`),
    CONSTRAINT `fk_department_ID` FOREIGN KEY (`department_ID`) REFERENCES `departments` (`department_ID`)
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
CREATE TABLE `departments` (
    `department_ID` int NOT NULL AUTO_INCREMENT,
    `department_name` varchar(50) NOT NULL,
    `location` varchar(100) NOT NULL,
    PRIMARY KEY (`department_ID`)
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
INSERT INTO memberships (member_ID, start_date)
VALUES
('1', '2024-01-01'),
('2', '2024-06-15'),
('3', '2024-11-20');

-- @block
INSERT INTO trainers (First_name, Last_name, specialization)
VALUES ('Alice', 'Johnson', 'Musculation'),
    ('Bob', 'Smith', 'Cardio'),
    ('Eva', 'Martinez', 'Studio');
-- @block
SELECT *
FROM trainers;
-- @block
INSERT INTO members (
        First_name,
        Last_name,
        Date_Of_Birth,
        Gender,
        Phone_number
    )
VALUES(
        'Alex',
        'Johnson',
        '1990-07-15',
        'Male',
        '1234567890'
    );
-- @block
INSERT INTO members (
        First_name,
        Last_name,
        Date_Of_Birth,
        Gender,
        Phone_number,
        Email
    )
VALUES(
        'Nora',
        'Hall',
        '2000-09-15',
        'Female',
        '1234567890',
        'Nora@gmail.com'
    );
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
