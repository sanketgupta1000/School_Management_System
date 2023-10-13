--when data is inserted in person, if it is a student, it will be automatically inserted into student table
create or replace trigger person_student
after insert
on person
for each row
when (new.is_student in (1))
declare
	stu_count number;
	stu_id varchar(5);
begin
    select count(*) into stu_count from student;
	stu_id := ('S' || (stu_count+1));
	insert into student values(stu_id, (:new.person_id));
	dbms_output.put_line('Inserted a student. New student id: ' || stu_id);
	-- dbms_output.put_line('Person id: '||(:new.person_id)||' Student id: '||stu_id);
end;


--when data is inserted in person, if it is not a student, it will ask for data related to employee and insert into employee table
create or replace trigger person_employee
after insert
on person
for each row
when (new.is_student in (0))
declare
    emp_count number;
	emp_id varchar(5);
	salary number;
	job varchar(20);
begin
    select count(*) into emp_count from employee;
	emp_id := 'E'||(emp_count+1);
	salary := :enter_salary;
	job := :enter_job;
	insert into employee values(emp_id, (:new.person_id), salary, job);
end;


--when an employee is inserted, if it is a teacher, it will be automatically inserted into teacher table
create or replace trigger emp_teacher
after insert
on employee
for each row
when (new.job in ('Teacher'))
declare
	teacher_count number;
	teacher_id varchar(5);
begin
    select count(*) into teacher_count from teacher;
	teacher_id := ('T' || (teacher_count+1));
	insert into teacher values(teacher_id, (:new.employee_id));
	dbms_output.put_line('Inserted a teacher. New teacher id: ' || teacher_id);
	-- dbms_output.put_line('Person id: '||(:new.person_id)||' Student id: '||stu_id);
end;


