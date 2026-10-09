SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT customerID) AS unique_customers,
  COUNTIF(customerID IS NULL) AS missing_customer_ids,
  COUNTIF(tenure IS NULL) AS missing_tenure,
  COUNTIF(MonthlyCharges IS NULL) AS missing_monthly_charges,
  COUNTIF(TotalCharges IS NULL) AS missing_total_charges,
  COUNTIF(Churn IS NULL) AS missing_churn
FROM `telecom-churn-analytics.telecom_churn.customer_churn_raw`;


-- Check blanks and categorical values
-- Identify blank charges, zero tenure, and churn status.

SELECT
  COUNTIF(TRIM(CAST(TotalCharges AS STRING)) = '') AS blank_total_charges,
  COUNTIF(TRIM(customerID) = '') AS blank_customer_ids,
  COUNTIF(tenure = 0) AS zero_tenure_customers,
  COUNTIF(Churn = TRUE) AS churned_customers,
  COUNTIF(Churn = FALSE) AS retained_customers
FROM `telecom-churn-analytics.telecom_churn.customer_churn_raw`;


-- Create the cleaned customer table
-- Convert TotalCharges and derive analysis-ready fields.

CREATE OR REPLACE TABLE
  `telecom-churn-analytics.telecom_churn.customer_churn_clean`
AS

SELECT
  customerID,
  gender,
  SeniorCitizen,
  Partner,
  Dependents,
  tenure,
  PhoneService,
  MultipleLines,
  InternetService,
  OnlineSecurity,
  OnlineBackup,
  DeviceProtection,
  TechSupport,
  StreamingTV,
  StreamingMovies,
  Contract,
  PaperlessBilling,
  PaymentMethod,
  MonthlyCharges,

  SAFE_CAST(
    NULLIF(TRIM(CAST(TotalCharges AS STRING)), '')
    AS FLOAT64
  ) AS TotalCharges,

  Churn,

  CASE
    WHEN tenure <= 12 THEN '0-12 months'
    WHEN tenure <= 24 THEN '13-24 months'
    WHEN tenure <= 48 THEN '25-48 months'
    ELSE '49+ months'
  END AS TenureGroup,

  CASE
    WHEN Churn = TRUE THEN 1
    ELSE 0
  END AS ChurnFlag,

  CASE
    WHEN Churn = FALSE THEN 1
    ELSE 0
  END AS RetainedFlag,

  CASE
    WHEN Churn = TRUE THEN MonthlyCharges
    ELSE 0
  END AS MonthlyRevenueAtRisk

FROM
  `telecom-churn-analytics.telecom_churn.customer_churn_raw`;
