PROMPT Creating table Loan

CREATE TABLE Loan(
  LoanID              NUMBER(4)     NOT NULL,
  BorrowerID	      NUMBER(4)     NOT NULL,
  BookCopyID	      NUMBER(4)     NOT NULL,
  ProcessedByStaffID  VARCHAR2(20)  NOT NULL,
  LoanDate            VARCHAR2(20)  NOT NULL,
  DueDate             VARCHAR2(20)  NOT NULL,
  ReturnDate          VARCHAR2(20)  NOT NULL,
  PRIMARY KEY (LoanID),
  FOREIGN KEY (BorrowerID) REFERENCES Borrower (BorrowerID),
  FOREIGN KEY (BookCopyID) REFERENCES BookCopy (BookCopyID)
  FOREIGN KEY (ProcessedByStaffID) REFERENCES Loan (ProcessedByStaffID)
);
