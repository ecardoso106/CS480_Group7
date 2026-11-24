-- schema.sql: Kidris Law Offices database (CS 480, Team 7)
-- Run on a clean MySQL 8 server:  mysql < schema.sql ; mysql < data.sql
-- 9 tables = 7 entity sets + 2 M:N relationships (1:N relationships add no tables)

DROP SCHEMA IF EXISTS group_7;
CREATE SCHEMA group_7;
USE group_7;

-- ---------------------------------------------------------------
-- Entity: Lawyer (R1) 
-- DONE BY: Kike
-- ---------------------------------------------------------------
CREATE TABLE lawyer (
  lawyer_id     INT          NOT NULL,
  name          VARCHAR(60)  NOT NULL,
  phone_number  VARCHAR(20)  NOT NULL,
  email         VARCHAR(100) NOT NULL,
  lawyer_type   VARCHAR(20)  NOT NULL,
  PRIMARY KEY (lawyer_id),
  UNIQUE (email),
  CONSTRAINT chk_lawyer_type CHECK (lawyer_type IN ('In-house', 'Outsourced'))
);

-- ---------------------------------------------------------------
-- Law Practice Area (R2): 1:N from Lawyer; one row per lawyer per practice area
-- ON DELETE CASCADE: practice areas have no meaning without their lawyer
-- DONE BY: Kike
-- ---------------------------------------------------------------
CREATE TABLE law_practice_area (
  lawyer_id      INT         NOT NULL,
  practice_area  VARCHAR(30) NOT NULL,
  PRIMARY KEY (lawyer_id, practice_area),
  CONSTRAINT fk_lpa_lawyer FOREIGN KEY (lawyer_id) REFERENCES lawyer (lawyer_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT chk_practice_area CHECK (practice_area IN ('Personal Injury', 'Immigration'))
);

-- ---------------------------------------------------------------
-- Entity: Client (R3)
-- DONE BY: Kaitlyn, Modified by: Elizabeth
-- ---------------------------------------------------------------
CREATE TABLE client (
  client_id  INT          NOT NULL,
  name       VARCHAR(60)  NOT NULL,
  email      VARCHAR(100),
  PRIMARY KEY (client_id)
);

-- ---------------------------------------------------------------
-- Client Phone Numbers (R3): 1:N from Client; one row per client per phone number
-- ON DELETE CASCADE: phone numbers have no meaning without their client
-- DONE BY: Kaitlyn, Modified by: Elizabeth
-- ---------------------------------------------------------------
CREATE TABLE client_phone_numbers (
  client_id     INT         NOT NULL,
  phone_number  VARCHAR(20) NOT NULL,
  PRIMARY KEY (client_id, phone_number),
  CONSTRAINT fk_phone_client FOREIGN KEY (client_id) REFERENCES client (client_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ---------------------------------------------------------------
-- Entity: Case (R4)
-- DONE BY: Aiden, Modified by: Elizabeth
-- ---------------------------------------------------------------
CREATE TABLE cases (
  case_number     INT           NOT NULL,
  case_type       VARCHAR(20)   NOT NULL,
  open_date       DATE          NOT NULL,                       -- C5
  closed_date     DATE,
  status          VARCHAR(10)   NOT NULL,
  total_fee       DECIMAL(10,2) NOT NULL,
  receipt_number  VARCHAR(20),
  PRIMARY KEY (case_number),
  CONSTRAINT chk_case_type   CHECK (case_type IN ('Personal Injury', 'Immigration')),
  CONSTRAINT chk_case_status CHECK (status IN ('Open', 'Pending', 'Approved', 'Denied', 'Closed')),   -- C9
  CONSTRAINT chk_closed_date CHECK (                                                                  -- C5
      (status = 'Closed'  AND closed_date IS NOT NULL AND closed_date >= open_date)
   OR (status <> 'Closed' AND closed_date IS NULL)),
  CONSTRAINT chk_receipt     CHECK (receipt_number IS NULL OR case_type = 'Immigration'),            -- C14
  CONSTRAINT chk_total_fee   CHECK (total_fee >= 0)
);

-- ---------------------------------------------------------------
-- M:N relationship: Involved In (Client - Case), attribute role (R7, C1, C3, C13)
-- ON DELETE RESTRICT: records are kept permanently (C11, C12)
-- DONE BY: Elizabeth
-- ---------------------------------------------------------------
CREATE TABLE case_client (
  case_number  INT         NOT NULL,
  client_id    INT         NOT NULL,
  role         VARCHAR(25) NOT NULL,
  PRIMARY KEY (case_number, client_id),
  CONSTRAINT fk_cc_case   FOREIGN KEY (case_number) REFERENCES cases (case_number)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_cc_client FOREIGN KEY (client_id) REFERENCES client (client_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT chk_role CHECK (role IN ('Principal Applicant', 'Beneficiary', 'Injured Party'))
);

-- ---------------------------------------------------------------
-- M:N relationship: Assigned (Lawyer - Case), attribute date_assigned (R8, C2, C4)
-- DONE BY: Elizabeth
-- ---------------------------------------------------------------
CREATE TABLE case_lawyer (
  case_number    INT  NOT NULL,
  lawyer_id      INT  NOT NULL,
  date_assigned  DATE NOT NULL,
  PRIMARY KEY (case_number, lawyer_id),
  CONSTRAINT fk_cl_case   FOREIGN KEY (case_number) REFERENCES cases (case_number)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_cl_lawyer FOREIGN KEY (lawyer_id) REFERENCES lawyer (lawyer_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ---------------------------------------------------------------
-- Entity: Payment (R5), with 1:N Receives (Case) and 1:N Makes (Client) (C6, C7)
-- DONE BY: Elizabeth
-- ---------------------------------------------------------------
CREATE TABLE payment (
  payment_number  INT           NOT NULL,
  case_number     INT           NOT NULL,                       -- exactly one case (C6)
  client_id       INT           NOT NULL,                       -- exactly one client (C6)
  amount          DECIMAL(10,2) NOT NULL,
  payment_date    DATE          NOT NULL,
  PRIMARY KEY (payment_number),
  CONSTRAINT fk_pay_case   FOREIGN KEY (case_number) REFERENCES cases (case_number)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_pay_client FOREIGN KEY (client_id) REFERENCES client (client_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT chk_amount CHECK (amount > 0)                      -- C7
);

-- ---------------------------------------------------------------
-- Entity: Document (R6), with 1:N Has (Case) (C8, C10)
-- DONE BY: Aiden, Modified by: Elizabeth
-- ---------------------------------------------------------------
CREATE TABLE document (
  document_id      INT          NOT NULL,
  name             VARCHAR(100) NOT NULL,
  document_type    VARCHAR(45)  NOT NULL,
  document_source  VARCHAR(100) NOT NULL,
  upload_date      DATE         NOT NULL,
  case_number      INT          NOT NULL,                       -- exactly one case (C8)
  PRIMARY KEY (document_id),
  CONSTRAINT fk_doc_case FOREIGN KEY (case_number) REFERENCES cases (case_number)
    ON DELETE RESTRICT ON UPDATE CASCADE
);