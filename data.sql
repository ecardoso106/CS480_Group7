-- data.sql: sample data for group_7 (run after schema.sql)
USE group_7;

-- lawyer
INSERT INTO lawyer (lawyer_id, name, email, lawyer_type) VALUES
  (1, 'Kayode Idris', 'kidrislaw@yahoo.com', 'In-house'),
  (2, 'Elizabeth Cardoso', 'ecard6@uic.edu', 'Outsourced'),
  (3, 'Kaitlyn Aquino', 'kaqui@uic.edu', 'In-house'),
  (4, 'Aiden Pina', 'apina7@uic.edu', 'Outsourced'),
  (5, 'Victoria Vega', 'vvega@uic.edu', 'Outsourced'),
  (6, 'Holly Robles', 'hrobl23@uic.edu', 'In-house'),
  (7, 'Kike Idris', 'kidri2@uic.edu', 'In-house'),
  (8, 'Katy Perry', 'kperry@gmail.com', 'Outsourced'),
  (9, 'Khloe Kardashian', 'kkardas@hotmail.com', 'In-house'),
  (10, 'Michael Jordan', 'mjordan@yahoo.com', 'In-house'),
  (11, 'Jane Doe', 'jdoe@gmail.com', 'In-house'),
  (12, 'John Doe', 'jhdoe@yahoo.com', 'In-house'),
  (13, 'Christopher Nolan', 'chnolan@hotmail.com', 'Outsourced'),
  (14, 'Will Smith', 'willsmith@gmail.com', 'In-house'),
  (15, 'Beyonce Knowles', 'bknowles@yahoo.com', 'In-house'),
  (16, 'Solana Rowe', 'srowe@yahoo.com', 'In-house'),
  (17, 'Willow Smith', 'wsmith@yahoo.com', 'Outsourced'),
  (18, 'Rayvn Lenae', 'rlenae@gmail.com', 'In-house'),
  (19, 'Ariana Grande', 'agrande@hotmail.com', 'Outsourced'),
  (20, 'Serena William', 'swilliam@hotmail.com', 'In-house');

-- lawyer_practice_area: multivalued {Practice Area} (R2)
INSERT INTO lawyer_practice_area (lawyer_id, practice_area) VALUES
  (1, 'Immigration'),
  (1, 'Personal Injury'),
  (2, 'Immigration'),
  (3, 'Immigration'),
  (3, 'Personal Injury'),
  (4, 'Personal Injury'),
  (5, 'Immigration'),
  (6, 'Immigration'),
  (7, 'Personal Injury'),
  (7, 'Immigration'),
  (8, 'Personal Injury'),
  (9, 'Immigration'),
  (10, 'Immigration'),
  (10, 'Personal Injury'),
  (11, 'Personal Injury'),
  (12, 'Personal Injury'),
  (13, 'Immigration'),
  (14, 'Personal Injury'),
  (15, 'Personal Injury'),
  (16, 'Immigration'),
  (16, 'Personal Injury'),
  (17, 'Personal Injury'),
  (18, 'Immigration'),
  (18, 'Personal Injury');

-- cases
INSERT INTO cases (case_number, case_type, open_date, closed_date, status, total_fee, receipt_number) VALUES
  (1001, 'Immigration', '2026-01-10', NULL, 'Open', 3500.00, 'IOE1234567890'),
  (1002, 'Personal Injury', '2026-02-15', NULL, 'Pending', 5000.00, NULL),
  (1003, 'Immigration', '2026-03-01', NULL, 'Approved', 2500.00, 'IOE9876543210'),
  (1004, 'Personal Injury', '2026-03-20', '2026-06-15', 'Closed', 7000.00, NULL),
  (1005, 'Immigration', '2026-04-05', NULL, 'Pending', 4000.00, 'IOE1122334455'),
  (1006, 'Personal Injury', '2026-05-12', NULL, 'Open', 6000.00, NULL),
  (1007, 'Immigration', '2026-06-18', '2026-09-10', 'Closed', 3000.00, 'IOE5566778899'),
  (1008, 'Personal Injury', '2026-07-22', NULL, 'Open', 4500.00, NULL);

-- document
INSERT INTO document (document_id, name, document_type, document_source, upload_date, case_number) VALUES
  (101, 'Visa Petition', 'Immigration Form', 'Client', '2026-01-12', 1001),
  (102, 'Passport Copy', 'Identification', 'Client', '2026-01-15', 1001),
  (103, 'Medical Bill', 'Medical Record', 'Hospital', '2026-02-17', 1002),
  (104, 'Accident Report', 'Police Report', 'Police Department', '2026-02-20', 1002),
  (105, 'Citizenship Application', 'Immigration Form', 'Client', '2026-03-05', 1003),
  (106, 'Medical Records', 'Medical Record', 'Hospital', '2026-03-22', 1004),
  (107, 'Insurance Claim', 'Insurance Document', 'Insurance Company', '2026-03-25', 1004),
  (108, 'Visa Application', 'Immigration Form', 'Client', '2026-04-07', 1005),
  (109, 'Medical Bill', 'Medical Record', 'Hospital', '2026-05-15', 1006),
  (110, 'Accident Photos', 'Evidence', 'Client', '2026-05-16', 1006),
  (111, 'Approval Notice', 'Government Notice', 'USCIS', '2026-06-20', 1007),
  (112, 'Police Report', 'Police Report', 'Police Department', '2026-07-25', 1008);