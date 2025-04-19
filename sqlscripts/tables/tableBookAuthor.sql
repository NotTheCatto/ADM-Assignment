PROMPT Creating table BookAuthor

CREATE TABLE BookAuthor(
  BookID	  NUMBER(4)     NOT NULL,
  AuthorID	  NUMBER(4)     NOT NULL,
  PRIMARY KEY (BookID, AuthorID),
  FOREIGN KEY (BookID) REFERENCES Book (BookID),
  FOREIGN KEY (AuthorID) REFERENCES Author (AuthorID)
);
