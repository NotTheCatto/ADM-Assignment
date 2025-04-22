/*
Boon Earn Iie - Report 1: Top 5 performing library staff in last month
*/
CREATE OR REPLACE PROCEDURE staff_performance_report IS
    -- Declare cursor variables
    TYPE shift_schedule_cursor_type is REF CURSOR;
    shiftSchedule_cursor shift_schedule_cursor_type;

    -- Declare variables
    -- Staff table variables
    v_StaffID Staff.StaffID%TYPE;
    v_StaffName Staff.StaffName%TYPE;
    v_HireDate Staff.HireDate%TYPE;
    v_StaffID Staff.StaffID%TYPE;

    -- Declare cursors
    CURSOR cursor_staff IS
	SELECT s.StaffID, s.StaffName, r.RoleName, AVG(p.ReviewScore) AvgScore, a.Street, a.City, a.PostalCode, a.State, a.Country, c.PhoneNo, c.EmailAddress, s.HireDate, s.Gender,
	    CURSOR (
		SELECT t.ShiftName, t.ShiftStartTime, t.ShiftEndTime t.ShiftDescription
		FROM ShiftType t
		INNER JOIN StaffShiftSchedule sc ON t.ShiftTypeID=sc.ShiftTypeID
		INNER JOIN Staff s ON sc.StaffID=s.StaffID
		ORDER BY ShiftID
	    ) Shift_Info
	FROM Staff s,
	INNER JOIN StaffRole r ON s.RoleID=r.RoleID
	INNER JOIN StaffPerformanceReview p ON s.StaffID=p.StaffID
	INNER JOIN Address a ON s.AddressID=a.AddressID
	INNER JOIN Contact a ON s.ContactID=c.ContactID
	WHERE EXTRACT(month, p.ReviewDate)=EXTRACT(month, SYSDATE)-1
	GROUP BY StaffID
	ORDER BY AvgScore
	LIMIT 5;

BEGIN
    -- Set variables

    -- Print report title / headings
    DBMS_OUTPUT.PUT_LINE('Top 5 performing library staff in ' || TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'MONTH') || ' ' || EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -1)));
    --DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('Date Printed: ' || TO_CHAR(SYSDATE, 'dd-Mon-yyyy'));
    --DBMS_OUTPUT.PUT_LINE(CHR(10));

    -- Open cursor
    OPEN cursor_staff

    -- Loop
    LOOP

	-- Fetch
	FETCH cursor_staff INTO v_CustNo, v_CustName, v_ContactPhone, v_SalesRepEmpNo, v_SalesRepEmpName, cursor_order;

	-- Break loop if cursor fetches nothing
	EXIT WHEN <cursor>$NOTFOUND;

	-- Print

    -- End loop
    END LOOP

    -- Output grand total / summary

    -- Close cursor
END;
/


CREATE OR REPLACE PROCEDURE staff_performance_report IS

     TYPE order_cursor_typ IS REF CURSOR;
     cursor_order    order_cursor_typ;

     --From Customers/Employees Table
     v_CustNo Customers.CustomerNumber%TYPE;
     v_CustName Customers.CustomerName%TYPE;
     v_ContactPhone Customers.Phone%TYPE;
     v_SalesRepEmpNo Customers.SalesRepEmployeeNumber%TYPE;
     v_SalesRepEmpName VARCHAR(60);

     -- From Orders table
     v_OrderNo Orders.OrderNumber%TYPE;
     v_OrderDate Orders.OrderDate%TYPE;
     v_FinalTotal Orders.FinalTotal%TYPE;

     --For Report
     v_GST NUMBER;
     v_TotalCustAmt NUMBER;
     v_TotalCustGST NUMBER;
     v_NoOfCust NUMBER;
     v_GrandTotalSpending NUMBER;
     v_GrandTotalGST NUMBER;
     v_CountOrder   NUMBER;
     v_CountCustomer NUMBER;



     CURSOR cursor_cust IS
     SELECT DISTINCT c.CustomerNumber, CustomerName,  Phone, SalesRepEmployeeNumber, e.FirstName || ' ' || e.LastName As "SalesRepEmpName",
		CURSOR(
			SELECT o.OrderNumber, o.OrderDate, o.FinalTotal
			FROM Orders o
			WHERE c.CustomerNumber = o.CustomerNumber
			AND EXTRACT(YEAR FROM o.OrderDate) = EXTRACT(YEAR FROM SYSDATE)
			AND EXTRACT (MONTH FROM o.OrderDate) = EXTRACT(MONTH FROM SYSDATE)
			ORDER BY o.OrderNumber
		) Order_Info
     FROM Customers c, Employees e, Orders o1
     WHERE c.SalesRepEmployeeNumber = e.EmployeeNumber
     AND c.CustomerNumber = o1.CustomerNumber
    AND EXTRACT(YEAR FROM o1.OrderDate) = EXTRACT(YEAR FROM SYSDATE)
    AND EXTRACT (MONTH FROM o1.OrderDate) = EXTRACT(MONTH FROM SYSDATE);



BEGIN
	v_GST := 0;
	v_TotalCustAmt := 0;
	v_TotalCustGST := 0;
	v_NoOfCust := 0;
	v_GrandTotalSpending := 0;
	v_GrandTotalGST := 0;
	v_CountOrder   := 0;
	v_CountCustomer :=0;

	DBMS_OUTPUT.PUT_LINE('CUSTOMERS MONTHLY ORDER REPORT FOR THE MONTH OF ' || TO_CHAR(SYSDATE, 'MONTH') || ' ' || EXTRACT(YEAR FROM SYSDATE));
	--DBMS_OUTPUT.PUT_LINE(CHR(10));
	DBMS_OUTPUT.PUT_LINE('Date Printed: ' || TO_CHAR(SYSDATE, 'dd-Mon-yyyy'));
	--DBMS_OUTPUT.PUT_LINE(CHR(10));

	OPEN cursor_cust;
	LOOP
	     FETCH cursor_cust INTO v_CustNo, v_CustName, v_ContactPhone, v_SalesRepEmpNo, v_SalesRepEmpName, cursor_order;
	     EXIT WHEN cursor_cust%NOTFOUND;
		v_NoOfCust := v_NoOfCust + 1;
		DBMS_OUTPUT.PUT_LINE(CHR(10));
		DBMS_OUTPUT.PUT_LINE('Customer No : ' || v_CustNo);
		DBMS_OUTPUT.PUT_LINE('Customer Name : ' || v_CustName);
		DBMS_OUTPUT.PUT_LINE('Contact No : ' || v_ContactPhone);
		DBMS_OUTPUT.PUT_LINE('Sales Rep No/Name: ' || v_SalesRepEmpNo || ' - ' || v_SalesRepEmpName);
		DBMS_OUTPUT.PUT_LINE(RPAD('.',80,'.'));

		v_CountOrder := 0; --reset no. of orders for each customer
		--=====================================
		-- Display Orders for each customer
		--=====================================
		v_TotalCustAmt := 0.0;
		v_TotalCustGST := 0.0;

		LOOP
		FETCH cursor_order INTO v_OrderNo, v_OrderDate, v_FinalTotal;
		EXIT WHEN cursor_order%NOTFOUND;
			v_CountOrder := v_CountOrder + 1;
			v_TotalCustAmt := v_TotalCustAmt + v_FinalTotal;
			v_GST := v_FinalTotal * 0.06;
			v_TotalCustGST := v_TotalCustGST + v_GST;
			DBMS_OUTPUT.PUT_LINE(RPAD((v_CountOrder || '.  Order Date : ' || v_OrderDate),30));
			DBMS_OUTPUT.PUT_LINE(RPAD('Final Total: RM ' || TO_CHAR(v_FinalTotal,'$99,999.99'),30));
			DBMS_OUTPUT.PUT_LINE(RPAD('GST Amount: RM ' || TO_CHAR(v_GST,'$99,999.99'),30));
			DBMS_OUTPUT.PUT_LINE(CHR(10));
		END LOOP;
		v_GrandTotalSpending := v_GrandTotalSpending + v_TotalCustAmt;
		v_GrandTotalGST := v_GrandTotalGST + v_TotalCustGST;
	END LOOP;
	CLOSE cursor_cust;
END;
/


