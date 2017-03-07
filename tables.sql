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