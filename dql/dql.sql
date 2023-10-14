
-- find the number of students in std1
select count(*) as student_in_standard1 from (student natural join enrollment) where standard_no=1;

-- Find when is the 2nd maths lecture of the week In STD 2
select day, start_time, end_time from lecture  where lecture_no =2 and subject_name='Mathematics' and standard_no=2;

-- in which classroom std3 students are study
select room_no,building_no from standard where standard_no=3;

-- find the capacity of room in which standard 3's student studies
select capacity from (standard natural join classroom) where standard_no =3;

-- find the name of teachers who teaches  Hindi in standard2
select distinct F_name||' '||M_name||' '||L_name as Hindi_Std2_Teacher from (lecture natural join teacher natural join employee natural join person) where subject_name='Hindi' and standard_no=2;

-- find the name of students who is studies in standard 1
select F_name||' '||M_name||' '||L_name as Student_Std1 from (person natural join student natural join enrollment) where standard_no=1;

-- find the name and salary of every employee who is teacher
select F_name||' '||M_name||' '||L_name as Teacher_Name, Salary from (person natural join employee natural join teacher);

-- find the enrolled date, std, roll_no of the students who's student id is S12
select enrolled_date, standard_no, roll_no from (enrollment) where student_id='S12';

-- find the time table of std1 on monday
select lecture_no,subject_name,standard_no,start_time,end_time  from lecture where standard_no = 1 and day='Monday';

-- Find whether Student with student id S4 was present on 3rd June, 2019 or not.
select status from (student natural join person natural join attendance) where day_no=(select day_no from working_day where date_='03-JUN-2019') and student_id='S4';

--Find whether roll number 3 of standard 2nd was present on 3rd June, 2019 or not.
select status from attendance where person_id=(select person_id from student where student_id=(select student_id from enrollment where roll_no=3 and standard_no=2)) and day_no=(select day_no from working_day where date_='03-JUN-2019');

--Find mobile number of student of standard 2nd with roll number 5.
select mobile_no from person_mobile where person_id=
(
    select person_id from student where student_id=
    (
        select student_id from enrollment where roll_no=5 and standard_no=2
    )
);
select mobile_no from enrollment natural join student natural join person natural join person_mobile where standard_no=2 and roll_no=5;

--find start_time and end_time of subject 'Hindi' in standard 2 on Tuesday
select start_time,end_time from  lecture where subject_name='Hindi' and standard_no=2 and day='Tuesday';

-- find the name of books that is learn by student of standard 3;
select  book from subject where standard_no = 3;