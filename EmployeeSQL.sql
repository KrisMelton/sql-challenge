-- Drop existing tables if they exist
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS dept;

-- Create dept table
CREATE TABLE dept (
    dept_no VARCHAR(10) PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL
);

-- Create employees table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first VARCHAR(40) NOT NULL,
    last VARCHAR(40) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL
);

-- Create titles table to store job titles
CREATE TABLE titles (
    title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(40) NOT NULL
);

-- Create salaries table to store employee salaries
CREATE TABLE salaries (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Create dept_emp table to link employees to departments
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(10) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES dept(dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- Create dept_manager table to store department managers
CREATE TABLE dept_manager (
    dept_no VARCHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES dept(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    PRIMARY KEY (dept_no, emp_no)
);

-- Create titles table to store job titles
CREATE TABLE titles(
    title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(40) NOT NULL
);

-- Query to select employee details along with their salaries
SELECT 
    e.emp_no, 
    e.last, 
    e.first, 
    e.sex, 
    s.salary
FROM 
    employees e
JOIN 
    salaries s ON e.emp_no = s.emp_no;

-- Query to select employees hired within a specific date range
SELECT 
    first, 
    last, 
    hire_date
FROM 
    employees
WHERE 
    hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- Query to select department managers and their details
SELECT 
    dm.dept_no, 
    d.dept_name, 
    e.emp_no, 
    e.last, 
    e.first
FROM 
    dept_manager dm
JOIN 
    employees e ON dm.emp_no = e.emp_no
JOIN 
    dept d ON dm.dept_no = d.dept_no;

-- Query to select employees along with their department details
SELECT 
    de.dept_no, 
    e.emp_no, 
    e.last, 
    e.first, 
    d.dept_name
FROM 
    dept_emp de
JOIN 
    employees e ON de.emp_no = e.emp_no
JOIN 
    dept d ON de.dept_no = d.dept_no;

-- Query to select specific employee details based on first and last name
SELECT 
    first, 
    last, 
    sex
FROM 
    employees
WHERE 
    first = 'Hercules' AND last LIKE 'B%';

-- Query to select employees in the Sales department
SELECT 
    e.emp_no, 
    e.last, 
    e.first
FROM 
    employees e
JOIN 
    dept_emp de ON e.emp_no = de.emp_no
JOIN 
    dept d ON de.dept_no = d.dept_no
WHERE 
    d.dept_name = 'Sales';

-- Query to select employees in either Sales or Development departments
SELECT 
    e.emp_no, 
    e.last, 
    e.first, 
    d.dept_name
FROM 
    employees e
JOIN 
    dept_emp de ON e.emp_no = de.emp_no
JOIN 
    dept d ON de.dept_no = d.dept_no
WHERE 
    d.dept_name IN ('Sales', 'Development');

-- Query to count the frequency of last names in employees table
SELECT 
    last, 
    COUNT(*) AS frequency
FROM 
    employees
GROUP BY 
    last
ORDER BY 
    frequency DESC;
