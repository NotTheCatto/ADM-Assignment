/*
Boon Earn Iie - Report 2: Uptrends in loaned books categories in past 3 months  WARN: Incomplete
*/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE borrower_loan_books(
	p_StaffID Staff.StaffID%TYPE,
)IS

	-- Declare cursor variables
	TYPE bookcopy_cursor_type IS REF CURSOR;
	bookcopy_cursor bookcopy_cursor_type;

	-- Declare variables
	v_CategoryName Category.CategoryName%TYPE;
	v_BookCount
	v_BookCopyCount
	v_LoanCount3
	v_LoanCount2
	v_LoanCount1

	v_code NUMBER;
	v_errMsg VARCHAR2(64);

	-- Declare cursors
	CURSOR category_cursor IS
		SELECT c.CategoryName, COUNT(DISTINCT b.BookID), COUNT(bc.BookCopyID),
		COUNT(case when (condition -3) then 1 end) AS ,
		COUNT(case when (condition -2) then 1 end) AS ,
		COUNT(case when (condition -1) then 1 end) AS
		FROM Category c
		INNER JOIN Book b ON c.CategoryID = b.CategoryID
		INNER JOIN BookCopy bc ON b.BookID = bc.BookID
		INNER JOIN Loan l ON bc.BookCopyID = l.BookCopyID
		ORDER BY c.CategoryName
		GROUP BY c.CategoryID;

	-- Declare exceptions
	xxx EXCEPTION;

BEGIN
	-- Set variables
	v_PrevGrowthRate := 0
	v_CurrentGrowthRate := 0
	v_GrowthRateDiff := 0
	v_HighestLoanCount := 0
	v_LowestLoanCount := 0
	v_HighestGrowthRate := 0
	v_LowestGrowthRate := 0
	v_PrevAvgGrowthRate := 0
	v_CurrentAvgGrowthRate := 0

	-- Open cursor
	OPEN category_cursor;

	-- Loop
	LOOP
		-- Fetch category name, book count, loan cnt in month - 3, loan cnt in month - 2, loan cnt in month - 1
		FETCH category_cursor INTO

		-- Calculate all category prev avg g rate, current avg g rate, highest loan count, lowest loan count, current highest g rate, current lowest g rate

		-- Calculate growth rate for -3 to -2, and -2 to -1, growth rate difference
		-- prevgrate = 100 / -3 x -2
		-- currentgrate = 100 / -2 x -1
		-- diffgrate = currentgrate - prevgrate
		-- highestloan = if loancount > highestloan then highestcount := loancount
		-- lowestloan = if loancount < lowestloan then lowestcount := loancount
		-- highestcurrentgrate = if currentgrate > highestcurrentgrate then highestcurrentgrate := currentgrate
		-- lowestcurrentgrate = if currentgrate < lowestcurrentgrate then lowestcurrentgrate := currentgrate
		-- prevavggrate = prevavggrate += prevgrowthrate (divide by num of rows)
		-- currentavggrate = currentavggrate += currentgrowthrate (divide by num of rows aka num of category)

		-- Print line
		DBMS_OUTPUT.PUT_LINE();

	-- End loop
	END LOOP;

	-- Print overall total avg growtg rate, high category g rate, lowest category g rate
	DBMS_OUTPUT.PUT_LINE();
	DBMS_OUTPUT.PUT_LINE();

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
