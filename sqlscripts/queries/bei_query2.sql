/*
Boon Earn Iie - Query 2: List of books available for loaning
 */
CLEAR COLUMNS
-- Set page size and line size
SET PAGESIZE 1000
SET LINESIZE 150
COLUMN "Details of best performing library staffs in last 5 months" FORMAT A20 JUSTIFY CENTER

SELECT s.StaffID, s.StaffFirstName, s.StaffLastName, r.RoleName, s.StaffGender, AVG(r.ReviewScore), 
FROM 
INNER JOIN  ON 
INNER JOIN  ON 
GROUP BY s.StaffID
ORDER BY ShiftDay;

-- Create view
