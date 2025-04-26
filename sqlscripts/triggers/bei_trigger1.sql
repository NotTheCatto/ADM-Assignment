/*
Boon Earn Iie - Trigger 1: Validate and warn new assignments of staffs’ shift schedules
*/
CREATE OR REPLACE TRIGGER TRG_XXX
BEFORE INSERT ON StaffShiftSchedule
FOR EACH ROW
DECLARE
	-- Declare neccessary variables
	v_fStartTime ShiftType.ShiftStartTime%TYPE;
	v_fEndTime ShiftType.ShiftEndTime%TYPE;
	v_iStartTime ShiftType.ShiftStartTime%TYPE;
	v_iEndTime ShiftType.ShiftEndTime%TYPE;
	v_ShiftID StaffShiftSchedule.ShiftID%TYPE;

	-- Declare cursors
	TYPE schedule_cursor_type is REF CURSOR;
	schedule_cursor schedule_cursor_type;

	TYPE time_cursor_type is REF CURSOR;
	time_cursor time_cursor_type;

	-- Declare exceptions
	overlapped_schedule EXCEPTION;

	v_code NUMBER;
	v_errMsg VARCHAR2(64);

BEGIN
	-- Open cursor
	OPEN schedule_cursor FOR
		'SELECT s.ShiftID, t.ShiftStartTime, t.ShiftEndTime
		FROM ShiftType t
		INNER JOIN StaffShiftSchedule s ON t.ShiftTypeID = s.ShiftTypeID
		WHERE StaffID=' || :new.StaffID;

	OPEN time_cursor FOR
		'SELECT ShiftStartTime, ShiftEndTime
		FROM ShiftType
		WHERE ShiftTypeID=' || :new.ShiftTypeID;

	FETCH time_cursor INTO v_iStartTime, v_iEndTime;

	-- Loop
	LOOP
		-- Fetch all assigned shift schedules
		FETCH schedule_cursor INTO v_ShiftID, v_fStartTime, v_fEndTime;
		EXIT WHEN schedule_cursor%NOTFOUND;

		-- Compare inserted start and end time with existing shift start and end time
		IF (v_fStartTime <= v_iStartTime AND v_iStartTime <= v_fEndTime) THEN
			RAISE overlapped_schedule;
		END IF;

		IF (v_fStartTime <= v_iEndTime AND v_iEndTime <= v_fEndTime) THEN
			RAISE overlapped_schedule;
		END IF;
	-- End loop
	END LOOP;

	CLOSE schedule_cursor;
	CLOSE time_cursor;

EXCEPTION
	WHEN overlapped_schedule THEN
		DBMS_OUTPUT.PUT_LINE('--- WARNING ---');
		DBMS_OUTPUT.PUT_LINE('This record overlaps schedule ''' || v_ShiftID || ''', please consider removing this record');
	WHEN others THEN
		v_code := SQLCODE;
		v_errMsg := SUBSTR(SQLERRM, 1, 64);
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('An exception has occured.');
		DBMS_OUTPUT.PUT_LINE('Error code: ' || v_code);
		DBMS_OUTPUT.PUT_LINE('Error message: ' || v_errmsg);
END;
/
