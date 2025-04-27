/*
Boon Earn Iie - Procedure 2: Record review of staffs' performance
*/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE review_staff_performance(
	p_ReviewedStaffID Staff.StaffID%TYPE,
	p_ReviewingStaffID Staff.StaffID%TYPE,
	p_ReviewScore StaffPerformanceReview.ReviewScore%TYPE
)IS
	-- Declare cursor variables
	TYPE role_cursor_type IS REF CURSOR;
	role_cursor role_cursor_type;

	-- Declare variables
	v_RoleID StaffRole.RoleID%TYPE;

	v_code NUMBER;
	v_errMsg VARCHAR2(64);

	-- Declare exceptions
	invalid_reviewer_role EXCEPTION;
	invalid_score EXCEPTION;

BEGIN
	-- Check if reviewer has an appropriate role
	OPEN role_cursor FOR 'SELECT RoleID FROM Staff WHERE StaffID=' || p_ReviewingStaffID;
	FETCH role_cursor INTO v_RoleID;
	CLOSE role_cursor;
	IF ( v_RoleID != 3 ) THEN -- 3 for circulation supervisor
		RAISE invalid_reviewer_role;
	END IF;

	-- Validate score
	IF ( p_ReviewScore < 0 OR p_ReviewScore > 100 ) THEN
		RAISE invalid_score;
	END IF;

	-- Insert review record
	INSERT INTO StaffPerformanceReview (ReviewID, StaffID, ReviewerID, ReviewDate, ReviewScore) VALUES (SEQ_PERFORMANCE.nextval, p_ReviewedStaffID, p_ReviewingStaffID, SYSDATE, p_ReviewScore);

	-- Commit transaction
	Commit;

	-- Print success message
	DBMS_OUTPUT.PUT_LINE('--- SUCCESS ---');
	DBMS_OUTPUT.PUT_LINE('Reviewed Staff ID: ' || p_ReviewedStaffID);
	DBMS_OUTPUT.PUT_LINE('Reviewing Staff ID: ' || p_ReviewingStaffID);
	DBMS_OUTPUT.PUT_LINE('Date reviewed: ' || TO_DATE(SYSDATE, 'DD-MON-YYYY'));
	DBMS_OUTPUT.PUT_LINE('Score given: ' || p_ReviewScore);

EXCEPTION
	WHEN invalid_reviewer_role THEN
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('Reviewing staff''s role ''' || v_RoleID || ''' is not a valid role for reviewing staff''s performance.');
	WHEN invalid_score THEN
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('Review score of ''' || p_ReviewScore || ''' is not a valid score.');
	WHEN others THEN
		v_code := SQLCODE;
		v_errMsg := SUBSTR(SQLERRM, 1, 64);
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('An exception has occurred.');
		DBMS_OUTPUT.PUT_LINE('Error code: ' || v_code);
		DBMS_OUTPUT.PUT_LINE('Error message: ' || v_errmsg);
		ROLLBACK;
END;
/
