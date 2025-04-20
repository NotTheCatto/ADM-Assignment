PROMPT Creating table LibraryBranch

CREATE TABLE LibraryBranch(
  LibraryBranchID NUMBER(4) NOT NULL,
  AddressID NUMBER(4) NOT NULL,
  ContactID NUMBER(4) NOT NULL,
  BranchName VARCHAR2(50) NOT NULL,
  PRIMARY KEY (LibraryBranchID),
  FOREIGN KEY (AddressID) REFERENCES Address (AddressID),
  FOREIGN KEY (ContactID) REFERENCES Contact (ContactID)
);

