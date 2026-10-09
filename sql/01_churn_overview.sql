-- Executive Churn KPIs

SELECT
  COUNT(*) AS total_customers,
  SUM(ChurnFlag) AS churned_customers,
  SUM(RetainedFlag) AS retained_customers,
  ROUND(100 * AVG(ChurnFlag), 2) AS churn_rate_pct,
  ROUND(100 * AVG(RetainedFlag), 2) AS retention_rate_pct,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
  ROUND(SUM(MonthlyRevenueAtRisk), 2) AS monthly_revenue_at_risk
FROM `telecom-churn-analytics.telecom_churn.customer_churn_clean`;
