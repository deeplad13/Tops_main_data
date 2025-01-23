create database MarketCo;
use MarketCo;

create table Company(
CompanyID int primary key,
CompanyName varchar(45) not null,
Street varchar(45) not null,
City varchar(45) not null,
State varchar(5) not null, 
Zip varchar(10) not null
);

insert into Company (CompanyID,CompanyName,Street,City,State,Zip)
values(1,"Urban Outfitters, Inc.","5000 S Broad Street", 'Philadelphia', 'PA', '19112'),
(2,'Tata Consultancy Services', "Nirmal Building ,nariman point" ,"Mumbai","MH", '400021'),
(3,"Infosys", "Electronic city phase 1", "Bengaluru", "KA", '560100'),
(4,"Adani Group", "Shantigram Township", "Ahmedabad", "GJ", '382421'),
(5,"Mahindra", "Worli" , "Mumbai", "MH", '400018'),
(6,"Tata Steel", "Jubilee Building Bistupur", "jamshedpur", "JK", '831001'),
(7,"Reliance industries", "Marker chamber ,nariman point", "Mumbai", "MH", '400021'),
(8,"Tech Mahindra", "Sharda center eradwane", "Pune", "MH", '411004');

select *from Company;

update Company
set CompanyName = "Urban Outfitters"
where CompanyID = 1;

select *from Company;

-- NEW TABLE

create table Contact(
ContactID int primary key,
CompanyID int not null,
FirstName varchar(45) not null,
LastName varchar(45) not null,
Street varchar(45) not null,
City varchar(45) not null,
State varchar(5) not null, 
Zip varchar(10) not null,
IsMain boolean not null,
Email varchar(45) not null,
Phone varchar(12)
);

insert into Contact (ContactID,CompanyID,FirstName,LastName,Street,City,State,Zip,IsMain,Email,Phone)
values (1, 201, 'Aarav', 'Sharma', '15 MG Road', 'Mumbai', 'MH', '400001', 1, 'aarav.sharma@example.com', '9876543210'),
(2, 202, 'Ishita', 'Verma', '23 Nehru Nagar', 'Delhi', 'DL', '110001', 0, 'ishita.verma@example.com', '9812345678'),
(3, 203, 'Rohan', 'Gupta', '47 Lal Bahadur Shastri Rd', 'Bangalore', 'KA', '560001', 1, 'rohan.gupta@example.com', '9845678901'),
(4, 204, 'Ananya', 'Mehta', '12 Residency Road', 'Chennai', 'TN', '600001', 0, 'ananya.mehta@example.com', '9871234567'),
(5, 205, 'Aditya', 'Patel', '89 Ellis Bridge', 'Ahmedabad', 'GJ', '380001', 1, 'aditya.patel@example.com', '9874563210'),
(6, 206, 'Diya', 'Singh', '6 Park Street', 'Kolkata', 'WB', '700001', 0, 'diya.singh@example.com', '9832109876'),
(7, 207, 'Karan', 'Reddy', '54 Jubilee Hills', 'Hyderabad', 'TS', '500001', 1, 'karan.reddy@example.com', '9887654321'),
(8, 208, 'Nisha', 'Chopra', '34 Model Town', 'Chandigarh', 'PB', '160001', 0, 'nisha.chopra@example.com', '9811122233'),
(9, 209, 'Rahul', 'Kapoor', '78 Civil Lines', 'Lucknow', 'UP', '226001', 1, 'rahul.kapoor@example.com', '9934567890'),
(10, 210, 'Priya', 'Joshi', '10 MG Road', 'Pune', 'MH', '411001', 0, 'priya.joshi@example.com', '9823456789');

select *from Contact;

-- NEW TABLE

create table ContactEmployee (
ContactEmployeeID int primary key,
ContactID int ,
EmployeeID int,
ContactDate date not null,
Description varchar(100) not null
);

insert into ContactEmployee(ContactEmployeeID,ContactID,EmployeeID,ContactDate,Description)
values (1, 101, 201, '2025-01-15', 'Discussed project requirements.'),
(2, 102, 202, '2025-01-16', 'Follow-up meeting on product delivery.'),
(3, 103, 203, '2025-01-17', 'Negotiated contract terms.'),
(4, 104, 204, '2025-01-18', 'Discussed marketing strategy.'),
(5, 105, 205, '2025-01-19', 'Reviewed project timelines.'),
(6, 106, 206, '2025-01-20', 'Updated on development progress.'),
(7, 107, 207, '2025-01-21', 'Discussed customer feedback.'),
(8, 108, 208, '2025-01-22', 'Meeting on supply chain improvements.'),
(9, 109, 209, '2025-01-23', 'Brainstorming session for new features.'),
(10, 110, 210, '2025-01-24', 'Reviewed budget and financials.');

select *from ContactEmployee;

-- NEW TABLE

create table Employee (
EmployeeID int primary key,
FirstName varchar(45) not null,
LastName varchar(45) not null,
Salary float not null,
HireDate date not null,
JobTitle varchar(25) not null,
Email varchar(45) not null,
Phone bigint not null
);

alter table Employee
modify column Phone varchar(15);

insert into Employee(EmployeeID,FirstName,LastName,Salary,HireDate,JobTitle,Email,Phone)
values(1, 'John', 'Doe', 60000, '2022-01-15', 'Software Developer', 'john.doe@example.com', '555-123-4567'),
(2, 'Jane', 'Smith', 75000, '2021-05-20', 'Project Manager', 'jane.smith@example.com', '555-234-5678'),
(3, 'Michael', 'Johnson', 70000, '2020-11-01', 'Data Analyst', 'michael.johnson@example.com', '555-345-6789'),
(4, 'Emily', 'Brown', 80000, '2019-07-15', 'UX Designer', 'emily.brown@example.com', '555-456-7890'),
(5, 'David', 'Williams', 72000, '2023-03-10', 'Business Analyst', 'david.williams@example.com', '555-567-8901'),
(6, 'Sarah', 'Davis', 85000, '2020-09-25', 'HR Specialist', 'sarah.davis@example.com', '555-678-9012'),
(7, 'James', 'Wilson', 77000, '2018-06-05', 'DevOps Engineer', 'james.wilson@example.com', '555-789-0123'),
(8, 'Anna', 'Moore', 68000, '2021-08-30', 'Marketing Manager', 'anna.moore@example.com', '555-890-1234'),
(9, 'Olivia', 'Anderson', 88000, '2019-12-01', 'Operations Manager', 'olivia.anderson@example.com', '555-012-3456'),
(10, 'Lesley', 'Bland', 95000, '2017-02-15', 'Senior Developer', 'lesley.bland@example.com', '555-901-2345');

update Employee
set Phone = '215-555-8800'
where EmployeeID = 10;

select *from Employee;


-- 8 ) What is the significance of “%” and “_” operators in the LIKE statement?

-- The LIKE statement is used to search for a specified pattern in a column. The % and _ are wildcard characters used within the LIKE statement:

-- % (Percent Sign): Matches zero, one, or multiple characters.
-- Example:
-- WHERE name LIKE 'A%' will match any value starting with 'A' (e.g., 'Adam', 'Alice', 'Arun').
-- _ (Underscore): Matches exactly one character.
-- Example:
-- WHERE name LIKE '_a%' will match values where the second character is 'a' (e.g., 'Mark', 'Sara', but not 'Amy').

-- 9) Explain normalization in the context of databases.

-- Normalization is a process in database design that organizes data to minimize redundancy and ensure data integrity. It involves dividing a database into multiple related tables and defining relationships between them. The goal is to:

-- Eliminate duplicate data.
-- data dependencies are logical.
-- Simplify maintenance and scalability.

-- Key Normal Forms (NF):

-- 1NF (First Normal Form): Ensures each column contains atomic (indivisible) values, and each record is unique.
-- 2NF (Second Normal Form): Builds on 1NF by ensuring that all non-key attributes depend on the entire primary key.
-- 3NF (Third Normal Form): Ensures no transitive dependency exists (non-key attributes depend only on the primary key).

-- 10) What does a join in MySQL mean?

-- A join in MySQL is used to combine rows from two or more tables based on a related column (usually a foreign key). It allows you to query and retrieve data that is spread across multiple tables.

-- Example

SELECT employees.name, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id;

-- 11) What do you understand about DDL, DCL, and DML in MySQL?

-- DDL (Data Definition Language):
-- Deals with defining and modifying the structure of a database or its objects (e.g., tables, indexes).
-- Commands: CREATE, ALTER, DROP, TRUNCATE.

-- DML (Data Manipulation Language):
-- Deals with manipulating data stored in a database.
-- Commands: SELECT, INSERT, UPDATE, DELETE.

-- DCL (Data Control Language):
-- Deals with permissions and access control in a database.
-- Commands: GRANT, REVOKE.

-- 12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins?

-- The MySQL JOIN clause is used to combine rows from two or more tables based on a related column. It allows for complex queries to retrieve and analyze data stored in different tables.

-- Common Types of Joins:
-- 1) INNER JOIN: Returns rows with matching values in both tables.
-- 2)LEFT JOIN (or LEFT OUTER JOIN): Returns all rows from the left table and matching rows from the right table. Non-matching rows from the right table will contain NULL.
-- 3)RIGHT JOIN (or RIGHT OUTER JOIN): Returns all rows from the right table and matching rows from the left table. Non-matching rows from the left table will contain NULL.
-- 4)FULL JOIN (or FULL OUTER JOIN): Returns all rows where there is a match in one of the tables. MySQL does not directly support this, but it can be simulated using UNION.
-- 5)CROSS JOIN: Returns the Cartesian product of two tables (all combinations of rows).














