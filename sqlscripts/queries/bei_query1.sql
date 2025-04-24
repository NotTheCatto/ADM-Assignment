/*
Boon Earn Iie - Query 1: Summary of staff shift schedule and details of assigned staff  WARN: Pending testing
*/
CLEAR COLUMNS
-- Set page size and line size
SET PAGESIZE 1000
SET LINESIZE 150
COLUMN "Summary of staff shift schedule and assigned staff" FORMAT A20 JUSTIFY CENTER

SELECT type.ShiftName, library.BranchName, schedule.ShiftStartTime, schedule.ShiftEndTime, COUNT(),
FROM StaffShiftSchedule schedule
INNER JOIN ShiftType type ON schedule.ShiftTypeID=type.ShiftTypeID
INNER JOIN LibraryBranch library ON schedule.LibraryBranchID=library.LibraryBranchID
GROUP BY ShiftStartTime, ShiftEndTime, ShiftDay
ORDER BY ShiftDay;
