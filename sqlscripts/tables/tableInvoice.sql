PROMPT Creating table Invoice

CREATE TABLE Invoice(
  InvoiceID	  NUMBER(4)     NOT NULL,
  FineID	  NUMBER(4)     NOT NULL,
  MembershipID	  NUMBER(4)     NOT NULL, -- Should it be BorrwerID?
  InvoiceDate	  DATE		NOT NULL,
  InvoiceAmount	  NUMBER(8,2)   NOT NULL,
  PRIMARY KEY (InvoiceID),
  FOREIGN KEY (FineID) REFERENCES Fine (FineID),
  FOREIGN KEY (MembershipID) REFERENCES Membership (MembershipID)
);
