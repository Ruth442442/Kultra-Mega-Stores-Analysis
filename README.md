# Kultra-Mega-Stores-Analysis
SQL  case study for Kultra Mega Stores using SQL to analyze sales, customers, and shipping data (2009–2012).
## Company Overview

Kultra Mega Stores (KMS) is a leading retail and wholesale company based in Lagos, Nigeria, specializing in office supplies and furniture. The company serves a diverse customer base, including individual consumers, small business owners, and large corporate clients. This project focuses on data from the Abuja division, where management has requested data-driven insights from historical order data (2009–2012) to support business decisions and growth strategies


##  Objectives
Analyze historical order data to:
- Identify high-performing product categories
- Understand customer and regional sales patterns
- Optimize shipping strategies
- Advise on customer segmentation and revenue growth

##  Tools Used
- SQL

##  Insights

### 1. Which product category had the highest sales?

```sql
SELECT TOP 1
    Product_Category,
    SUM(Sales) AS TotalSales
FROM
    dbo.KMS
GROUP BY
    Product_Category
ORDER BY
    TotalSales DESC;
```
**Insight:**
The product category with the highest sales is Technology, with a total sales value of ₦5,984,248.18


### 2. What are the Top 3 and Bottom 3 regions in terms of sales?
```
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
```
**Insight:**
Top 3 Regions with the highest sales:
West
Ontario
Prairie

 Bottom 3 Regions with the lowest sales:
Nunavut
Northwest Territories
Yukon

### 3. What were the total sales of appliances in Ontario?
```sql
	Select
	sum(sales) as totalsalesapplianceonterio
	from 
	    dbo.KMS
	where 
	    product_category = 'appliance'
	AND region = 'onterio'
```
**Insight:**
No sales were recorded under the "Appliances" category in Ontario, or in the entire dataset

### 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers

```
		SELECT top 10
    Customer_Name,
    SUM(sales) AS TotalSales
FROM
     dbo.KMS
GROUP BY
    Customer_Name
ORDER BY
    TotalSales ASC
```
**Insights & Recommendations:**

Customer Segments:
Most of these low-value customers are from the Consumer, Home Office, and Small Business segments, with a few from Corporate.

Product Categories:
The majority purchased Furniture and Office Supplies, which typically have moderate margins but may lack recurring demand
To increase revenue from the bottom 10 customers, KMS should re-engage them through targeted promotions and personalized communication, especially within the Consumer and Home Office segments. Offering bundled product deals and occasional loyalty discounts can encourage higher spending. For small business clients, simple B2B incentives like flexible pricing or priority service may improve retention. Additionally, gathering feedback through short surveys can reveal specific barriers to purchase and inform future engagement strategies

### 5. KMS incurred the most shipping cost using which shipping method?
```
		SELECT top 1
    Ship_Mode,
    SUM(Shipping_Cost) AS TotalShippingCost
FROM
    dbo.KMS
GROUP BY
    Ship_Mode
ORDER BY
    TotalShippingCost DESC
```
**Insight:**  
Delivery Truck was the most expensive shipping method, with a total cost of ₦51,971.94. While it's likely used for large orders, the high spend suggests it may be overused. KMS could reduce costs by reviewing when this method is truly necessary.

### 6. Who are the most valuable customers, and what products or services do they typically purchase?
```
	SELECT TOP 5
    Customer_Name,
    [Product_Category],
    [Customer_Segment],
    SUM(Sales) AS TotalSales
FROM KMS
GROUP BY Customer_Name, [Product_Category], [Customer_Segment]
ORDER BY TotalSales DESC
```
**Insight:**
KMS’s top customers, led by Emily Phan, mainly purchased **Technology** products across all segments. This confirms Technology as the key revenue driver and highlights the importance of retaining high-value tech buyers

### 7. Which small business customer had the highest sales?
```
SELECT TOP 1
    Customer_Name,
    SUM(Sales) AS TotalSales
FROM KMS
WHERE [Customer_Segment] = 'Small Business'
GROUP BY Customer_Name
ORDER BY TotalSales DESC
```
**Insight:**
Dennis Kane stands out as our top small business customer, with total sales of ₦75,967.59.

### 8. Which corporate customer placed the most number of orders in 2009–2012?
```
SELECT TOP 1
    Customer_Name,
    COUNT(DISTINCT [Order_ID]) AS NumberOfOrders
FROM KMS
WHERE [Customer_Segment] = 'Corporate'
  AND [Order_Date] BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY Customer_Name
ORDER BY NumberOfOrders DESC;
```
**Insight:**
Adam Hart placed the most orders among corporate customers during 2009–2012, with a total of 18 orders

### 9. Which consumer customer was the most profitable one?
```
SELECT TOP 1
    Customer_Name,
    SUM(Profit) AS TotalProfit
FROM KMS
WHERE [Customer_Segment] = 'Consumer'
GROUP BY Customer_Name
ORDER BY TotalProfit DESC
```
**Insight:**
Emily Phan was the most profitable consumer customer, generating a total profit of ₦34,005.44.

### 10. Which customer returned items, and what segment do they belong to?
```
SELECT 
    k.Customer_Name,
    k.[Customer_Segment]
FROM KMS k
JOIN ORDER_STATUS os ON k.[Order_ID] = os.[Order_ID]
WHERE os.Status = 'Returned';
```
**Insight:**
A total of 872 customers returned items, spanning all customer segments. Notable repeat returners include Dorothy Badders, Grant Carroll, and Carlos Soltero, suggesting potential issues worth reviewing.


### 11. If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority? 
```
Select Order_Priority, Ship_Mode,
    COUNT([Order_ID]) AS [order count],
    SUM(sales - profit) AS [Estimated shipping cost],
    AVG(DATEDIFF(DAY, [Order_Date], [Ship_Date])) AS [Avg ship date]
from  [KMS] 
group by Order_Priority,Ship_Mode
order by  Order_Priority,Ship_Mode desc
```
**Insight:** 
The company did not align shipping methods with order priority. High-priority orders often used slower Delivery Truck services instead of Express Air, while low-priority orders unnecessarily incurred high Express Air costs. This mismatch led to inefficient shipping spend, suggesting a need to revise logistics policies based on order urgency.

## File
[View sql file](KMS_Project.sql)



