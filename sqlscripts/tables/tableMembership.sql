PROMPT Creating table Membership

CREATE TABLE Membership(
  MembershipID NUMBER(4) NOT NULL,
  MembershipTypeID NUMBER(4) NOT NULL,
  StatusCode NUMBER(4) NOT NULL,
  MembershipStartDate DATE DEFAULT SYSDATE NOT NULL,
  MembershipEndDate DATE NOT NULL,
  PRIMARY KEY (MembershipID),
  FOREIGN KEY (MembershipTypeID) REFERENCES MembershipType (MembershipTypeID),
  FOREIGN KEY (StatusCode) REFERENCES StatusCode (StatusCode)
);

