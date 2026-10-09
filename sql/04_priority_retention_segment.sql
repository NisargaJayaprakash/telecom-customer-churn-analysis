
-- Identify high-risk customer segments
-- Minimum segment size: 50 customers

SELECT
  Contract,
  TenureGroup,
  InternetService,
  PaymentMethod,
  OnlineSecurity,
  TechSupport,
  COUNT(*) AS total_customers,
  SUM(ChurnFlag) AS churned_customers,
  ROUND(100 * AVG(ChurnFlag), 2) AS churn_rate_pct,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
  ROUND(SUM(MonthlyRevenueAtRisk), 2) AS monthly_revenue_at_risk
FROM `telecom-churn-analytics.telecom_churn.customer_churn_clean`
GROUP BY
  Contract,
  TenureGroup,
  InternetService,
  PaymentMethod,
  OnlineSecurity,
  TechSupport
HAVING COUNT(*) >= 50
ORDER BY churn_rate_pct DESC, monthly_revenue_at_risk DESC
LIMIT 15;
