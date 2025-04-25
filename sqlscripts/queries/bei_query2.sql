/*
Boon Earn Iie - Query 2: List of books available for loaning  WARN: Pending testing
 */

CLEAR COLUMNS
-- Set page size and line size
SET PAGESIZE 1000
SET LINESIZE 150
COLUMN "Details of best performing library staffs in last 5 months" FORMAT A20 JUSTIFY CENTER

SELECT b.BookID, b.BookName, COUNT(c.BookCopyID) ,LISTAGG(c.BookCopyID, ',') WITHING GROUP (ORDER BY c.BookCopyID) "Available book copies'' ID", 
FROM BookCopy c
INNER JOIN StatusCode s ON c.StatusCode=s.StatusCode
INNER JOIN Book b ON c.BookID=b.BookID
WHERE c.StatusCode = 1
GROUP BY c.BookCopyID
ORDER BY c.BookCopyID;

-- Create view
