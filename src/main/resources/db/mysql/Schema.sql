
-- TSYLLABUS
CREATE TABLE UniOviSCOPE.tsyllabus(
    ID BIGINT(20) NOT NULL AUTO_INCREMENT,
    CODE VARCHAR(255) NOT NULL,
    DENOMINATION VARCHAR(255) NOT NULL,
    IMPLANTATION_YEAR BIGINT NOT NULL,
    NUM_COURSES INTEGER NOT NULL,
    NUMECTS DOUBLE NOT NULL,
    RESPONSIBLE_CENTER VARCHAR(255) NOT NULL,
    STATE VARCHAR(255) NOT NULL,
    TYPE VARCHAR(255) NOT NULL,
    CONSTRAINT PK_TSYLLABUS PRIMARY KEY(ID),
    CONSTRAINT UK_TSYLLABUS_CODE UNIQUE(CODE)
);

-- TSUBJECT        
CREATE TABLE UniOviSCOPE.tsubject(
    ID BIGINT(20) NOT NULL AUTO_INCREMENT,
    CODE VARCHAR(255) NOT NULL,
    COURSE INTEGER NOT NULL,
    CREDITS DOUBLE NOT NULL,
    DENOMINATION VARCHAR(255) NOT NULL,
    TEMPORALITY VARCHAR(255) NOT NULL,
    TYPE VARCHAR(255) NOT NULL,
    SYLLABUS_ID BIGINT NOT NULL,
    CONSTRAINT PK_TSUBJECT PRIMARY KEY(ID),
    CONSTRAINT FK_TSUBJECT_SYLLABUS_ID FOREIGN KEY(SYLLABUS_ID) REFERENCES UniOviSCOPE.tsyllabus(ID),
    CONSTRAINT UK_TSUBJECT_CODE UNIQUE(CODE)
);

-- TCOURSE
CREATE TABLE UniOviSCOPE.tcourse(
    ID BIGINT(20) NOT NULL AUTO_INCREMENT,
    YEAR BIGINT NOT NULL,
    CONSTRAINT PK_TCOURSE PRIMARY KEY(ID),
    CONSTRAINT UK_TCOURSE UNIQUE(YEAR)
);  

-- TCOURSE_SUBJECT
CREATE TABLE UniOviSCOPE.tcourse_subject(
    COURSE_ID BIGINT(20) NOT NULL,
    SUBJECT_ID BIGINT(20) NOT NULL,
    PRIMARY KEY(COURSE_ID, SUBJECT_ID),
    CONSTRAINT FK_TCOURSE_SUBJECT_COURSE_ID FOREIGN KEY(COURSE_ID) REFERENCES UniOviSCOPE.tcourse(ID),
    CONSTRAINT FK_TCOURSE_SUBJECT_SUBJECT_ID FOREIGN KEY(SUBJECT_ID) REFERENCES UniOviSCOPE.tsubject(ID)
);

-- TGROUP
CREATE TABLE UniOviSCOPE.tgroup(
    ID BIGINT(20) NOT NULL AUTO_INCREMENT,
    CODE VARCHAR(255) NOT NULL,
    TYPE VARCHAR(255) NOT NULL,
    SUBJECT_COURSE_ID BIGINT NOT NULL,
    SUBJECT_SUBJECT_ID BIGINT NOT NULL,
    CONSTRAINT TGROUP PRIMARY KEY(ID),
    CONSTRAINT FK_TGROUP_SUBJECT_COURSE_ID FOREIGN KEY(SUBJECT_COURSE_ID, SUBJECT_SUBJECT_ID) REFERENCES UniOviSCOPE.tcourse_subject(COURSE_ID, SUBJECT_ID)
);

-- TUSER        
CREATE TABLE UniOviSCOPE.tuser(
    ID BIGINT(20) NOT NULL AUTO_INCREMENT,
    DNI VARCHAR(255) NOT NULL,
    FIRST_NAME VARCHAR(255) NOT NULL,
    LAST_NAME VARCHAR(255) NOT NULL,
    USER_NAME VARCHAR(255) NOT NULL,
    PASSWORD VARCHAR(255) NOT NULL,
    ROLE VARCHAR(255) NOT NULL,
    CONSTRAINT PK_TTEACHER PRIMARY KEY(ID),
    CONSTRAINT UK_TTEACHER_USER_NAME UNIQUE(USER_NAME)
);

-- TTEACHER_GROUP
CREATE TABLE UniOviSCOPE.tteacher_group(
    GROUP_ID BIGINT(20) NOT NULL,
    TEACHER_ID BIGINT(20) NOT NULL,
    PRIMARY KEY(GROUP_ID, TEACHER_ID),
    CONSTRAINT FK_TTEACHER_GROUP_GROUP_ID FOREIGN KEY(GROUP_ID) REFERENCES UniOviSCOPE.tgroup(ID),
    CONSTRAINT FK_TTEACHER_GROUP_TEACHER_ID FOREIGN KEY(TEACHER_ID) REFERENCES UniOviSCOPE.tuser(ID)
); 


-- TSTUDENT_GROUP
CREATE TABLE UniOviSCOPE.tstudent_group(
    GROUP_ID BIGINT(20) NOT NULL,
    STUDENT_ID BIGINT(20) NOT NULL,
    PRIMARY KEY(GROUP_ID, STUDENT_ID),
    CONSTRAINT FK_TSTUDENT_GROUP_GROUP_ID FOREIGN KEY(GROUP_ID) REFERENCES UniOviSCOPE.tgroup(ID),
    CONSTRAINT FK_TSTUDENT_GROUP_STUDENT_ID FOREIGN KEY(STUDENT_ID) REFERENCES UniOviSCOPE.tuser(ID)
); 

-- TSESSION
CREATE TABLE UniOviSCOPE.tsession(
    ID BIGINT(20) NOT NULL AUTO_INCREMENT,
    DESCRIPTION VARCHAR(255) NOT NULL,
    `END` TIMESTAMP NOT NULL,
    LOCATION VARCHAR(255) NOT NULL,
    START TIMESTAMP NOT NULL,
    GROUP_ID BIGINT NOT NULL,
    CONSTRAINT TSESSION PRIMARY KEY(ID),
    CONSTRAINT FK_TSESSION_GROUP_ID FOREIGN KEY(GROUP_ID) REFERENCES UniOviSCOPE.tgroup(ID)
); 

-- TSESSION_TOKEN
CREATE TABLE UniOviSCOPE.tsession_token(
	ID BIGINT(20) NOT NULL AUTO_INCREMENT,
	TOKEN VARCHAR(255) NOT NULL,
	GENERATED TIMESTAMP NOT NULL,
	SESSION_ID BIGINT NOT NULL,
	CONSTRAINT TSESSION_TOKEN PRIMARY KEY(ID),
	CONSTRAINT FK_TSESSION_TOKEN_SESSION_ID FOREIGN KEY(SESSION_ID) REFERENCES UniOviSCOPE.tsession(ID),
	CONSTRAINT UK_TSESSION_TOKEN_TOKEN UNIQUE(TOKEN)
);

-- TATTENDANCE
CREATE TABLE UniOviSCOPE.tattendance(
    `COMMENT` VARCHAR(255) NOT NULL,
    CONFIRMED BOOLEAN NOT NULL,
    DATE TIMESTAMP,
    FACE_RECOGNITION_OFF BOOLEAN NOT NULL,
    SESSION_ID BIGINT(20) NOT NULL,
    STUDENT_ID BIGINT(20) NOT NULL,
    CONSTRAINT PK_TATTENDANCE PRIMARY KEY(SESSION_ID, STUDENT_ID),
    CONSTRAINT FK_TATTENDANCE_SESSION_ID FOREIGN KEY(SESSION_ID) REFERENCES UniOviSCOPE.tsession(ID),
    CONSTRAINT FK_TATTENDANCE_STUDENT_ID FOREIGN KEY(STUDENT_ID) REFERENCES UniOviSCOPE.tuser(ID)
);           