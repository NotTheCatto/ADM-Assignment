PROMPT Creating table Contact

CREATE TABLE Contact (
  ContactID NUMBER(4) NOT NULL,
  PhoneNo VARCHAR2(20) NOT NULL
    CONSTRAINT phone_format_chk
      CHECK (REGEXP_LIKE(
        PhoneNo,
        '^(010|012|016|017|018)-[0-9]{3} [0-9]{4}$'
      )),
  EmailAddress VARCHAR2(50) NOT NULL
    CONSTRAINT email_format_chk
      CHECK (REGEXP_LIKE(
        EmailAddress,
        '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
      )),
  PRIMARY KEY (ContactID)
);

