PROMPT Creating table ShiftType

CREATE TABLE ShiftType(
  ShiftTypeID NUMBER(4) NOT NULL,  
  ShiftName VARCHAR2(10) NOT NULL,
  ShiftDescription VARCHAR2(700) NOT NULL,
  ShiftStartTime TIMESTAMP NOT NULL,
  ShiftEndTime TIMESTAMP NOT NULL,
  PRIMARY KEY (ShiftTypeID)
);

