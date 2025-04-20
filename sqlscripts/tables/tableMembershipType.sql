PROMPT Creating table MembershipType

CREATE TABLE MembershipType(
  MembershipTypeID NUMBER(4) NOT NULL,
  MembershipName VARCHAR2(10) NOT NULL,
  MembershipDescription VARCHAR2(200) NOT NULL,
  MembershipAmount NUMBER(8,2) NOT NULL CHECK (MembershipAmount >= 0),
  PRIMARY KEY (MembershipTypeID)
);

