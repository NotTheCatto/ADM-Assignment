PROMPT Creating table StaffShiftSchedule

CREATE TABLE StaffShiftSchedule(
  ShiftID NUMBER(4)	NOT NULL,
  StaffID NUMBER(4)	NOT NULL,
  LibraryBranchID NUMBER(4)	NOT NULL,
  ShiftTypeID NUMBER(4) NOT NULL,
  PRIMARY KEY (ShiftID),
  FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
  FOREIGN KEY (LibraryBranchID) REFERENCES LibraryBranch (LibraryBranchID),
  FOREIGN KEY (ShiftTypeID) REFERENCES ShiftType (ShiftTypeID)
);

