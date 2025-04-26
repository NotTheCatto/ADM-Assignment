/*
Boon Earn Iie - Report 2: Uptrends in loaned books categories in past 3 months  WARN: Incomplete
*/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE book_category_uptrend IS

	-- Declare cursor variables
	TYPE bookcopy_cursor_type IS REF CURSOR;
	bookcopy_cursor bookcopy_cursor_type;

	-- Declare variables
	v_CategoryName Category.CategoryName%TYPE;
	v_BookCount NUMBER(20);
	v_BookCopyCount NUMBER(20);
	v_LoanCount3 NUMBER(20);
	v_LoanCount2 NUMBER(20);
	v_LoanCount1 NUMBER(20);

	v_PrevGrowthRate NUMBER;
	v_CurrentGrowthRate NUMBER;
	v_GrowthRateDiff NUMBER;
	v_HighestLoanCount NUMBER;
	v_LowestLoanCount NUMBER;
	v_HighestGrowthRate NUMBER;
	v_LowestGrowthRate NUMBER;
	v_PrevAvgGrowthRate NUMBER;
	v_CurrentAvgGrowthRate NUMBER;

	v_HighestCategory Category.Categoryname%TYPE;
	v_LowestCategory Category.Categoryname%TYPE;

	v_code NUMBER;
	v_errMsg VARCHAR2(64);

	-- Declare cursors
	CURSOR category_cursor IS
		SELECT c.CategoryName, COUNT(DISTINCT b.BookID) AS BookCount, COUNT(bc.BookCopyID) AS CopyCount,
		COUNT(CASE WHEN (L.LOANDATE BETWEEN ADD_MONTHS(TRUNC(SYSDATE,'MM'),-3) AND LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE,'MM'),-3))) THEN LoanID END),
		COUNT(CASE WHEN (L.LOANDATE BETWEEN ADD_MONTHS(TRUNC(SYSDATE,'MM'),-2) AND LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE,'MM'),-2))) THEN LoanID END),
		COUNT(CASE WHEN (L.LOANDATE BETWEEN ADD_MONTHS(TRUNC(SYSDATE,'MM'),-1) AND LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE,'MM'),-1))) THEN LoanID END)
		FROM Category c
		INNER JOIN BookCategory bct ON c.CategoryID = bct.CategoryID
		INNER JOIN Book b ON bct.BookID = b.BookID
		INNER JOIN BookCopy bc ON b.BookID = bc.BookID
		INNER JOIN Loan l ON bc.BookCopyID = l.BookCopyID
		GROUP BY c.CategoryID, c.CategoryName
		ORDER BY c.CategoryName;


	-- Declare exceptions
	xxx EXCEPTION;

BEGIN
	-- Set variables
	v_HighestGrowthRate := -999;
	v_LowestGrowthRate := 999;

	DBMS_OUTPUT.PUT_LINE(CHR(10));
	DBMS_OUTPUT.PUT_LINE('			--- Uptrends in loaned books categories in past 3 months ---');
	DBMS_OUTPUT.PUT_LINE(CHR(10));
	-- Open cursor
	OPEN category_cursor;

	DBMS_OUTPUT.PUT_LINE(RPAD('Category name', 25) || RPAD('Book count', 13) || RPAD('Copy count', 13) || RPAD(TO_CHAR(ADD_MONTHS(SYSDATE, -3), 'MONTH'), 10) || RPAD(TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'MONTH'), 10) || RPAD(TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'MONTH'), 10) || RPAD('Prev. growth', 20) || RPAD('Current growth', 20));


	DBMS_OUTPUT.PUT_LINE('===================================================================================================================');

	-- Loop
	LOOP
		-- Fetch category name, book count, loan cnt in month - 3, loan cnt in month - 2, loan cnt in month - 1
		FETCH category_cursor INTO v_CategoryName, v_BookCount, v_BookCopyCount, v_LoanCount3, v_LoanCount2, v_LoanCount1;

		-- Break loop if cursor fetches nothing
		EXIT WHEN category_cursor%NOTFOUND;
		/*
		Calculate all category prev avg g rate, current avg g rate, highest loan count, lowest loan count, current highest g rate, current lowest g rate
		Calculate growth rate for -3 to -2, and -2 to -1, growth rate difference
		prevgrate = 100 / -3 x -2
		currentgrate = 100 / -2 x -1
		diffgrate = currentgrate - prevgrate
		highestloan = if loancount > highestloan then highestcount := loancount
		lowestloan = if loancount < lowestloan then lowestcount := loancount
		highestcurrentgrate = if currentgrate > highestcurrentgrate then highestcurrentgrate := currentgrate
		lowestcurrentgrate = if currentgrate < lowestcurrentgrate then lowestcurrentgrate := currentgrate
		prevavggrate = prevavggrate += prevgrowthrate (divide by num of rows)
		currentavggrate = currentavggrate += currentgrowthrate (divide by num of rows aka num of category)
		*/

		v_PrevGrowthRate := v_LoanCount2 - v_LoanCount3;
		v_CurrentGrowthRate := v_LoanCount1 - v_LoanCount2;

		IF (v_HighestGrowthRate < v_CurrentGrowthRate) THEN
			v_HighestCategory := v_Categoryname;
			v_HighestGrowthRate := v_CurrentGrowthRate;
		END IF;

		IF (v_LowestGrowthRate > v_CurrentGrowthRate) THEN
			v_LowestCategory := v_Categoryname;
			v_LowestGrowthRate := v_CurrentGrowthRate;
		END IF;

		-- Print line
		DBMS_OUTPUT.PUT_LINE(RPAD(v_CategoryName, 25) || RPAD(v_BookCount, 13) || RPAD(v_BookCopyCount, 13) || RPAD(v_LoanCount3, 10) || RPAD(v_LoanCount2, 10) || RPAD(v_LoanCount1, 10) || RPAD(v_PrevGrowthRate, 20) || RPAD(v_CurrentGrowthRate, 20));

	-- End loop
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('===================================================================================================================');

	-- Print overall total avg growtg rate, high category g rate, lowest category g rate
	DBMS_OUTPUT.PUT_LINE(CHR(10));
	DBMS_OUTPUT.PUT_LINE('Category with the highest growth : ' || v_HighestCategory || ' (' || v_HighestGrowthRate || ')');
	DBMS_OUTPUT.PUT_LINE('Category with the lowest growth : ' || v_LowestCategory || ' (' || v_LowestGrowthRate || ')');
	-- DBMS_OUTPUT.PUT_LINE();

	-- Close cyrsor
	CLOSE category_cursor;
-- Handle exceptions
EXCEPTION
	WHEN others THEN
		v_code := SQLCODE;
		v_errMsg := SUBSTR(SQLERRM, 1, 64);
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('An exception has occured.');
		DBMS_OUTPUT.PUT_LINE('Error code: ' || v_code);
		DBMS_OUTPUT.PUT_LINE('Error message: ' || v_errmsg);
END;
/
