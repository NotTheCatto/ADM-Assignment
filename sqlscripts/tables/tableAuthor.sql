PROMPT Creating table Author

CREATE TABLE Author(
  AuthorID NUMBER(4) NOT NULL,
  AuthorFirstName VARCHAR2(20) NOT NULL,
  AuthorLastName VARCHAR2(20) NOT NULL,
  AuthorGender CHAR(1) NOT NULL
    CONSTRAINT chk_author_gender
    CHECK (AuthorGender IN ('M','F')),  
  Biography VARCHAR2(700),
  PRIMARY KEY (AuthorID)
);

