PROMPT Creating table Borrower

CREATE TABLE Borrower(
  BorrowerID	    NUMBER(4)     NOT NULL,
  MembershipID	    NUMBER(4)     NOT NULL,
  AddressID	    NUMBER(4)     NOT NULL,
  ContactID 	    NUMBER(4)     NOT NULL,
  BorrowerFirstName NUMBER(4)     NOT NULL,
  BorrowerLastName  VARCHAR2(700) NOT NULL,
  PRIMARY KEY (BookID),
  FOREIGN KEY (MembershipID) REFERENCES Membership (MembershipID),
  FOREIGN KEY (AddressID) REFERENCES Address (AddressID),
  FOREIGN KEY (ContactID) REFERENCES Contact (ContactID)
);
