WITH yearly_cohort AS (
    SELECT DISTINCT
        customerkey,
        EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year,
        s.quantity * s.netprice * s.exchangerate AS revenue
    FROM sales s
)

SELECT DISTINCT
    cohort_year,
    COUNT(DISTINCT y.customerkey) AS total_customers,
    SUM(revenue) AS total_revenue,
    CAST(SUM(revenue)/COUNT(DISTINCT y.customerkey) AS DECIMAL(10, 2)) AS customer_revenue
FROM yearly_cohort y
GROUP BY
    cohort_year 
ORDER BY
    cohort_year

-- Use the cohort_analysis view
SELECT
    cohort_year,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(total_net_revenue) AS total_revenue,
    CAST(SUM(total_net_revenue) / COUNT(DISTINCT customerkey) AS DECIMAL(10, 2)) AS customer_revenue
FROM
    cohort_analysis
GROUP BY
    cohort_year
ORDER BY
    cohort_year


-- Monthly based revenue analysis
SELECT
    TO_CHAR(orderdate, 'YYYY-MM') AS year_month,
    CAST(SUM(total_net_revenue) AS DECIMAL(10,2)) AS total_revenue,
    COUNT(DISTINCT customerkey) AS total_customers,
    CAST(SUM(total_net_revenue)  / COUNT(DISTINCT customerkey) AS DECIMAL(10,2)) AS customer_revenue
    
FROM
    cohort_analysis
GROUP BY
    year_month
ORDER BY
    year_month

-- Monthly based revenue analysis (ROlling average)
WITH based AS (
    SELECT
    TO_CHAR(orderdate, 'YYYY-MM') AS year_month,
    CAST(SUM(total_net_revenue) AS DECIMAL(10,2)) AS total_revenue,
    COUNT(DISTINCT customerkey) AS total_customers,
    CAST(SUM(total_net_revenue)  / COUNT(DISTINCT customerkey) AS DECIMAL(10,2)) AS customer_revenue
    
FROM
    cohort_analysis
GROUP BY
    year_month
ORDER BY
    year_month
)

SELECT
    year_month,
    CAST(AVG(total_revenue) OVER(ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS DECIMAL(10,2)) AS total_revenue,
    CAST(AVG(total_customers) OVER(ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS DECIMAL(10,2)) AS total_customers,
    CAST(AVG(total_revenue) OVER(ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) / AVG(total_customers) OVER(ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS DECIMAL(10,2)) AS customer_revenue
FROM
    based
