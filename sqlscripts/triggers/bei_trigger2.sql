/*
Boon Earn Iie - Trigger 2: Validate status code of each updated book copies  WARN: Incomplete
*/
CREATE OR REPLACE TRIGGER TRG_XXX
AFTER INSERT ON XXX
FOR EACH ROW
DECLARE
	-- Declare neccessary variables

BEGIN
	-- Fetch all Loan records that is associated with the BookCopyID
	-- Check if thre are any NULL values in ReturnDate field
	OPEN loan_cursor;
	LOOP
		FETCH loan_cursor INTO;
		-- if return date null, flag on

	END LOOP
	CLOSE loan_cursor;

	-- Open cursor
	OPEN bookcopy_cursor;

	-- Fetch statuscode of book
	FETCH bookcopy_cursor INTO;

	-- If NULL value found, check if 1 or 3
	IF (<flag on>) THEN
		-- ch2ck if 2
		-- else correct to 3 and print warning msg

	ELSE
		-- check if 1 or 3
		-- else correct to 2 and print borrower name and contact info

	END IF;

EXCEPTION
	WHEN overlapped_schedule THEN
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('BookCopy with the ID ''' || p_BookCopyID || ''' is not available for loan.');
	WHEN others THEN
		v_code := SQLCODE;
		v_errMsg := SUBSTR(SQLERRM, 1, 64);
		DBMS_OUTPUT.PUT_LINE('--- ERROR ---');
		DBMS_OUTPUT.PUT_LINE('An exception has occured.');
		DBMS_OUTPUT.PUT_LINE('Error code: ' || v_code);
		DBMS_OUTPUT.PUT_LINE('Error message: ' || v_errmsg);
		ROLLBACK;
END;
/


/* Example
CREATE OR REPLACE TRIGGER TRG_UPT_ORDERS_AMT
AFTER INSERT ON orderDetails
FOR EACH ROW
DECLARE
	v_OrderAmount   NUMBER := 0.00;
	v_TotalDiscount NUMBER := 0.00;
	v_FinalTotal	NUMBER := 0.00;
	v_discount	  number(2,2);
BEGIN
	select discount into v_discount
	from Orders
	where orderNumber = :orderNumber;

	v_OrderAmount   := :new.priceEach * :new.quantityOrdered;
	v_TotalDiscount := ROUND(v_OrderAmount*discount,2);
	v_FinalTotal	:= v_OrderAmount - v_TotalDiscount;

	UPDATE ORDERS
	SET OrderAmount   = OrderAmount + v_OrderAmount,
		TotalDiscount = TotalDiscount + v_TotalDiscount,
		FinalTotal	= FinalTotal + v_FinalTotal
	WHERE orderNumber = :new.orderNumber;
END;
/
*/
