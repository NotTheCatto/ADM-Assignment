PROMPT Creating table Fine

CREATE TABLE Fine(
  FineID NUMBER(4) NOT NULL,
  LoanID NUMBER(4) NOT NULL,
  StatusCode NUMBER(4) DEFAULT 5 NOT NULL
    CHECK (StatusCode IN (4, 5)),
  FineAmount NUMBER(8,2) NOT NULL CHECK (FineAmount >= 0),
  FineDate DATE DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (FineID),
  FOREIGN KEY (LoanID) REFERENCES Loan (LoanID),
  FOREIGN KEY (StatusCode) REFERENCES StatusCode (StatusCode)
);

