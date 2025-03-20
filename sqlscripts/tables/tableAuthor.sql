PROMPT Creating table Author

CREATE TABLE Author(
  AuthorID          NUMBER(4)     NOT NULL,
  AuthorFirstName   VARCHAR2(20)  NOT NULL,
  AuthorLastName    VARCHAR2(20)  NOT NULL,
  AuthorGender      CHAR(1)       NOT NULL,
  Biography         VARCHAR2(700) NOT NULL,
  PRIMARY KEY (AddressID)
);
