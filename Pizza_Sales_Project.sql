/*PIZZA SALES DATA EXPLORATION */

-- How many types of Pizzas we have?
SELECT
      COUNT(DISTINCT(name)) AS Number_Of_Pizzatypes
FROM Pizza_types;
-- We have 32 types of pizza

-- How many categories of Pizza do we have?
SELECT 
      COUNT(DISTINCT(Category)) AS Number_Of_Categories
FROM pizza_types;
-- We have 4 Categories of Pizza

-- Total Quantity Sold
SELECT SUM(Quantity)
FROM Order_details;
-- 49574 were sold in 2015


-- Number of orders , quantitiy Ordered and Revenue per Pizza Size
SELECT
     Size,
     COUNT(order_id) AS Number_Of_Orders,
     SUM(quantity) AS Quantity_Ordered,
     ROUND(SUM(quantity*price)) Revenue
FROM pizzas P
JOIN order_details Od
ON P.pizza_id = Od.pizza_id
GROUP BY Size
ORDER BY Size ;

-- Number of orders , quantitiy Ordered and Revenue per Pizza Size
SELECT 
      Category,
	  COUNT(order_id) AS Number_Of_Orders,
	  SUM(quantity) AS Quantity_Ordered,
	  ROUND(SUM(quantity*price)) Revenue
FROM pizzas P
JOIN order_details Od
ON P.pizza_id = Od.pizza_id
JOIN pizza_types Pt
ON P.pizza_type_id = pt.pizza_type_id
GROUP BY  category;
      

-- How many customers do we have each day?
SELECT 
	  dayofweek(date) AS Day_number,
	  dayname(date) AS Weekday,
      COUNT(order_id) AS Number_of_Customer
FROM orders
GROUP BY Day_number , Weekday
Order by Day_number;

-- The Are there any peak hours?
    SELECT 
           DISTINCT(hour(time)) AS Hour,
		   COUNT(order_id) AS Orders
From orders
GROUP BY  Hour
ORDER BY  Orders DESC;


-- How many pizzas are typically in an order? 
SELECT 
      name AS Pizza_Name , 
	  COUNT(order_id) AS Number_of_Order,
	  SUM(quantity) AS Quantity_Ordered
FROM Pizzas P
JOIN order_details Od
ON P.pizza_id = Od.pizza_id
JOIN pizza_types Pt
ON P.pizza_type_id = pt.pizza_type_id
GROUP BY  Pizza_Name
ORDER BY Quantity_Ordered DESC;

--  Top 5 bestsellers
SELECT 
      name AS Pizza_Name , 
	  COUNT(order_id) AS Number_of_Order,
	  SUM(quantity) AS Quantity_Ordered
FROM Pizzas P
JOIN order_details Od
ON P.pizza_id = Od.pizza_id
JOIN pizza_types Pt
ON P.pizza_type_id = pt.pizza_type_id
GROUP BY  Pizza_Name
ORDER BY Quantity_ordered DESC
LIMIT 5;

-- How much money did we make this year? Can we indentify any seasonality in the sales?

SELECT 
	  ROUND(SUM(Quantity * Price)) AS Revenue
FROM Pizzas P
JOIN order_details Od
ON P.pizza_id = Od.pizza_id
JOIN pizza_types Pt
ON P.pizza_type_id = Pt.pizza_type_id;

-- Can we indentify any seasonality in the sales?
SELECT 
      monthname(date) AS Month,
	  ROUND(SUM(Quantity * Price))AS Revenue
FROM Pizzas P
JOIN order_details Od
ON P.pizza_id = Od.pizza_id
JOIN pizza_types Pt
ON P.pizza_type_id = Pt.pizza_type_id
JOIN orders O
ON O.order_id = Od.order_id
GROUP BY Month;

-- Revenue by Hour
SELECT 
      DISTINCT(Hour(time)) AS Hour,
	  ROUND(SUM(Quantity * Price))AS Revenue
FROM Pizzas P
JOIN order_details Od
ON P.pizza_id = Od.pizza_id
JOIN pizza_types Pt
ON P.pizza_type_id = Pt.pizza_type_id
JOIN orders O
ON O.order_id = Od.order_id
GROUP BY  Hour;

-- Are there any pizzas we should take of the menu, or any promotions we could leverage?
SELECT 
      name AS Pizza_Name,
      -- COUNT(order_id) AS Number_of_Order,
      SUM(Quantity) AS Quantity_Ordered,
	  ROUND(SUM(Quantity * Price))AS Revenue
FROM Pizzas P
JOIN order_details Od
ON P.pizza_id = Od.pizza_id
JOIN pizza_types Pt
ON P.pizza_type_id = Pt.pizza_type_id
JOIN orders O
ON O.order_id = Od.order_id
GROUP BY 1
ORDER BY Revenue;

 


