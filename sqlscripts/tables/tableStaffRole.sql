PROMPT Creating table StaffRole

CREATE TABLE StaffRole(
  RoleID          NUMBER(4)     NOT NULL,
  RoleName        VARCHAR2(20)  NOT NULL,
  RoleDescription VARCHAR2(20)  NOT NULL,

  PRIMARY KEY (RoleID)
);
