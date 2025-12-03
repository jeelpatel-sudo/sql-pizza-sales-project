# sql-pizza-sales-project
This project explores a pizza sales dataset using MySQL to practice data cleaning, joining tables, aggregation, and advanced analytical SQL techniques. The goal is to understand sales performance, ordering patterns, and revenue trends using real-world SQL queries. The dataset is sourced from Ayushi0214’s GitHub repository: pizza-sales---SQL (https://github.com/Ayushi0214/pizza-sales---SQL).

**Project Overview**

The analysis is divided into Basic, Intermediate, and Advanced SQL tasks. Each section builds on the previous one to extract deeper insights from the dataset.

**Basic Analysis**

1. Total number of orders – counted all orders placed.
2. Total revenue generated – calculated using pizza prices and quantities.
3. Highest-priced pizza – identified using price comparison.
4. Most common pizza size – determined based on order frequency.
5. Top 5 pizzas by quantity sold – ranked pizzas by total units ordered.

**Intermediate Analysis**

1. Category-wise quantity sold – joined multiple tables to aggregate totals across pizza categories.
2. Order distribution by hour – analyzed ordering patterns throughout the day.
3. Pizza category distribution – identified how many pizza types exist in each category.
4. Average daily pizzas sold – grouped sales by date to calculate daily averages.
5. Top 3 pizzas by revenue – used aggregation and ranking to find top performers.

**Advanced Analysis**

1. Percentage revenue contribution – calculated each pizza’s share of overall revenue using window functions.
2. Cumulative revenue over time – built a running total to observe revenue growth trends.
3. Top 3 pizzas per category by revenue – ranked pizzas within each category using window functions.

**SQL Concepts Used**

**This project practices essential SQL skills including:**
Joins (INNER JOIN), Aggregations (SUM, COUNT, AVG), Grouping & Ordering, Window Functions (Row_number(), Over(), Partition by (), cumulative sums), CTEs for organizing complex queries, Date & time functions such as extracting hours and dates
