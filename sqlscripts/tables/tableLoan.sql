PROMPT Creating table Loan

CREATE TABLE Loan(
  LoanID              NUMBER(4)     NOT NULL,
  BorrowerID	      NUMBER(4)     NOT NULL,
  BookCopyID	      NUMBER(4)     NOT NULL,
  ProcessedByStaffID  NUMBER(4)	    NOT NULL, -- Do we need another field for separating staff when loaning and returning?
  LoanDate            DATE	    NOT NULL,
  DueDate             DATE	    NOT NULL,
  ReturnDate          DATE,
  PRIMARY KEY (LoanID),
  FOREIGN KEY (BorrowerID) REFERENCES Borrower (BorrowerID),
  FOREIGN KEY (BookCopyID) REFERENCES BookCopy (BookCopyID)
  FOREIGN KEY (ProcessedByStaffID) REFERENCES Loan (ProcessedByStaffID)
);
