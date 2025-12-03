# sql-pizza-sales-project
This project performs exploratory data analysis on a pizza sales dataset using MySQL. The analysis focuses on sales performance, order patterns, revenue trends, and pizza category insights using aggregation, ranking, and window functions.


**Key Analyses Performed**

**Sales & Revenue Analysis :**

1. Calculated total orders, total revenue, and average daily sales

2. Identified the highest-priced pizza and best-selling pizza sizes

3. Extracted the top 5 most-ordered pizza types

**Category & Quantity Insights :**

1. Aggregated total quantities sold by pizza category

2. Counted pizza types per category

3. Identified top 3 pizzas by revenue using CTEs and window functions

**Time-Based Analysis :**

1. Analyzed order distribution by hour

2. Computed revenue contribution (%) by category

3. Calculated cumulative revenue over time using window functions
   
**Techniques Used :**

This project demonstrates SQL concepts such as:

1. CTEs for structured queries

2. Window functions (ROW_NUMBER(), cumulative sums, percent calculations)

3. Aggregations (SUM, COUNT, AVG)

4. Date & string functions (HOUR(), SUBSTRING())

5. Ranking pizza performance within categories
