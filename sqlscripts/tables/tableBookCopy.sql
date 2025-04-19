PROMPT Creating table BookCopy

CREATE TABLE BookCopy(
  BookCopyID	  NUMBER(4)     NOT NULL,
  BookID	  NUMBER(4)     NOT NULL,
  LibraryBranchID NUMBER(4)     NOT NULL,
  StatusCode 	  NUMBER(4)     NOT NULL,
  ShelfLocation   VARCHAR2(20)  NOT NULL,
  PRIMARY KEY (BookCopyID),
  FOREIGN KEY (BookID) REFERENCES Book (BookID),
  FOREIGN KEY (LibraryBranchID) REFERENCES LibraryBranch (LibraryBranchID),
  FOREIGN KEY (StatusCode) REFERENCES StatusCode (StatusCode)
);
