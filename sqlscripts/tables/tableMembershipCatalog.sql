PROMPT Creating table MembershipCatalog

CREATE TABLE MembershipCatalog (
  CatalogID      NUMBER(4) NOT NULL PRIMARY KEY,
  MembershipID   NUMBER(4)          NOT NULL,
  CatalogType    VARCHAR2(20)    NOT NULL
    CONSTRAINT chk_catalog_type CHECK (CatalogType IN ('RENEW', 'UPGRADE')),
  Amount         NUMBER(10,2)    NOT NULL,
  CatalogDate    DATE            DEFAULT SYSDATE,
  CONSTRAINT fk_catalog_membership
    FOREIGN KEY (MembershipID)
    REFERENCES Membership(MembershipID)
);
