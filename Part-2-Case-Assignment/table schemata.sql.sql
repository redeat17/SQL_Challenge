
employees
-
emp_no int pk 
emp_title_id varchar(15) FK >- titles.title_id
birth_date date
first_name varchar(30)
last_name varchar
sex char(1)
hire_date date

departments 
-
dept_no varchar(15) PK
dept_name varchar(30)

dept_manager
-
dept_no varchar(15) FK >- departments.dept_no
emp_no int FK >- employees.emp_no

titles
-
title_id varchar(15) PK
title varchar(30)

dept_emp
-
emp_no int FK - employees.emp_no
dept_no varchar(15) FK >- departments.dept_no

salaries
-
emp_no int FK >- employees.emp_no
salary int 

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/Ko72LW
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
drop table if exists employees cascade;
drop table if exists dept_emp cascade;
drop table if exists dept_manager cascade;
drop table if exists departments cascade;
drop table if exists salaries cascade;
drop table if exists titles cascade;


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/Ko72LW
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(15)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" varchar(15)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(15)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" varchar(15)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(15)   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

COPY departments(dept_no, dept_name)
FROM 'C:\Users\redea\SQL_Challenge\Part-2-Case-Assignment\data\departments.csv'
DELIMITER ','
CSV HEADER;

COPY dept_emp(emp_no, dept_no)
FROM 'C:\Users\redea\SQL_Challenge\Part-2-Case-Assignment\data\dept_emp.csv'
DELIMITER ','
CSV HEADER;

COPY dept_manager(dept_no, emp_no)
FROM 'C:\Users\redea\SQL_Challenge\Part-2-Case-Assignment\data\dept_manager.csv'
DELIMITER ','
CSV HEADER;

COPY employees(emp_no,emp_title_id, birth_date,first_name, last_name, sex,hire_date)
FROM 'C:\Users\redea\SQL_Challenge\Part-2-Case-Assignment\data\employees.csv'
DELIMITER ','
CSV HEADER;


COPY salaries(emp_no, salary)
FROM 'C:\Users\redea\SQL_Challenge\Part-2-Case-Assignment\data\salaries.csv'
DELIMITER ','
CSV HEADER;

COPY titles(title_id, title)
FROM 'C:\Users\redea\SQL_Challenge\Part-2-Case-Assignment\data\titles.csv'
DELIMITER ','
CSV HEADER;

select count(*) from public.departments;
select count(*) from public.dept_emp;
select count(*) from public.dept_manager;
select count(*) from public.employees;
select count(*) from public.salaries;
select count(*) from public.titles;
