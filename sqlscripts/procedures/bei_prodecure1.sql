/*
Boon Earn Iie - Procedure 1: Loan books to borrowers
*/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE borrower_loan_books(
	p_StaffID Staff.StaffID%TYPE,
	p_BorrowerID Borrower.BorrowerID%TYPE,
	p_BookCopyID BookCopy.BookCopyID%TYPE
)IS
	-- Declare cursor variables
	TYPE bookcopy_cursor_type IS REF CURSOR;
	bookcopy_cursor bookcopy_cursor_type;

	-- Declare variables
	v_LoanDate Loan.LoanDate%TYPE;
	v_DueDate Loan.DueDate%TYPE;
	v_StatusCode BookCopy.StatusCode%TYPE;
	v_code NUMBER;
	v_errMsg VARCHAR2(64);

	-- Declare exceptions
	copy_not_available EXCEPTION;

BEGIN
	-- Set variables
	OPEN bookcopy_cursor FOR 'SELECT StatusCode FROM BookCopy WHERE BookCopyID=' || p_BookCopyID;

	-- Start transaction
	-- Check if status code is 1
	FETCH bookcopy_cursor INTO v_StatusCode;
	CLOSE bookcopy_cursor;
	IF ( v_StatusCode = 1 ) THEN
		-- Status is set to 2 as unavailable
		UPDATE BookCopy SET StatusCode = 2 WHERE BookCopyID=p_BookCopyID;
	
		-- Create Loan record
		INSERT INTO Loan (LoanID, BorrowerID, BookCopyID, LoanProcessedByStaffID, ReturnProcessedByStaffID, LoanDate, DueDate, ReturnDate) VALUES (SEQ_LOAN.nextval, p_BorrowerID, p_BookCopyID, p_StaffID, NULL, SYSDATE, ( SYSDATE + 14 ), NULL);
	
		-- Commit transaction
		Commit;

		-- Print success message
		DBMS_OUTPUT.PUT_LINE('--- SUCCESS ---');
		DBMS_OUTPUT.PUT_LINE('Borrower ID: ' || p_BorrowerID);
		DBMS_OUTPUT.PUT_LINE('Book borrowed (ID): ' || p_BookCopyID);
		DBMS_OUTPUT.PUT_LINE('Processed by Staff (ID): ' || p_StaffID);
	ELSE
		RAISE copy_not_available;
	END IF;

-- Handle exceptions
EXCEPTION
	WHEN copy_not_available THEN
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('BookCopy with the ID ''' || p_BookCopyID || ''' is not available for loan.');
	WHEN others THEN
		v_code := SQLCODE;
		v_errMsg := SUBSTR(SQLERRM, 1, 64);
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('An exception has occured.');
		DBMS_OUTPUT.PUT_LINE('Error code: ' || v_code);
		DBMS_OUTPUT.PUT_LINE('Error message: ' || v_errmsg);
		ROLLBACK;
END;
/
