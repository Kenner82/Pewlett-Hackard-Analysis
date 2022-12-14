-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
-- Retrieve the title, from_date, and to_date columns from the Titles table.
-- Create a new table using the INTO clause.
-- Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were 
-- born between 1952 and 1955. Then, order by the employee number.

SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS emp
INNER JOIN titles as ti
ON (emp.emp_no = ti.emp_no)
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no;


-- Note: There are duplicate entries for some employees because they have switched titles over the years. 
-- Use the following instructions to remove these duplicates and keep only the most recent title of each employee.

-- Copy the query from the Employee_Challenge_starter_code.sql and add it to your Employee_Database_challenge.sql file.
-- Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
-- These columns will be in the new table that will hold the most recent title of each employee.
-- Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
-- Create a Unique Titles table using the INTO clause.
-- Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.

SELECT DISTINCT ON (emp_no) emp_no, 
	first_name, 
	last_name, 
	title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;


-- Write another query in the Employee_Database_challenge.sql file to retrieve 
-- the number of employees by their most recent job title who are about to retire.

-- First, retrieve the number of titles from the Unique Titles table.
-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.

SELECT COUNT(title),
	title
-- INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;



-- In the Employee_Database_challenge.sql file, write a query to create a Mentorship Eligibility table that holds 
-- the employees who are eligible to participate in a mentorship program.

-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Create a new table using the INTO clause.
-- Join the Employees and the Department Employee tables on the primary key.
-- Join the Employees and the Titles tables on the primary key.
-- Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all 
-- the employees whose birth dates are between January 1, 1965 and December 31, 1965.
-- Order the table by the employee number.


SELECT DISTINCT ON (emp.emp_no) emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS emp
INNER JOIN dept_employees as de
ON (emp.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (emp.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') 
	AND (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp.emp_no;