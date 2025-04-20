PROMPT Creating table BookCategory

CREATE TABLE BookCategory(
  BookID NUMBER(4) NOT NULL,
  CategoryID NUMBER(4) NOT NULL,
  PRIMARY KEY (BookID, CategoryID),
  FOREIGN KEY (BookID) REFERENCES Book (BookID),
  FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);

