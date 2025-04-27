PROMPT Creating table StaffPerformanceReview

CREATE TABLE StaffPerformanceReview(
  ReviewID NUMBER(4) NOT NULL,
  StaffID NUMBER(4) NOT NULL,
  ReviewerID NUMBER(4) NOT NULL,
  ReviewDate DATE DEFAULT SYSDATE NOT NULL,
  ReviewScore NUMBER(3) NOT NULL CHECK (ReviewScore BETWEEN 0 AND 100),
  PRIMARY KEY (ReviewID),
  FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
  FOREIGN KEY (ReviewerID) REFERENCES Staff (StaffID),
  CHECK (ReviewerID <> StaffID)
);

CREATE INDEX idx_staffperformancereview_reviewscore ON StaffPerformanceReview(ReviewScore);
