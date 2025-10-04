create database hospitaldb;
use hospitaldb;

create table doctors (
	doctor_id varchar(10),
    first_name varchar(15) not null,
    last_name varchar(15) not null,
    specialization varchar(20),
    phone_number varchar(15),
    years_experience int,
    hospital_branch varchar(50),
    email varchar(50) not null
);

create table patients (
	patient_id varchar(10),
    first_name varchar(15),
    last_name varchar(15),
    gender char(1),
    date_of_birth date,
    contact_number varchar(15) not null,
    address varchar(100),
    registration_date date,
    insurance_provider varchar(50),
    insurance_number varchar(50),
    email varchar(50)
);

create table appointments (
	appointment_id varchar(10),
    patient_id varchar(10),
    doctor_id varchar(10),
    appointment_date date,
    appointment_time time,
    reason_for_visit varchar(100),
    status varchar(50)
);

create table treatments (
	treatment_id varchar(10),
    appointment_id varchar(10),
    treatment_type varchar(50),
    description varchar(100),
    cost decimal(10,2),
    treatment_date date
);

create table billing (
	bill_id varchar(10),
    patient_id varchar(10),
    treatment_id varchar(10),
    bill_date date,
    amount decimal(10,2),
    payment_method varchar(50),
    payment_status varchar(50)
);

LOAD DATA LOCAL INFILE 'D:/DATA ANALYTICS/SQL/practice/archive (13)/appointments.csv'
INTO TABLE appointments
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'D:/DATA ANALYTICS/SQL/practice/archive (13)/doctors.csv'
INTO TABLE doctors
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'D:/DATA ANALYTICS/SQL/practice/archive (13)/billing.csv'
INTO TABLE billing
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'D:/DATA ANALYTICS/SQL/practice/archive (13)/patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'D:/DATA ANALYTICS/SQL/practice/archive (13)/treatments.csv'
INTO TABLE treatments
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from doctors;
select * from patients;
select * from appointments;
select * from treatments;
select * from billing;

-- update
update doctors
set first_name = "Ajay" , last_name = "Mehta"
where doctor_id = "D001";

update patients
set first_name = "Steve", last_name = "Smith" , gender = "M"
where patient_id = "P001";

-- OPERATORS
-- LOGICAL

select * from doctors
where specialization = "pediatrics" and years_experience > 21;

select * from doctors
where specialization = "pediatrics" or years_experience > 20;

select * from doctors
where not specialization = "Dermatology";

-- COMPARISON
select * from doctors
where hospital_branch = "Central Hospital";

select * from doctors
where specialization != "Pediatrics";

select * from doctors
where years_experience > 19;

select * from doctors
where years_experience < 19;

-- SET OPERATORS

select first_name from doctors
union select first_name from
patients;

select first_name from doctors
union all select first_name from
patients;

select first_name from doctors
intersect select first_name from
patients;

select first_name from doctors
except select first_name from
patients;

-- OTHER OPERATORS
select * from doctors
where hospital_branch in ("Westside clinic","Eastside clinic");

select * from billing 
where amount between 4000 and 5000;

select * from doctors
where first_name like "A%";

select * from doctors
where first_name is not null;

-- SELET STATEMENT
-- DQL QUERY

select distinct specialization from  doctors;

-- WHERE 
select first_name,last_name from doctors
where years_experience > 22;

-- ORDER BY
select first_name,specialization from doctors
order by specialization Asc;

-- GROUP BY
select insurance_provider,count(*)
from patients
group by insurance_provider;

select treatment_type,sum(cost) as sum_of_cost
from treatments
group by treatment_type;

select specialization,max(years_experience)
from doctors
group by specialization;

-- HAVING CLAUSE
select treatment_type,count(*)
from treatments
group by treatment_type
having treatment_type = "MRI";

-- LIMIT CLAUSE
select first_name,last_name from patients
limit 4;

select first_name,last_name from patients
limit 4
offset 4;

-- JOINS

-- INNER JOIN
select * from doctors;
select * from patients;
select * from appointments;
select * from billing; 
select * from treatments; 

select d.first_name,d.last_name,d.hospital_branch,a.reason_for_visit
from doctors d inner join appointments a on d.doctor_id = a.doctor_id;

select d.first_name,d.specialization,a.status
from doctors d left join appointments a on d.doctor_id = a.doctor_id;

select t.treatment_type,b.amount,b.payment_status
from treatments t right join billing b on t.treatment_id = b.treatment_id;

select p.first_name,p.last_name,b.amount,b.payment_method
from patients p left join billing b on p.patient_id = b.patient_id
union
select p.first_name,p.last_name,b.amount,b.payment_method
from patients p right join billing b on p.patient_id = b.patient_id;

-- ADVANCED SQL
-- SUBQUERY

select first_name,last_name from patients where patient_id in (select
patient_id from appointments where reason_for_visit = "Therapy");

select first_name,last_name,specialization from doctors where doctor_id in (select
doctor_id from appointments where reason_for_visit = "Consultation");

-- DATEDIFF
select datediff("2025-7-31","2025-7-20");

-- DATEADD
select date_add(appointment_date,interval 2 day) from appointments;

-- DATESUB
select date_sub(appointment_date,interval 10 day) from appointments;

-- EXTRACT
select extract(year from date_of_birth),extract(month from date_of_birth) from patients;

-- VIEWS 
create view `new_view` as
select p.first_name,p.last_name,p.email,b.amount
from patients p inner join billing b on p.patient_id = b.patient_id;

select * from new_view;

-- STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE GetPatientsByVisitReason(IN visit_reason VARCHAR(100))
BEGIN
    SELECT DISTINCT p.patient_id, p.first_name, p.last_name, a.reason_for_visit
    FROM patients p
    JOIN appointments a ON p.patient_id = a.patient_id
    WHERE a.reason_for_visit = visit_reason;
END //

DELIMITER ;

call GetPatientsByVisitReason("Therapy");
call GetPatientsByVisitReason("Consultation");

-- USER DEFINED FUNCTION
DELIMITER //

CREATE FUNCTION CalculateAge(dob DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    RETURN age;
END //

DELIMITER ;

select CalculateAge(date_of_birth) from patients;
SELECT first_name, last_name, CalculateAge(date_of_birth) AS age
FROM patients;

-- JOIN MORE THAN 2 TABLE
-- List the patient name, doctor name, appointment date, and reason for visit

select p.first_name,p.last_name,d.first_name,d.last_name,a.appointment_date,a.reason_for_visit
from patients p
join appointments a on p.patient_id = a.patient_id
join doctors d on a.doctor_id = d.doctor_id;

-- Show each treatment with patient name, doctor name, treatment type, and treatment cost

select p.first_name,d.first_name,t.treatment_type,t.cost
from treatments t 
join appointments a on t.appointment_id = a.appointment_id
join patients p on a.patient_id = p.patient_id
join doctors d on a.doctor_id = d.doctor_id;

-- Get all billed treatments along with patient name, treatment type, bill amount, and payment status

select p.first_name,t.treatment_type,b.amount,b.payment_status
from billing b
join patients p on b.patient_id = p.patient_id
join treatments t on b.treatment_id = t.treatment_id;

-- Find the total bill amount paid by each patient along with their full name

select p.first_name,p.last_name,sum(b.amount) as Total_bill_amount
from  patients p
join billing b on p.patient_id = b.patient_id
where b.payment_status = "Paid"
group by p.first_name,p.last_name;

-- Display doctor name, number of appointments handled, and total treatment cost for each doctor

select d.first_name,d.last_name,count(a.appointment_id) as Number_of_appointment,sum(t.cost) as total_cost
from doctors d
join appointments a on d.doctor_id = a.doctor_id
join treatments t on a.appointment_id = t.appointment_id
group by d.first_name,d.last_name;

-- MORE THAN 3 TABLE
-- Show patient name, doctor name, treatment type, treatment cost, and bill amount

-- select p.first_name,d.first_name,t.treatment_type,t.cost,b.amount
-- from patients p
-- join appointments a on p.patient_id = a.patient_id
-- join doctors d on a.doctor_id = d.doctor_id
-- join treatments t on a.appointment_id = t.appointment_id
-- join billing b on t.treatment_id = b.treatment_id;

SELECT 
    p.first_name AS patient_first_name,
    d.first_name AS doctor_first_name,
    t.treatment_type,
    t.cost AS treatment_cost,
    b.amount AS bill_amount
FROM billing b
JOIN patients p ON b.patient_id = p.patient_id
JOIN treatments t ON b.treatment_id = t.treatment_id
JOIN appointments a ON t.appointment_id = a.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

-- List doctor name, number of distinct patients treated, and total billing amount generated
select d.first_name,d.last_name,count(distinct a.patient_id) as number_of_patient,sum(b.amount) as billing_amount
from doctors d
join appointments a on d.doctor_id= a.doctor_id
join treatments t on a.appointment_id = t.appointment_id
join billing b on t.treatment_id = b.treatment_id
group by d.first_name,d.last_name;

-- Show all treatments along with patient name, doctor name, appointment date, and bill status
select p.first_name,d.first_name,a.appointment_date,t.treatment_type,b.payment_status
from treatments t
join appointments a on t.appointment_id = a.appointment_id
join patients p on a.patient_id = p.patient_id
join doctors d on a.doctor_id = d.doctor_id
left join billing b on t.treatment_id = b.treatment_id;

-- Display patient name, total amount billed, number of treatments, and number of appointments
select p.first_name,p.last_name,
count(distinct a.appointment_id) as appointment_count,
count(distinct t.treatment_id) as treatment_count,
sum(b.amount) as total_billed
from patients p
left join appointments a on p.patient_id = a.patient_id
left join treatments t on a.appointment_id = t.appointment_id
left join billing b on t.treatment_id = b.treatment_id
group by p.first_name,p.last_name;

-- Show all patients who have received treatment and billing, along with doctor name, treatment type, cost, and payment method
select p.first_name,d.first_name,
t.treatment_type,
t.cost,
b.payment_method
from billing b
join patients p on b.patient_id = p.patient_id
join treatments t on b.treatment_id = t.treatment_id
join appointments a on t.appointment_id = a.appointment_id
join doctors d on a.doctor_id = d.doctor_id;

-- Show appointments where a patient received treatment but has not been billed yet. Display patient name, doctor name, and appointment date
select p.first_name,d.first_name,a.appointment_date
from appointments a
join patients p on a.patient_id = p.patient_id
join doctors d on a.doctor_id = d.doctor_id
join treatments t on a.appointment_id = t.appointment_id
left join billing b on t.treatment_id = b.treatment_id
where b.bill_id is null;

-- Display all patients with their latest treatment date, treatment type, bill amount, and doctor name
select p.first_name,t.treatment_date,t.treatment_type,b.amount,d.first_name
from treatments t
join appointments a on t.appointment_id = a.appointment_id
join patients p on a.patient_id = p.patient_id
join doctors d on a.doctor_id = d.doctor_id
left join billing b on b.treatment_id = t.treatment_id
where t.treatment_date = (
    select MAX(t2.treatment_date)
    from treatments t2
    where t2.appointment_id = a.appointment_id
);

-- For each insurance provider, list total number of patients, total treatment cost, and total billed amount
select p.insurance_provider,count(distinct p.patient_id) as total_patient,sum(t.cost) as total_cost,sum(b.amount) as total_billed
from patients p
join appointments a on p.patient_id = a.patient_id
join treatments t on a.appointment_id = t.appointment_id
join billing b on b.treatment_id = t.treatment_id
group by p.insurance_provider; 


-- WINDOWS FUNCTION
-- Find the billing amount and running total of bill amounts for each patient (ordered by bill date)	
    
select b.patient_id,
    p.first_name,
    b.bill_date,
    b.amount,
    sum(b.amount) over (partition by b.patient_id order by b.bill_date) as running_total
    from billing b
    join patients p on b.patient_id = p.patient_id;
    
-- Rank doctors based on years of experience within each specialization

select  doctor_id,
    first_name,
    last_name,
    specialization,
    years_experience,
    rank() over (partition by specialization order by years_experience desc) as experience_rank
    from doctors;
    
-- For each patient, find the date of their latest appointment
select * from (select 
	p.patient_id,p.first_name,a.appointment_date,
	ROW_NUMBER() OVER (PARTITION BY p.patient_id ORDER BY a.appointment_date DESC) AS rn
    FROM patients p
    JOIN appointments a ON p.patient_id = a.patient_id
) AS ranked
WHERE rn = 1;

-- List all treatments with cost and average cost per treatment type

SELECT 
    treatment_type,
    description,
    cost,
    AVG(cost) OVER (PARTITION BY treatment_type) AS avg_cost_by_type
FROM treatments;

-- Show billing records with total amount billed and payment count per payment method

SELECT 
    payment_method,
    amount,
    SUM(amount) OVER (PARTITION BY payment_method) AS total_by_method,
    COUNT(*) OVER (PARTITION BY payment_method) AS count_by_method
FROM billing;

-- SQL CASE EXPRESSION
-- SIMPLE CASE SYNTAX
CASE column_name
  WHEN value1 THEN result1
  WHEN value2 THEN result2
  ...
  ELSE default_result
END

-- SEARCHED CASE
CASE 
  WHEN condition1 THEN result1
  WHEN condition2 THEN result2
  ...
  ELSE default_result
END

-- SIMPLE CASE
-- Display each appointment's ID and a simplified label:
-- 'Done' if status is 'Completed'
-- 'Not Done' if status is 'Cancelled'
-- 'Upcoming' if status is 'Scheduled'
-- 'Other' for all other cases

SELECT 
    appointment_id,
    status,
    CASE status
        WHEN 'Completed' THEN 'Done'
        WHEN 'Cancelled' THEN 'Not Done'
        WHEN 'Scheduled' THEN 'Upcoming'
        ELSE 'Other'
    END AS status_label
FROM appointments;

-- Show each bill’s ID and label the payment method as:
-- 'Card' for 'Credit Card' or 'Debit Card'
-- 'Cash' for 'Cash'
-- 'Other' for all else

select
	bill_id,
    payment_method,
    case payment_method
		when 'Credit Card' then 'Card'
        when 'Debit Card' then 'Card'
        when 'Cash' then 'Cash'
        else 'Other'
	end as payment_group
from billing;

--  List doctor names and rename branches as:
-- 'CH' for 'Central Hospital'
-- 'WC' for 'Westside Clinic'
-- 'EC' for 'Eastside Clinic'
-- 'Other' otherwise
    
select 
	first_name,
    last_name,
    hospital_branch,
    case hospital_branch
		when 'Central Hospital' then 'CH'
        when 'Westside Clinic' then 'WC'
        when 'Eastside Clinic' then 'EC'
        else 'Other'
	end as branch_code
from doctors;

-- Show patient names and display full form of gender:
-- 'Male' for 'M'
-- 'Female' for 'F'
-- 'Other' otherwise

select 
	first_name,
    last_name,
    gender,
    case gender
		when 'M' then 'Male'
        when 'F' then 'Female'
        else 'Other'
	end as gender_full_form
from patients;

--  Classify insurance providers as:
-- 'Private' for 'Aetna', 'Cigna', 'UnitedHealthcare'
-- 'Government' for 'Medicare' or 'Medicaid'
-- 'Uninsured' for NULL values
-- 'Other' for all else
        
select 
	first_name,
    last_name,
    insurance_provider,
    case  insurance_provider
		when 'Aetna' then 'Private'
		when 'Cigna' then 'Private'
        when 'UnitedHealthcare' then 'Private'
        when 'Medicare' then 'Goverment'
        when 'Medicaid' then 'Goverment'
        when Null then 'Uninsured'
        else 'Other'
	end as insurance_group
from patients;

-- SEARCHED CASE
-- List doctor names and categorize their experience as:
-- 'Junior' if < 5 years
-- 'Mid-Level' if between 5 and 15
-- 'Senior' if > 15 years

select 
	first_name,
    last_name,
    years_experience,
    case 
		when years_experience < 5 then 'Junior'
        when years_experience between 5 and 15 then 'Mid-Level'
        else 'Senior'
	end as experience_level
from doctors;

-- Show treatment type, cost, and a label:
-- 'Low' if cost < 2000
-- 'Medium' if cost between 2000 and 5000
-- 'High' if cost > 5000
	
select 
	treatment_type,
    cost,
    case
		when cost < 2000 then 'Low'
		when cost between 2000 and 5000 then 'Medium'
        else 'High'
	end as cost_category
from treatments;

-- List bill ID, patient ID, amount, and a flag:
-- 'Paid' if payment_status = 'Paid'
-- 'Unpaid' otherwise

select 
	bill_id,
    patient_id,
    amount,
    case
		when payment_status = 'Paid 'then 'Paid'
        else 'Unpaid'
	end as payment_flag
from billing;

-- Show patient names and a column:
-- 'Insured' if insurance_provider is not null
-- 'Not Insured' otherwise
   
select 
	first_name,
    last_name,
    insurance_provider,
    case
		when insurance_provider is not null then 'Insured'
        else 'Not Insured'
	end as insurance_status
from patients;

-- Show each patient’s name and classify them as:
-- 'Child' if age < 13
-- 'Teen' if age between 13 and 19
-- 'Adult' if between 20 and 59
-- 'Senior' if 60 or older

select 
	first_name,
    last_name,
    CalculateAge(date_of_birth) AS age,
    case
		when CalculateAge(date_of_birth) < 13 then 'Child'
        when CalculateAge(date_of_birth) between 13 and 19 then 'Teen'
        when CalculateAge(date_of_birth) between 20 and 59 then 'Adult'
        else 'Senior'
	end as age_group
from patients;

-- Show patient names and total billed amount with a flag:
-- 'High Value' if total > 10,000
-- 'Regular' otherwise

select
	first_name,
    last_name,
    sum(b.amount) as total_billed_amount,
    case
		when sum(b.amount) > 10000 then 'High value'
        else 'Regular'
	end as billing_category
from patients p
join billing b on p.patient_id = b.patient_id
group by first_name,last_name;

-- Show appointment ID, time, and period of day:
-- 'Morning' if before 12 PM
-- 'Afternoon' if between 12 PM–5 PM
-- 'Evening' otherwise

select
	appointment_id,
    appointment_time,
    case
		when hour(appointment_time) < 12 then 'Morning'
        when hour(appointment_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
	end as time_of_day
from appointments;

-- Show treatment type, cost, and billing priority:
-- 'High Priority' if cost > 5000 and treatment type is 'Surgery'
-- 'Medium Priority' if cost between 3000–5000
-- 'Low Priority' otherwise
    
select 
	treatment_type,
    cost,
    case
		when cost > 5000 and treatment_type = 'Surgery' then"High Priority"
        when cost between 3000 and 5000 then "Medium Priority"
        else 'Low Priority'
	end as billing_priority
from treatments;

-- List all patients with:
-- 'Missing Email' if email is NULL
-- Has Email' otherwise
    
select 
	first_name,
    last_name,
    email,
    case
		when email is null then 'Missing Email'
        else 'Has Email'
	end as email_status
from patients;