PROMPT Creating table Borrower

CREATE TABLE Borrower(
  BorrowerID	    NUMBER(4)     NOT NULL,
  MembershipID	    NUMBER(4),
  AddressID	    NUMBER(4)     NOT NULL,
  ContactID 	    NUMBER(4)     NOT NULL,
  BorrowerFirstName VARCHAR2(20)  NOT NULL,
  BorrowerLastName  VARCHAR2(20)  NOT NULL,
  PRIMARY KEY (BorrowerID),
  FOREIGN KEY (MembershipID) REFERENCES Membership (MembershipID),
  FOREIGN KEY (AddressID) REFERENCES Address (AddressID),
  FOREIGN KEY (ContactID) REFERENCES Contact (ContactID)
);
