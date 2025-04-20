PROMPT Creating table Payment

CREATE TABLE Payment(
  PaymentID NUMBER(4) NOT NULL,
  InvoiceID NUMBER(4) NOT NULL,
  PaymentMethodID NUMBER(4) NOT NULL,
  PaymentDate DATE DEFAULT SYSDATE NOT NULL,
  PaymentAmount NUMBER(8,2) NOT NULL CHECK (PaymentAmount >= 0),
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (InvoiceID) REFERENCES Invoice (InvoiceID),
  FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID)
);

