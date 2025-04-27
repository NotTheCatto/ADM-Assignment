/*
Boon Earn Iie - Trigger 2: Validate status code of each updated book copies
*/

CREATE OR REPLACE TRIGGER TRG_VAL_STATUS
FOR INSERT OR UPDATE ON BOOKCOPY
COMPOUND TRIGGER
    TYPE copy_list IS TABLE OF BookCopy%ROWTYPE INDEX BY PLS_INTEGER;
    bookcopies_to_update copy_list;
    
	-- Declare cursor variable
	TYPE bookcopy_cursor_type is REF CURSOR;
	bookcopy_cursor bookcopy_cursor_type;

	TYPE loan_cursor_type is REF CURSOR;
	loan_cursor loan_cursor_type;

	-- Declare neccessary variables
	v_LoanID Loan.LoanID%TYPE;
	v_NullFlag VARCHAR(2);
	v_StatusCode BookCopy.StatusCode%TYPE;
	v_iBookCopyID BookCopy.BookCopyID%TYPE;

	v_code NUMBER;
	v_errMsg VARCHAR2(64);

    BEFORE EACH ROW IS
    BEGIN
        IF :NEW.StatusCode != :OLD.StatusCode THEN
            bookcopies_to_update(bookcopies_to_update.COUNT + 1).BookCopyID := :NEW.BookCopyID;
        END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS
    BEGIN
        FOR i IN 1..bookcopies_to_update.COUNT LOOP

			v_NullFlag := 'f';
			v_iBookCopyID := bookcopies_to_update(i).BookCopyID;

			-- Fetch all Loan records that is associated with the BookCopyID
			-- Check if thre are any NULL values in ReturnDate field
			OPEN loan_cursor FOR
				'SELECT LoanID
				FROM Loan
				WHERE ReturnDate = NULL AND BookCopyID=' || v_iBookCopyID;

			FETCH loan_cursor INTO v_LoanID;
			IF (loan_cursor%NOTFOUND) THEN
				v_NullFlag := 't';
			END IF;

			CLOSE loan_cursor;

			-- Open cursor
			OPEN bookcopy_cursor FOR
				'SELECT StatusCode
				FROM BookCopy
				WHERE BookCopyID=' || v_iBookCopyID;

			-- Fetch statuscode of book
			FETCH bookcopy_cursor INTO v_StatusCode;

			IF (v_NullFlag = 't') THEN
				-- RAISE_APPLICATION_ERROR(-20000, 'if null is t');
				IF (v_StatusCode != 2) THEN
					UPDATE BookCopy SET StatusCode = 3 WHERE BookCopyID = v_iBookCopyID;
					DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
					DBMS_OUTPUT.PUT_LINE('Set status code to 3');
				END IF;
			ELSE
				IF (v_StatusCode != 1 AND v_StatusCode != 3) THEN
					UPDATE BookCopy SET StatusCode = 2 WHERE BookCopyID = v_iBookCopyID;
					DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
					DBMS_OUTPUT.PUT_LINE('Set status code to 2');
					DBMS_OUTPUT.PUT_LINE('Borrower name, phone no, email');
				END IF;
			END IF;

			CLOSE bookcopy_cursor;

        END LOOP;
    END AFTER STATEMENT;
END;
/
