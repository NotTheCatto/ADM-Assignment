PROMPT Creating table PerformanceReview

CREATE TABLE PerformanceReview(
  ReviewID	NUMBER(4)	NOT NULL,
  StaffID	NUMBER(4)	NOT NULL,
  ReviewerID	NUMBER(4)	NOT NULL,
  ReviewDate	VARCHAR(20)	NOT NULL,
  ReviewScore	VARCHAR(20)	NOT NULL,
  ReviewComment	VARCHAR(20)	NOT NULL,
  PRIMARY KEY (ReviewID),
  FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
  FOREIGN KEY (ReviewerID) REFERENCES Staff (StaffID)
);
