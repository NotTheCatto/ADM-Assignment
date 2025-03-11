PROMPT Dropping tables...;
BEGIN
	EXECUTE IMMEDIATE 'DROP TABLE Address';
	EXECUTE IMMEDIATE 'DROP TABLE Contact';
	EXECUTE IMMEDIATE 'DROP TABLE Publisher';
	EXECUTE IMMEDIATE 'DROP TABLE StaffRole';
	EXECUTE IMMEDIATE 'DROP TABLE Staff';
	EXECUTE IMMEDIATE 'DROP TABLE StaffPerformanceReview';
	EXECUTE IMMEDIATE 'DROP TABLE LibraryBranch';
	EXECUTE IMMEDIATE 'DROP TABLE ShiftType';
	EXECUTE IMMEDIATE 'DROP TABLE StaffShiftSchedule';
	EXECUTE IMMEDIATE 'DROP TABLE MembershipType';
	EXECUTE IMMEDIATE 'DROP TABLE StatusCode';
	EXECUTE IMMEDIATE 'DROP TABLE Membership';
	EXECUTE IMMEDIATE 'DROP TABLE Borrower';
	EXECUTE IMMEDIATE 'DROP TABLE Author';
	EXECUTE IMMEDIATE 'DROP TABLE BookAuthor';
	EXECUTE IMMEDIATE 'DROP TABLE Category';
	EXECUTE IMMEDIATE 'DROP TABLE BookCategory';
	EXECUTE IMMEDIATE 'DROP TABLE LanguageCode';
	EXECUTE IMMEDIATE 'DROP TABLE Book';
	EXECUTE IMMEDIATE 'DROP TABLE BookCopy';
	EXECUTE IMMEDIATE 'DROP TABLE Loan';
	EXECUTE IMMEDIATE 'DROP TABLE Fine';
	EXECUTE IMMEDIATE 'DROP TABLE Invoice';
	EXECUTE IMMEDIATE 'DROP TABLE Payment';
	EXCEPTION
		WHEN OTHERS THEN
			NULL;
END;
/

@@ tableAddress.sql;
@@ tableContact.sql;
@@ tablePublisher.sql;
@@ tableStaffRole.sql;
@@ tableStaff.sql;
@@ tableStaffPerformanceReview.sql;
@@ tableLibraryBranch.sql;
@@ tableShiftType.sql;
@@ tableStaffShiftSchedule.sql;
@@ tableMembershipType.sql;
@@ tableStatusCode.sql;
@@ tableMembership.sql;
@@ tableBorrower.sql;
@@ tableAuthor.sql;
@@ tableBookAuthor.sql;
@@ tableCategory.sql;
@@ tableBookCategory.sql;
@@ tableLanguageCode.sql;
@@ tableBook.sql;
@@ tableBookCopy.sql;
@@ tableLoan.sql;
@@ tableFine.sql;
@@ tableInvoice.sql;
@@ tablePayment.sql;
