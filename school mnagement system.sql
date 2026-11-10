create database schoolmanagementsystem;
use schoolmanagementsystem;
create table students(
              student_id int primary key,
              first_name varchar(50) not null,
              last_name varchar(50) not null);
desc students;
 create table subjects(
               subject_id int primary key,
               subject_name varchar(50) not null);
desc subjects;
 create table exams(
           exam_id int primary key,
           exam_name varchar(100) not null,
		   exam_date date not null);
desc exams;
create table marks(
               mark_id int primary key,
               student_id int not null,
               subject_id int not null,
               exam_id int not null,
               score int not null,
               foreign key(student_id)
               references students(student_id),
               foreign key(subject_id)
               references subjects(subject_id),
               foreign key(exam_id)
               references exams(exam_id));
               
desc marks;
#insert data into tables
insert into students values
(1, 'Aarav', 'Sharma'),
(2, 'Ananya', 'Reddy'),
(3, 'Rahul', 'Kumar'),
(4, 'Priya', 'Verma'),
(5, 'Arjun', 'Rao'),
(6, 'Sneha', 'Patel'),
(7, 'Kiran', 'Naidu'),
(8, 'Meera', 'Das'),
(9, 'Vikram', 'Singh'),
(10, 'Sita', 'Krishna');
select  *from students;

insert into subjects values
(1, 'Mathematics'),
(2, 'Science'),
(3, 'English'),
(4, 'Hindi'),
(5, 'Computer Science');
select *from subjects;

insert into exams values
(1, 'Unit Test 1', '2024-06-15'),
(2, 'Half-Yearly 2024', '2024-10-15'),
(3, 'Annual Exam 2025', '2025-03-20');
select *from exams;

insert into marks values
(1, 1, 1, 1, 85),
(2, 1, 2, 1, 78),
(3, 1, 3, 1, 92),
(4, 2, 1, 1, 91),
(5, 2, 2, 1, 88),
(6, 3, 1, 1, 67),
(7, 3, 2, 1, 74),
(8, 4, 1, 1, 96),
(9, 4, 2, 1, 89),
(10, 5, 1, 1, 80),
(11, 6, 2, 1, 86),
(12, 7, 1, 1, 88),
(13, 8, 2, 1, 74),
(14, 9, 1, 1, 95),
(15, 10, 3, 1, 85);
select *from marks;

#1 List the first name and last name of every student
select first_name,last_name from students;

#2Find all entries in the Marks table where the score is greater than 80
select *from marks where score > 80;


#3List all exams sorted by their date, starting with the most recent.
select * from exams order by exam_date desc;

#4List the First Name, Subject Name, and Score for every mark recorded.
select s.first_name,sub.subject_name,m.score
from marks m
join students s on m.student_id=s.student_id
join subjects sub on m.subject_id=sub.subject_id;


#5Calculate the average score for each subject. Display the Subject Name and the Average Score.
select sub.subject_name,
round(avg(m.score),2) as average_score
from marks m
join subjects sub on m.subject_id=sub.subject_id
group by sub.subject_name;



#6How many marks have been recorded specifically for "Aarav Sharma"?
select count(*) as marks_count
from marks m
join students s on m.student_id=s.student_id
where s.first_name='Aarav'
and s.last_name='sharma';


#7Find the student (First Name, Last Name) who has the highest single score in any exam.
select s.first_name,s.last_name,sub.subject_name,m.score
from marks m
join students s on m.student_id=s.student_id
join subjects sub on m.subject_id=sub.subject_id
where m.score=(select max(score) from marks);


#8. Display the Exam Name and the total sum of scores for that exam, but only for exams where the total sum is greater than 250.
select e.exam_name,sum(m.score) as total_score
from exams e
join marks m on e.exam_id=m.exam_id
group by e.exam_name
having sum(m.score)>250;


#9Create a report showing the Student Name, Subject, Score, and a status column that says "Pass" if the score is 70 or above, and "Fail" if below.
select s.first_name,s.last_name,sub.subject_name,m.score,
case
when m.score>=70 then 'pass'
else 'fail'
end as status
from marks m
join students s on m.student_id=s.student_id
join subjects sub on m.subject_id=sub.subject_id;
