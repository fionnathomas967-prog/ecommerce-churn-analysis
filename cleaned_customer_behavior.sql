CREATE OR REPLACE VIEW `ecommerce_analysis.cleaned_customer_behavior` AS
SELECT
 *,
  -- Age Grouping
 CASE
   WHEN Age IS NULL THEN 'Unknown'
   WHEN Age < 25 THEN 'Under 25'
   WHEN Age BETWEEN 25 AND 40 THEN '25-40'
   WHEN Age BETWEEN 41 AND 60 THEN '41-60'
   ELSE '60+'
 END AS age_group,


 -- At-Risk / Churn Risk Status
 CASE
   WHEN Login_Frequency < 5 AND Cart_Abandonment_Rate > 0.5 THEN 'At-Risk'
   WHEN Login_Frequency >= 15 AND Cart_Abandonment_Rate < 0.4 THEN 'High Engagement'
   ELSE 'Moderate Risk'
 END AS customer_churn_status,


 -- Customer Value Tiering (Total Purchases * Avg Order Value)
 CASE
   WHEN (Total_Purchases * Average_Order_Value) >= 2000 THEN 'High Value'
   WHEN (Total_Purchases * Average_Order_Value) BETWEEN 800 AND 1999 THEN 'Mid Value'
   ELSE 'Low Value'
 END AS customer_value_tier


FROM `ecommerce_analysis.customer_churn`
