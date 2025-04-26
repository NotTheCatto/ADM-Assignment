/*
Boon Earn Iie - Trigger 1: Validate new assignments of staffs’ shift schedules  WARN: Incomplete
*/
CREATE OR REPLACE TRIGGER TRG_XXX
AFTER INSERT ON XXX
FOR EACH ROW
DECLARE
	-- Declare neccessary variables

	-- Declare exceptions
	overlapped_schedule EXCEPTION;

BEGIN
	-- Open cursor
	OPEN assigned_cursor;

	-- Loop
	LOOP
		-- Fetch all assigned shift schedules
		FETCH assigned_cursor INTO

		-- Compare inserted start and end time with existing shift start and end time
		IF () THEN
		-- fetched(f), inserted(i)
		-- fstarttime < istarttime < fendtime, raise
		-- fstarttime < iendtime < fendtime, raise

		-- Raise error if overlapping found
		END IF;
	-- End loop
	END LOOP;

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
