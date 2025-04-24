/*
Boon Earn Iie - Report 2: Uptrends in loaned books categories in past 3 months  WARN: Incomplete
*/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE borrower_loan_books(
	p_StaffID Staff.StaffID%TYPE,
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

	-- Declare cursors

	-- Declare exceptions
	copy_not_available EXCEPTION;

BEGIN
	-- Set variables
-- Handle exceptions
EXCEPTION
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
