WITH yearly_cohort AS (
    SELECT DISTINCT
        customerkey,
        EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year,
        EXTRACT(YEAR FROM orderdate) AS purchase_year
    FROM sales
)

SELECT DISTINCT
    cohort_year,
    purchase_year,
    COUNT(DISTINCT y.customerkey) AS number_of_customers,
    SUM(s.quantity * s.netprice * s.exchangerate) AS net_revenue
FROM sales s
LEFT JOIN yearly_cohort y 
    ON s.customerkey = y.customerkey
WHERE y.cohort_year < '2020' AND y.purchase_year < '2020'
GROUP BY
    cohort_year, purchase_year
ORDER BY
    cohort_year, purchase_year;