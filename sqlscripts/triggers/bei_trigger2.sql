/*
Boon Earn Iie - Trigger 2: Validate status code of each updated book copies  WARN: Incomplete
*/
CREATE OR REPLACE TRIGGER TRG_XXX
AFTER INSERT ON XXX
FOR EACH ROW
DECLARE
	-- Declare neccessary variables

BEGIN
	-- Fetch statuscode of book

	-- Fetch all Loan records that is associated with the BookCopyID

	-- Check if thre are any NULL values in ReturnDate field

	-- If NULL value found, check if 1 or 3

		-- If 1, change to 2 and set success msg

		-- Else if 3, warn anomaly alongside Loan details

	-- Else if no NULL value, check and set to 1 if not 1 and set success msg

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
