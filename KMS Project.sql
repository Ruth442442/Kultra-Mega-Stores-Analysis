select * from dbo.KMS
--------- Question 1----------
SELECT TOP 1
    Product_Category,
    SUM(Sales) AS TotalSales
FROM
    dbo.KMS
GROUP BY
    Product_Category
ORDER BY
    TotalSales DESC;

	-------- Question 2-------
	SELECT TOP 3
    Region,
    SUM(Sales) AS TotalSales
FROM
    dbo.KMS
GROUP BY
    Region
ORDER BY
    TotalSales DESC;

		SELECT TOP 3
    Region,
    SUM(Sales) AS TotalSales
FROM
    dbo.KMS
GROUP BY
    Region
ORDER BY
    TotalSales ASC;

	------ Question 3 ---------
	
	Select
	sum(sales) as totalsalesapplianceonterio
	from 
	    dbo.KMS
	where 
	    product_category = 'appliance'
	AND region = 'onterio'



   ------- Question 4 ----------

		SELECT top 10
    Customer_Name,
	Customer_Segment,
	Product_Category, 
	SUM(sales) AS TotalSales
FROM
     dbo.KMS
GROUP BY
    Customer_Name,
	Customer_Segment,
	Product_Category
ORDER BY
    TotalSales ASC

--------- Question 5 --------
		SELECT top 1
    Ship_Mode,
    SUM(Shipping_Cost) AS TotalShippingCost
FROM
    dbo.KMS
GROUP BY
    Ship_Mode
ORDER BY
    TotalShippingCost DESC


	-------- Question 6 --------- 
	SELECT TOP 5
    Customer_Name,
    [Product_Category],
    [Customer_Segment],
    SUM(Sales) AS TotalSales
FROM KMS
GROUP BY Customer_Name, [Product_Category], [Customer_Segment]
ORDER BY TotalSales DESC

----- Question 7 -------
SELECT TOP 1
    Customer_Name,
    SUM(Sales) AS TotalSales
FROM KMS
WHERE [Customer_Segment] = 'Small Business'
GROUP BY Customer_Name
ORDER BY TotalSales DESC

------ Question 8 -------
SELECT TOP 1
    Customer_Name,
    COUNT(DISTINCT [Order_ID]) AS NumberOfOrders
FROM KMS
WHERE [Customer_Segment] = 'Corporate'
  AND [Order_Date] BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY Customer_Name
ORDER BY NumberOfOrders DESC;

------- Question 9 --------
SELECT TOP 1
    Customer_Name,
    SUM(Profit) AS TotalProfit
FROM KMS
WHERE [Customer_Segment] = 'Consumer'
GROUP BY Customer_Name
ORDER BY TotalProfit DESC

------ Question 10 -------

SELECT 
    k.Customer_Name,
    k.[Customer_Segment]
FROM KMS k
JOIN ORDER_STATUS os ON k.[Order_ID] = os.[Order_ID]
WHERE os.Status = 'Returned';

------ Question 11 -------
Select Order_Priority, Ship_Mode,
    COUNT([Order_ID]) AS [order count],
    SUM(sales - profit) AS [Estimated shipping cost],
    AVG(DATEDIFF(DAY, [Order_Date], [Ship_Date])) AS [Avg ship date]
from  [KMS] 
group by Order_Priority,Ship_Mode
order by  Order_Priority,Ship_Mode desc

------ No, the company did not spend shipping costs appropriately based on order priority. High priority orders used Delivery Truck more than Express Air, even though it was slower and more expensive (₦1.33M vs ₦206K).Low priority orders still used Express Air, wasting money on a fast, costly method (₦191K), despite delivery still taking 4 days -----


