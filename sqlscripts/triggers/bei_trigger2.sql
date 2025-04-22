/*
Boon Earn Iie - Trigger 2: Create fine records if books are returned late
*/
CREATE OR REPLACE TRIGGER TRG_XXX
AFTER INSERT ON XXX
FOR EACH ROW
DECLARE
    -- Declare neccessary variables

BEGIN
    -- Fetch return date and due date

    -- If return date is NULL, end trigger

    -- Compare due date greater than due date, create Fine record, else end trigger

    -- Prompt Fine record is created alongsidee new FineID

END;
/

/* Example
CREATE OR REPLACE TRIGGER TRG_UPT_ORDERS_AMT
AFTER INSERT ON orderDetails
FOR EACH ROW
DECLARE
   v_OrderAmount   NUMBER := 0.00;
   v_TotalDiscount NUMBER := 0.00;
   v_FinalTotal    NUMBER := 0.00;
   v_discount      number(2,2);
BEGIN
   select discount into v_discount
   from Orders
   where orderNumber = :orderNumber;

   v_OrderAmount   := :new.priceEach * :new.quantityOrdered;
   v_TotalDiscount := ROUND(v_OrderAmount*discount,2);
   v_FinalTotal    := v_OrderAmount - v_TotalDiscount;

   UPDATE ORDERS
   SET OrderAmount   = OrderAmount + v_OrderAmount,
       TotalDiscount = TotalDiscount + v_TotalDiscount,
       FinalTotal    = FinalTotal + v_FinalTotal
   WHERE orderNumber = :new.orderNumber;
END;
/
*/
