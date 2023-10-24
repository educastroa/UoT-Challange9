SELECT e.emp_no, e.first_name, e.last_name, e.sex, s.salary 
FROM employees AS e 
JOIN salaries AS s ON e.emp_no = s.emp_no;

SELECT first_name, last_name, hire_date 
FROM employees 
WHERE hire_date > '1986-01-01' 
AND hire_date < '1986-12-31';

SELECT d.dept_name, e.emp_no, e.first_name, e.last_name 
FROM departments AS d 
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no 
JOIN employees AS e ON dm.emp_no = e.emp_no;

SELECT d.dept_name, e.emp_no, e.first_name, e.last_name 
FROM departments AS d 
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no 
JOIN employees AS e ON dm.emp_no = e.emp_no;

SELECT first_name, last_name, sex 
FROM employees 
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

SELECT e.emp_no, e.first_name, e.last_name 
FROM employees AS e 
JOIN dept_emp AS de ON e.emp_no = de.emp_no 
JOIN departments AS d ON de.dept_no = d.dept_no 
WHERE d.dept_name = 'Sales';

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name 
FROM employees AS e 
JOIN dept_emp AS de ON e.emp_no = de.emp_no 
JOIN departments AS d ON de.dept_no = d.dept_no 
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

SELECT last_name, count(*) AS last_name_count 
FROM employees 
GROUP BY last_name 
ORDER BY last_name_count DESC;