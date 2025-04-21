PROMPT Creating table Invoice

CREATE TABLE Invoice (
  InvoiceID NUMBER(4) NOT NULL,
  FineID NUMBER(4),
  MembershipID NUMBER(4),
  InvoiceDate DATE DEFAULT SYSDATE NOT NULL,
  InvoiceAmount NUMBER(8,2) NOT NULL CHECK (InvoiceAmount >= 0),
  PRIMARY KEY (InvoiceID),
  FOREIGN KEY (FineID) REFERENCES Fine (FineID),
  FOREIGN KEY (MembershipID) REFERENCES Membership (MembershipID),
  CONSTRAINT chk_invoice_type
    CHECK ( 
       (FineID IS NOT NULL AND MembershipID IS NULL) 
    OR (FineID IS NULL AND MembershipID IS NOT NULL)
    )
);
