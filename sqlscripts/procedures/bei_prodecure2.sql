/*
Boon Earn Iie - Procedure 2: Schedule library staff to new shift schedule
*/

CREATE OR REPLACE PROCEDURE schedule_staff_shift(
    p_StaffID Staff.StaffID%TYPE,
    p_ShiftTypeID ShiftType.ShiftTypeID%TYPE,
    p_LibraryBranchID LibraryBranch.LibraryBranchID%TYPE
)IS
    -- Declare cursor variables
    TYPE schedule_cursor IS REF CURSOR;
    existingSchedule_cursor schedule_cursor_type;

    -- Declare variables

    -- Declare cursors
    CURSOR cursor_scheduleTypes IS
        SELECT *
        FROM ShiftType
        ORDER BY ShiftTypeID

BEGIN
    -- List all available shift types and prompt user to select a shift type to assign to (Consider option to create shift type)
    OPEN cursor_types;
    LOOP
        FETCH cursor_types INTO v_ShiftTypeID, v_ShiftName, v_ShiftDescription, v_ShiftStartTime,v_ShiftEndTime;
        EXIT WHEN cursor_types%NOTFOUND;
        -- WARN: Potential error

        DBMS_OUTPUT.PUT_LINE('Enter Staff ID of the staff to be assigned shift schedule');

    END LOOP;
    CLOSE cursor_types;


END;
/
