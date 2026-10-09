-- What contract types are driving churn?

SELECT
  Contract,
  COUNT(*) AS total_customers,
  SUM(ChurnFlag) AS churned_customers,
  ROUND(100 * AVG(ChurnFlag), 2) AS churn_rate_pct,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
  ROUND(SUM(MonthlyRevenueAtRisk), 2) AS monthly_revenue_at_risk
FROM `telecom-churn-analytics.telecom_churn.customer_churn_clean`
GROUP BY Contract
ORDER BY churn_rate_pct DESC;


-- How does tenure relate to churn?

SELECT
  TenureGroup,
  COUNT(*) AS total_customers,
  SUM(ChurnFlag) AS churned_customers,
  ROUND(100 * AVG(ChurnFlag), 2) AS churn_rate_pct,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
FROM `telecom-churn-analytics.telecom_churn.customer_churn_clean`
GROUP BY TenureGroup
ORDER BY
  CASE TenureGroup
    WHEN '0-12 months' THEN 1
    WHEN '13-24 months' THEN 2
    WHEN '25-48 months' THEN 3
    WHEN '49+ months' THEN 4
  END;
