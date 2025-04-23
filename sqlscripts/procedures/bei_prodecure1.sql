SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE borrower_loan_books(
	p_StaffID Staff.StaffID%TYPE,
	p_BorrowerID Borrower.BorrowerID%TYPE,
	p_BookCopyID BookCopy.BookCopyID%TYPE
)IS
    -- Declare variables
	v_LOANDATE LOAN.LOANDATE%TYPE
	v_DUEDATE LOAN.DUEDATE%TYPE
BEGIN
	-- Print param variables
	DBMS_OUTPUT.PUT_LINE('StaffID: ' || p_StaffID);
	DBMS_OUTPUT.PUT_LINE('BorrowerID: ' || p_BorrowerID);
	DBMS_OUTPUT.PUT_LINE('BookCopyID: ' || p_BookCopyID);

    -- Set variables
	v_LOANDATE := SYSDATE;
	v_DUEDATE := ADDAYS(SYSDATE, 14);

	-- Start transaction
	-- Set status code for BookCopyID record

	-- Get current date
	-- Calculate due date
	-- Create Loan record
	INSERT INTO Loan (LoanID, BorrowerID, BookCopyID, LoanProcessedByStaffID, ReturnProcessedByStaffID, LoanDate, DueDate, ReturnDate) VALUES (SEQ_LOAN, p_BorrowerID, p_BookCopyID, p_StaffID, NULL, v_LOANDATE, v_DUEDATE, NULL);
	-- Commit transaction
	Commit;

-- Handle exceptions
EXCEPTION
	ROLLBACK;

END;
/
/*
Boon Earn Iie - Procedure 1: Loan books to borrowers
*/

