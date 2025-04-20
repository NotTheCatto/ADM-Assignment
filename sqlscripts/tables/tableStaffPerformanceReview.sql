PROMPT Creating table StaffPerformanceReview

CREATE TABLE StaffPerformanceReview(
  ReviewID NUMBER(4) NOT NULL,
  StaffID NUMBER(4) NOT NULL,
  ReviewerID NUMBER(4) NOT NULL,
  ReviewDate DATE DEFAULT SYSDATE NOT NULL,
  ReviewScore NUMBER(3) NOT NULL CHECK (ReviewScore >= 0 AND ReviewScore <= 100),
  ReviewComment VARCHAR2(700) NOT NULL,
  PRIMARY KEY (ReviewID),
  FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
  FOREIGN KEY (ReviewerID) REFERENCES Staff (StaffID)
);

