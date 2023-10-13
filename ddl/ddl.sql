CREATE TABLE Person
(
	Person_ID varchar(10) PRIMARY KEY,
    F_Name varchar(50) not null,
    M_Name varchar(50) not null,
    L_Name varchar(50) not null,
    House_No varchar(10) not null,
    society_name varchar(50) not null,
    street_name varchar(50) not null,
    locality varchar(30) not null,
    pincode number(6,0) not null,
    gender varchar(10) CHECK (gender IN('Male', 'Female', 'Other')),
    is_student number(1, 0) check (is_student in(0, 1)),
    dob date not null
);

CREATE TABLE person_mobile(
	person_id varchar(10),
    mobile_no number(10, 0) not null,
    foreign key(person_id) REFERENCES person(person_id),
    primary key(person_id, mobile_no)
);

CREATE TABLE student(
	student_id varchar(10) PRIMARY KEY,
    person_id varchar(10),
    foreign key(person_id) REFERENCES person(person_id)
);

CREATE TABLE employee(
	employee_id varchar(10) PRIMARY KEY,
    person_id varchar(10),
    salary number(6, 0) not null,
    job varchar(30) check (job in('Teacher', 'Watchman', 'Cleanliness Worker', 'Peon')),
    foreign key (person_id) REFERENCES person(person_id)
);

CREATE TABLE teacher(
	teacher_id varchar(10) PRIMARY KEY,
    employee_id varchar(10),
    foreign key (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE classroom(
	room_no number(3, 0),
    building_no number(3, 0),
    capacity number(3, 0),
    primary key(room_no, building_no)
);

CREATE TABLE standard(
	standard_no number(2, 0) PRIMARY KEY,
    teacher_id varchar(10),
    room_no number(3, 0),
    building_no number(3, 0),
    foreign key(teacher_id) REFERENCES teacher(teacher_id),
    foreign key(room_no, building_no) references classroom
);

create table subject
(
    subject_name varchar(30) not null,
    standard_no number(3),
    book varchar(40) not null,
    foreign key(standard_no) references standard(standard_no),
    primary key(subject_name, standard_no)
);

create table enrollment
(
    roll_no number(3),
    standard_no number(3),
    student_id varchar(10) not null,
    enrolled_date date not null,
    foreign key(standard_no) references standard,
    foreign key(student_id) references student,
    primary key(roll_no, standard_no)
);

create table lecture
(
    lecture_no number(2),
    subject_name varchar(30),
    standard_no number(3),
    teacher_id varchar(10),
    day varchar(14) check (day in('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')),
    start_time varchar(10) not null,
    end_time varchar(10) not null,
    primary key(standard_no, subject_name, lecture_no),
    foreign key(subject_name, standard_no) references subject,
    foreign key(teacher_id) references teacher
);

create table working_day
(
    day_no number(3),
    date_ date not null unique,
    primary key(day_no)
);

create table attendance
(
    day_no number(3),
    person_id varchar(10),
    status varchar(15) check (status in('Present', 'Absent')),
    primary key(day_no, person_id),
    foreign key(day_no) references working_day,
    foreign key(person_id) references person
);