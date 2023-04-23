-- create department table
create table departments(
dept_no varchar not null,
dept_name varchar not null,
PRIMARY KEY (dept_no));

--create dept_emp table
create table dept_emp(
emp_no int not null,
dept_no varchar not null,
PRIMARY KEY (emp_no, dept_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no));

-- create dept manager table 
create table dept_manager(
dept_no varchar not null,
emp_no int not null,
PRIMARY KEY (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no));

--create emp table 
create table employee(
emp_no int not null,
emp_title varchar not null,
birth_date date,
first_name varchar not null,
last_name varchar not null,
sex varchar not null,
hire_date date,	
PRIMARY KEY (emp_no) );

-- create salary table  
create table salary(
emp_no int not null,
salary int not null,	
PRIMARY KEY (emp_no),
foreign key(emp_no) references employee(emp_no) );

--create title 
create table titles(
title_id  varchar not null,
title  varchar not null,	
PRIMARY KEY (title_id));

-- add foreign id to emp 
ALTER TABLE "employee" ADD CONSTRAINT "fk_" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

-- List the employee number, last name, first name, sex, and salary of each employee. 
select e.emp_no, e.last_name, e.first_name, e.sex,s.salary
from employee e  
join salary s 
on (e.emp_no= s.emp_no)

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employee
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'

--List the manager of each department along with their department number,
--department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_manager dm
ON d.dept_no = dm.dept_no
JOIN employee e
ON dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employee e
ON de.emp_no = e.emp_no
JOIN departments d
ON de.dept_no = d.dept_no;

--List first name, last name, and sex of each employee whose first name is 
--Hercules and whose last name begins with the letter B.
SELECT employee.first_name, employee.last_name, employee.sex
FROM employee
WHERE first_name = 'Hercules'
AND last_name Like 'B%'

--List each employee in the Sales department, 
--including their employee number, last name, and first name.
SELECT departments.dept_name,dept_emp.emp_no, employee.last_name, employee.first_name
FROM dept_emp
JOIN employee
ON dept_emp.emp_no = employee.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee 
--number, last name, first name, and department name.
select dept_emp.emp_no,employee.last_name, employee.first_name,departments.dept_name
FROM dept_emp
JOIN employee
ON dept_emp.emp_no = employee.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name).
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employee
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;