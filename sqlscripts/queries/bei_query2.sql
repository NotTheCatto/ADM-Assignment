/*
Boon Earn Iie - Query 2: List of books available for loaning
 */
CLEAR COLUMNS;
TTITLE ON;
COLUMN BookID FORMAT 999 JUSTIFY LEFT;
COLUMN Title FORMAT A20 JUSTIFY LEFT;
COLUMN Language FORMAT A8 JUSTIFY LEFT;
COLUMN Qty FORMAT 99 JUSTIFY LEFT;
COLUMN Available_Copies FORMAT A28 JUSTIFY LEFT;

-- Set page size and line size
SET PAGESIZE 40;
SET LINESIZE 70;
SET WRAP ON;
TTITLE CENTER ' --- List of books available for loaning --- ' FORMAT A20 SKIP 2 LEFT 'Page: ' SQL.PNO SKIP 1;

SELECT b.BookID, b.Title, l.LanguageName AS Language, COUNT(c.BookCopyID) AS Qty, LISTAGG(c.BookCopyID, ', ') WITHIN GROUP (ORDER BY b.BookID, b.Title, l.LanguageName) "AVAILABLE_COPIES"
FROM Book b
INNER JOIN BookCopy c ON b.BookID=c.BookID
INNER JOIN StatusCode s ON c.StatusCode=s.StatusCode
INNER JOIN LanguageCode l ON b.LanguageCode=l.LanguageCode
WHERE s.StatusName = 'Available'
GROUP BY b.BookID, b.Title, l.LanguageName
ORDER BY l.LanguageName, b.Title;

-- Create view  WARN: Pending testing
CREATE OR REPLACE VIEW available_books AS
	SELECT b.BookID, b.Title, l.LanguageName AS Language, COUNT(c.BookCopyID) AS Qty, LISTAGG(c.BookCopyID, ', ') WITHIN GROUP (ORDER BY b.BookID, b.Title, l.LanguageName) "AVAILABLE_COPIES"
	FROM Book b
	INNER JOIN BookCopy c ON b.BookID=c.BookID
	INNER JOIN StatusCode s ON c.StatusCode=s.StatusCode
	INNER JOIN LanguageCode l ON b.LanguageCode=l.LanguageCode
	WHERE s.StatusName = 'Available'
	GROUP BY b.BookID, b.Title, l.LanguageName
	ORDER BY l.LanguageName, b.Title
	WITH READ ONLY;
