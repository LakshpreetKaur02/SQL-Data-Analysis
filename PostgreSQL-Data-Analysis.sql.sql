--database -- collection of tables 
--schema -- design of tables 

-->DDL(DATA DEFINATION LANGUAGE)
create table courses(
course_id int primary key,
name varchar(30),
enrollments int,
duration int
)

select * from courses

--->inserting values(part of DML) 
insert into courses values
(001,'DATA ANALYTICS',30,'6 months'),
(002,'DATA SCIENCE',34,'8 months'),
(003,'AI-ML',20,'1 year')

---> to add column 
alter table courses 
add column fee varchar(30)


---to convert varchar to int (extra code)
alter table courses
alter column fee type int
using fee ::int


--->to change type from int to varchar
alter table courses alter duration type varchar(30)


---> to rename column name 
alter table courses 
rename name to course_name


---> to drop a column 
alter table courses 
drop column fee


---> to delete table
--truncate (will delete only values and keep the structure intact)
--drop  (will delete the whole table , even from scheme )
truncate table courses
drop table courses


--- drop and view database , view table 


--DML ( DATA MANIPULATION LANGUAGE--->TO CHANGE THE DATA WITHIN THE STRUCURE)
insert into courses values 
(4,'WEB DEVELOPMENT',5,'5 months'),
(5,'PYTHON FULL STACK',2,'8 months'),
(6,'GEN AI',14,'1 year')


alter table courses add column trainer varchar(30)

update courses 
set trainer='LAKSHPREET' where course_name IN ('AI-ML','GEN AI') 

update courses 
set trainer='LARRY' where course_name IN ('DATA SCIENCE','DATA ANALYTICS')

update courses 
set trainer='RUBY' where course_name IN ('WEB DEVELOPMENT')

update courses 
set trainer='MONA' where course_name IN ('PYTHON FULL STACK')


select * from courses

create table students
(student_id int primary key,
name varchar(30),
course_name varchar(30))

insert into students values 
(001,'RAHUL','DATA ANALYTICS'),
(002,'PAVANI','GEN AI'),
(003,'SAISHA','AI-ML'),
(004,'HARRY','DATA SCIENCE'),
(005,'SHAGUN','DATA ANALYTICS')

insert into students values
(006,'KHUSHI','MATHEMATICS')

---> update
update courses 
set fee=45000 where course_id=1

--if no where applied , the performed function will be performed on all the rows 
update courses
set fee=35000 

update courses
set fee=45000
where course_id in (1,2)

select * from courses 
order by course_id


--- DQL (DATA QUERY LANGUAGE)

select * from courses 
where course_name="AI-ML" 

select * from courses 
where course_name='AI-ML' and fee>30000

select * from courses 
where fee between 30000 and 40000

select * from courses 
where fee in (35000,45000)

--LIKE FUNCTION 

select * from courses
where course_name like 'D%'   ---Starts with D

select * from courses
where course_name like '%E'   ---Ends with E

select * from courses
where course_name like '%DATA%' ---Has DATA in between


--ORDER BY 

select * from courses
order by fee asc

select * from courses 
order by enrollments desc


--LIMIT

select * from courses
order by fee desc limit 2

--to get distinct values from the table which has repeated values of something
select distinct trainer from courses
select distinct trainer,enrollments from courses



---OPERATORS(+,-,*,>,<,=) (<,>,= already used with where)
select course_id,course_name,trainer, enrollments+10 as Enrollments from courses


--FUNCTIONS IN SQL

--a) AGGREGATE FUNCTIONS (sum,count,min,max,avg) 
select sum(fee) from courses
--bigent data type 
select max(fee) from courses
select min(fee) from courses
select count(course_name) from courses 
select count(distinct trainer) from courses
select avg(fee) from courses

--STRING FUNCTIONS 
select lower(course_name) from courses
select initcap(course_name) from courses
select upper(course_name) from courses
select course_name,length(course_name) as length from courses
select * from courses
select concat(course_name,' is having a duration of ',duration, ' and is taught by ',trainer,'. This ', course_name,' charges a total of ',fee,'. Currently having a TOTAL ENROLLMENTS of ', enrollments) as statement from courses

--DATE AND TIME FUNCTIONS
select now()
select current_date

alter table courses
add column joining_date date

update courses
set joining_date='02-08-2026'

select * from courses

--DATE FORMAT
select to_char(joining_date,'dd-month-yy') from courses


--coalesce
create table insaan(
name varchar(30),
email varchar(40),
phone varchar(20)
)


insert into insaan(name,email,phone)
values('sujal',null,'238432'),
      ('atul',null,null),
	  ('shivam','s@gmail.com','908402'),
	  ('harman','h@gmail.com',null)

select name, email, phone, coalesce(email,phone,'no contact') as contact from insaan


--GROUP BY (applied with aggr)

select trainer,sum(fee) as total from courses group by trainer
select trainer,round(avg(fee),2) from courses group by trainer
select trainer,max(fee) from courses group by trainer
select trainer,count(fee) from courses group by trainer


--WHERE AND HAVING 
--where (first data filter, new table formed, then on that new table grp by will be applied,then sum) 
select trainer,sum(fee) as total from courses where enrollments>10 group by trainer 

--having (first grp by table then filtering for having condition, then sum, having is only applied on aggregate functions)
select trainer,sum(fee) as total from courses group by trainer having sum(fee)>30000



--JOINS 

--4 TYPES 
--1) INNER JOIN 
--2) OUTER JOIN 
--3) LEFT JOIN 
--4) RIGHT JOIN 


--1) inner join 
select students.student_id,students.name,students.course_name,courses.trainer,courses.fee
from students
inner join courses
on courses.course_name=students.course_name

------------------#eg--------------------

create table python (
name varchar(20) ,
marks int
)

create table excel(
name varchar(20),
marks int
)


insert into python(name,marks)
values ('a',25),
       ('b',26),
	   ('c',27),
	   ('d',28),
	   ('a',31)

insert into excel(name,marks)
values ('e',27),
       ('f',28),
	   ('a',29),
	   ('b',30)

select * from python
select * from excel

select python.name,python.marks,excel.marks
from python
inner join excel
on python.name = excel.name

--------------------------------------------------

--2) outer join 
select python.name,python.marks,excel.marks
from python
left join excel
on python.name=excel.name

union 

select excel.name,python.marks,excel.marks
from python
right join excel
on python.name=excel.name
order by name asc

--or 

SELECT COALESCE(python.name, excel.name) AS name,
       excel.marks AS excel_marks,
       python.marks AS python_marks
FROM python
FULL JOIN excel
ON python.name = excel.name;


--3) left join 
select python.name,python.marks,excel.marks
from python
left join excel
on python.name=excel.name

select excel.name,python.marks,excel.marks
from excel
left join python
on python.name=excel.name

--4) right join 
select excel.name,python.marks,excel.marks
from python
right join excel
on python.name=excel.name


--5) self join 

--data for self join :-

create table corporate(
employee_id int,
employee_name varchar(30),
manager_id int
)

insert into corporate values
(1,'Haroop',null),
(2,'Harman',1),
(3,'Gautum',2),
(4,'Divyam',2),
(6,'Sujal',3),
(7,'Atul',3)

select * from corporate

select c.employee_id,c.employee_name as manager_name,h.employee_name as emp_name
from corporate as h
self join corporate as c
on c.employee_id=h.manager_id

select employeworkers.name, manager.name
from corporate as workers    --created alias (nick name)
inner join corporate as manager
on workers.employee_id = manager.manager_id



--SUQ-QUERY ( query inside query)

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INTEGER,
    joining_date DATE
)

INSERT INTO employees (employee_id, name, department, salary, joining_date)
VALUES
(1, 'Amit', 'IT', 50000, '2023-05-10'),
(2, 'Neha', 'HR', 45000, '2024-02-15'),
(3, 'Rahul', 'IT', 60000, '2024-07-20'),
(4, 'Simran', 'Finance', 55000, '2022-11-05'),
(5, 'Karan', 'IT', 52000, '2024-09-12')

select * from employees

select * from employees
where salary > (
select avg(salary) from employees         --sub query/inner que
)


--CTE (COMMON TABLE EXPRESSIONS)
--(filtering table and taking a part out of it by filtering , then making that part a different table using with)
--a temporary table will be formed, helping you write the queries , but this table is not saved in database 
--making output as table is cte 

with it_table as (select * from employees where department = 'IT')
select * from it_table

with it_table as (select * from employees where department = 'IT')
select * from it_table
where salary > 50000

--
select * from employees where department = 'IT' order by salary desc limit 1
--

with salary_table as (select * from employees where department= 'IT')
select * from salary_table 
order by salary desc 
limit 1


with inner_cte as (select python.name,excel.marks,python.marks as pmarks 
from python 
inner join excel 
on python.name=excel.name)
select * from inner_cte
order by pmarks desc


--window function (do not use * in this function)

select name,department,salary,
avg(salary) over (partition by department) --to make window
as avg_salary                             
from employees                              

--syntax --: 
function()
over(
partition by column --to make window 
order by column
)

select name , department , salary, avg(salary) from employees group by department 


with avg_salaryy as (
select name,department,salary,
avg(salary) over (partition by department) --to make window
as avg_salary                             
from employee) 
select * from avg_salaryy
where salary>avg_salary


create table employees(
name varchar(12),
department varchar(12),
salary int 
)

insert into employees
values('varun','it',40000),
      ('pooja','hr',35000),
	  ('anjali','finance',34000),
	  ('diya','it',36000),
	  ('simran','finance',42000)


-- to filter 2nd highest
with my_cte as 
(
select name,department,salary, dense_rank() over(order by salary desc) as "ranking" from employees
)
select * from my_cte where ranking=2


with my_cte1 as 
(
select *, sum(salary)
over(),               --to put the previous detail by making new col 
avg(salary)
over() as averagesalary,
dense_rank()
over(order by salary desc) 
from employees
)
select* , salary-averagesalary as diff from my_cte1


--to rank according to the department .. ranking within the department ----PARTITION BY 
select *, sum(salary)
over(),
avg(salary)
over() as averagesalary,
dense_rank()
over(partition by department order by salary desc) 
from employees


--find out the person with rank 2 
with cte_2 as (
select *, sum(salary)
over(),
avg(salary)
over() as averagesalary,
dense_rank() 
over(partition by department order by salary desc) as ranking
from employees
)
select * from cte_2 where ranking=1


--no order by [over empty] and partition by 
--sum()
--min()
--max()
--avg()


--order by exists, partition by 
--rank
--row_number
--dense_rank
--lead
--lag


select * , avg(salary) over() as avg_salary from employees
select * , avg(salary) over(partition by department) as avg_salary from employees


update employees 
set salary = 50000 where employee_id = 2

--dense_rank , row_number, rank()
select *,
dense_rank() over(order by salary desc),
row_number() over (order by salary desc),
rank() over(order by salary desc) --2 is missing , it removes the row no of repeated value, and gives same rank to the same value
from employees


select *,
dense_rank() over(partition by department order by salary desc),
row_number() over (partition by department order by salary desc),
rank() over(partition by department order by salary desc) --2 is missing , it removes the row no of repeated value, and gives same rank to the same value
from employees


--CONSTRAINTS 

create table emp2(
id int,
name varchar(20),
city varchar(30),
salary int
)

insert into emp2 values
(1,'rahul','amritsar',29000)

insert into emp2 values
(null,'rohit','amritsar',29000)

--table will run , with null value as id of rohit 
--we need to apply constraint to prevent null data to enter it

drop table emp2

create table emp2(
id int not null,
name varchar(20),
city varchar(30),
salary int
)

insert into emp2 values
(1,'rahul','amritsar',29000)

insert into emp2 values
(null,'rohit','amritsar',29000)


insert into emp2 values
(1,'rohit','amritsar',29000)

--both ids 2, it will run, given we havent applied any primary key
--for this , apply constraint--unique

drop table emp2

create table emp2(
id int not null unique,
name varchar(20),
city varchar(30),
salary int
)

--PRIMANY KEY --NOT NULL + UNIQUE

drop table emp2

create table emp2(
id int primary key,
name varchar(20),
city varchar(30),
salary int
)


--FORIEGN KEY

create table students1
(id int primary key,
name varchar(34)
)

create table orders2 
(
order_id int primary key,
product_name varchar(30),
student_id int, --data type must be same for the foriegn key col in both table
foreign key(student_id) references students1(id) on delete cascade --delete cascade --if id 2 get deleted from table students1, the related data from table orders2 will also get deleted
)


insert into students1 values
(1,'Lakshpreet'),
(2,'Pavani'),
(3,'Larry'),
(4,'Shagun')

insert into orders2 values
(101,'Laptop',4),
(102,'Ring',2),
(103,'Mobile',1),
(104,'Earpods',3)

select * from orders2

delete from students1 where id=2

insert into orders2 values
(111,'GUITAR',7)          --as 7 not a student id 




--CHECK 
--we want that salary must not be below 16000
drop table emp2

create table emp2(
id int primary key,
name varchar(20),
city varchar(30),
salary int check(salary>16000) 
)

insert into emp2 values
(1,'rohit','amritsar',9000)

insert into emp2 values
(1,'rohit','amritsar',19000)


--DEFAULT
--if we forget to write city, it will take 'Amritsar' as default value
drop table emp2

create table emp2(
id int primary key,
name varchar(20),
city varchar(30) DEFAULT 'Amritsar',
salary int check(salary>16000)
)

insert into emp2(id,name,city,salary) values ---HAVE TO WRITE OTHER COL NAMES AND NOT CITY TO GET THE RESULT 
(4,'rohit',19000,17000)

select * from emp2

--VIEWS( VIEWS ~ CTE,  VIEW FORMS ITS OWN TABLE AND CTE --TEMPORARY TABLE)
--changes in view also lead to changes in the parmanent table 

 --IN CTE, UPDATIONS DO NOT WORK ( AS TABLE IS TEMPORARY)

 with my_cte as (select * from emp2 where salary>=18000)
 select * from my_cte 
 update my_cte set salary = 22000
 where id=2

--changes in view also lead to changes in the parmanent table 
create view vieww as 
select * from emp2 
where salary>=18000

select  * from vieww

update vieww set salary = 22000
where id=2

select * from emp2


--case
select name,salary,
case
   when salary >70000 then 'high salary'
   when salary <60000 then 'low salary'
   when salary between 60000 and 70000 then 'medium salary'
   else 'invalid'
end as salary_type
from employees    --forms a new column based on different conditions













