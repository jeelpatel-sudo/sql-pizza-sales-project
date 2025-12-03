-- Basic:
-- 1. Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders_placed
FROM
    orders;

-- 2. Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- 3. Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- 4. Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS total_order
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY total_order DESC;

-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS total_ordered_pizza
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY 2 DESC
LIMIT 5;

-- Intermediate:
-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity_order
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category;

-- 2.Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(orders.time) AS hour,
    COUNT(orders.order_id) AS total_orders
FROM
    orders
GROUP BY hour
ORDER BY 1 ASC;

-- 3.Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pizza_types.category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- 4a.Calculate the average number of ordered per day.
with CTE_T1 as (SELECT 
    SUBSTRING(orders.date, 6, 5) AS dates,
    COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY dates) 
SELECT 
   ROUND(AVG(total_orders), 1) AS Avg_Order_Per_Day
FROM
    CTE_T1;

-- 4b.Group the orders by date and calculate the average number of pizzas ordered per day.
With CTE_2 as
(SELECT 
    SUBSTRING(orders.date, 6, 5) AS dates,
    SUM(order_details.quantity) AS Num_pizzas_per_day
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY dates)
SELECT 
    ROUND(AVG(Num_pizzas_per_day), 2) AS Avg_Num_Pizzas_Per_Day
FROM
    CTE_2 ;

-- 5.Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY 2 DESC
LIMIT 3;

-- Advanced:
-- 1.Calculate the percentage contribution of each pizza type to total revenue.
with CTE_Revenue as 
(SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
)

SELECT 
    pizza_types.category,
    ROUND((SUM(order_details.quantity * pizzas.price)/ (Select Sum(Revenue)From CTE_Revenue) * 100), 2) AS Revenue_Contribution_in_Percentage
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category ;

-- 2.Analyze the cumulative revenue generated over time.
With CTE_Rolling_Total as 
(SELECT 
    SUBSTRING(orders.date, 6,5 ) AS dates,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Revenue
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
        JOIN
    Pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY `dates`)

Select 
	`dates`, Revenue, ROUND(sum(Revenue) over (order by `dates`), 2) as Cumulative_Revenue
From
	CTE_Rolling_Total ;

-- 3.Determine the top 3 most ordered pizza types based on revenue for each pizza category.
-- pizza category , pizza name, revenue, ranking

With CTE_Revenue as 
(SELECT 
    pizza_types.category, pizza_types.name, ROUND (SUM(order_details.quantity * pizzas.price), 2) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category, pizza_types.`name` ),

CTE_Revenue_Rankings (Category, Name, Revenue, Top_3_Most_Ordered_Pizzas) as 
(SELECT
	* , row_number () over (partition by `category` order by Revenue) as Top_3_Most_Ordered_Pizzas
From 
	CTE_Revenue)
SELECT 
    *
FROM
    CTE_Revenue_Rankings
WHERE
    Top_3_Most_Ordered_Pizzas <= 3;