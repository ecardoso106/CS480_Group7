-- schema.sql: Kidris Law Offices database (CS 480, Team 7)
-- Run on a clean MySQL 8 server:  mysql < schema.sql ; mysql < data.sql
-- Tables so far: lawyer, lawyer_practice_area, cases, document

DROP SCHEMA IF EXISTS group_7;
CREATE SCHEMA group_7;
USE group_7;

-- ---------------------------------------------------------------
-- Entity: Lawyer (R1)
-- ---------------------------------------------------------------
CREATE TABLE lawyer (
  lawyer_id     INT          NOT NULL,
  name          VARCHAR(60)  NOT NULL,
  email         VARCHAR(100) NOT NULL,
  lawyer_type   VARCHAR(20)  NOT NULL,
  PRIMARY KEY (lawyer_id),
  UNIQUE (email),
  CONSTRAINT chk_lawyer_type CHECK (lawyer_type IN ('In-house', 'Outsourced'))
);

-- ---------------------------------------------------------------
-- Multivalued attribute: Lawyer {Practice Area} (R2)
-- ON DELETE CASCADE: practice areas have no meaning without their lawyer
-- ---------------------------------------------------------------
CREATE TABLE lawyer_practice_area (
  lawyer_id      INT         NOT NULL,
  practice_area  VARCHAR(30) NOT NULL,
  PRIMARY KEY (lawyer_id, practice_area),
  CONSTRAINT fk_lpa_lawyer FOREIGN KEY (lawyer_id) REFERENCES lawyer (lawyer_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT chk_practice_area CHECK (practice_area IN ('Personal Injury', 'Immigration'))
);

-- ---------------------------------------------------------------
-- Entity: Case (R4)
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
-- Entity: Document (R6), with 1:N Has (Case) (C8, C10)
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