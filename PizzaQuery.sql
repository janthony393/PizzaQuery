-- Total Revenue

select SUM(total_price) as TotalRevenue
from dbo.pizzaDB

-- Total Number of Orders

select SUM(total_price) / COUNT(Distinct order_id) as AverageOrder
from dbo.pizzaDB

-- Total Pizza's sold

select Sum(quantity) as Total_Pizza_Sold
from dbo.pizzaDB

--Total Order's placed

select Count(distinct order_id) as TotalOrders
from dbo.pizzaDB


-- Average Pizza Sold

select CAST(Cast(SUM(quantity) as Decimal(10,2)) / 
CAST(Count(Distinct order_id) AS Decimal (10,2)) AS decimal(10,2)) as AVG_PIZZA_PERORDER
FROM dbo.pizzaDB

--Daily Trend

SELECT DATENAME(DW, order_date) as OrderDay, COUNT(DISTINCT Order_id) as Total_Orders
from dbo.pizzaDB
Group by DATENAME(DW, order_date)

--Hourly Trend

select DATEPART(HOUR, order_time) as Order_hours, COUNT(DISTINCT Order_id) as Total_Orders
from dbo.pizzaDB
Group by DATEPART(HOUR, order_time)
Order by DATEPART(HOUR, order_time)

--Percentage of Sales by Pizza Category

select pizza_category, SUM(total_price) as Total_Sales, SUM(total_price) * 100 / (select sum(total_price)
from dbo.pizzaDB WHERE MONTH(ORDER_DATE) = 1) as PCT
from dbo.pizzaDB 
WHERE MONTH(ORDER_DATE) = 1
Group by pizza_category

--Percentage by Sales by Pizza Size

select pizza_size, SUM(total_price) as Total_Sales, cast (SUM(total_price) * 100 / (select sum(total_price)
from dbo.pizzaDB Where DATEPART(quarter, order_date) = 1)  AS decimal (10,2)) as PCT
from dbo.pizzaDB 
Where DATEPART(quarter, order_date) = 1
Group by pizza_size
Order by PCT DESC

--Total Pizza sold by Pizza Category

select pizza_category, sum(quantity) as Total_Pizza_Sold
from dbo.pizzaDB
Group by pizza_category

--Top 5 best Sellers

select top 5 pizza_name, sum(quantity) as Total_Pizza_Sold
from dbo.pizzaDB
Group by pizza_name
Order by sum(quantity) DESC

-- Bottom 5 Pizza

select top 5 pizza_name, sum(quantity) as Total_Pizza_Sold
from dbo.pizzaDB
WHERE MONTH(order_date) = 1
Group by pizza_name
Order by sum(quantity) ASC



