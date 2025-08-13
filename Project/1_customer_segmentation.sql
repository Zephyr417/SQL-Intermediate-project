-- Customer Segmentation
-- Questions: Who are our most valuable customers?

WITH customer_level AS(
    SELECT
        customerkey,
        SUM(quantity * netprice * exchangerate) AS total_revenue
    FROM
        sales
    GROUP BY
        customerkey
    ORDER BY
        customerkey
), 
customer_segment AS (
SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_revenue) AS ltv_25,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_revenue) AS ltv_75
FROM customer_level
)

SELECT
    COUNT(DISTINCT customerkey) AS customer_count,
    CAST(SUM(total_revenue) AS DECIMAL(12,2)) AS total_ltv,
    CAST(100*SUM(total_revenue) / (SELECT SUM(total_revenue) FROM customer_level) AS DECIMAL(10,1)) AS ltv_percentage,
    CASE WHEN total_revenue > customer_segment.ltv_75 THEN 'High-Value'
        WHEN total_revenue < customer_segment.ltv_25 THEN 'Low-Value'
        ELSE 'Medium-Value'
        END AS level,
    CAST(SUM(total_revenue)/COUNT(DISTINCT customerkey) AS DECIMAL(10,2)) AS avg_ltv
FROM
    customer_level, customer_segment
GROUP BY
    level
ORDER BY
    level




-- Subquery
WITH customer_level AS(
    SELECT
        customerkey,
        SUM(quantity * netprice * exchangerate) AS total_revenue
    FROM
        sales
    GROUP BY
        customerkey
    ORDER BY
        customerkey
), 
customer_segment AS (
SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_revenue) AS ltv_25,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_revenue) AS ltv_75
FROM customer_level
)

SELECT
    c.*,
    CASE WHEN total_revenue > cs.ltv_75 THEN 'High'
        WHEN total_revenue < cs.ltv_25 THEN 'Low'
        ELSE 'Medium'
        END AS level
FROM
    customer_level c,
    customer_segment cs