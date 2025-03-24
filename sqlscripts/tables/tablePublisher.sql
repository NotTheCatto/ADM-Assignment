PROMPT Creating table Publisher

CREATE TABLE Publisher(
  PublisherID	NUMBER(4)	NOT NULL,
  AddressID	NUMBER(4)	NOT NULL,
  ContactID	NUMBER(4)	NOT NULL,
  Publishername	VARCHAR(20)	NOT NULL,
  PRIMARY KEY (PublisherID),
  FOREIGN KEY (AddressID) REFERENCES Address (AddressID),
  FOREIGN KEY (ContactID) REFERENCES Contact (ContactID)
);
