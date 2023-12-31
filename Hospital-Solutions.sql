--// SQL Practice Questions using database 'patients', 'admissions', 'doctors', and 'province_names' //

--Show first name, last name, and gender of patients whose gender is 'M'

SELECT first_name, last_name, gender
FROM patients
WHERE Gender = 'M'



--Show first name and last name of patients who does not have allergies. (null)

SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL



--Show first name of patients that start with the letter 'C'

SELECT first_name 
FROM patients
WHERE first_name LIKE 'c%'



--Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120



--Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL



--Show first name and last name concatinated into one column to show their full name.

Select concat(first_name, ' ', last_name)
FROM patients



--Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'

SELECT first_name, last_name, province_names.province_name
FROM patients
Inner join province_names
ON patients.province_id = province_names.province_id



--Show how many patients have a birth_date with 2010 as the birth year.

select count(patient_id)
From patients
Where birth_date like '%2010%'



--Show the first_name, last_name, and height of the patient with the greatest height.

Select first_name, last_name, MAX(height) as Height
FROM patients



--Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000

Select *
From patients
WHere patient_id IN (1,45,534,879,1000)



--Show the total number of admissions

Select COUNT(patient_id)
FROM admissions



--Show all the columns from admissions where the patient was admitted and discharged on the same day.

Select *
From admissions
Where admission_date = discharge_date



--Show the patient id and the total number of admissions for patient_id 579.

Select patient_id, COUNT(admission_date)
FROM admissions
Where patient_id = '579'



--Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

Select distinct City
FROM patients
Where province_id = 'NS'



--Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

Select first_name, last_name, birth_date
From patients
Where height > 160 AND weight > 70



--Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null\

select first_name, last_name, allergies
FROM patients
Where city = 'Hamilton' AND allergies IS NOT NULL



--Show unique birth years from patients and order them by ascending.
Select Distinct YEAR(birth_date)
FROM patients
Order by birth_date ASC



--Show unique first names from the patients table which only occurs once in the list. For example, 
if two or more people are named 'John' in the first_name column then don't include their name in the 
output list. If only 1 person is named 'Leo' then include them in the output.

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1



--Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. 

Select patients.patient_id, first_name, last_name
From patients
Inner join admissions
ON patients.patient_id = admissions.patient_id
Where diagnosis Like 'Dementia'



--Show first and last name, allergies from patients which have allergies to either 'Penicillin' 
or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

Select first_name, last_name, allergies
From patients
Where allergies in ('Penicillin', 'Morphine')
Order by allergies, first_name, last_name ASC



--Show the city and the total number of patients in the city. Order from most to least 
patients and then by city name ascending.

Select city, COUNT(*) 
From patients
Group by city
order by COUNT(*) DESC, city ASc



--Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"

SELECT first_name, last_name, 'Patient' as role 
FROM patients
    Union all
select first_name, last_name, 'Doctor' AS role
from doctors;



--Show all allergies ordered by popularity. Remove NULL values from query.

Select allergies, COUNT(*) as numofallergies
FROM patients
WHERE allergies IS NOT NULL
group by allergies
Order by numofallergies DESC



--Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

Select first_name, last_name, birth_date
From patients
Where birth_date Like '197%'
order by birth_date
