-- Q1: Total sales revenue by product category for each month
SELECT
    d.year_number,
    d.month_number,
    d.month_name,
    p.category,
    SUM(f.revenue) AS total_sales_revenue
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY d.year_number, d.month_number, d.month_name, p.category
ORDER BY d.year_number, d.month_number, p.category;

-- Q2: Top 2 performing stores by total revenue
SELECT
    s.store_name,
    s.store_city,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_store s
    ON f.store_key = s.store_key
GROUP BY s.store_name, s.store_city
ORDER BY total_revenue DESC, s.store_name
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
WITH monthly_sales AS (
    SELECT
        d.year_number,
        d.month_number,
        d.month_name,
        SUM(f.revenue) AS monthly_revenue
    FROM fact_sales f
    JOIN dim_date d
        ON f.date_key = d.date_key
    GROUP BY d.year_number, d.month_number, d.month_name
)
SELECT
    year_number,
    month_number,
    month_name,
    monthly_revenue,
    monthly_revenue - LAG(monthly_revenue) OVER (
        ORDER BY year_number, month_number
    ) AS mom_revenue_change
FROM monthly_sales
ORDER BY year_number, month_number;
