SET FEEDBACK ON;

 -- Can't escape '&', so `SET DEFINE OFF` is used to escape that symbol.
SET DEFINE OFF;

PROMPT Deleting records...;
BEGIN
-- DELETE FROM Payment;
DELETE FROM Invoice;
DELETE FROM Fine;
DELETE FROM Loan;
DELETE FROM PaymentMethod;
DELETE FROM BookCopy;
DELETE FROM BookCategory;
DELETE FROM BookAuthor;
DELETE FROM Book;
DELETE FROM StaffShiftSchedule;
DELETE FROM StaffPerformanceReview;
DELETE FROM Staff;
DELETE FROM LanguageCode;
DELETE FROM Category;
DELETE FROM Author;
DELETE FROM Membership;
DELETE FROM Borrower;
DELETE FROM StatusCode;
DELETE FROM MembershipType;
DELETE FROM ShiftType;
DELETE FROM LibraryBranch;
DELETE FROM StaffRole;
DELETE FROM Publisher;
DELETE FROM Contact;
DELETE FROM Address;
END;
/

PROMPT Inserting records...;
BEGIN
@@ AddressRecord.sql;
@@ ContactRecord.sql;
@@ PublisherRecord.sql;
@@ StaffRoleRecord.sql;
@@ LibraryBranchRecord.sql;
@@ ShiftTypeRecord.sql;
@@ MembershipTypeRecord.sql;
@@ StatusCodeRecord.sql;
@@ BorrowerRecord.sql;
@@ MembershipRecord.sql;
@@ AuthorRecord.sql;
@@ CategoryRecord.sql;
@@ LanguageCodeRecord.sql;
@@ StaffRecord.sql;
@@ StaffPerformanceReviewRecord.sql;
@@ StaffShiftScheduleRecord.sql;
@@ BookRecord.sql;
@@ BookAuthorRecord.sql;
@@ BookCategoryRecord.sql;
@@ BookCopyRecord.sql;
@@ PaymentMethodRecord.sql;
@@ LoanRecord.sql;
@@ FineRecord.sql;
@@ InvoiceRecord.sql;
-- @@ PaymentRecord.sql;
END;
/

SET DEFINE ON;
