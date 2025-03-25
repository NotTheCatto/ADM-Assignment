PROMPT Creating table PerformanceReview

CREATE TABLE PerformanceReview(
  ReviewID	NUMBER(4)	NOT NULL,
  StaffID	NUMBER(4)	NOT NULL,
  ReviewerID	NUMBER(4)	NOT NULL,
  ReviewDate	DATE		NOT NULL,
  ReviewScore	NUMBER(3)	NOT NULL,
  ReviewComment	VARCHAR2(700)	NOT NULL,
  PRIMARY KEY (ReviewID),
  FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
  FOREIGN KEY (ReviewerID) REFERENCES Staff (StaffID)
);
