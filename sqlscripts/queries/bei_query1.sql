/*
Boon Earn Iie - Query 1: Summary of staff shift schedule and details of assigned staff
*/
CLEAR COLUMNS;
TTITLE ON;
COLUMN ShiftTypeID FORMAT 999 JUSTIFY LEFT;
COLUMN ShiftName FORMAT A9 JUSTIFY LEFT;
COLUMN StartTime FORMAT A9 JUSTIFY LEFT;
COLUMN EndTime FORMAT A9 JUSTIFY LEFT;
COLUMN NumOfStaff FORMAT 999999999 JUSTIFY LEFT;
COLUMN StaffAvgScore FORMAT 999.99 JUSTIFY LEFT;

-- Set page size and line size;
SET PAGESIZE 300;
SET LINESIZE 66;
TTITLE CENTER ' --- Summary of staff shift schedule and assigned staff --- ' FORMAT A20 SKIP 2 LEFT 'Page: ' SQL.PNO SKIP 1;

SELECT t.ShiftTypeID, t.ShiftName, TO_CHAR(t.ShiftStartTime,'hh24:mi:ss') AS StartTime, TO_CHAR(t.ShiftEndTime,'hh24:mi:ss') AS EndTime, COUNT(sc.StaffID) AS NumOfStaff, ROUND(AVG(r.ReviewScore), 2) AS StaffAvgScore
FROM StaffShiftSchedule sc
INNER JOIN ShiftType t ON sc.ShiftTypeID=t.ShiftTypeID
INNER JOIN Staff s ON sc.StaffID=s.StaffID
INNER JOIN StaffPerformanceReview r ON s.StaffID=r.StaffID
GROUP BY t.ShiftTypeID, t.ShiftName, t.ShiftStartTime, t.ShiftEndTime
ORDER BY t.Shiftname;

-- Create view
CREATE OR REPLACE VIEW staff_schedule_summary AS
	SELECT t.ShiftTypeID, t.ShiftName, TO_CHAR(t.ShiftStartTime,'hh24:mi:ss') AS StartTime, TO_CHAR(t.ShiftEndTime,'hh24:mi:ss') AS EndTime, COUNT(sc.StaffID) AS NumOfStaff, ROUND(AVG(r.ReviewScore), 2) AS StaffAvgScore
	FROM StaffShiftSchedule sc
	INNER JOIN ShiftType t ON sc.ShiftTypeID=t.ShiftTypeID
	INNER JOIN Staff s ON sc.StaffID=s.StaffID
	INNER JOIN StaffPerformanceReview r ON s.StaffID=r.StaffID
	GROUP BY t.ShiftTypeID, t.ShiftName, t.ShiftStartTime, t.ShiftEndTime
	ORDER BY t.Shiftname
	WITH READ ONLY;
