PROMPT Creating table ShiftSchedule

CREATE TABLE ShiftSchedule(
  ShiftID	  NUMBER(4)	NOT NULL,
  StaffID	  NUMBER(4)	NOT NULL,
  LibraryBranchID NUMBER(4)	NOT NULL,
  ShiftTypeID	  NUMBER(4)	NOT NULL,
  ShiftDate	  DATE		NOT NULL,
  ShiftStartTime  TIMESTAMP	NOT NULL,
  ShiftEndTime    TIMESTAMP	NOT NULL,
  PRIMARY KEY (ShiftID),
  FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
  FOREIGN KEY (LibraryBranchID) REFERENCES LibraryBranch (LibraryBranchID),
  FOREIGN KEY (ShiftTypeID) REFERENCES ShiftType (ShiftTypeID)
);
