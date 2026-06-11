CREATE DATABASE customer_churn_db;
 USE customer_churn_db;
 USE customer_churn_db;

SELECT *
FROM customer_churn
LIMIT 10;

SELECT COUNT(*)
FROM customer_churn;
DESCRIBE customer_churn;

SELECT
    Churn,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Churn;

SELECT
    Contract,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Contract;

SELECT
    Contract,
    Churn,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Contract, Churn
ORDER BY Contract;

SELECT COUNT(*)
FROM customer_churn;

#1 Total Customers

SELECT COUNT(*) AS total_customers
FROM customer_churn;

#2 Churn Distribution
SELECT
    Churn,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Churn;

#3churn Rate %
SELECT
ROUND(
100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
    / COUNT(*),
2
) AS churn_rate
FROM customer_churn;

#4:  Gender Distribution
SELECT
    gender,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY gender;


-
--query 5:  Churn by Gender
SELECT
    gender,
    Churn,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY gender, Churn;

Contract Analysis

--query 6: Customers by Contract Type
SELECT
    Contract,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Contract;

--query 7: Churn by Contract Type
SELECT
    Contract,
    Churn,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Contract, Churn
ORDER BY Contract;

--quert 8: Contract-wise Churn Rate
SELECT
    Contract,
    ROUND(
        100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
    2) AS churn_rate
FROM customer_churn
GROUP BY Contract;

Revenue Analysis

--query 9: Average Monthly Charges
SELECT
ROUND(AVG(MonthlyCharges),2)
AS avg_monthly_charge
FROM customer_churn;

--query 10: Average Monthly Charges by Churn
SELECT
    Churn,
    ROUND(AVG(MonthlyCharges),2)
    AS avg_monthly_charge
FROM customer_churn
GROUP BY Churn;

--query 11: Total Revenue
SELECT
ROUND(SUM(TotalCharges),2)
AS total_revenue
FROM customer_churn;

Tenure Analysis

--query 12: Average Tenure
SELECT
ROUND(AVG(tenure),2)
AS avg_tenure
FROM customer_churn;

--query 13: Tenure by Churn
SELECT
    Churn,
    ROUND(AVG(tenure),2)
    AS avg_tenure
FROM customer_churn
GROUP BY Churn;

CASE Statement Queries

--query 14: Customer Segmentation by Tenure
SELECT
CASE
    WHEN tenure < 12 THEN 'New Customer'
    WHEN tenure BETWEEN 12 AND 36 THEN 'Regular Customer'
    ELSE 'Loyal Customer'
END AS customer_segment,
COUNT(*) AS customers
FROM customer_churn
GROUP BY customer_segment;

--query 15: Churn by Customer Segment
SELECT
CASE
    WHEN tenure < 12 THEN 'New Customer'
    WHEN tenure BETWEEN 12 AND 36 THEN 'Regular Customer'
    ELSE 'Loyal Customer'
END AS customer_segment,
Churn,
COUNT(*) AS customers
FROM customer_churn
GROUP BY customer_segment, Churn;

Payment Analysis

--query 16: Payment Method Distribution
SELECT
    PaymentMethod,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY customers DESC;

--query 17: Churn by Payment Method
SELECT
    PaymentMethod,
    ROUND(
        100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
    2) AS churn_rate
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

Window Function Queries

--query 18: Rank Contract Types by Customer Count
SELECT
    Contract,
    COUNT(*) AS customers,
    RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS ranking
FROM customer_churn
GROUP BY Contract;

--query 19: Rank Payment Methods by Churn Rate
SELECT
    PaymentMethod,
    ROUND(
        100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
    2) AS churn_rate,
    RANK() OVER(
        ORDER BY
        ROUND(
            100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
            / COUNT(*),
        2) DESC
    ) AS ranking
FROM customer_churn
GROUP BY PaymentMethod;

--query 20: Top Revenue Customers
SELECT
    customerID,
    TotalCharges,
    RANK() OVER(
        ORDER BY TotalCharges DESC
    ) AS revenue_rank
FROM customer_churn
LIMIT 20;

#5:  Churn by Gender
SELECT
    gender,
    Churn,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY gender, Churn;

#Contract Analysis

# 6: Customers by Contract Type
SELECT
    Contract,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Contract;

# 7: Churn by Contract Type
SELECT
    Contract,
    Churn,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Contract, Churn
ORDER BY Contract;

#8: Contract-wise Churn Rate
SELECT
    Contract,
    ROUND(
        100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
    2) AS churn_rate
FROM customer_churn
GROUP BY Contract;

#Revenue Analysis

#9: Average Monthly Charges
SELECT
ROUND(AVG(MonthlyCharges),2)
AS avg_monthly_charge
FROM customer_churn;

#10: Average Monthly Charges by Churn
SELECT
    Churn,
    ROUND(AVG(MonthlyCharges),2)
    AS avg_monthly_charge
FROM customer_churn
GROUP BY Churn;

#11: Total Revenue
SELECT
ROUND(SUM(TotalCharges),2)
AS total_revenue
FROM customer_churn;

#Tenure Analysis

#12: Average Tenure
SELECT
ROUND(AVG(tenure),2)
AS avg_tenure
FROM customer_churn;

#13: Tenure by Churn
SELECT
    Churn,
    ROUND(AVG(tenure),2)
    AS avg_tenure
FROM customer_churn
GROUP BY Churn;

#CASE Statement Queries

#14: Customer Segmentation by Tenure
SELECT
CASE
    WHEN tenure < 12 THEN 'New Customer'
    WHEN tenure BETWEEN 12 AND 36 THEN 'Regular Customer'
    ELSE 'Loyal Customer'
END AS customer_segment,
COUNT(*) AS customers
FROM customer_churn
GROUP BY customer_segment;

#15: Churn by Customer Segment
SELECT
CASE
    WHEN tenure < 12 THEN 'New Customer'
    WHEN tenure BETWEEN 12 AND 36 THEN 'Regular Customer'
    ELSE 'Loyal Customer'
END AS customer_segment,
Churn,
COUNT(*) AS customers
FROM customer_churn
GROUP BY customer_segment, Churn;

#Payment Analysis

#16: Payment Method Distribution
SELECT
    PaymentMethod,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY customers DESC;

#17: Churn by Payment Method
SELECT
    PaymentMethod,
    ROUND(
        100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
    2) AS churn_rate
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

#Window Function Queries

#18: Rank Contract Types by Customer Count
SELECT
    Contract,
    COUNT(*) AS customers,
    RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS ranking
FROM customer_churn
GROUP BY Contract;

#19: Rank Payment Methods by Churn Rate
SELECT
    PaymentMethod,
    ROUND(
        100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
    2) AS churn_rate,
    RANK() OVER(
        ORDER BY
        ROUND(
            100 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
            / COUNT(*),
        2) DESC
    ) AS ranking
FROM customer_churn
GROUP BY PaymentMethod;

#20: Top Revenue Customers
SELECT
    customerID,
    TotalCharges,
    RANK() OVER(
        ORDER BY TotalCharges DESC
    ) AS revenue_rank
FROM customer_churn
LIMIT 20;