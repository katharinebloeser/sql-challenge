CREATE TABLE departments (
    dept_no VARCHAR(30) PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL
);

CREATE TABLE dept_emp (
    emp_no int,
    dept_no VARCHAR(30),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
    dept_no varchar (30),
    emp_no int,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no, dept_no) REFERENCES dept_emp(emp_no, dept_no)
);

CREATE TABLE titles (
    emp_title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_no SERIAL PRIMARY KEY,
    emp_title_id VARCHAR(10) REFERENCES titles(emp_title_id),
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex CHAR(1),
    hire_date DATE NOT NULL
);
--I used ChatGPT to help with this part instead of using the Composite Key
ALTER TABLE employees
ADD CONSTRAINT fk_emp_title
FOREIGN KEY (emp_title_id)
REFERENCES titles(emp_title_id);

CREATE TABLE salaries (
    emp_no serial primary key,
    salary money
);

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT a.emp_no, a.last_name, a.first_name, a.sex, b.salary
FROM employees a
JOIN salaries b ON a.emp_no = b.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT last_name, first_name, hire_date
FROM employees
WHERE DATE_PART('year', hire_date)=1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT a.dept_no, a.dept_name, b. emp_no, b.dept_no, c.last_name, c.first_name
FROM departments a
JOIN dept_manager b ON a.dept_no = b.dept_no
JOIN employees c ON b.emp_no= c.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT a.dept_no, a.emp_no, b.last_name, b.first_name, c.dept_name
FROM dept_emp a
JOIN employees b ON a.emp_no = b.emp_no 
JOIN departments c ON a.dept_no = c.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex 
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT a.dept_no, a.emp_no, b.last_name, b.first_name, c.dept_name
FROM dept_emp a
JOIN employees b ON a.emp_no = b.emp_no 
JOIN departments c ON a.dept_no = c.dept_no
WHERE c.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT a.dept_no, a.emp_no, b.last_name, b.first_name, c.dept_name
FROM dept_emp a
JOIN employees b ON a.emp_no = b.emp_no 
JOIN departments c ON a.dept_no = c.dept_no
WHERE c.dept_name = 'Sales' OR c.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS "last name frequency"
FROM employees
GROUP BY last_name
ORDER BY "last name frequency" DESC;


