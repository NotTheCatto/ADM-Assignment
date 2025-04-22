/*
Boon Earn Iie - Procedure 2: Schedule library staff to new shift schedule
*/

CREATE OR REPLACE PROCEDURE schedule_staff_shift IS
    -- (Set parameters: StaffID)

    -- Declare cursor variables
    TYPE schedule_cursor_type IS REF CURSOR;
    existingSchedule_cursor schedule_cursor_type;

    -- Declare variables

    -- Declare cursors
    CURSOR cursor_scheduleTypes IS
        SELECT *
        FROM ShiftType
        ORDER BY ShiftTypeID

BEGIN
    -- Prompt StaffID to assign schedule
    DBMS_OUTPUT.PUT_LINE('Enter Staff ID of the staff to be assigned shift schedule');

    -- List all shift schedule the entered staff is already in
    

    -- List all available shift types and prompt user to select a shift type to assign to (Consider option to create shift type)
    OPEN cursor_types;
    LOOP
        FETCH cursor_types INTO v_ShiftTypeID, v_ShiftName, v_ShiftDescription, v_ShiftStartTime,v_ShiftEndTime;
        EXIT WHEN cursor_types%NOTFOUND;
        -- WARN: Potential error

        DBMS_OUTPUT.PUT_LINE('Enter Staff ID of the staff to be assigned shift schedule');

    END LOOP;
    CLOSE cursor_types;


    -- If user select create shift type (?)

        -- Prompt ShiftName for new ShiftType

        -- Prompt ShiftDescription for new ShiftType

        -- Prompt ShiftStartTime  for new ShiftType

        -- Prompt ShiftEndTime for new ShiftType

        -- Insert new shift type

    -- List all library branches and prompt user to select a library branch to assign to

END;
/
