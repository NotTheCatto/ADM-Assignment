PROMPT Creating table Membership

CREATE TABLE Membership(
  MembershipID NUMBER(4) NOT NULL,
  BorrowerID NUMBER(4) NOT NULL,
  MembershipTypeID NUMBER(4) DEFAULT 1 NOT NULL
    CHECK (MembershipTypeID IN (1, 2, 3)),
  StatusCode NUMBER(4) DEFAULT 6 NOT NULL
    CHECK (StatusCode IN (6, 7)),
  MembershipStartDate DATE DEFAULT SYSDATE NOT NULL,
  MembershipEndDate DATE DEFAULT (SYSDATE + 90) NOT NULL,
  PRIMARY KEY (MembershipID),
  FOREIGN KEY (BorrowerID) REFERENCES Borrower (BorrowerID),
  FOREIGN KEY (MembershipTypeID) REFERENCES MembershipType (MembershipTypeID),
  FOREIGN KEY (StatusCode) REFERENCES StatusCode (StatusCode)
);
