PROMPT Creating table Address

CREATE TABLE Address(
  AddressID	NUMBER(4)     NOT NULL,
  Street	VARCHAR2(20)  NOT NULL,
  City		VARCHAR2(20)  NOT NULL,
  PostalCode 	NUMBER(5)     NOT NULL,
  State 	VARCHAR2(14)  NOT NULL,
  Country 	VARCHAR(9,2)  NOT NULL,

  PRIMARY KEY (AddressID)
);
