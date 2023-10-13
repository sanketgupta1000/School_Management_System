--only for demonstration purposes

--This will take data from person table, and put into employee table with random job and salary
create or replace procedure randomize_employee
is
    --cursor to iterate on person table where emp's data is stored
	cursor person_emp
	is
		select person_id from person where is_student=0;

	e_count number;
	e_id varchar(5);
	p_id varchar(6);
	e_salary number;
	e_job varchar(20);

	--associative array of job
	type jb is table of varchar(20) index by pls_integer;
	emp_job jb;
begin
    emp_job(0) := 'Teacher';
	emp_job(1) := 'Watchman';
	emp_job(2) := 'Cleanliness Worker';
	emp_job(3) := 'Peon';

	open person_emp;
	loop
        --getting person id
        fetch person_emp into p_id;
		exit when person_emp%notfound;

		--generating emp id
		select count(*) into e_count from employee;
		e_id := 'E' || (e_count+1);

		--randomizing job
		e_job := emp_job(trunc(dbms_random.value(0, 4)));

		if(e_job in ('Teacher'))
        then
            e_salary := 40000;
		else
            e_salary := 10000;
		end if;

		--now inserting into employee
		insert into employee values(e_id, p_id, e_salary, e_job);
	end loop;
end;

--to randomly add mobile numbers
create or replace procedure randomize_mobile
is
    cursor person_
    is
        select person_id from person;
        
    p_id varchar(10);
    mno number;
begin
    open person_;
    loop
        fetch person_ into p_id;
        exit when person_%notfound;
        mno := trunc(dbms_random.value(6666666666, 9999999999));
        insert into person_mobile values(p_id, mno);
    end loop;
end;

--to randomly add attendance
create or replace procedure randomize_attendance
is
    cursor day_
    is
        select day_no from working_day;
    cursor p
    is
        select person_id from person;
    d_no number;
    p_id varchar(10);
    
    type asso_status_arr is table of varchar(20) index by PLS_INTEGER;
    status asso_status_arr;
begin

    status(0) := 'Present';
    status(1) := 'Present';
    status(2) := 'Present';
    status(3) := 'Absent';
    open day_;
    loop
        fetch day_ into d_no;
        exit when day_%notfound;
        open p;
        loop
            fetch p into p_id;
            exit when p%notfound;
            insert into attendance values(d_no, p_id, status(trunc(dbms_random.value(0, 4))));
        end loop;
        close p;
    end loop;
    close day_;
end;