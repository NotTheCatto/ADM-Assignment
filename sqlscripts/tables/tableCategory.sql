PROMPT Creating table Category

CREATE TABLE Category(
  CategoryID	      NUMBER(4)     NOT NULL,
  CategoryName	      VARCHAR2(20)  NOT NULL,
  CategoryDescription VARCHAR2(300) NOT NULL,

  PRIMARY KEY (CategoryID)
);
