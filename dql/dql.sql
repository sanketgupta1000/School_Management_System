
--1 find the number of students in std1
select count(*) as student_in_standard1 from (student natural join enrollment natural join standard) where standard_no=1;

--2 Find when is the 2nd maths lecture of the week In STD 2
select start_time  from lecture  where lecture_no =2 and subject_name='Mathematics' and standard_no=2;

--3 in which classroom std3 students are study
select room_no,building_no from standard where standard_no=3;

--4 find the capacity of room in which standard 3's student studies
select capacity from (standard natural join classroom) where standard_no =3;

--5 find the name of teachers who teaches  Hindi in standard2
select F_name,M_name,L_name from (person natural join employee natural join teacher natural join lecture) where subject_name='Hindi' and standard_no=2;

--6 find the standard who's room capaity is 30
select  standard_no from (standard natural join classroom) where capacity=30;

--7 find the name of students who is studies in standard 1
select F_name,M_name,L_name from (person natural join student natural  join enrollment) where standard_no=1;

--8 find the name and salary of every employee who is teacher
select F_name,M_name,L_name,salary from (person natural join employee natural join teacher);

--9 find the enrolled date and roll_no of the students who's person id is P0047
select enrolled_date,roll_no from (person natural join student natural join enrollment) where person_id='P0023';

--10 find the time table of std1 on monday
select lecture_no,subject_name,standard_no,start_time,end_time  from (lecture natural join subject) where standard_no = 1 and day='Monday';

--11 find the building no of standard2
select building_no from standard where standard_no=2;

--12 find the name of person who were absent in day 25
select F_name,M_name,L_name from (person natural join attendance) where day_no = '25';

--13 find the mobile_no of person who's locality is nadiad
select mobile_no from (person natural join person_mobile) where locality='Nadiad';

--14 find start_time and end_time of subject 'Hindi' in standard 2 on Tuesday
select start_time,end_time from  lecture where subject_name='Hindi' and standard_no=2 and day='Tuesday';

--15 find the name of books that is learn by student of standard 3;
select  book from subject where standard_no = 3;