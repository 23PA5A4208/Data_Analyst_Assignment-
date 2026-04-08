-- =====================================================
-- PlatinumRx DA Assignment - Clinic Management System
-- Part B: Query Solutions
-- =====================================================

USE clinic_management;

-- =====================================================
-- QUESTION 1: Find the revenue we got from each sales 
-- channel in a given year
-- =====================================================
-- Approach: Group by sales_channel and sum the amounts
-- Using parameterized year for flexibility

-- For year 2021 (can be parameterized)
SET @target_year = 2021;

SELECT 
    sales_channel,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_revenue,
    AVG(amount) AS average_transaction_value
FROM clinic_sales
WHERE YEAR(datetime) = @target_year
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- Alternative without variable (direct filter)
SELECT 
    sales_channel,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_revenue,
    AVG(amount) AS average_transaction_value
FROM clinic_sales
WHERE datetime >= '2021-01-01' AND datetime < '2022-01-01'
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- =====================================================
-- QUESTION 2: Find top 10 the most valuable customers 
-- for a given year
-- =====================================================
-- Approach: Group by customer, sum their total spending
-- and rank to get top 10

SET @target_year = 2021;

SELECT 
    c.uid,
    c.name,
    c.mobile,
    COUNT(cs.oid) AS total_orders,
    SUM(cs.amount) AS total_spent,
    AVG(cs.amount) AS average_order_value
FROM customer c
INNER JOIN clinic_sales cs ON c.uid = cs.uid
WHERE YEAR(cs.datetime) = @target_year
GROUP BY c.uid, c.name, c.mobile
ORDER BY total_spent DESC
LIMIT 10;

-- =====================================================
-- QUESTION 3: Find month wise revenue, expense, profit, 
-- status (profitable / not-profitable) for a given year
-- =====================================================
-- Approach: Aggregate revenue and expenses separately by month
-- then join and calculate profit

SET @target_year = 2021;

WITH monthly_revenue AS (
    SELECT 
        MONTH(datetime) AS month_num,
        MONTHNAME(datetime) AS month_name,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = @target_year
    GROUP BY MONTH(datetime), MONTHNAME(datetime)
),
monthly_expenses AS (
    SELECT 
        MONTH(datetime) AS month_num,
        SUM(amount) AS total_expenses
    FROM expenses
    WHERE YEAR(datetime) = @target_year
    GROUP BY MONTH(datetime)
)
SELECT 
    mr.month_num,
    mr.month_name,
    COALESCE(mr.total_revenue, 0) AS revenue,
    COALESCE(me.total_expenses, 0) AS expenses,
    COALESCE(mr.total_revenue, 0) - COALESCE(me.total_expenses, 0) AS profit,
    CASE 
        WHEN COALESCE(mr.total_revenue, 0) > COALESCE(me.total_expenses, 0) THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM monthly_revenue mr
LEFT JOIN monthly_expenses me ON mr.month_num = me.month_num
ORDER BY mr.month_num;

-- =====================================================
-- QUESTION 4: For each city find the most profitable 
-- clinic for a given month
-- =====================================================
-- Approach: Calculate profit per clinic per month, 
-- then use window function to find most profitable per city

SET @target_year = 2021;
SET @target_month = 9; -- September

WITH clinic_monthly_profit AS (
    SELECT 
        cl.cid,
        cl.clinic_name,
        cl.city,
        cl.state,
        COALESCE(SUM(cs.amount), 0) AS revenue,
        COALESCE((SELECT SUM(e.amount) 
                  FROM expenses e 
                  WHERE e.cid = cl.cid 
                  AND YEAR(e.datetime) = @target_year 
                  AND MONTH(e.datetime) = @target_month), 0) AS expenses,
        COALESCE(SUM(cs.amount), 0) - COALESCE((SELECT SUM(e.amount) 
                  FROM expenses e 
                  WHERE e.cid = cl.cid 
                  AND YEAR(e.datetime) = @target_year 
                  AND MONTH(e.datetime) = @target_month), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs ON cl.cid = cs.cid 
        AND YEAR(cs.datetime) = @target_year 
        AND MONTH(cs.datetime) = @target_month
    GROUP BY cl.cid, cl.clinic_name, cl.city, cl.state
),
ranked_clinics AS (
    SELECT 
        cid,
        clinic_name,
        city,
        state,
        revenue,
        expenses,
        profit,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS profit_rank
    FROM clinic_monthly_profit
)
SELECT 
    city,
    cid,
    clinic_name,
    revenue,
    expenses,
    profit
FROM ranked_clinics
WHERE profit_rank = 1
ORDER BY city;

-- =====================================================
-- QUESTION 5: For each state find the second least 
-- profitable clinic for a given month
-- =====================================================
-- Approach: Similar to Q4 but find 2nd least profitable
-- using ascending order ranking

SET @target_year = 2021;
SET @target_month = 9; -- September

WITH clinic_monthly_profit AS (
    SELECT 
        cl.cid,
        cl.clinic_name,
        cl.city,
        cl.state,
        COALESCE(SUM(cs.amount), 0) AS revenue,
        COALESCE((SELECT SUM(e.amount) 
                  FROM expenses e 
                  WHERE e.cid = cl.cid 
                  AND YEAR(e.datetime) = @target_year 
                  AND MONTH(e.datetime) = @target_month), 0) AS expenses,
        COALESCE(SUM(cs.amount), 0) - COALESCE((SELECT SUM(e.amount) 
                  FROM expenses e 
                  WHERE e.cid = cl.cid 
                  AND YEAR(e.datetime) = @target_year 
                  AND MONTH(e.datetime) = @target_month), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs ON cl.cid = cs.cid 
        AND YEAR(cs.datetime) = @target_year 
        AND MONTH(cs.datetime) = @target_month
    GROUP BY cl.cid, cl.clinic_name, cl.city, cl.state
),
ranked_clinics AS (
    SELECT 
        cid,
        clinic_name,
        city,
        state,
        revenue,
        expenses,
        profit,
        RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS profit_rank_asc
    FROM clinic_monthly_profit
)
SELECT 
    state,
    cid,
    clinic_name,
    city,
    revenue,
    expenses,
    profit
FROM ranked_clinics
WHERE profit_rank_asc = 2
ORDER BY state;

-- =====================================================
-- BONUS: Comprehensive Monthly Report for All Clinics
-- =====================================================
-- This query provides a complete overview of all clinics'
-- performance for the given month

SET @report_year = 2021;
SET @report_month = 9;

SELECT 
    cl.state,
    cl.city,
    cl.cid,
    cl.clinic_name,
    COALESCE(SUM(cs.amount), 0) AS revenue,
    COALESCE(exp_data.total_expenses, 0) AS expenses,
    COALESCE(SUM(cs.amount), 0) - COALESCE(exp_data.total_expenses, 0) AS profit,
    COUNT(cs.oid) AS transaction_count
FROM clinics cl
LEFT JOIN clinic_sales cs ON cl.cid = cs.cid 
    AND YEAR(cs.datetime) = @report_year 
    AND MONTH(cs.datetime) = @report_month
LEFT JOIN (
    SELECT cid, SUM(amount) AS total_expenses
    FROM expenses
    WHERE YEAR(datetime) = @report_year AND MONTH(datetime) = @report_month
    GROUP BY cid
) exp_data ON cl.cid = exp_data.cid
GROUP BY cl.cid, cl.clinic_name, cl.city, cl.state, exp_data.total_expenses
ORDER BY cl.state, cl.city, profit DESC;
