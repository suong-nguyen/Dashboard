/* PROJECT WALK THOUGH */
--- 1. Import Data in SQL
--- 2. KPIs: Total Revenue, Average Order Value, Total Pizzas Sold, Total Orders, Average Pizzas Per Order
--- 3. Daily Trend
--- 4. Monthly Trend
--- 5. % of Sales by Category 
--- 6. % of Sales by Size
--- 7. Top 5 by: revenue, quantity, No.order
--- 8. Bottom 5: revenue, quantity, No.order


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- 1. Import Data in SQL
	Create database Pizza_sales
	use Pizza_sales


--- 2. KPIs: Total Revenue, Average Order Value, Total Pizzas Sold, Total Orders, Average Pizzas Per Order
	
	--- Total Revenue, Average Order Value, Total Pizzas Sold, Total Orders

	SELECT Round(SUM(total_price),0) AS Total_Revenue,
		   Round((SUM(total_price) / COUNT(DISTINCT order_id)),2) AS Avg_order_Value,
		   SUM(quantity) AS Total_pizza_sold,
		   COUNT(DISTINCT order_id) AS Total_Orders
	FROM pizza_sales

	
	--- Average Pizzas Per Order

	SELECT round(SUM(quantity)/ COUNT(DISTINCT order_id),2)
	AS Avg_Pizzas_per_order
	FROM pizza_sales


--- 3. Daily Trend
	SELECT DATENAME(DW, order_date) AS order_day, 
		   COUNT(DISTINCT order_id) AS total_orders 
	FROM pizza_sales
	GROUP BY DATENAME(DW, order_date)



--- 4. Monthly Trend
	Select DATENAME(MONTH, order_date) as Month_Name, 
		   COUNT(DISTINCT order_id) as Total_Orders
	from pizza_sales
	GROUP BY DATENAME(MONTH, order_date) 


--- 5. % of Sales by Category 
	SELECT pizza_category, 
		   Round(SUM(total_price),2) as total_revenue,
		   Round(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales),2) AS PCT
	FROM pizza_sales
	GROUP BY pizza_category
	Order by 3 desc


--- 6. % of Sales by Size
	SELECT pizza_size, 
		   Round(SUM(total_price),0) as total_revenue,
		   Round(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales),2) AS PCT
	FROM pizza_sales
	GROUP BY pizza_size
	ORDER BY pizza_size


--- 7. Top 5 
	
	--- by revenue
	SELECT	Top 5 pizza_name, 
			SUM(total_price) AS Total_Revenue
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Revenue DESC


	-- by quantity
	SELECT	Top 5 pizza_name, 
			SUM(quantity) as Total_quantity
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_quantity DESC

	-- by order
	SELECT	Top 5 pizza_name, 
			COUNT(DISTINCT order_id) AS Total_Orders
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Orders DESC




--- 8. Bottom 5
	
	--- by revenue
	SELECT	Top 5 pizza_name, 
			SUM(total_price) AS Total_Revenue
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Revenue 


	-- by quantity
	SELECT	Top 5 pizza_name, 
			SUM(quantity) as Total_quantity
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_quantity 

	-- by order
	SELECT	Top 5 pizza_name, 
			COUNT(DISTINCT order_id) AS Total_Orders
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Orders 