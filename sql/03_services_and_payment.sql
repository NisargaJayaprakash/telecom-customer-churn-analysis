
-- Internet service and churn

SELECT
  InternetService,
  COUNT(*) AS total_customers,
  SUM(ChurnFlag) AS churned_customers,
  ROUND(100 * AVG(ChurnFlag), 2) AS churn_rate_pct,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
FROM `telecom-churn-analytics.telecom_churn.customer_churn_clean`
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;


-- Online Security and Tech Support

SELECT
  OnlineSecurity,
  TechSupport,
  COUNT(*) AS total_customers,
  SUM(ChurnFlag) AS churned_customers,
  ROUND(100 * AVG(ChurnFlag), 2) AS churn_rate_pct
FROM `telecom-churn-analytics.telecom_churn.customer_churn_clean`
WHERE InternetService != 'No'
GROUP BY OnlineSecurity, TechSupport
ORDER BY churn_rate_pct DESC;


-- Monthly charges and churn

SELECT
  CASE
    WHEN Churn = TRUE THEN 'Churned'
    ELSE 'Retained'
  END AS customer_status,
  COUNT(*) AS customers,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
  ROUND(MIN(MonthlyCharges), 2) AS min_monthly_charge,
  ROUND(MAX(MonthlyCharges), 2) AS max_monthly_charge,
  ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM `telecom-churn-analytics.telecom_churn.customer_churn_clean`
GROUP BY customer_status
ORDER BY avg_monthly_charge DESC;


-- Payment method and churn

SELECT
  PaymentMethod,
  COUNT(*) AS total_customers,
  SUM(ChurnFlag) AS churned_customers,
  ROUND(100 * AVG(ChurnFlag), 2) AS churn_rate_pct,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
FROM `telecom-churn-analytics.telecom_churn.customer_churn_clean`
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;
