PROMPT Creating table Book

CREATE TABLE Book(
  BookID	  NUMBER(4)     NOT NULL,
  PublisherID	  NUMBER(4)     NOT NULL,
  LanguageCode	  NUMBER(4)     NOT NULL,
  Title 	  VARCHAR2(20)  NOT NULL,
  ISBN  	  VARCHAR2(20)  NOT NULL,
  PublicationYear NUMBER(4)     NOT NULL,
  BookDescription VARCHAR2(700) NOT NULL,
  PRIMARY KEY (BookID),
  FOREIGN KEY (PublisherID) REFERENCES Publisher (PublisherID),
  FOREIGN KEY (LanguageCode) REFERENCES LanguageCode (LanguageCode)
);
