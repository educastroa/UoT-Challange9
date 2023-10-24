CREATE TABLE employees (
    emp_no int   NOT NULL,
    emp_title_id varchar(50)   NOT NULL,
    birth_date varchar(50)   NOT NULL,
    first_name varchar(50)   NOT NULL,
    last_name varchar(50)   NOT NULL,
    sex varchar(50)   NOT NULL,
    hire_date varchar(50)   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE titles (
    title_id varchar(50)   NOT NULL,
    title varchar(50)   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);


CREATE TABLE dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar(50)   NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (
        emp_no, dept_no
     )
);

CREATE TABLE departments (
    dept_no varchar(50)   NOT NULL,
    dept_name varchar(50)   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL
);

CREATE TABLE dept_manager (
    dept_no varchar(50)   NOT NULL,
    emp_no int   NOT NULL
);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);


CREATE OR REPLACE FUNCTION custom_date_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.birth_date ~ '^(0?[1-9]|1[0-2])/(0?[1-9]|[12][0-9]|3[01])/\d{4}$' THEN
    NEW.birth_date = to_char(to_date(NEW.birth_date, 'MM/DD/YYYY'), 'YYYY-MM-DD');
  ELSE
    RAISE EXCEPTION 'Invalid date format: %', NEW.birth_date;
  END IF;

  IF NEW.hire_date ~ '^(0?[1-9]|1[0-2])/(0?[1-9]|[12][0-9]|3[01])/\d{4}$' THEN
    NEW.hire_date = to_char(to_date(NEW.hire_date, 'MM/DD/YYYY'), 'YYYY-MM-DD');
  ELSE
    RAISE EXCEPTION 'Invalid date format: %', NEW.hire_date;
  END IF;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER convert_custom_date_on_insert
BEFORE INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION custom_date_insert_trigger();