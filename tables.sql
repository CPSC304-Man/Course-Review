DROP TABLE Recommend;
DROP TABLE Review;
DROP TABLE RateCourse;
DROP TABLE ReviewCourse;
DROP TABLE CourseDetails;
DROP TABLE Course;
DROP TABLE Professor;
DROP TABLE Student;
DROP TABLE TA;
DROP TABLE Admin;


CREATE TABLE Professor (
    professor_ID CHAR(9) PRIMARY KEY,
    name VARCHAR(4000)
);

CREATE TABLE Student (
    student_ID CHAR(8) PRIMARY KEY,
    name VARCHAR(4000),
    email VARCHAR(4000),
    dept CHAR(4)
);

CREATE TABLE TA (
    ta_ID CHAR(10) PRIMARY KEY,
    name VARCHAR(4000)
);

CREATE TABLE Admin (
    admin_ID CHAR(9) PRIMARY KEY,
    dept CHAR(4) NOT NULL
);

CREATE TABLE Course (
    course_ID CHAR(14) PRIMARY KEY,
    dept CHAR(4),
    code CHAR(4),
    semester VARCHAR(20),
    professor_ID CHAR(9) NOT NULL,
    TA_ID CHAR(10) NOT NULL,
    average NUMBER,
    CONSTRAINT Course_FK_professor FOREIGN KEY (professor_ID) REFERENCES Professor(professor_ID),
    CONSTRAINT Course_FK_TA FOREIGN KEY (TA_ID) REFERENCES TA(TA_ID),
    UNIQUE (dept, code, semester)
);

CREATE TABLE CourseDetails (
    dept CHAR(4),
    code CHAR(4),
    name VARCHAR(100),
    description VARCHAR(4000),
    admin_ID CHAR(9) NOT NULL,
    nextReview DATE DEFAULT NULL,
    PRIMARY KEY (dept, code),
    CONSTRAINT CourseDetails_FK_admin FOREIGN KEY (admin_ID) REFERENCES Admin(admin_ID)
);

CREATE TABLE ReviewCourse (
    course_ID CHAR(14) PRIMARY KEY,
    rate_deadline DATE,
    review_deadline DATE,
    CONSTRAINT ReviewCourse_FK_course FOREIGN KEY (course_ID) REFERENCES Course(course_ID)
);

CREATE TABLE RateCourse (
    rate_course_ID RAW(32) PRIMARY KEY,
    course_ID CHAR(14),
    student_ID CHAR(8),
    courseComment VARCHAR(4000),
    courseRate NUMBER,
    professorComment VARCHAR(4000),
    professorRate NUMBER,
    taComment VARCHAR(4000),
    taRate NUMBER,
    CONSTRAINT RateCourse_FK_course FOREIGN KEY (course_ID) REFERENCES ReviewCourse(course_ID) ON DELETE CASCADE,
    CONSTRAINT RateCourse_FK_student FOREIGN KEY (student_ID) REFERENCES Student(student_ID)
);

CREATE TABLE Review (
    review_ID RAW(32) PRIMARY KEY,
    course_ID CHAR(14),
    professor_ID CHAR(9),
    reviewComment VARCHAR(4000),
    CONSTRAINT Review_FK_course FOREIGN KEY (course_ID) REFERENCES ReviewCourse(course_ID) ON DELETE CASCADE,
    CONSTRAINT Review_FK_professor FOREIGN KEY (professor_ID) REFERENCES Professor(professor_ID)
);

CREATE TABLE Recommend (
    recommend_ID RAW(32) PRIMARY KEY,
    course_ID CHAR(14),
    professor_ID CHAR(9),
    recommendation VARCHAR(4000),
    admin_ID CHAR(9),
    complete DATE DEFAULT NULL,
    CONSTRAINT Recomend_FK_course FOREIGN KEY (course_ID) REFERENCES ReviewCourse(course_ID) ON DELETE CASCADE,
    CONSTRAINT Recomend_FK_professor FOREIGN KEY (professor_ID) REFERENCES Professor(professor_ID),
    CONSTRAINT Recomend_FK_admin FOREIGN KEY (admin_ID) REFERENCES Admin(admin_ID)
);


INSERT INTO Professor VALUES ('P00000001', 'Hazra Imran');
INSERT INTO Professor VALUES ('P00000002', 'Mike Feely');
INSERT INTO Professor VALUES ('P00000003', 'Donal Acton');
INSERT INTO Professor VALUES ('P00000004', 'Rafael Lopes Rogo');
INSERT INTO Professor VALUES ('P00000005', 'Laks Lashamana');
INSERT INTO Professor VALUES ('P00000006', 'Gregor Kiczales');
INSERT INTO Professor VALUES ('P00000007', 'Steven Wolfman');
INSERT INTO Professor VALUES ('P00000008', 'Patrice Belleville');
INSERT INTO Professor VALUES ('P10000001', 'Professor 1');
INSERT INTO Professor VALUES ('P10000002', 'Professor 2');
INSERT INTO Professor VALUES ('P10000003', 'Professor 3');
INSERT INTO Professor VALUES ('P10000004', 'Professor 4');
INSERT INTO Professor VALUES ('P10000005', 'Professor 5');
INSERT INTO Professor VALUES ('P10000006', 'Professor 6');
INSERT INTO Professor VALUES ('P10000007', 'Professor 7');
INSERT INTO Professor VALUES ('P10000008', 'Professor 8');
INSERT INTO Professor VALUES ('P10000009', 'Professor 9');
INSERT INTO Professor VALUES ('P10000010', 'Professor 10');
INSERT INTO Professor VALUES ('P10000011', 'Professor 11');
INSERT INTO Professor VALUES ('P10000012', 'Professor 12');
INSERT INTO Professor VALUES ('P10000013', 'Professor 13');
INSERT INTO Professor VALUES ('P10000014', 'Professor 14');
INSERT INTO Professor VALUES ('P10000015', 'Professor 15');
INSERT INTO Professor VALUES ('P10000016', 'Professor 16');
INSERT INTO Professor VALUES ('P10000017', 'Professor 17');
INSERT INTO Professor VALUES ('P10000018', 'Professor 18');
INSERT INTO Professor VALUES ('P10000019', 'Professor 19');
INSERT INTO Professor VALUES ('P10000020', 'Professor 20');
INSERT INTO Professor VALUES ('P10000021', 'Professor 21');
INSERT INTO Professor VALUES ('P10000022', 'Professor 22');
INSERT INTO Professor VALUES ('P10000023', 'Professor 23');
INSERT INTO Professor VALUES ('P10000024', 'Professor 24');
INSERT INTO Professor VALUES ('P10000025', 'Professor 25');
INSERT INTO Professor VALUES ('P10000026', 'Professor 26');
INSERT INTO Professor VALUES ('P10000027', 'Professor 27');
INSERT INTO Professor VALUES ('P10000028', 'Professor 28');
INSERT INTO Professor VALUES ('P10000029', 'Professor 29');
INSERT INTO Professor VALUES ('P10000030', 'Professor 30');
INSERT INTO Professor VALUES ('P10000031', 'Professor 31');
INSERT INTO Professor VALUES ('P10000032', 'Professor 32');
INSERT INTO Professor VALUES ('P10000033', 'Professor 33');
INSERT INTO Professor VALUES ('P10000034', 'Professor 34');
INSERT INTO Professor VALUES ('P10000035', 'Professor 35');
INSERT INTO Professor VALUES ('P10000036', 'Professor 36');
INSERT INTO Professor VALUES ('P10000037', 'Professor 37');
INSERT INTO Professor VALUES ('P10000038', 'Professor 38');
INSERT INTO Professor VALUES ('P10000039', 'Professor 39');
INSERT INTO Professor VALUES ('P10000040', 'Professor 40');
INSERT INTO Professor VALUES ('P10000041', 'Professor 41');
INSERT INTO Professor VALUES ('P10000042', 'Professor 42');
INSERT INTO Professor VALUES ('P10000043', 'Professor 43');
INSERT INTO Professor VALUES ('P10000044', 'Professor 44');
INSERT INTO Professor VALUES ('P10000045', 'Professor 45');
INSERT INTO Professor VALUES ('P10000046', 'Professor 46');
INSERT INTO Professor VALUES ('P10000047', 'Professor 47');
INSERT INTO Professor VALUES ('P10000048', 'Professor 48');
INSERT INTO Professor VALUES ('P10000049', 'Professor 49');


INSERT INTO Student VALUES ('28144970', 'CHAU Tsun Man', 'tmchau@connect.ust.hk', 'CPSC');
INSERT INTO Student VALUES ('00000001', 'Rachel Fishman', 'rachelfishman@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000002', 'Harry Potter', 'potter@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000003', 'Ron Weasley', 'rweasley@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000004', 'Harmione Granger', 'granger@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000005', 'Albus Dumbeldore', 'dumbledore@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000006', 'Draco Malfoy', 'malfoy@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000007', 'Cedric Diggory', 'diggory@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000008', 'Fred Weasley', 'fweasley@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000009', 'Ginny Weasley', 'gweasley@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000010', 'Oliver Wood', 'wood@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000011', 'Katie Bell', 'bell@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('00000012', 'Draco Malfoy', 'draco@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000001', 'Student 1', 'student1@ubc.ca', 'CPSC');
INSERT INTO Student VALUES ('10000002', 'Student 2', 'student2@ubc.ca', 'COMM');
INSERT INTO Student VALUES ('10000003', 'Student 3', 'student3@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000004', 'Student 4', 'student4@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000005', 'Student 5', 'student5@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000006', 'Student 6', 'student6@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000007', 'Student 7', 'student7@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000008', 'Student 8', 'student8@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000009', 'Student 9', 'student9@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000010', 'Student 10', 'student10@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000011', 'Student 11', 'student11@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000012', 'Student 12', 'student12@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000013', 'Student 13', 'student13@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000014', 'Student 14', 'student14@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000015', 'Student 15', 'student15@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000016', 'Student 16', 'student16@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000017', 'Student 17', 'student17@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000018', 'Student 18', 'student18@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000019', 'Student 19', 'student19@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000020', 'Student 20', 'student20@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000021', 'Student 21', 'student21@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000022', 'Student 22', 'student22@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000023', 'Student 23', 'student23@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000024', 'Student 24', 'student24@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000025', 'Student 25', 'student25@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000026', 'Student 26', 'student26@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000027', 'Student 27', 'student27@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000028', 'Student 28', 'student28@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000029', 'Student 29', 'student29@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000030', 'Student 30', 'student30@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000031', 'Student 31', 'student31@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000032', 'Student 32', 'student32@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000033', 'Student 33', 'student33@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000034', 'Student 34', 'student34@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000035', 'Student 35', 'student35@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000036', 'Student 36', 'student36@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000037', 'Student 37', 'student37@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000038', 'Student 38', 'student38@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000039', 'Student 39', 'student39@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000040', 'Student 40', 'student40@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000041', 'Student 41', 'student41@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000042', 'Student 42', 'student42@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000043', 'Student 43', 'student43@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000044', 'Student 44', 'student44@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000045', 'Student 45', 'student45@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000046', 'Student 46', 'student46@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000047', 'Student 47', 'student47@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000048', 'Student 48', 'student48@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000049', 'Student 49', 'student49@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000050', 'Student 50', 'student50@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000051', 'Student 51', 'student51@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000052', 'Student 52', 'student52@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000053', 'Student 53', 'student53@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000054', 'Student 54', 'student54@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000055', 'Student 55', 'student55@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000056', 'Student 56', 'student56@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000057', 'Student 57', 'student57@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000058', 'Student 58', 'student58@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000059', 'Student 59', 'student59@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000060', 'Student 60', 'student60@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000061', 'Student 61', 'student61@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000062', 'Student 62', 'student62@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000063', 'Student 63', 'student63@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000064', 'Student 64', 'student64@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000065', 'Student 65', 'student65@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000066', 'Student 66', 'student66@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000067', 'Student 67', 'student67@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000068', 'Student 68', 'student68@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000069', 'Student 69', 'student69@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000070', 'Student 70', 'student70@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000071', 'Student 71', 'student71@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000072', 'Student 72', 'student72@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000073', 'Student 73', 'student73@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000074', 'Student 74', 'student74@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000075', 'Student 75', 'student75@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000076', 'Student 76', 'student76@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000077', 'Student 77', 'student77@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000078', 'Student 78', 'student78@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000079', 'Student 79', 'student79@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000080', 'Student 80', 'student80@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000081', 'Student 81', 'student81@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000082', 'Student 82', 'student82@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000083', 'Student 83', 'student83@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000084', 'Student 84', 'student84@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000085', 'Student 85', 'student85@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000086', 'Student 86', 'student86@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000087', 'Student 87', 'student87@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000088', 'Student 88', 'student88@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000089', 'Student 89', 'student89@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000090', 'Student 90', 'student90@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000091', 'Student 91', 'student91@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000092', 'Student 92', 'student92@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000093', 'Student 93', 'student93@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000094', 'Student 94', 'student94@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000095', 'Student 95', 'student95@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000096', 'Student 96', 'student96@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000097', 'Student 97', 'student97@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000098', 'Student 98', 'student98@ubc.ca', 'DEPT');
INSERT INTO Student VALUES ('10000099', 'Student 99', 'student99@ubc.ca', 'DEPT');


INSERT INTO TA VALUES ('TA00000001', 'Niall Horad');
INSERT INTO TA VALUES ('TA00000002', 'Liam Payne');
INSERT INTO TA VALUES ('TA00000003', 'Louis Tomlinson');
INSERT INTO TA VALUES ('TA00000004', 'Harry Styles');
INSERT INTO TA VALUES ('TA00000005', 'Zayne Malik');
INSERT INTO TA VALUES ('TA10000001', 'TA 1');
INSERT INTO TA VALUES ('TA10000002', 'TA 2');
INSERT INTO TA VALUES ('TA10000003', 'TA 3');
INSERT INTO TA VALUES ('TA10000004', 'TA 4');
INSERT INTO TA VALUES ('TA10000005', 'TA 5');
INSERT INTO TA VALUES ('TA10000006', 'TA 6');
INSERT INTO TA VALUES ('TA10000007', 'TA 7');
INSERT INTO TA VALUES ('TA10000008', 'TA 8');
INSERT INTO TA VALUES ('TA10000009', 'TA 9');
INSERT INTO TA VALUES ('TA10000010', 'TA 10');
INSERT INTO TA VALUES ('TA10000011', 'TA 11');
INSERT INTO TA VALUES ('TA10000012', 'TA 12');
INSERT INTO TA VALUES ('TA10000013', 'TA 13');
INSERT INTO TA VALUES ('TA10000014', 'TA 14');
INSERT INTO TA VALUES ('TA10000015', 'TA 15');
INSERT INTO TA VALUES ('TA10000016', 'TA 16');
INSERT INTO TA VALUES ('TA10000017', 'TA 17');
INSERT INTO TA VALUES ('TA10000018', 'TA 18');
INSERT INTO TA VALUES ('TA10000019', 'TA 19');
INSERT INTO TA VALUES ('TA10000020', 'TA 20');
INSERT INTO TA VALUES ('TA10000021', 'TA 21');
INSERT INTO TA VALUES ('TA10000022', 'TA 22');
INSERT INTO TA VALUES ('TA10000023', 'TA 23');
INSERT INTO TA VALUES ('TA10000024', 'TA 24');
INSERT INTO TA VALUES ('TA10000025', 'TA 25');
INSERT INTO TA VALUES ('TA10000026', 'TA 26');
INSERT INTO TA VALUES ('TA10000027', 'TA 27');
INSERT INTO TA VALUES ('TA10000028', 'TA 28');
INSERT INTO TA VALUES ('TA10000029', 'TA 29');
INSERT INTO TA VALUES ('TA10000030', 'TA 30');
INSERT INTO TA VALUES ('TA10000031', 'TA 31');
INSERT INTO TA VALUES ('TA10000032', 'TA 32');
INSERT INTO TA VALUES ('TA10000033', 'TA 33');
INSERT INTO TA VALUES ('TA10000034', 'TA 34');
INSERT INTO TA VALUES ('TA10000035', 'TA 35');
INSERT INTO TA VALUES ('TA10000036', 'TA 36');
INSERT INTO TA VALUES ('TA10000037', 'TA 37');
INSERT INTO TA VALUES ('TA10000038', 'TA 38');
INSERT INTO TA VALUES ('TA10000039', 'TA 39');
INSERT INTO TA VALUES ('TA10000040', 'TA 40');
INSERT INTO TA VALUES ('TA10000041', 'TA 41');
INSERT INTO TA VALUES ('TA10000042', 'TA 42');
INSERT INTO TA VALUES ('TA10000043', 'TA 43');
INSERT INTO TA VALUES ('TA10000044', 'TA 44');
INSERT INTO TA VALUES ('TA10000045', 'TA 45');
INSERT INTO TA VALUES ('TA10000046', 'TA 46');
INSERT INTO TA VALUES ('TA10000047', 'TA 47');
INSERT INTO TA VALUES ('TA10000048', 'TA 48');
INSERT INTO TA VALUES ('TA10000049', 'TA 49');


INSERT INTO Admin VALUES ('CPSCAdmin', 'CPSC');
INSERT INTO Admin VALUES ('COMMAdmin', 'COMM');

INSERT INTO Course VALUES ('CPSC304_2016W2', 'CPSC', '304', '2016 Winter Term 2', 'P00000001', 'TA00000001', '80.0');
INSERT INTO Course VALUES ('CPSC304_2016W1', 'CPSC', '304', '2016 Winter Term 1', 'P00000001', 'TA00000001', '80.0');
INSERT INTO Course VALUES ('CPSC313_2016W2', 'CPSC', '313', '2016 Winter Term 2', 'P00000002', 'TA00000002', '70.0');
INSERT INTO Course VALUES ('CPSC317_2016W2', 'CPSC', '317', '2016 Winter Term 2', 'P00000003', 'TA00000003', '60.0');
INSERT INTO Course VALUES ('COMM294_2016W2', 'COMM', '294', '2016 Winter Term 2', 'P00000004', 'TA00000004', '50.0');
INSERT INTO Course VALUES ('CPSC110_2016W1', 'CPSC', '110', '2016 Winter Term 1', 'P00000006', 'TA00000001', '55.0');
INSERT INTO Course VALUES ('CPSC121_2016W2', 'CPSC', '121', '2016 Winter Term 2', 'P00000007', 'TA00000002', '70.0');
INSERT INTO Course VALUES ('CPSC121_2015W2', 'CPSC', '121', '2015 Winter Term 2', 'P00000008', 'TA00000002', '75.0');



INSERT INTO CourseDetails VALUES ('CPSC', '304', 'Introduction to Relational Databases', 'Introduction to Relational Databases', 'CPSCAdmin', NULL);
INSERT INTO CourseDetails VALUES ('CPSC', '313', 'Computer Hardware and Operating Systems', 'Computer Hardware and Operating Systems', 'CPSCAdmin', NULL);
INSERT INTO CourseDetails VALUES ('CPSC', '317', 'Internet Computing', 'Internet Computing', 'CPSCAdmin', NULL);
INSERT INTO CourseDetails VALUES ('COMM', '294', 'Managerial Accounting', 'Managerial Accounting', 'COMMAdmin', NULL);
INSERT INTO CourseDetails VALUES ('CPSC', '110', 'Computation, Programs, and Programming', 'Computation, Programs, and Programming', 'CPSCAdmin', NULL);
INSERT INTO CourseDetails VALUES ('CPSC', '121', 'Models of Computation', 'Models of Computation', 'CPSCAdmin', NULL);
