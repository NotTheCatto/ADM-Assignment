PROMPT Creating table Fine

CREATE TABLE Fine(
  FineID	  NUMBER(4)     NOT NULL,
  LoanID	  NUMBER(4)     NOT NULL,
  StatusCode	  NUMBER(4)     NOT NULL,
  FineAmount	  NUMBER(8,2)     NOT NULL,
  FineDate	  DATE		NOT NULL,
  PRIMARY KEY (FineID),
  FOREIGN KEY (LoanID) REFERENCES Loan (LoanID),
  FOREIGN KEY (StatusCode) REFERENCES StatusCode (StatusCode)
);
