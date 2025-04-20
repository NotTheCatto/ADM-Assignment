PROMPT Creating table Staff

CREATE TABLE Staff(
  StaffID NUMBER(4) NOT NULL,
  AddressID NUMBER(4)NOT NULL,
  ContactID NUMBER(4)	NOT NULL,
  RoleID NUMBER(4) NOT NULL,
  StaffFirstName VARCHAR2(20) NOT NULL,
  StaffLastName VARCHAR2(20) NOT NULL,
  StaffGender CHAR(1) NOT NULL
    CONSTRAINT chk_staff_gender
    CHECK (StaffGender IN ('M','F')), 
  HireDate DATE DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (StaffID),
  FOREIGN KEY (AddressID) REFERENCES Address (AddressID),
  FOREIGN KEY (ContactID) REFERENCES Contact (ContactID),
  FOREIGN KEY (RoleID) REFERENCES StaffRole (RoleID)
);

