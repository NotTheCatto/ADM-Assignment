/*
Boon Earn Iie - Report 1: Top 5 performing library staff in last month  WARN: Incomplete
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

	-- Declare cursors
	CURSOR cursor_staff IS
		SELECT * FROM (
			SELECT s.StaffID, s.StaffFirstName, s.StaffLastName, r.RoleName, AVG(p.ReviewScore) AvgScore, a.Street, a.City, a.PostalCode, a.State, a.Country, c.PhoneNo, c.EmailAddress, s.HireDate, s.StaffGender
-- 			CURSOR (
-- 				SELECT t.ShiftName, TO_CHAR(t.ShiftStartTime,'hh24:mi:ss'), TO_CHAR(t.ShiftEndTime,'hh24:mi:ss'), t.ShiftDescription
-- 				FROM ShiftType t
-- 				INNER JOIN StaffShiftSchedule sc ON t.ShiftTypeID=sc.ShiftTypeID
-- 				INNER JOIN Staff s ON sc.StaffID=s.StaffID
-- 				ORDER BY ShiftID
-- 			) Shift_Info
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

	-- Print report title / headings
	DBMS_OUTPUT.PUT_LINE('Top 5 performing library staff in ' || TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'MONTH') || ' ' || EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -1)));
	--DBMS_OUTPUT.PUT_LINE(CHR(10));
	DBMS_OUTPUT.PUT_LINE('Date Printed: ' || TO_CHAR(SYSDATE, 'dd-Mon-yyyy'));
	--DBMS_OUTPUT.PUT_LINE(CHR(10));

	-- Open cursor
	OPEN cursor_staff;

	-- Loop
	LOOP
		-- Fetch
		FETCH cursor_staff INTO v_StaffID, v_StaffFirstName, v_StaffLastName, v_RoleName, v_AvgScore, v_Street, v_City, v_PostalCode, v_State, v_Country, v_PhoneNo, v_EmailAddress, v_HireDate, v_StaffGender;
	
		-- Break loop if cursor fetches nothing
		EXIT WHEN cursor_staff%NOTFOUND;
	
		-- Print
		OPEN shiftSchedule_cursor FOR 'SELECT t.ShiftName, t.ShiftStartTime, t.ShiftEndTime, t.ShiftDescription
		FROM ShiftType t
		INNER JOIN StaffShiftSchedule sc ON t.ShiftTypeID=sc.ShiftTypeID
		INNER JOIN Staff s ON sc.StaffID=' || v_StaffID || '
		ORDER BY ShiftID';
		LOOP
			FETCH shiftSchedule_cursor INTO v_Shiftname, v_ShiftStartTime, v_ShiftEndTime, v_ShiftDescription;
			EXIT WHEN shiftSchedule_cursor%NOTFOUND;

		END LOOP;
		CLOSE shiftSchedule_cursor;
	
	-- End loop
	END LOOP;

	-- Output grand total / summary

	-- Close cursor
END;
/

