/*
Boon Earn Iie - Report 1: Top 5 performing library staff in last month
*/
SET PAGESIZE 0;
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE staff_performance_report IS
	-- Declare cursor variables
	TYPE shift_schedule_cursor_type is REF CURSOR;
	shiftSchedule_cursor shift_schedule_cursor_type;

	-- Declare variables
	-- Staff table variables

	v_StaffID Staff.StaffID%TYPE;
	v_StaffFirstName Staff.StaffFirstName%TYPE;
	v_StaffLastName Staff.StaffLastName%TYPE;
	v_RoleName StaffRole.RoleName%TYPE;
	v_AvgScore StaffPerformanceReview.ReviewScore%TYPE;
	v_Street Address.Street%TYPE;
	v_City Address.City%TYPE;
	v_PostalCode Address.PostalCode%TYPE;
	v_State Address.State%TYPE;
	v_Country Address.Country%TYPE;
	v_PhoneNo Contact.PhoneNo%TYPE;
	v_EmailAddress Contact.EmailAddress%TYPE;
	v_HireDate Staff.HireDate%TYPE;
	v_StaffGender Staff.StaffGender%TYPE;

	v_Shiftname ShiftType.ShiftName%TYPE;
	v_ShiftStartTime ShiftType.ShiftStartTime%TYPE;
	v_ShiftEndTime ShiftType.ShiftEndTime%TYPE;
	v_ShiftDescription ShiftType.ShiftDescription%TYPE;

	v_i NUMBER(2);

	-- Declare cursors
	CURSOR cursor_staff IS
		SELECT * FROM (
			SELECT s.StaffID, s.StaffFirstName, s.StaffLastName, r.RoleName, AVG(p.ReviewScore) AvgScore, a.Street, a.City, a.PostalCode, a.State, a.Country, c.PhoneNo, c.EmailAddress, s.HireDate, s.StaffGender
			FROM Staff s
			INNER JOIN StaffRole r ON s.RoleID=r.RoleID
			INNER JOIN StaffPerformanceReview p ON s.StaffID=p.StaffID
			INNER JOIN Address a ON s.AddressID=a.AddressID
			INNER JOIN Contact c ON s.ContactID=c.ContactID
			WHERE EXTRACT(MONTH FROM p.ReviewDate)=EXTRACT(MONTH FROM SYSDATE)-1
			GROUP BY s.StaffID, s.StaffFirstName, s.StaffLastName, r.RoleName, a.Street, a.City, a.PostalCode, a.State, a.Country, c.PhoneNo, c.EmailAddress, s.HireDate, s.StaffGender
			ORDER BY AvgScore DESC
		) WHERE ROWNUM <= 5;

BEGIN
	-- Set variables
	v_i := 0;

	-- Print report title / headings
	DBMS_OUTPUT.PUT_LINE(CHR(10));
	DBMS_OUTPUT.PUT_LINE(' --- Top 5 performing library staff in ' || TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'MONTH') || ' ' || EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -1)) || ' --- ');
	DBMS_OUTPUT.PUT_LINE('Date Printed: ' || TO_CHAR(SYSDATE, 'dd-Mon-yyyy'));
	DBMS_OUTPUT.PUT_LINE(CHR(10));

	-- Open cursor
	OPEN cursor_staff;

	-- Loop
	LOOP
		-- Fetch
		FETCH cursor_staff INTO v_StaffID, v_StaffFirstName, v_StaffLastName, v_RoleName, v_AvgScore, v_Street, v_City, v_PostalCode, v_State, v_Country, v_PhoneNo, v_EmailAddress, v_HireDate, v_StaffGender;
		-- Break loop if cursor fetches nothing
		EXIT WHEN cursor_staff%NOTFOUND;

		v_i := v_i + 1;

		DBMS_OUTPUT.PUT_LINE('No. ' || v_i || CHR(9) );
		DBMS_OUTPUT.PUT_LINE('Staff ID: ' || v_StaffID || CHR(9) || CHR(9) || 'Staff Name: ' || v_StaffFirstName || ' ' || v_StaffLastName || CHR(9) || CHR(9) || 'Gender: ' || v_StaffGender);
		DBMS_OUTPUT.PUT_LINE('Role: ' || v_RoleName || CHR(9) || CHR(9) || 'Average score: ' || v_AvgScore);
		DBMS_OUTPUT.PUT_LINE('Address: ' || v_Street || ', ' || v_City || ', ' || v_PostalCode || ', ' || v_State || ', ' || v_Country);
		DBMS_OUTPUT.PUT_LINE('Contact: ' || v_PhoneNo || ', ' || v_EmailAddress);
		DBMS_OUTPUT.PUT_LINE('Hire date: ' || v_HireDate);
		DBMS_OUTPUT.PUT_LINE(CHR(10));

		DBMS_OUTPUT.PUT_LINE('Assigned shift schedule(s)');
		DBMS_OUTPUT.PUT_LINE('==========================================================================================');
		DBMS_OUTPUT.PUT_LINE('Shift name' || CHR(9) || 'Start time' || CHR(9) || 'End time' || CHR(9) || 'Description' || CHR(9) || CHR(9));
		DBMS_OUTPUT.PUT_LINE('==========================================================================================');
	
		-- Print
		OPEN shiftSchedule_cursor FOR 'SELECT t.ShiftName, t.ShiftStartTime, t.ShiftEndTime, t.ShiftDescription
		FROM ShiftType t
		INNER JOIN StaffShiftSchedule sc ON t.ShiftTypeID=sc.ShiftTypeID
		WHERE sc.StaffID = ' || v_StaffID || 'ORDER BY ShiftID';

		LOOP
			FETCH shiftSchedule_cursor INTO v_ShiftName, v_ShiftStartTime, v_ShiftEndTime, v_ShiftDescription;
			EXIT WHEN shiftSchedule_cursor%NOTFOUND;

			DBMS_OUTPUT.PUT_LINE(v_ShiftName || CHR(9) || CHR(9) || TO_CHAR(v_ShiftStartTime,'hh24:mi:ss') || CHR(9) || TO_CHAR(v_ShiftEndTime,'hh24:mi:ss') || CHR(9) || v_ShiftDescription || CHR(9) || CHR(9));

		END LOOP;
		CLOSE shiftSchedule_cursor;

		DBMS_OUTPUT.PUT_LINE('==========================================================================================');
		DBMS_OUTPUT.PUT_LINE(CHR(10));
	-- End loop
	END LOOP;

	-- Output grand total / summary

	-- Close cursor
END;
/

