PROMPT Creating table ShiftSchedule

CREATE TABLE ShiftSchedule(
  ShiftID	  NUMBER(4)	NOT NULL,
  StaffID	  NUMBER(4)	NOT NULL,
  LibraryBranchID NUMBER(4)	NOT NULL,
  ShiftTypeID	  VARCHAR(20)	NOT NULL,
  ShiftDate	  VARCHAR(20)	NOT NULL,
  ShiftStartTime  VARCHAR(20)	NOT NULL,
  ShiftEndTime    VARCHAR(20)	NOT NULL,
  PRIMARY KEY (ShiftID),
  FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
  FOREIGN KEY (LibraryBranchID) REFERENCES LibraryBranch (LibraryBranchID),
  FOREIGN KEY (ShiftTypeID) REFERENCES ShiftType (ShiftTypeID)
);
