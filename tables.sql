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
    email VARCHAR(4000)
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
    course_ID CHAR(14),
    student_ID CHAR(8),
    courseComment VARCHAR(4000),
    courseRate NUMBER,
    professorComment VARCHAR(4000),
    professorRate NUMBER,
    taComment VARCHAR(4000),
    taRate NUMBER,
    PRIMARY KEY (course_ID, student_ID),
    CONSTRAINT RateCourse_FK_course FOREIGN KEY (course_ID) REFERENCES ReviewCourse(course_ID),
    CONSTRAINT RateCourse_FK_student FOREIGN KEY (student_ID) REFERENCES Student(student_ID)
);

CREATE TABLE Review (
    course_ID CHAR(14),
    professor_ID CHAR(9),
    reviewComment VARCHAR(4000),
    PRIMARY KEY (course_ID, professor_ID),
    CONSTRAINT Review_FK_course FOREIGN KEY (course_ID) REFERENCES ReviewCourse(course_ID),
    CONSTRAINT Review_FK_professor FOREIGN KEY (professor_ID) REFERENCES Professor(professor_ID)
);

CREATE TABLE Recommend (
    course_ID CHAR(14),
    professor_ID CHAR(9),
    recommendation VARCHAR(4000),
    admin_ID CHAR(7),
    complete DATE DEFAULT NULL,
    PRIMARY KEY (course_ID, professor_ID, admin_ID),
    CONSTRAINT Recomend_FK_course FOREIGN KEY (course_ID) REFERENCES ReviewCourse(course_ID),
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
INSERT INTO Professor VALUES ('P00000007', 'Patrice Belleville');


INSERT INTO Student VALUES ('28144970', 'CHAU Tsun Man', 'tmchau@connect.ust.hk');
INSERT INTO Student VALUES ('00000001', 'Rachel Fishman', 'rachelfishman@ubc.ca');
INSERT INTO Student VALUES ('00000002', 'Harry Potter', 'potter@ubc.ca');
INSERT INTO Student VALUES ('00000003', 'Ron Weasley', 'rweasley@ubc.ca');
INSERT INTO Student VALUES ('00000004', 'Harmione Granger', 'granger@ubc.ca');
INSERT INTO Student VALUES ('00000005', 'Albus Dumbeldore', 'dumbledore@ubc.ca');
INSERT INTO Student VALUES ('00000006', 'Draco Malfoy', 'malfoy@ubc.ca');
INSERT INTO Student VALUES ('00000007', 'Cedric Diggory', 'diggory@ubc.ca');
INSERT INTO Student VALUES ('00000008', 'Fred Weasley', 'fweasley@ubc.ca');
INSERT INTO Student VALUES ('00000009', 'Ginny Weasley', 'gweasley@ubc.ca');
INSERT INTO Student VALUES ('00000010', 'Oliver Wood', 'wood@ubc.ca');
INSERT INTO Student VALUES ('00000011', 'Katie Bell', 'bell@ubc.ca');
INSERT INTO Student VALUES ('00000012', 'Draco Malfoy', 'draco@ubc.ca');


INSERT INTO TA VALUES ('TA00000001', 'Niall Horad');
INSERT INTO TA VALUES ('TA00000002', 'Liam Payne');
INSERT INTO TA VALUES ('TA00000003', 'Louis Tomlinson');
INSERT INTO TA VALUES ('TA00000004', 'Harry Styles');
INSERT INTO TA VALUES ('TA00000005', 'Zayne Malik');


INSERT INTO Admin VALUES ('CPSCAdmin', 'CPSC');
INSERT INTO Admin VALUES ('COMMAdmin', 'COMM');

INSERT INTO Course VALUES ('CPSC304_2016W2', 'CPSC', '304', '2016 Winter Term 2', 'P00000001', 'TA00000001', '80.0');
INSERT INTO Course VALUES ('CPSC304_2016W1', 'CPSC', '304', '2016 Winter Term 1', 'P00000001', 'TA00000001', '80.0');
INSERT INTO Course VALUES ('CPSC313_2016W2', 'CPSC', '313', '2016 Winter Term 2', 'P00000002', 'TA00000002', '70.0');
INSERT INTO Course VALUES ('CPSC317_2016W2', 'CPSC', '317', '2016 Winter Term 2', 'P00000003', 'TA00000003', '60.0');
INSERT INTO Course VALUES ('COMM294_2016W2', 'COMM', '294', '2016 Winter Term 2', 'P00000004', 'TA00000004', '50.0');
INSERT INTO Course VALUES ('CPSC110_2016W1', 'CPSC', '110', '2016 Winter Term 1', 'P00000006', 'TA00000001', '55.0');
INSERT INTO Course VALUES ('CPSC121_2016W2', 'CPSC', '121', '2016 Winter Term 2', 'P00000007', 'TA00000002', '70.0');
INSERT INTO Course VALUES ('CPSC121_2015W2', 'CPSC', '121', '2016 Winter Term 2', 'P00000008', 'TA00000002', '75.0');



INSERT INTO CourseDetails VALUES ('CPSC', '304', 'Introduction to Relational Databases', 'Introduction to Relational Databases', 'CPSCAdmin', NULL);
INSERT INTO CourseDetails VALUES ('CPSC', '313', 'Computer Hardware and Operating Systems', 'Computer Hardware and Operating Systems', 'CPSCAdmin', NULL);
INSERT INTO CourseDetails VALUES ('CPSC', '317', 'Internet Computing', 'Internet Computing', 'CPSCAdmin', NULL);
INSERT INTO CourseDetails VALUES ('COMM', '294', 'Managerial Accounting', 'Managerial Accounting', 'COMMAdmin', NULL);
INSERT INTO CourseDetails VALUES ('CPSC', '110', 'Computation, Programs, and Programming', 'Computation, Programs, and Programming', 'CPSCAdmin', NULL);
INSERT INTO CourseDetails VALUES ('CPSC', '121', 'Models of Computation', 'Models of Computation', 'CPSCAdmin', NULL);
