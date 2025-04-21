PROMPT Creating table Borrower

CREATE TABLE Borrower(
  BorrowerID NUMBER(4) NOT NULL,
  AddressID NUMBER(4) NOT NULL,
  ContactID NUMBER(4) NOT NULL,
  BorrowerFirstName VARCHAR2(20) NOT NULL,
  BorrowerLastName VARCHAR2(20) NOT NULL,
  BorrowerGender CHAR(1) NOT NULL
    CONSTRAINT chk_borrower_gender
    CHECK (BorrowerGender IN ('M','F')),
  PRIMARY KEY (BorrowerID),
  FOREIGN KEY (AddressID) REFERENCES Address (AddressID),
  FOREIGN KEY (ContactID) REFERENCES Contact (ContactID)
);

