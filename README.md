# Intermediate SQL - Sales Analysis

## Overview
Using contoso_100k dataset, a sample dataset simulating a company's sales data, to analyze customer behavior, customer groups, retention, and lifetime value to improve customer retention and maximize revenue.

## Business Questions
1. **Customer Segmentation:** Who are the most valuable customers?
2. **Cohort Analysis:** How do different customer groups generate revenue?
3. **Retention Analysis:** Which customers are showing signs of declining purchase activity?

## Clean Up Data

**SQL Query**: [0_create_view.sql](0_create_view.sql)

- Aggregated sales and customer data into total revenue and order counts.
- Calculated first purchase dates and extracted first purchase year for cohort analysis
- Created view combining transactions and customer details

## Analysis

### 1. Customer Segmentation
**SQL Query**: [1_customer_segmentation.sql](1_customer_segmentation.sql)
- Categorized the customers into 3 groups based on their total lifetime value (LTV)
- Calculated each group's total LTV, average customer LTV, and their share in the overall LTV distribution.

**Visualization:**

<img src="Resources\1_customer_segmentation.png" alt="Customer Segmentation: LTV Distribution" width="50%">

**Key Findings:**
- High-value segment (25% of customers) drives 66% of revenue ($135.4M)
- Mid-value segment (50% of customers) generates 32% of revenue ($66.6M)
- Low-value segment (25% of customers) accounts for 2% of revenue ($4.3M)

**Business Insights:**
- High-value segment is the revenue backbone. Retention strategies, VIP programs, and personalized service for this segment could yield significant profit
- Mid-value segment offers scalable growth potential, they may respond well to targeted upselling, loyalty incentives, and bundling offers to move them into the high-value tier.
- For low-value segment, design re-engagement campaigns and price-sensitive promotions to increase purchase frequency

### 2. Customer Revenue by Cohort
**SQL Query**: [2_cohort_analysis.sql](2_cohort_analysis.sql)

- Calculated the total revenue and customer count per cohorts
- Customers were grouped into cohorts based on the year of their first purchase
- Calculated the average customer revenue within each cohort year

**Visualization:**

Customer Revenue by Cohort Year

<img src="Resources\2_customer_revenue.png" alt="Customer Revenue Normalized" width="50%">

Investigate Monthly Revenue & Customer Trends

<img src="Resources\2_monthly_revenue.png" alt="Monthly Revenue & CustomerTrends" width="50%">  

**Key Findings:**  
- The overall customer revenue has declined in more recent cohorts, with the older cohorts (2016-2018) spent around $5000, while 2024 cohort spending dropped to around $2000.  
- Revenue and customer numbers generally shows the same pattern. Both of them first peaked at 3 million in 2019, then dropped to approximately 0.5 million by the end of 2020. They experienced another peak in 2022–2023, but both metrics are now trending downward in 2024.
- High volatility in revenue and customer count, with sharp drops in 2020 and 2024, signaling retention challenges.  

**Business Insights:**  
- Investigate cohort differences by applying successful strategies from high-spending cohorts (2016-2018) to newer ones.
- Boost retention & re-engagement by targeting recent cohorts (2022-2024) with personalized offers to prevent churn.  
- Stabilize revenue fluctuations and introduce loyalty programs or subscriptions to ensure consistent spending.  

### 3. Customer Retention
**SQL Query**: [3_customer_retention.sql](3_customer_retention.sql)
- Calculated the total customer number for each cohort year
- Classified customers status into 'Active' and 'Churned'
- Computed the percentage of customers for each status per cohort year

**Visualization:**

<img src="Resources\3_customer_retention.png" alt="Customer Revenue Normalized" width="50%">

**Key Findings:**
- Retention rates are consistently low (8-10%) across all cohorts, suggesting retention issues are systemic rather than specific to certain years.

**Business Insights:**
- Improve early engagement through stronger onboarding, personalized follow-ups, and targeted loyalty initiatives could help address this gap.
- Conduct churn analysis to pinpoint key attrition drivers will enable the business to implement focused strategies that boost long-term retention.

## Strategic Recommendations
1. **Customer Value Optimization**
    - Launch retention strategies, VIP programs, and personalized service for high-value cohort

    - Target mid-value cohort with upselling, loyalty rewards, and product/service bundles to shift them into the high-value tier.

    - Use re-engagement campaigns and price-sensitive promotions to boost low-value cohort purchase frequency.

2. **Cohort Performance Strategy**
    - Apply best practices from high-spending cohorts (2016–2018) to improve performance of newer cohorts.

    - Target recent cohorts (2022–2024) with personalized offers to boost retention and prevent churn.

    - Stabilize revenue with loyalty programs or subscription models to encourage consistent spending.

3. **Retention & Churn Prevention**
    - Strengthen early engagement with improved onboarding, personalized follow-ups, and targeted loyalty initiatives.

    - Analyze churn drivers to design focused strategies for boosting long-term retention.