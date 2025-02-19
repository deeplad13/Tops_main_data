-- Create Database
create database try;
use try;

create table employees (
Employee_id int auto_increment primary key,name varchar(100), position varchar(100),
salary decimal(10,2),hire_date date);

use try;

select *from employees;

INSERT INTO employees (name, position, salary, hire_date) 
VALUES ('John Doe','Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

select *from employees;

CREATE TABLE employee_audit (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT,
name VARCHAR(100),position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE,
action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

select *from employee_audit;

 -- TRIGGERS 
 
 -- CREATE TRIGGER
 Delimiter $$
 create trigger after_employee_audit
 after insert on employees
 for each row
 begin 
 insert into employee_audit(employee_id,name,position,salary,hire_date)
 values(new.Employee_id,new.name,new.position,new.salary,new.hire_date);
 end;$$
 Delimiter ;
 
 -- CREATE STORED PROCEDURE
 
 Delimiter $$
 create procedure `add_employee` (
 in emp_name varchar(100),
 in emp_position varchar(100),
 in emp_salary decimal(10,2),
 in emp_hire_date date)
 Begin
 insert into employees(name, position, salary, hire_date) 
 values(emp_name,emp_position,emp_salary,emp_hire_date);
 end;$$
 Delimiter ;
 
 call add_employee("Rohit Verma","Data Analytics",95000.00,"2025-02-10");
 call add_employee("Ajay Mehta","Web Developer",75000.00,"2024-12-12");
 
 select *from employees;
 select *from employee_audit;




