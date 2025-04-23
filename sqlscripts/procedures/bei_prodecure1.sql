SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE borrower_loan_books(
	p_StaffID Staff.StaffID%TYPE,
	p_BorrowerID Borrower.BorrowerID%TYPE,
	p_BookCopyID BookCopy.BookCopyID%TYPE
)IS
	-- Declare cursor variables
	TYPE bookcopy_cursor_type IS REF_CURSOR;
	bookcopy_cursor bookcopy_cursor_type;

	-- Declare variables
	v_LOANDATE Loan.LoanDate%TYPE;
	v_DUEDATE Loan.DueDate%TYPE;
	v_StatusCode BookCopy.StatusCode%TYPE;

	-- Declare exceptions
	copy_not_available EXCEPTION;
BEGIN
	-- Print param variables
	DBMS_OUTPUT.PUT_LINE('StaffID: ' || p_StaffID);
	DBMS_OUTPUT.PUT_LINE('BorrowerID: ' || p_BorrowerID);
	DBMS_OUTPUT.PUT_LINE('BookCopyID: ' || p_BookCopyID);

	-- Set variables
	OPEN bookcopy_cursor FOR 'SELECT StatusCode FROM BookCopy WHERE BookCopyID=p_BookCopyID';

	-- Start transaction
	-- Check if status code is 1
	FETCH bookcopy_cursor INTO v_StatusCode;
	CLOSE bookcopy_cursor;
	IF v_StatusCode = 1 THEN
		-- Set status code for BookCopyID record
		UPDATE BookCopy
		SET StatusCode=2 -- 2 for 'Reserved' bazed on sample records
		WHERE BookCopyID=p=BookCopyID;
	
		-- Get current date
		v_LOANDATE := SYSDATE;
	
		-- Calculate due date
		v_DUEDATE := ADDDAYS(SYSDATE, 14);
	
		-- Create Loan record
		INSERT INTO Loan (LoanID, BorrowerID, BookCopyID, LoanProcessedByStaffID, ReturnProcessedByStaffID, LoanDate, DueDate, ReturnDate) VALUES (SEQ_LOAN, p_BorrowerID, p_BookCopyID, p_StaffID, NULL, v_LOANDATE, v_DUEDATE, NULL);
	
		-- Commit transaction
		Commit;
	ELSE
		RAISE copy_not_available;
	END IF;

-- Handle exceptions
EXCEPTION
	WHEN copy_not_available THEN
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('BookCopy ''' || p_BookCopyID || ''' is not available for loan.');
	WHEN others THEN
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('An exception has occured.');
		ROLLBACK;

END;
/
/*
Boon Earn Iie - Procedure 1: Loan books to borrowers
*/

