PROMPT Creating table Loan

CREATE TABLE Loan(
  LoanID NUMBER(4) NOT NULL,
  BorrowerID NUMBER(4) NOT NULL,
  BookCopyID NUMBER(4) NOT NULL,
  LoanProcessedByStaffID  NUMBER(4) NOT NULL,
  ReturnProcessedByStaffID  NUMBER(4),  
  LoanDate DATE DEFAULT SYSDATE NOT NULL,
  DueDate DATE DEFAULT (SYSDATE + 7) NOT NULL,
  ReturnDate DATE,
  PRIMARY KEY (LoanID),
  FOREIGN KEY (BorrowerID) REFERENCES Borrower (BorrowerID),
  FOREIGN KEY (BookCopyID) REFERENCES BookCopy (BookCopyID),
  FOREIGN KEY (LoanProcessedByStaffID) REFERENCES Staff (StaffID),
  FOREIGN KEY (ReturnProcessedByStaffID) REFERENCES Staff (StaffID)
);

