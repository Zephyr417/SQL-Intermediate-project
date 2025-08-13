-- Customer Retention
-- Who hasn't been purchasing for the last 6 month?
-- For e-commerce company, churn period is 6-12 month since last purchase
WITH customer_purchase AS (
SELECT
    orderdate,
    customerkey,
    EXTRACT(YEAR FROM MIN(orderdate) OVER(PARTITION BY customerkey)) AS cohort_year,
    MAX(orderdate) OVER() AS latest_date
FROM
    sales
) ,
customer_retention AS(
SELECT
    customerkey,
    MIN(orderdate) AS first_purchase_date,
    MAX(orderdate) AS last_purchase_date,
    MIN(cohort_year) AS cohort_year,
    CASE WHEN MAX(orderdate) > MAX(latest_date) - INTERVAL '6 Month' THEN 'Active'
        ELSE 'Churned' 
        END AS customer_status
FROM
    customer_purchase
GROUP BY
    customerkey
HAVING
    MIN(orderdate) < MAX(latest_date) - INTERVAL '6 Month'
ORDER BY
    customerkey
)

SELECT
    COUNT(customerkey) AS total_customer,
    cohort_year,
    customer_status,
    ROUND(COUNT(customerkey) * 100.0 / SUM(COUNT(customerkey)) OVER (PARTITION BY cohort_year),2) AS percentage_of_cohort
FROM
    customer_retention
GROUP BY
    customer_status, cohort_year
ORDER BY
    cohort_year, customer_status
