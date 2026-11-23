-- queries.sql: team queries so far (run after schema.sql and data.sql)
USE group_7;

-- All lawyers, and how many there are
SELECT * FROM lawyer;
SELECT COUNT(*) FROM lawyer;

-- In-house lawyers
SELECT name AS 'In-House Lawyers'
FROM lawyer
WHERE lawyer_type = 'In-house';

-- Outsourced lawyers
SELECT name AS 'Outsourced Lawyers'
FROM lawyer
WHERE lawyer_type = 'Outsourced';

-- Emails of in-house lawyers
SELECT email AS 'Emails of In-House Lawyers'
FROM lawyer
WHERE lawyer_type = 'In-house';

-- Lawyers with a yahoo.com email
SELECT name, email
FROM lawyer
WHERE email LIKE '%@yahoo.com';

-- All practice areas
SELECT * FROM lawyer_practice_area;

-- Number of immigration lawyers
SELECT COUNT(*) AS 'Total Number of Immigration Lawyers'
FROM lawyer_practice_area
WHERE practice_area = 'Immigration';

-- Number of personal injury lawyers
SELECT COUNT(*) AS 'Total Number of Personal Injury Lawyers'
FROM lawyer_practice_area
WHERE practice_area = 'Personal Injury';

-- Every lawyer with email and practice area
SELECT lawyer.name AS Name, lawyer.email AS Email, lawyer_practice_area.practice_area AS 'Practice Area'
FROM lawyer_practice_area
JOIN lawyer ON lawyer_practice_area.lawyer_id = lawyer.lawyer_id;

-- Personal injury lawyers with email
SELECT lawyer.name AS Name, lawyer.email AS Email
FROM lawyer_practice_area
JOIN lawyer ON lawyer_practice_area.lawyer_id = lawyer.lawyer_id
WHERE lawyer_practice_area.practice_area = 'Personal Injury';

-- In-house personal injury lawyers
SELECT lawyer.name AS 'In-House Personal Injury Lawyers'
FROM lawyer_practice_area
JOIN lawyer ON lawyer_practice_area.lawyer_id = lawyer.lawyer_id
WHERE lawyer_practice_area.practice_area = 'Personal Injury'
  AND lawyer.lawyer_type = 'In-house';

-- All cases and documents
SELECT * FROM cases;
SELECT * FROM document;

-- Q1: All open cases
SELECT case_number, case_type, open_date
FROM cases
WHERE status = 'Open';

-- Q2: Number of cases of each type
SELECT case_type, COUNT(*) AS total_cases
FROM cases
GROUP BY case_type;

-- Q3: Documents for each case
SELECT cases.case_number,
       cases.case_type,
       document.name AS document_name,
       document.document_type
FROM cases
JOIN document ON cases.case_number = document.case_number;

-- Q4: Number of documents in each case (D1 QR5)
SELECT cases.case_number,
       COUNT(document.document_id) AS document_count
FROM cases
LEFT JOIN document ON cases.case_number = document.case_number
GROUP BY cases.case_number;

-- Q5: All immigration cases
SELECT case_number, case_type, status
FROM cases
WHERE case_type = 'Immigration';