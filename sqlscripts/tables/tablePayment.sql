PROMPT Creating table Payment

CREATE TABLE Payment(
  PaymentID       NUMBER(4)     NOT NULL,
  InvoiceID       NUMBER(4)     NOT NULL,
  PaymentDate	  NUMBER(4)     NOT NULL,
  PaymentMethod   VARCHAR2(20)  NOT NULL,
  PaymentAmount   VARCHAR2(20)  NOT NULL,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (InvoiceID) REFERENCES Invoice (InvoiceID),
);
